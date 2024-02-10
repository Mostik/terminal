# Terminal utilities
## Install
```
zig fetch --save https://github.com/Mostik/terminal/archive/master.tar.gz
```
```zig
//build.zig
const terminal = b.dependency("terminal", .{}).module("terminal");

exe.root_module.addImport("terminal", terminal);

```
```zig
const std = @import("std");
const terminal = @import("terminal");

pub fn main() !void {
    const mytext = try terminal.format_string(
        "Test text",
        .{ terminal.Color.Bold, terminal.Color.bgBlue },
    );

    std.debug.print("{s}", .{mytext});

    std.debug.print("{s}Test text", .{terminal.Color.fgRed});
}
```
## ANSI Colors
![image](https://github.com/Mostik/terminal/assets/51542168/be23d641-e709-47c9-92bf-249db7f62401)
## Terminal Size
```zig
std.debug.print("{any}", .{terminal.size()});
// Size{ .rows = 47, .columns = 95, .x_pixels = 950, .y_pixels = 987 }
```
