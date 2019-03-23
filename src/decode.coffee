{
  MIDI_IN_CH,
  MIDI_IN_CCs,
  MIDI_OUT_CH,
  MIDI_OUT_CCs,
  SYSEX_DEVICE_ID,
  SYSEX_HEADER,
  SYSEX_MESSAGEs
} = require './midi-implementation'

###
 decode midi-in (DAW -> KK) message
###
decodeDownStream = (midiMessage) ->
  msg = switch
    when midiMessage.type is 'SysEx'
      parseSysEx midiMessage
    when midiMessage.channel is MIDI_IN_CH and midiMessage.type is 'ControlChange'
      parseCC midiMessage, MIDI_IN_CCs
  msg or
    id: 'Unknown'
    midiMessage: midiMessage

###
 decode midi-out (KK -> DAW) message
###
decodeUpStream = (midiMessage) ->
  msg = if midiMessage.channel is MIDI_OUT_CH and midiMessage.type is 'ControlChange'
    parseCC midiMessage, MIDI_OUT_CCs
  msg or
    id: 'Unknown'
    midiMessage: midiMessage

###
 parse sysex message
###
parseSysEx = (midiMessage) ->
  unless (bytesEquals SYSEX_DEVICE_ID, midiMessage.deviceId) and \
     (bytesEquals SYSEX_HEADER, midiMessage.data)
     return
  data = midiMessage.data.slice SYSEX_HEADER.length
  def = SYSEX_MESSAGEs[data[0]]
  unless def
    return
  value = data[1]
  index = data[2]
  result =
   id: def.id
  # has index?
  if def.hasIndex
    result.index = index
  else
    unless index is 0
      throw new Error "Maybe wrong definition. index isn't 0. id:#{def.id} index:#{index}"
  # has value?
  v = decodeValue value, def.encoding
  unless typeof def.encoding is 'string' and def.encoding.startsWith 'Fixed'
    result.value = v
  # has String?
  if def.hasString
    str = (Buffer.from data.slice 3).toString()
    if 'value' of result
      result.string = str
    else
      result.value = str
  result
###
 parse control change message
###
parseCC = (midiMessage, CCs) ->
  def = CCs[midiMessage.control]
  return unless def
  result =
    id: def.id
  if def.index isnt undefined
    result.index = def.index
  v = decodeValue midiMessage.value, def.encoding
  if typeof v isnt 'undefined'
    result.value = v
  result

###
 decode 7bit value
###
decodeValue = (v, enc) ->
  switch
    when enc is 'Bool1'
      unless v in [0, 1]
        throw new Error "Wrong definition of encoding [#{enc}]. value:#{v}"
      v isnt 0
    when enc is 'Bool7'
      unless v in [0, 127]
        throw new Error "Wrong definition of encoding [#{enc}]. value:#{v}"
      v isnt 0
    when enc is 'Int7'
      if v & 0x40 then v - 0x80 else v
    when typeof enc is 'object'
      unless v of enc
        throw new Error "Wrong definition of encoding [#{enc}]. value:#{v}"
      enc[v]
    when enc is 'UInt7' then v
    when enc is 'Fixed0'
      unless v is 0
        throw new Error "Wrong definition of encoding [#{enc}]. value:#{v}"
      undefined
    when enc is 'Fixed1'
      unless v is 1
        throw new Error "Wrong definition of encoding [#{enc}]. value:#{v}"
      undefined
    else
      throw new Error "Unknown definition of encoding [#{enc}]."

###
 compare primitive array
###
bytesEquals = (expect, src, offset = 0) ->
  expect.every (b, i) -> src.length > i and b is src[i + offset]


module.exports =
  decodeUpStream: decodeUpStream
  decodeDownStream: decodeDownStream
