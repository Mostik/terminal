const std = @import("std");
const page_allocator = std.heap.page_allocator;
pub const Color = @import("./color.zig");

pub fn format_string(str: []const u8, args: anytype) ![]u8 {
    var return_string: []u8 = std.mem.zeroes([]u8);

    inline for (std.meta.fields(@TypeOf(args))) |f| {
        return_string = try std.fmt.allocPrint(
            std.heap.page_allocator,
            "{s}{s}",
            .{ return_string, @as(f.type, @field(args, f.name)) },
        );
    }

    return try std.fmt.allocPrint(std.heap.page_allocator, "{s}{s}{s}", .{ return_string, str, Color.Default });
}

test "colors" {
    const text = "Hello, world!";

    const stdout = std.io.getStdOut().writer();

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgBlack})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgBlack})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.Default})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgRed})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgRed})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.Bold})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgGreen})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgGreen})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.Faint})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgYellow})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgYellow})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.Underline})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgBlue})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgBlue})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.Blink})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgPurple})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgPurple})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgCyan})});
    try stdout.print("\t{s}", .{try format_string(text, .{Color.bgCyan})});

    try stdout.print("\n{s}", .{try format_string(text, .{Color.fgWhite})});
    try stdout.print("\t{s}", .{try format_string(text, .{ Color.bgWhite, Color.fgBlack })});

    try stdout.print("\n", .{});
}
