{Transform} = require 'stream'
{decodeDownStream, decodeUpStream} = require './decode'
{encodeDownStream, encodeUpStream} = require './encode'

###
 transform midi-message to komplete-kontrol message for down stream (DAW -> KK)
###
class DownStreamDecoder extends Transform
  constructor: (opts) ->
    super objectMode: on
    
  _transform: (midiMessage, encoding, cb) ->
    try
      kkMessage = decodeDownStream midiMessage
      @push kkMessage
      cb()
    catch error
      cb(error)
###
 transform midi-message to komplete-kontrol message for up stream (KK -> DAW)
###
class UpStreamDecoder extends Transform
  constructor: (opts) ->
    super objectMode: on
    
  _transform: (midiMessage, encoding, cb) ->
    try
      kkMessage = decodeUpStream midiMessage
      @push kkMessage
      cb()
    catch error
      cb(error)


###
 transform komplete-kontrol message to midi-message for down stream (DAW -> KK)
###
class DownStreamEncoder extends Transform
  constructor: (opts) ->
    super objectMode: on
    
  _transform: (kkMessage, encoding, cb) ->
    try
      midiMessage = encodeDownStream kkMessage
      @push midiMessage
      cb()
    catch error
      cb(error)
###
 transform komplete-kontrol message to midi-message for up stream (KK -> DAW)
###
class UpStreamEncoder extends Transform
  constructor: (opts) ->
    super objectMode: on
    
  _transform: (kkMessage, encoding, cb) ->
    try
      midiMessage = encodeUpStream kkMessage
      @push midiMessage
      cb()
    catch error
      cb(error)

module.exports =
  DownStreamDecoder: DownStreamDecoder
  UpStreamDecoder: UpStreamDecoder
  DownStreamEncoder: DownStreamEncoder
  UpStreamEncoder: UpStreamEncoder
