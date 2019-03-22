midiMessage  = require '@lachenmayer/midi-messages'
midiUtils    = require './src/midi-utils'
kkMessage    = require './src/kk-midi-messages'
colors       = require 'colors'

# color theme
colors.setTheme
  upFirst: ['white', 'bold']
  upFollow: 'gray'
  downFirst: ['cyan', 'bold']
  downFollow: ['cyan', 'dim']

KOMPLETE_KONTROL_DAW_PORT = 'Komplete Kontrol M DAW'
DAW_BRIDGE_PORT = 'Komplete Kontrol Bridge DAW'
# MIDI Stream
kk = midiUtils.openMidi KOMPLETE_KONTROL_DAW_PORT
daw = midiUtils.openVirtualMidi DAW_BRIDGE_PORT


# MIDI message stream
downStreamMidiDecoder = new midiMessage.DecodeStream()
downStreamMidiEncoder = new midiMessage.EncodeStream useRunningStatus: on
upStreamMidiDecoder = new midiMessage.DecodeStream()
# Live doesn't support running status?
upStreamMidiEncoder = new midiMessage.EncodeStream  useRunningStatus: off

# MIDI Komlete Kontrol message stream
downStreamKKDecoder = new kkMessage.DownStreamDecoder()
downStreamKKEncoder = new kkMessage.DownStreamEncoder()
upStreamKKDecoder = new kkMessage.UpStreamDecoder()
upStreamKKEncoder = new kkMessage.UpStreamEncoder()

# daw.in.on 'data', (msg) ->
#   console.info 'DAW -> KK  RAW'.downFirst, msg
# downStreamMidiDecoder.on 'data', (msg) ->
#   console.info 'DAW -> KK MIDI'.downFollow, msg
# downStreamKKDecoder.on 'data', (msg) ->
#   console.info 'DAW -> KK   KK'.downFollow, msg
# downStreamKKEncoder.on 'data', (msg) ->
#   console.info 'DAW -> KK MIDI'.downFollow, msg
# downStreamMidiEncoder.on 'data', (msg) ->
#   console.info 'DAW -> KK  RAW'.downFollow, msg

# kk.in.on 'data', (msg) ->
#   console.info 'KK -> DAW  RAW'.upFirst, msg
# upStreamMidiDecoder.on 'data', (msg) ->
#   console.info 'KK -> DAW MIDI'.upFollow, msg
# upStreamKKDecoder.on 'data', (msg) ->
#   console.info 'KK -> DAW   KK'.upFollow, msg
# upStreamKKEncoder.on 'data', (msg) ->
#   console.info 'KK -> DAW MIDI'.upFollow, msg
# upStreamMidiEncoder.on 'data', (msg) ->
#   console.info 'KK -> DAW  RAW'.upFollow, msg


downStreamKKDecoder.on 'data', (msg) ->
  console.info 'DAW -> KK   KK'.downFirst, msg

upStreamKKDecoder.on 'data', (msg) ->
  console.info 'KK -> DAW   KK'.upFirst, msg

# down stream Komplete Kontrol <- DAW
daw.in
  .pipe downStreamMidiDecoder
  .pipe downStreamKKDecoder
  .pipe downStreamKKEncoder
  .pipe downStreamMidiEncoder
  .pipe kk.out

#  up stream Komplete Kontrol -> DAW
kk.in
  .pipe upStreamMidiDecoder
  .pipe upStreamKKDecoder
  .pipe upStreamKKEncoder
  .pipe upStreamMidiEncoder
  .pipe daw.out
