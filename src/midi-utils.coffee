midi = require 'midi'

module.exports =
  openVirtualMidi: (inName, outName) ->
    outName ?= inName
    input = new midi.input()
    output = new midi.output()
    input.openVirtualPort inName
    # ignore sysex, timing, active sensing
    input.ignoreTypes off, on, off
    output.openVirtualPort outName
    in: midi.createReadStream input
    out: midi.createWriteStream output

  openMidi: (inName, outName) ->
    outName ?= inName
    input = new midi.input()
    output = new midi.output()
    inputIndex = [0...input.getPortCount()].find (i) ->
      input.getPortName(i) is inName
    outputIndex = [0...input.getPortCount()].find (i) ->
      output.getPortName(i) is inName
    if typeof inputIndex is 'undefined'
      throw new Error "Unfound MIDI input port. name:#{inName}"
    if typeof outputIndex is 'undefined'
      throw new Error "Unfound MIDI output port. name:#{inName}"
    input.openPort inputIndex
    # ignore sysex, timing, active sensing
    input.ignoreTypes off, on, off
    output.openPort outputIndex
    in: midi.createReadStream input
    out: midi.createWriteStream output
