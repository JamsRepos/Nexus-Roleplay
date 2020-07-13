Config = {}

Config.RestrictedChannels = 3 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = false --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {

  ['not_on_radio'] = 'You are currently not on any frequency.',
  ['on_radio'] = 'You are currently on the frequency: <b>',
  ['joined_to_radio'] = 'You joined the frequency: <b>',
  ['restricted_channel_error'] = 'You can not join encrypted channels!',
  ['you_on_radio'] = 'You are already on the frequency: <b>',
  ['you_leave'] = 'You left the frequency: <b>',
  ['dropped_radio'] = 'You lost connection to frequency: <b>',

}
