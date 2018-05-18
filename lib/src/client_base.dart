import 'dart:typed_data';
import 'package:nats_protocol/src/msg.dart';

abstract class NatsClientBase {
  NatsClientBase(){

  }

  send(Uint8List buf){
    String msg = new String.fromCharCodes(buf);
    print('Sending: $msg');
  }

  sendString(String msg){
    Uint8List buf = new Uint8List.fromList(msg.runes.toList());
    send(buf);
  }

  process_msg(Msg msg) async {
    String payload = new String.fromCharCodes(msg.data);
    print('ID: ${msg.sid}');
    print('  subject: ${msg.subject}');
    print('  reply:   ${msg.reply}');
    print('  payload:');
    print('    ${msg.data}');
    print('    $payload');
  }

  process_ok() async {
    print('Processing: ok');
  }

  process_err(String error) async {
    print('Processing error: $error');
  }

  process_ping() async {
    sendString('PONG');
  }

  process_pong() async {
    print('Processing pong');
  }
}