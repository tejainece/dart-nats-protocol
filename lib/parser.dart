import 'dart:typed_data';
import 'package:nats_protocol/src/const.dart';
import 'package:nats_protocol/src/msg.dart';
import 'package:nats_protocol/src/client_base.dart';

// States
const int MAX_CONTROL_LINE_SIZE = 1024;

enum _State {
  parsing,
  awaitingCtrlLine,
  awaitingPayload
}

class NatsParser {
  Uint8List _buf = new List<int>();

  _State _state;
  int needed;
  Msg _msg;

  NatsClientBase nc;

  NatsParser(this.nc){
    reset();
  }

  reset() {
    _buf.clear();
    _state = _State.awaitingCtrlLine;
    needed = 0;
  }

  /*
    Parses the wire protocol from NATS for the client
    and dispatches the subscr iption callbacks.
  */
  parse(Uint8List data) async {
    _buf.addAll(data);

    switch(_state){
      case _State.awaitingCtrlLine:
        _parseCtrlLine();
        break;
      case _State.awaitingPayload:
        _parseMsgPayload();
        break;
      case _State.parsing:
        // Nothing to do
        break;
    }
  }

  _parseCtrlLine() async {
    _state = _State.parsing;

    String msgData = new String.fromCharCodes(_buf);

    Match msg = MSG_RE.firstMatch(msgData);
    if (msg != null){
      print('hice match');
      try {
        _msg = new Msg(
          subject: msg.group(1),
          sid: int.parse(msg.group(2)),
          reply: msg.group(3)
        );
        needed = int.parse(msg.group(5));
        _buf.removeRange(0, msg.group(0).length);
        _parseMsgPayload();
        return;
      } catch(e) {
        print('Error: $e');
        //throw ErrProtocol("nats: malformed MSG");
      }
    }

    _state = _State.awaitingCtrlLine;
  }

  _parseMsgPayload() async {
    _state = _State.parsing;

    if (_buf.length >= needed + CRLF_SIZE) {
      // Consume msg payload from _buffer and set next parser state.
      _msg.data = _buf.sublist(0, this.needed);
      _buf.removeRange(0, this.needed + CRLF_SIZE);
      await nc.process_msg(_msg);
      _parseCtrlLine();
      return;
    }

    _state = _State.awaitingPayload;
  }
}