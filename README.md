# Terminal utilities
## ANSI Colors
![image](https://github.com/Mostik/terminal/assets/51542168/be23d641-e709-47c9-92bf-249db7f62401)
## Install
```
zig fetch --save https://github.com/Mostik/terminal/archive/master.tar.gz
```
```zig
//build.zig
const terminal = b.dependency("terminal", .{}).module("terminal");

exe.root_module.addImport("terminal", terminal);

```
