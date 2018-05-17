// Protocol
//CONTROL_LINE = /^(.*)\r\n/, // TODO: remove / never used
const CRLF = '\r\n';
const EMPTY = '';
const SPC = ' ';

// Protocol
const INFO_OP = 'INFO';
const CONNECT_OP = 'CONNECT';
const PUB_OP = 'PUB';
const MSG_OP = 'MSG';
const SUB_OP = 'SUB';
const UNSUB_OP = 'UNSUB';
const PING_OP = 'PING';
const PONG_OP = 'PONG';
const OK_OP = '+OK';
const ERR_OP = '-ERR';
const MSG_END = '\n';

// Responses
const OK = OK_OP + CRLF;
const PING = PING_OP + CRLF;
const PONG = PONG_OP + CRLF;

// Regular Expressions
//final RegExp MSG_RE  = new RegExp(r"^MSG\s+([^\s]+)\s+([^\s]+)\s+(([^\s]+)[^\S\r\n]+)?(\d+)\r\n");
final RegExp MSG_RE  = new RegExp(r"^MSG\s+([^\s\r\n]+)\s+([^\s\r\n]+)\s+(([^\s\r\n]+)[^\S\r\n]+)?(\d+)\r\n");
final RegExp OK_RE   = new RegExp(r"^\+OK\s*\r\n");
final RegExp ERR_RE  = new RegExp(r"^-ERR\s+(\'.+\')?\r\n");
final RegExp PING_RE = new RegExp(r"^PING\s*\r\n");
final RegExp PONG_RE = new RegExp(r"^PONG\s*\r\n");
final RegExp INFO_RE = new RegExp(r"^INFO\s+([^\r\n]+)\r\n");