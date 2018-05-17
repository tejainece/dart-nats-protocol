import 'dart:typed_data';
import 'package:nuid/nuid.dart';
import 'package:nats_protocol/src/const.dart';

String createInbox() => "_INBOX." + nuid.next();

class Msg {
  String subject;
  int sid = 0;
  String reply;
  Uint8List data;

  Msg({this.subject: "", this.sid, this.reply: "", this.data});

  static String pub(String subject, String payload, [String replyTo]){
    if(payload == null){
      payload = EMPTY;
    }
    int n = payload.length;

    String subjectAndReplyTo = subject;
    if(replyTo != null && replyTo.isNotEmpty){
      subjectAndReplyTo = '${subject} ${replyTo}';
    }

    return "${PUB_OP} ${subjectAndReplyTo} ${replyTo} ${n}\r\n${payload}\r\n";
  }

  static String sub(String subject, int sid, [String queueGroup]){
    String subjectAndQueue = subject;
    if(queueGroup != null && queueGroup.isNotEmpty){
      subjectAndQueue = '${subject} ${queueGroup}';
    }
    return "${SUB_OP} ${subjectAndQueue} ${sid}\r\n";
  }

  static String unsub(int sid, [int maxMsg]){
    String sidAndMax = '${sid}';
    if(maxMsg != null){
      sidAndMax = '${sid} ${maxMsg}';
    }
    return "${UNSUB_OP} ${sidAndMax}\r\n";
  }
}