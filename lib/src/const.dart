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

// Sizes
const int CRLF_SIZE = CRLF.length;
const int OK_SIZE = OK.length;
const int PING_SIZE = PING.length;
const int PONG_SIZE = PONG.length;
const int MSG_OP_SIZE = MSG_OP.length;
const int ERR_OP_SIZE = ERR_OP.length;

// Regular Expressions
final RegExp MSG_RE  = new RegExp('\AMSG\s+([^\s]+)\s+([^\s]+)\s+(([^\s]+)[^\S\r\n]+)?(\d+)\r\n');
final RegExp OK_RE   = new RegExp('\A\+OK\s*\r\n');
final RegExp ERR_RE  = new RegExp('\A-ERR\s+(\'.+\')?\r\n');
final RegExp PING_RE = new RegExp('\APING\s*\r\n');
final RegExp PONG_RE = new RegExp('\APONG\s*\r\n');
final RegExp INFO_RE = new RegExp('\AINFO\s+([^\r\n]+)\r\n');