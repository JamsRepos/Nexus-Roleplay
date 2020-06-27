local AppelsEnCours = {}
local lastIndexCall = 10
local Spectating = false

function CharID(identifier)
 if identifier ~= nil then
  return exports['core']:GetCharacterID(identifier)
 end
end

function getSourceFromCharacterID(identifier, cb)
    TriggerEvent("core:getPlayers", function(users)
        for k , user in pairs(users) do
            if user.getCharacterID() == CharID(identifier) then
                cb(k)
                return
            end
        end
    end)
    cb(nil)
end --- might need to edit function to not error when no1 is on 

function getNumberPhone(identifier)
    local result = exports['GHMattiMySQL']:QueryResult("SELECT `phone_number` FROM characters WHERE id = @identifier", {
        ['@identifier'] = CharID(identifier)
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end

function getIdentifierByPhoneNumber(phone_number)
    local result = exports['GHMattiMySQL']:QueryResult("SELECT `identifier` FROM characters WHERE phone_number = @phone_number", {
        ['@phone_number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end

function getContacts(identifier)
    local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM phone_users_contacts WHERE char_id = @identifier", {
        ['@identifier'] = CharID(identifier)
    })
    return result
end

function addContact(source, identifier, number, display)
    exports['GHMattiMySQL']:QueryAsync("INSERT INTO phone_users_contacts (`char_id`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = CharID(identifier),
        ['@number'] = number,
        ['@display'] = display,
    })
    notifyContactChange(source, identifier)
end

function updateContact(source, identifier, id, number, display)
    exports['GHMattiMySQL']:QueryAsync("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    })
    notifyContactChange(source, identifier)
end

function deleteContact(source, identifier, id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_users_contacts WHERE `char_id` = @identifier AND `id` = @id", {
        ['@identifier'] = CharID(identifier),
        ['@id'] = id,
    })
    notifyContactChange(source, identifier)
end

function deleteAllContact(identifier)
   exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_users_contacts WHERE `char_id` = @identifier", {['@identifier'] = CharID(identifier)})
end

function notifyContactChange(source, identifier)
    if source ~= nil then 
        TriggerClientEvent("gcPhone:contactList", source, getContacts(identifier))
    end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local identifier = GetPlayerIdentifiers(source)[1]
    addContact(source, identifier, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local identifier = GetPlayerIdentifiers(source)[1]
    updateContact(source, identifier, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteContact(source, identifier, id)
end)

function getMessages(identifier)
    return exports['GHMattiMySQL']:QueryResult("SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.character_id = @identifier WHERE phone_messages.receiver = @phoneNumber", {
        ['@identifier'] = CharID(identifier),
        ['@phoneNumber'] = getNumberPhone(identifier) 
    })
end

function _internalAddMessage(transmitter, receiver, message, owner)
    local Query = "INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner);"
    local Query2 = 'SELECT * from phone_messages WHERE `id` = (SELECT LAST_INSERT_ID());'
    local Parameters = {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner
    }
    return exports['GHMattiMySQL']:QueryResult(Query .. Query2, Parameters)[1]
end

function addMessage(source, identifier, phone_number, message)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier ~= nil then 
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        getSourceFromCharacterID(otherIdentifier, function(osou)
            if osou ~= nil then 
               TriggerClientEvent("gcPhone:receiveMessage", osou, tomess)
               local character = exports['core']:GetActiveCharacter(osou)
               TriggerClientEvent('chat:actionmessage', -1, osou, "phone vibrates")
            end
        end) 
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", source, memess)
end


function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    exports['GHMattiMySQL']:QueryAsync("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", { 
        ['@receiver'] = mePhoneNumber,
        ['@transmitter'] = num
    })
end

function deleteMessage(msgId)
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_messages WHERE `id` = @id", {['@id'] = msgId})
end

function deleteAllMessageFromPhoneNumber(identifier, phone_number)
 local mePhoneNumber = getNumberPhone(identifier)
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number})
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {['@mePhoneNumber'] = mePhoneNumber})
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local identifier = GetPlayerIdentifiers(source)[1]
    addMessage(source, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local source = tonumber(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteAllMessageFromPhoneNumber(identifier, number)
    TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier))
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local source = tonumber(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteAllMessage(identifier)
    TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier))
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local identifier = GetPlayerIdentifiers(source)[1]
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local source = tonumber(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    TriggerClientEvent("gcPhone:contactList", source, {})
    TriggerClientEvent("gcPhone:allMessage", source, {})
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded',function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local identifier = GetPlayerIdentifier(source)
  local phone_number = user.getPhoneNumber()
  TriggerClientEvent("gcPhone:myPhoneNumber", source, phone_number)
  TriggerClientEvent("gcPhone:contactList", source, getContacts(identifier))
  TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier))
 end)
end)

function getCallHistory(num)
    local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120", {['@num'] = num})
    return result
end

function sendCallHistory(src, num) 
    local histo = getCallHistory(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels(appelInfo)
    exports['GHMattiMySQL']:QueryResult("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {['@owner'] = appelInfo.transmitter_num,['@num'] = appelInfo.receiver_num,['@incoming'] = 1,['@accepts'] = appelInfo.is_accepts})
    notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
       exports['GHMattiMySQL']:QueryResult("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
            end
        end)
    end
end

function notifyNewAppelsHisto(src, num) 
    sendCallHistory(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = GetPlayerIdentifier(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    sendCallHistory(sourcePlayer, num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    local rtcOffer = rtcOffer
    if phone_number == nil then 
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local srcIdentifier = GetPlayerIdentifier(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }

    if is_valid == true then
        getSourceFromCharacterID(destPlayer, function (srcTo)
            if srcTo ~= nil then
                local character = exports['core']:GetActiveCharacter(srcTo)
                TriggerClientEvent('chat:actionmessage', -1, srcTo, "phone rings")
                AppelsEnCours[indexCall].receiver_src = srcTo
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end)
    else
        TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
    end

end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)        --- original
            saveAppels(AppelsEnCours[id])
        end
    end
end)



RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then

        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = GetPlayerIdentifier(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {['@owner'] = srcPhone, ['@num'] = numero})
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM phone_calls WHERE `owner` = @owner", {['@owner'] = srcPhone})
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = GetPlayerIdentifier(source)
    appelsDeleteAllHistorique(srcIdentifier)
end)
