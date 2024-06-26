const std = @import("std");

pub const Type = enum {
    fg,
    bg,
};

pub const Colors = enum(u3) {
    black = 0,
    red = 1,
    green = 2,
    yellow = 3,
    blue = 4,
    purple = 5,
    cyan = 6,
    white = 7,
};

pub fn Color(t: ?Type) struct {
    tp: ?Type = .fg,

    pub inline fn bit(self: @This(), col: u3) []const u8 {
        if (self.tp == .fg) {
            return std.fmt.comptimePrint("\x1b[3{d}m", .{col});
        } else {
            return std.fmt.comptimePrint("\x1b[4{d}m", .{col});
        }
    }
    pub inline fn byte(self: @This(), col: u8) []const u8 {
        if (self.tp == .fg) {
            return std.fmt.comptimePrint("\x1b[38:5:{d}m", .{col});
        } else {
            return std.fmt.comptimePrint("\x1b[48:5:{d}m", .{col});
        }
    }
    pub inline fn rgb(self: @This(), r: u8, g: u8, b: u8) []const u8 {
        if (self.tp == .fg) {
            return std.fmt.comptimePrint("\x1b[38;2;{d};{d};{d}m", .{ r, g, b });
        } else {
            return std.fmt.comptimePrint("\x1b[48;2;{d};{d};{d}m", .{ r, g, b });
        }
    }
    pub inline fn hex(self: @This(), col: usize) []const u8 {
        if (self.tp == .fg) {
            return std.fmt.comptimePrint("\x1b[38;2;{d};{d};{d}m", .{
                @as(u8, @truncate(col >> 16)),
                @as(u8, @truncate(col >> 8)),
                @as(u8, @truncate(col >> 0)),
            });
        } else {
            return std.fmt.comptimePrint("\x1b[48;2;{d};{d};{d}m", .{
                @as(u8, @truncate(col >> 16)),
                @as(u8, @truncate(col >> 8)),
                @as(u8, @truncate(col >> 0)),
            });
        }
    }
    pub inline fn enm(self: @This(), col: Colors) []const u8 {
        if (self.tp == .fg) {
            return std.fmt.comptimePrint("\x1b[3{d}m", .{@intFromEnum(col)});
        } else {
            return std.fmt.comptimePrint("\x1b[4{d}m", .{@intFromEnum(col)});
        }
    }
    pub inline fn default(self: @This()) []const u8 {
        if (self.tp == .fg) {
            return "\x1b[39m";
        } else {
            return "\x1b[49m";
        }
    }

    pub inline fn reset(_: @This()) []const u8 {
        return "\x1b[0m";
    }
    pub inline fn erase(_: @This()) []const u8 {
        return "\x1b[K";
    }
    pub inline fn bold(_: @This()) []const u8 {
        return "\x1b[1m";
    }
    pub inline fn faint(_: @This()) []const u8 {
        return "\x1b[2m";
    }
    pub inline fn underline(_: @This()) []const u8 {
        return "\x1b[4m";
    }
} {
    return .{
        .tp = t,
    };
}

test "some" {
    std.debug.print("\n{s} default bit: 4          \n", .{Color(.fg).bit(4)});
    std.debug.print("{s}{s} bold byte: 82          \n", .{ Color(.fg).byte(82), Color(null).bold() });
    std.debug.print("{s}{s} faint rgb: 255, 0, 255 \n", .{ Color(.fg).rgb(255, 0, 255), Color(null).faint() });
    std.debug.print("{s}{s} underline hex: 0x22ffde   {s}  \n", .{ Color(.fg).hex(0x22ffde), Color(null).underline(), Color(null).reset() });
    std.debug.print("{s} enm: .yellow      \n", .{Color(.fg).enm(.yellow)});

    inline for (1..255) |i| {
        std.debug.print("{s}{s} {d} {s}", .{
            Color(.bg).byte(@as(u8, @intCast(i))),
            Color(.fg).byte(@as(u8, @intCast(255 - i))),
            i,
            Color(.bg).reset(),
        });
        if (i % 9 == 0) {
            std.debug.print("\n", .{});
        }
    }
}
