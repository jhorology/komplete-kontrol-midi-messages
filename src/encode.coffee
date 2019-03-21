{
  MIDI_IN_CH,
  MIDI_IN_CCs,
  MIDI_OUT_CH,
  MIDI_OUT_CCs,
  SYSEX_HEADER,
  SYSEX_MESSAGEs
} = require './midi-implementation'


###
  swap key and value
###
swapKeyValue = (obj) ->
  ret = {}
  (Object.keys obj).forEach (key) ->
    ret[obj[key]] = key
  ret

###
  reverse MIDI implementation
###
reverseMidiImplementation = (ccMessages, sysExMessages) ->
  ret = {}
  for cc, def of ccMessages
    encoding = if (typeof def.encoding is 'string')
      def.encoding
    else
      swapKeyValue def.encoding
    ret[def.id + (if 'index' of def then def.index else '')] =
      cc: cc
      encoding: encoding
      desc: def.desc
      
  for sysex, def of sysExMessages
    encoding = if (typeof def.encoding is 'string')
      def.encoding
    else
      swapKeyValue def.encoding
    ret[def.id] =
      sysex: sysex
      encoding: encoding
      hasIndex: def.hasIndex
      hasString: def.hasString
      desc: def.desc
  ret
  
KK_IN_MESSAGEs = reverseMidiImplementation MIDI_IN_CCs, SYSEX_MESSAGEs
KK_OUT_MESSAGEs = reverseMidiImplementation MIDI_OUT_CCs

###
  encode Komplete Kontrol message to midi-message for down stream(DAW -> KK)
###
encodeDownStream = (kkMessage) ->
  if kkMessage.id is 'Unknown'
    kkMessage.midiMessage
  else
    encodeMessage kkMessage, KK_IN_MESSAGEs, MIDI_IN_CH

###
  encode Komplete Kontrol message to midi-message for up stream(KK -> DAW)
###
encodeUpStream = (kkMessage) ->
  if kkMessage.id is 'Unknown'
    kkMessage.midiMessage
  else
    encodeMessage kkMessage, KK_OUT_MESSAGEs, MIDI_OUT_CH

###
  encode Komplete Kontrol message to midi-message
###
encodeMessage = (kkMessage, messages, ch) ->
  def = messages[kkMessage.id]
  def ?= messages[kkMessage.id + (if 'index' of kkMessage then kkMessage.index else '')]
  unless def
    throw new Error "Unknown message. kkMessage:#{kkMessage}"
  if 'cc' of def
    type: 'ControlChange'
    channel: ch
    control: parseInt def.cc
    value: encodeValue kkMessage.value, def.encoding
  else if 'sysex' of def
    data = [SYSEX_HEADER...]
    # value
    data.push if def.encoding
      encodeValue kkMessage.value, def.encoding
    else
      0
    # index
    data.push if def.hasIndex
      unless 'index' of kkMessage
        throw new Error "Message doesn't have index. kkMessage:#{kkMessage}"
      kkMessage.index
    else
      0
    # String
    if def.hasString
      data = if typeof kkMessage.value is 'string'
        [data..., (Array::slice (Buffer.from kkMessage.value), 0)...]
      else if typeof kkMessage.string is 'string'
        [data..., (Array::slice (Buffer.from kkMessage.string), 0)...]
    type: 'SysEx'
    deviceId: 0     # midi-messages doesn't support 2byte id.
    data: data
  else
    throw new Error "Wrong definition. def:#{def}"

###
  decode 7bit value
###
encodeValue = (v, enc) ->
  switch
    when enc is 'Bool1'
      if v then 1 else 0
    when enc is 'Bool7'
      if v then 127 else 0
    when enc is 'Fixed0' then 0
    when enc is 'Fixed1' then 1
    when enc is 'Int7'
      unless -63 <= v <= 63
        throw new Error "signed value exceeded 7bit range. value:#{v}"
      v & 0x7f
    when enc is 'UInt7'
      unless 0 <= v <= 127
        throw new Error "unsigned value exceeded 7bit range. value:#{v}"
      v
    when typeof enc is 'object'
      unless v of enc
        throw new Error "Unknown mapped value. value:#{v} map:#{enc}"
      enc[v]
    else
      throw new Error "Unknown encoding. value:#{v} encoding:#{enc}"

module.exports =
  encodeUpStream: encodeUpStream
  encodeDownStream: encodeDownStream
 
