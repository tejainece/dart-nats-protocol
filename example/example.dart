import 'dart:typed_data';
import 'package:nats_protocol/parser.dart';
import 'package:nats_protocol/src/client_base.dart';  

String msgSimple = "MSG foo.bar 1 9\r\n<payload>\r\n";
String msgReply  = "MSG foo.bar 1 _inbox.45 9\r\n<payload>\r\n";

class Client extends NatsClientBase {}

final NatsClientBase nc = new Client();
NatsParser parser = new NatsParser(nc);

main() async {
  String msg = msgSimple;
  //String msg = msgReply;
  Uint8List buf = new Uint8List.fromList(msg.runes.toList());

  print('Msg: $msg');
  print('Buffer: $buf');
  await parser.parse(buf);
} 