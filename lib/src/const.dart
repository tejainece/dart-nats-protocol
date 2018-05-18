import 'dart:typed_data';
import 'package:nats_protocol/src/utils.dart';

// Protocol
//CONTROL_LINE = /^(.*)\r\n/, // TODO: remove / never used
const CRLF = '\r\n';
const EMPTY = '';
const SPC = ' ';
final Uint8List b_CRLF = string2bytes(CRLF);
final Uint8List b_EMPTY = string2bytes(EMPTY);
final Uint8List b_SPC = string2bytes(SPC);

// Protocol
const s_INFO_OP = 'INFO';
const s_CONNECT_OP = 'CONNECT';
const s_PUB_OP = 'PUB';
const s_MSG_OP = 'MSG';
const s_SUB_OP = 'SUB';
const s_UNSUB_OP = 'UNSUB';
const s_PING_OP = 'PING';
const s_PONG_OP = 'PONG';
const s_OK_OP = '+OK';
const s_ERR_OP = '-ERR';
const s_MSG_END = '\n';

// Protocol in Uint8List format
final Uint8List b_INFO_OP = string2bytes(s_INFO_OP);
final Uint8List b_CONNECT_OP = string2bytes(s_CONNECT_OP);
final Uint8List b_PUB_OP = string2bytes(s_PUB_OP);
final Uint8List b_MSG_OP = string2bytes(s_MSG_OP);
final Uint8List b_SUB_OP = string2bytes(s_SUB_OP);
final Uint8List b_UNSUB_OP = string2bytes(s_UNSUB_OP);
final Uint8List b_PING_OP = string2bytes(s_PING_OP);
final Uint8List b_PONG_OP = string2bytes(s_PONG_OP);
final Uint8List b_OK_OP = string2bytes(s_OK_OP);
final Uint8List b_ERR_OP = string2bytes(s_ERR_OP);
final Uint8List b_MSG_END = string2bytes(s_MSG_END);

// Responses
const s_OK = s_OK_OP + CRLF;
const s_PING = s_PING_OP + CRLF;
const s_PONG = s_PONG_OP + CRLF;
final Uint8List b_OK = string2bytes(s_OK);
final Uint8List b_PING = string2bytes(s_PING);
final Uint8List b_PONG = string2bytes(s_PONG);

// Regular Expressions
//final RegExp MSG_RE  = new RegExp(r"^MSG\s+([^\s]+)\s+([^\s]+)\s+(([^\s]+)[^\S\r\n]+)?(\d+)\r\n");
final RegExp msg_re  = new RegExp(r"^MSG\s+([^\s\r\n]+)\s+([^\s\r\n]+)\s+(([^\s\r\n]+)[^\S\r\n]+)?(\d+)\r\n");
final RegExp ok_re   = new RegExp(r"^\+OK\s*\r\n");
final RegExp err_re  = new RegExp(r"^-ERR\s+(\'.+\')?\r\n");
final RegExp ping_re = new RegExp(r"^PING\s*\r\n");
final RegExp pong_re = new RegExp(r"^PONG\s*\r\n");
final RegExp info_re = new RegExp(r"^INFO\s+([^\r\n]+)\r\n");