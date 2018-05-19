import 'dart:convert';
import 'dart:typed_data';
import 'package:nats_protocol/src/const.dart';
import 'package:nats_protocol/src/msg.dart';
import 'package:nats_protocol/client_base.dart';

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

    Match msg = msg_re.firstMatch(msgData);
    if (msg != null){
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

    Match ok = ok_re.firstMatch(msgData);
    if (ok != null){
      // Do nothing and just skip.
      nc.process_ok();
      _buf.removeRange(0, ok.end);
      _parseCtrlLine();
      return;
    }

    Match err = err_re.firstMatch(msgData);
    if (err != null){
      String err_msg = err.group(1);
      await nc.process_err(err_msg);
      _buf.removeRange(0, err.end);
      _parseCtrlLine();
      return;
    }

    Match ping = ping_re.firstMatch(msgData);
    if(ping != null){
      _buf.removeRange(0, ping.end);
      await nc.process_ping();
      _parseCtrlLine();
      return;
    }

    Match pong = pong_re.firstMatch(msgData);
    if (pong != null) {
      _buf.removeRange(0, pong.end);
      await nc.process_pong();
      _parseCtrlLine();
      return;
    }

    Match info = info_re.firstMatch(msgData);
    if (info != null){
      Map<String,dynamic> srv_info = jsonDecode(info.group(1));
      await nc.process_info(srv_info);
      _buf.removeRange(0, info.end);
      _parseCtrlLine();
      return;
    }

    _state = _State.awaitingCtrlLine;
  }

  _parseMsgPayload() async {
    _state = _State.parsing;

    if (_buf.length >= needed + CRLF.length) {
      // Consume msg payload from _buffer and set next parser state.
      _msg.data = _buf.sublist(0, needed);
      _buf.removeRange(0, needed + CRLF.length);
      await nc.process_msg(_msg);
      _parseCtrlLine();
      return;
    }

    _state = _State.awaitingPayload;
  }
}