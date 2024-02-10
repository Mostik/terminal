const std = @import("std");

pub const Default = "\x1B[0m";
pub const Bold = "\x1B[1m";
pub const Faint = "\x1B[2m";
pub const Underline = "\x1B[4m";
pub const Blink = "\x1B[5m";

pub const fgBlack = "\x1B[30m";
pub const fgRed = "\x1B[31m";
pub const fgGreen = "\x1B[32m";
pub const fgYellow = "\x1B[33m";
pub const fgBlue = "\x1B[34m";
pub const fgPurple = "\x1B[35m";
pub const fgCyan = "\x1B[36m";
pub const fgWhite = "\x1B[37m";

pub const bgBlack = "\x1B[40m";
pub const bgRed = "\x1B[41m";
pub const bgGreen = "\x1B[42m";
pub const bgYellow = "\x1B[43m";
pub const bgBlue = "\x1B[44m";
pub const bgPurple = "\x1B[45m";
pub const bgCyan = "\x1B[46m";
pub const bgWhite = "\x1B[47m";
