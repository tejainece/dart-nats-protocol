import 'package:nats_protocol/src/msg.dart';

abstract class NatsClientBase {
  NatsClientBase(){
    
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

}