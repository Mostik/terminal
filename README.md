# Terminal utilities
[![wakatime](https://wakatime.com/badge/user/c76fba5a-9e0d-4336-98f1-75633a3b8c09/project/018d8d57-b288-4728-8f2b-83edcd165172.svg)](https://wakatime.com/badge/user/c76fba5a-9e0d-4336-98f1-75633a3b8c09/project/018d8d57-b288-4728-8f2b-83edcd165172)

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
    ...
}
```
## ANSI Colors
![image](https://github.com/Mostik/terminal/assets/51542168/97cdda8c-390d-45a7-a5c4-eeea0233f4d4)

## Terminal Size
```zig
std.debug.print("{any}", .{terminal.size()});
// Size{ .rows = 47, .columns = 95, .x_pixels = 950, .y_pixels = 987 }
```

## Cursor Position
```zig
const row = 10;
const col = 10;
try terminal.cursorPos(row, col);

```
## getch
```zig
const std = @import("std");
const terminal = @import("terminal");

pub fn main() !void {
    while (true) {
        const ch: u8 = try terminal.getch();

        std.debug.print("{any}", .{ch});
    }
}
```
