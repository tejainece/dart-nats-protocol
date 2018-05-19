import 'dart:typed_data';
import 'package:nats_protocol/src/msg.dart';
import 'package:nats_protocol/src/const.dart';

abstract class NatsClientBase {
  bool isSvrAlive = false;
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
    send(b_PONG);
  }

  process_pong() async {
    print('Processing pong');
  }

  process_info(Map<String,dynamic> info) async {
    print(info);
  }
}