const std = @import("std");
const page_allocator = std.heap.page_allocator;
pub usingnamespace @import("color.zig");

pub const Size = struct {
    rows: c_ushort,
    columns: c_ushort,
    x_pixels: c_ushort,
    y_pixels: c_ushort,
};

pub fn size() Size {
    var window_size: Size = undefined;
    const status = std.os.linux.ioctl(0, 0x00005413, @intFromPtr(&window_size));
    _ = status;
    return window_size;
}

pub fn clear() !void {
    const stdout = std.io.getStdOut().writer();
    _ = try stdout.write("\x1B[2J");
}

pub fn cursorPos(row: u8, col: u8) !void {
    const stdout = std.io.getStdOut().writer();
    _ = try stdout.print("\x1B[{d};{d}H", .{ row, col });
}

pub fn getch() !u8 {
    var ch: u8 = undefined;
    var oldt: std.os.system.termios = undefined;
    _ = std.os.linux.tcgetattr(std.os.STDIN_FILENO, &oldt);
    var newt = oldt;
    newt.lflag.ICANON = false;
    newt.lflag.ECHO = false;
    _ = try std.os.tcsetattr(std.os.STDIN_FILENO, std.os.linux.TCSA.NOW, newt);
    ch = try std.io.getStdIn().reader().readByte();
    _ = try std.os.tcsetattr(std.os.STDIN_FILENO, std.os.linux.TCSA.NOW, oldt);
    return ch;
}
