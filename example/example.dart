import 'dart:typed_data';
import 'package:nats_protocol/parser.dart';
import 'package:nats_protocol/src/client_base.dart';  

String msgSimple = "MSG foo.bar 1 21\r\nMessage without reply\r\n";
String msgReply  = "MSG foo.bar 1 _inbox.45 18\r\nMessage with reply\r\n";
String msgOk = "+OK\r\n";
String msgErr = "-ERR 'Some error message'\r\n";

class Client extends NatsClientBase {}

final NatsClientBase nc = new Client();
NatsParser parser = new NatsParser(nc);

main() async {
  Uint8List bufSimple = new Uint8List.fromList(msgSimple.runes.toList());
  Uint8List bufReply = new Uint8List.fromList(msgReply.runes.toList());
  Uint8List bufOk = new Uint8List.fromList(msgOk.runes.toList());
  Uint8List bufErr = new Uint8List.fromList(msgErr.runes.toList());


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
} 