var money = 0
var bank = 0

window.addEventListener('message', function (event) {


    switch(event.data.action) {
        case 'tick':
            $(".container").css("display", event.data.show ? "none" : "block");
            $("#boxHeal").css("width", event.data.health + "%");
            $("#boxArmor").css("width", event.data.armor + "%");
            $("#boxStamina").css("width", event.data.stamina + "%");
            break;
        
        case 'updateStatus':
            updateStatus(event.data.hunger, event.data.thirst);
            break;
        case 'showui':
            $('body').show();
            break;
        case 'hideui':
            $('body').hide();
            break;
        case 'set-voice':
            $("#boxVoice").css("width", event.data.value + "%");
            break;
        case 'voice-color':
            if (event.data.isTalking) {
                $('#boxVoice').addClass('active');
            } else {
                $('#boxVoice').removeClass('active');
            }
            break;
        case 'update-clock':
            $('.clock').html(event.data.time + ' <span class="ampm">' + event.data.ampm + '</span>')
            break;
        case 'update-position':
            if (event.data.street2 !== '') {
                $('.position').html(event.data.direction + ' <span class="seperator">|</span> ' + event.data.street1 + ' <span class="seperator2">-</span> ' + event.data.street2 + ' <span class="seperator">|</span> ' + event.data.area);
            } else {
                $('.position').html(event.data.direction + ' <span class="seperator">|</span> ' + event.data.street1 + ' <span class="seperator">|</span> ' + event.data.area);
            }
            break;
    }
});

function updateStatus(hunger, thirst){
    $('#boxHunger').css('width', hunger + '%')
    $('#boxThirst').css('width', thirst + '%')
}