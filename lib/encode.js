// Generated by CoffeeScript 2.3.2
(function() {

  /*
    encode Komplete Kontrol message to midi-message for down stream(DAW -> KK)
  */
  /*
    encode Komplete Kontrol message to midi-message
  */
  /*
    encode Komplete Kontrol message to midi-message for up stream(KK -> DAW)
  */
  /*
    decode 7bit value
  */
  /*
  reverse MIDI implementation
  */
  /*
    swap key and value
  */
  var KK_IN_MESSAGEs, KK_OUT_MESSAGEs, MIDI_IN_CCs, MIDI_IN_CH, MIDI_OUT_CCs, MIDI_OUT_CH, SYSEX_DEVICE_ID, SYSEX_HEADER, SYSEX_MESSAGEs, encodeDownStream, encodeMessage, encodeUpStream, encodeValue, reverseMidiImplementation, swapKeyValue;

  ({MIDI_IN_CH, MIDI_IN_CCs, MIDI_OUT_CH, MIDI_OUT_CCs, SYSEX_DEVICE_ID, SYSEX_HEADER, SYSEX_MESSAGEs} = require('./midi-implementation'));

  swapKeyValue = function(obj) {
    var ret;
    ret = {};
    (Object.keys(obj)).forEach(function(key) {
      return ret[obj[key]] = key;
    });
    return ret;
  };

  reverseMidiImplementation = function(ccMessages, sysExMessages) {
    var cc, def, encoding, ret, sysex;
    ret = {};
    for (cc in ccMessages) {
      def = ccMessages[cc];
      encoding = (typeof def.encoding === 'string') ? def.encoding : swapKeyValue(def.encoding);
      ret[def.id + ('index' in def ? def.index : '')] = {
        cc: parseInt(cc),
        encoding: encoding,
        desc: def.desc
      };
    }
    for (sysex in sysExMessages) {
      def = sysExMessages[sysex];
      encoding = (typeof def.encoding === 'string') ? def.encoding : swapKeyValue(def.encoding);
      ret[def.id] = {
        sysex: parseInt(sysex),
        encoding: encoding,
        hasIndex: def.hasIndex,
        hasString: def.hasString,
        desc: def.desc
      };
    }
    return ret;
  };

  KK_IN_MESSAGEs = reverseMidiImplementation(MIDI_IN_CCs, SYSEX_MESSAGEs);

  KK_OUT_MESSAGEs = reverseMidiImplementation(MIDI_OUT_CCs);

  encodeDownStream = function(kkMessage) {
    if (kkMessage.id === 'Unknown') {
      return kkMessage.midiMessage;
    } else {
      return encodeMessage(kkMessage, KK_IN_MESSAGEs, MIDI_IN_CH);
    }
  };

  encodeUpStream = function(kkMessage) {
    if (kkMessage.id === 'Unknown') {
      return kkMessage.midiMessage;
    } else {
      return encodeMessage(kkMessage, KK_OUT_MESSAGEs, MIDI_OUT_CH);
    }
  };

  encodeMessage = function(kkMessage, messages, ch) {
    var data, def;
    def = messages[kkMessage.id];
    if (def == null) {
      def = messages[kkMessage.id + ('index' in kkMessage ? kkMessage.index : '')];
    }
    if (!def) {
      throw new Error(`Unknown message. kkMessage:${kkMessage}`);
    }
    if ('cc' in def) {
      return {
        type: 'ControlChange',
        channel: ch,
        control: def.cc,
        value: encodeValue(kkMessage.value, def.encoding)
      };
    } else if ('sysex' in def) {
      data = [...SYSEX_HEADER];
      data.push(def.sysex);
      // value
      data.push(def.encoding ? encodeValue(kkMessage.value, def.encoding) : 0);
      // index
      data.push((function() {
        if (def.hasIndex) {
          if (!('index' in kkMessage)) {
            throw new Error(`Message doesn't have index. kkMessage:${kkMessage}`);
          }
          return kkMessage.index;
        } else {
          return 0;
        }
      })());
      // String
      if (def.hasString) {
        data = typeof kkMessage.value === 'string' ? [...data, ...(Array.prototype.slice.call(Buffer.from(kkMessage.value), 0))] : typeof kkMessage.string === 'string' ? [...data, ...(Array.prototype.slice.call(Buffer.from(kkMessage.string), 0))] : void 0;
      }
      return {
        type: 'SysEx',
        deviceId: SYSEX_DEVICE_ID,
        data: data
      };
    } else {
      throw new Error(`Wrong definition. def:${def}`);
    }
  };

  encodeValue = function(v, enc) {
    switch (false) {
      case enc !== 'Bool1':
        if (v) {
          return 1;
        } else {
          return 0;
        }
        break;
      case enc !== 'Bool7':
        if (v) {
          return 127;
        } else {
          return 0;
        }
        break;
      case enc !== 'Fixed0':
        return 0;
      case enc !== 'Fixed1':
        return 1;
      case enc !== 'Int7':
        if (!((-63 <= v && v <= 63))) {
          throw new Error(`signed value exceeded 7bit range. value:${v}`);
        }
        return v & 0x7f;
      case enc !== 'UInt7':
        if (!((0 <= v && v <= 127))) {
          throw new Error(`unsigned value exceeded 7bit range. value:${v}`);
        }
        return v;
      case typeof enc !== 'object':
        if (!(v in enc)) {
          throw new Error(`Unknown mapped value. value:${v} map:${enc}`);
        }
        return enc[v];
      default:
        throw new Error(`Unknown encoding. value:${v} encoding:${enc}`);
    }
  };

  module.exports = {
    encodeUpStream: encodeUpStream,
    encodeDownStream: encodeDownStream
  };

}).call(this);