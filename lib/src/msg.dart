import 'dart:typed_data';
import 'package:nuid/nuid.dart';
import 'package:nats_protocol/src/utils.dart';
import 'package:nats_protocol/src/const.dart';

String createInbox() => "_INBOX." + nuid.next();

class Msg {
  String subject;
  int sid = 0;
  String reply;
  Uint8List data;

  Msg({this.subject: "", this.sid, this.reply: "", this.data});

  static Uint8List pub(String subject, Uint8List payload, [String replyTo=""]){
    Uint8List msg = new Uint8List.fromList(b_PUB_OP);
    msg.addAll(string2List(' ${subject}'));
    if(replyTo.isNotEmpty){
      msg.addAll(string2List(' ${replyTo}'));
    }

    //return "${s_PUB_OP} ${subjectAndReplyTo} ${n}\r\n${payload}\r\n";
    if(payload == null){
      payload = b_EMPTY;
    }
    int n = payload.length;
    msg.addAll(string2bytes(' ${n}'));
    msg.addAll(b_CRLF);
    msg.addAll(payload);
    msg.addAll(b_CRLF);
    return msg;
  }

  static Uint8List sub(String subject, int sid, [String queueGroup=""]){
    Uint8List msg = new Uint8List.fromList(b_SUB_OP);
    msg.addAll(string2bytes(' ${subject}'));
    if(queueGroup.isNotEmpty){
      msg.addAll(string2bytes(' ${queueGroup}'));
    }
    msg.addAll(b_CRLF);
    return msg;
  }

  static Uint8List unsub(int sid, [int maxMsg]){
    Uint8List msg = new Uint8List.fromList(b_UNSUB_OP);
    msg.addAll(string2bytes('${sid}'));
    if(maxMsg != null){
      msg.addAll(string2bytes(' ${maxMsg}'));
    }
    msg.addAll(b_CRLF);
    return msg;
  }
}