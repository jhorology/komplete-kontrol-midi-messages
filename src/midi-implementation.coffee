###
  MIDI implementation fo DAW MIDI-IN
###
MIDI_IN_CH = 16
MIDI_IN_CCs =
  1:
    id: 'Hello'
    encoding: 'Fixed0'  # 0=off, 127=on
    desc: 'Not sure, activate deep-integration'
  2:
    id: 'Goodby'
    encoding: 'Fixed0'  # 0=off, 127=on
    desc: 'Not sure, disable deep-integration'
  16:
    id: 'Play'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Play button.'
  17:
    id: 'Restart'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Restart button (Shift + Play), maybe unused.'
  18:
    id: 'Rec'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Rec button.'
  19:
    id: 'Count-In'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Count-In button (Shift + Rec).'
  20:
    id: 'Stop'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Stop button.'
  21:
    id: 'Clear'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Clear button (Shift + Stop), maybe unused.'
  22:
    id: 'Loop'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Loop button.'
  23:
    id: 'Metro'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Metro button.'
  24:
    id: 'Tempo'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'Set LED state of Tempo button. maybe unused.'
  32:
    id: 'Undo'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'LED state of Undo button. maybe unused.'
  33:
    id: 'Redo'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'LED state of Redo button. maybe unused.'
  34:
    id: 'Quantize'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'LED state of Quantize button. maybe unused.'
  35:
    id: 'Auto'
    encoding: 'Bool7'  # 0=off, 127=on
    desc: 'LED state of Auto button (Shift + Quantize).'
  80:
    id: 'Knob'
    index: 0
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 1 absolute value, usually uesd as absolute position of fader of Mixer.'
  81:
    id: 'Knob'
    index: 1
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 2 absolute value, usually uesd as absolute position of fader of Mixer.'
  82:
    id: 'Knob'
    index: 2
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 3 absolute value, usually uesd as absolute position of fader of Mixer.'
  83:
    id: 'Knob'
    index: 3
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 4 absolute value, usually uesd as absolute position of fader of Mixer.'
  84:
    id: 'Knob'
    index: 4
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 5 absolute value, usually uesd as absolute position of fader of Mixer.'
  85:
    id: 'Knob'
    index: 5
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 6 absolute value, usually uesd as absolute position of fader of Mixer.'
  86:
    id: 'Knob'
    index: 6
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 7 absolute value, usually uesd as absolute position of fader of Mixer.'
  87:
    id: 'Knob'
    index: 7
    encoding: 'UInt7'  # 0 - 127
    desc: 'Knob 8 absolute value, usually uesd as absolute position of fader of Mixer.'
  88:
    id: 'ShiftKnob'
    index: 0
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 1 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  89:
    id: 'ShiftKnob'
    index: 1
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 2 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  90:
    id: 'ShiftKnob'
    index: 2
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 3 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  91:
    id: 'ShiftKnob'
    index: 3
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 4 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  92:
    id: 'ShiftKnob'
    index: 4
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 5 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  93:
    id: 'ShiftKnob'
    index: 5
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 6 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  94:
    id: 'ShiftKnob'
    index: 6
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 7 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  95:
    id: 'ShiftKnob'
    index: 7
    encoding: 'UInt7'  # 0 - 127
    desc: 'Shift + Knob 8 absolute value, usually uesd as absolute position of pan of Mixer, center=64.'
  96:
    id: 'ClipLaunch'
    encoding: 'Fixed1'  # always 1
    desc: 'Not sure, just a Feedback for DialPush?'
  97:
    id: 'ClipStop'
    encoding: 'UInt7'  # 1, 127
    desc: 'Not sure, just a Feedback for ShiftDialPush?'

SYSEX_DEVICE_ID = [0, 33, 9]
SYSEX_HEADER = [0, 0, 68, 67, 1, 0]
SYSEX_MESSAGEs =
  64:
    id: 'TrackType'
    encoding: {0: 'EMPTY', 1: 'DEFAULT', 6: 'MASTER'}
    hasIndex: on
    hasString: off
    desc: 'Set type of indexed track.'
  65:
    id: 'TrackChanged'
    encoding: 'UInt7'   # value encoding
    hasIndex: off
    hasString: on
    desc: 'Notify instance id of KK for last selected track. "NIKBxx" or ""'
  66:
    id: 'TrackSelection'
    encoding: 'Bool1'  # value encoding
    hasIndex: on
    hasString: off
    desc: 'Set selection state of indexed track.'
  67:
    id: 'TrackMute'
    encoding: 'Bool1'  # value encoding
    hasIndex: on
    hasString: off
    desc: 'Set mute state of indexed track.'
  68:
    id: 'TrackSolo'
    encoding: 'Bool1'  # value encoding
    hasIndex: on
    hasString: off
    desc: 'Set solo state of indexed track.'
  68:
    id: 'TrackArm'
    encoding: 'Bool1'  # value encoding
    hasIndex: on
    hasString: off
    desc: 'Set arm state of indexed track.'
  70:
    id: 'TrackVolume'
    encoding: 'Fixed0'  # always 0
    hasIndex: on
    hasString: on
    desc: 'Set display volume value of indexed track.'
  71:
    id: 'TrackPanning'
    encoding: 'Fixed0'  # always 0
    hasIndex: on
    hasString: on
    desc: 'Set display pannning value of indexed track.'
  72:
    id: 'TrackName'
    encoding: 'Fixed0'  # always 0
    hasIndex: on
    hasString: on
    desc: 'Set name of indexed track.'
  
