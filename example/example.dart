import 'dart:typed_data';
import 'package:nats_protocol/parser.dart';
import 'package:nats_protocol/src/client_base.dart';
import 'package:nats_protocol/src/utils.dart';

String msgSimple = "MSG foo.bar 1 21\r\nMessage without reply\r\n";
String msgReply  = "MSG foo.bar 1 _inbox.45 18\r\nMessage with reply\r\n";
String msgOk = "+OK\r\n";
String msgErr = "-ERR 'Some error message'\r\n";
String msgPing = "PING\r\n";
String msgPong = "PONG\r\n";


class Client extends NatsClientBase {}

final NatsClientBase nc = new Client();
NatsParser parser = new NatsParser(nc);

main() async {
  Uint8List bufSimple = string2bytes(msgSimple);
  Uint8List bufReply  = string2bytes(msgReply);
  Uint8List bufOk     = string2bytes(msgOk);
  Uint8List bufErr    = string2bytes(msgErr);
  Uint8List bufPing   = string2bytes(msgPing);
  Uint8List bufPong   = string2bytes(msgPong);


  print('----------------------');
  print('Msg:\n$msgSimple');
  parser.parse(bufSimple);

  print('----------------------');
  print('Msg:\n$msgReply');
  parser.parse(bufReply);

  print('----------------------');
  print('Msg:\n$msgOk');
  parser.parse(bufOk);

  print('----------------------');
  print('Msg:\n$msgErr');
  parser.parse(bufErr);

  print('----------------------');
  print('Msg:\n$msgPing');
  parser.parse(bufPing);

  print('----------------------');
  print('Msg:\n$msgPong');
  parser.parse(bufPong);

  print('----------------------');
} 