###
  MIDI implementation fo DAW MIDI-OUT
###
MIDI_OUT_CH = 16
MIDI_OUT_CCs =
  16:
    id: 'Play'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Play button.'
  17:
    id: 'Restart'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Restart button (Shift + Play).'
  18:
    id: 'Rec'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Rec button.'
  19:
    id: 'Countin'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Countin button (Shift + Rec).'
  20:
    id: 'Stop'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Stop button.'
  21:
    id: 'Clear'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Clear button (Shift + Stop).'
  22:
    id: 'Loop'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Loop button.'
  23:
    id: 'Metro'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Metro button.'
  24:
    id: 'Tempo'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Tempo button.'
  32:
    id: 'Undo'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Undo button.'
  33:
    id: 'Redo'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Redo button.'
  34:
    id: 'Quantize'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Quantize button.'
  35:
    id: 'Auto'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Auto button (Shift + Quantize).'
  48:
    id: 'DialVerticalClick'
    encoding: 'Int7'  # signed 7bit
    desc: 'Trigger of Dial up/down click, click down=1, click up=-1'
  50:
    id: 'DialHorizontalClick'
    encoding: 'Int7'  # signed 7bit
    desc: 'Trigger of Dial left/right click, click right=1, click left=-1'
  52:
    id: 'DialRotate'
    encoding: 'Int7'  # signed 7bit
    desc: 'Dial encoder value, rotate right=1, rotate left=-1'
  67:
    id: 'Mute'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Muteo button (Shift + <).'
  68:
    id: 'Solo'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Muteo button (Shift + >).'
  80:
    id: 'Knob'
    index: 0
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  81:
    id: 'Knob'
    index: 1
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  82:
    id: 'Knob'
    index: 2
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  83:
    id: 'Knob'
    index: 3
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  84:
    id: 'Knob'
    index: 4
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  85:
    id: 'Knob'
    index: 5
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  86:
    id: 'Knob'
    index: 6
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  87:
    id: 'Knob'
    index: 7
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Knob 1 relational value, usually uesd as control fader of Mixer.'
  88:
    id: 'ShiftKnob'
    index: 0
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 1 relational value, usually uesd as control pan of Mixer.'
  88:
    id: 'ShiftKnob'
    index: 1
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 2 relational value, usually uesd as control pan of Mixer.'
  89:
    id: 'ShiftKnob'
    index: 2
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 3 relational value, usually uesd as control pan of Mixer.'
  90:
    id: 'ShiftKnob'
    index: 3
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 4 relational value, usually uesd as control pan of Mixer.'
  91:
    id: 'ShiftKnob'
    index: 4
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 5 relational value, usually uesd as control pan of Mixer.'
  92:
    id: 'ShiftKnob'
    index: 5
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 6 relational value, usually uesd as control pan of Mixer.'
  93:
    id: 'ShiftKnob'
    index: 6
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 7 relational value, usually uesd as control pan of Mixer.'
  94:
    id: 'ShiftKnob'
    index: 7
    encoding: 'Int7'  # signed 7bit rotate right=1, rotate left=-1
    desc: 'Shift + Knob 8 relational value, usually uesd as control pan of Mixer.'
  96:
    id: 'DialPush'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Dial push. usually used as trigger of launching clip.'
  97:
    id: 'ShiftDialPush'
    encoding: 'Fixed1'  # always 1
    desc: 'Trigger of Shfit Dial push. usually used as trigger of stop clip.'

module.exports =
  MIDI_IN_CH: MIDI_IN_CH
  MIDI_IN_CCs: MIDI_IN_CCs
  MIDI_OUT_CH: MIDI_OUT_CH
  MIDI_OUT_CCs: MIDI_OUT_CCs
  SYSEX_DEVICE_ID: SYSEX_DEVICE_ID
  SYSEX_HEADER: SYSEX_HEADER
  SYSEX_MESSAGEs: SYSEX_MESSAGEs
