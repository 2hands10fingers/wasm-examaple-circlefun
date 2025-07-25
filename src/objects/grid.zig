const Cell = @import("./automata.zig").Cell;
const indexing = @import("../utils/indexing.zig");
const colors = @import("../utils/colors.zig");
const rl = @import("raylib");
const std = @import("std");
const math = std.math;
const random = std.crypto.random;

const Circle = struct {
    x: f32,
    y: f32,
    radius: f32,
    color: rl.Color,

    pub fn init(x: f32, y: f32, radius: f32, color: rl.Color) Circle {
        return Circle{
            .x = x,
            .y = y,
            .radius = radius,
            .color = color,
        };
    }

    pub fn draw(self: Circle) void {
        rl.drawCircleV(
            .{ .x = self.x, .y = self.y },
            self.radius,
            self.color,
        );
    }
};

pub const Grid = struct {
    num_rows: u64,
    num_cols: u64,
    girdCells: []Cell,
    padding: i32,
    cell_width: i32,
    cell_height: i32,
    allocator: *std.mem.Allocator,

    pub fn init(
        rowCount: comptime_int,
        colCount: comptime_int,
        padding: u8,
        cell_width: i32,
        cell_height: i32,
        allocator: *std.mem.Allocator,
    ) !Grid {
        std.debug.assert(rowCount == colCount);
        const total = rowCount * colCount;
        const cells = try allocator.alloc(Cell, total);

        for (0..rowCount) |row| {
            for (0..colCount) |col| {
                const index = col * colCount + row;

                cells[index] = Cell{
                    .x = @as(i32, @intCast(row)),
                    .y = @as(i32, @intCast(col)),
                    .alive = false,
                };
            }
        }

        return .{
            .girdCells = cells,
            .num_rows = rowCount,
            .num_cols = colCount,
            .padding = padding,
            .cell_width = cell_width,
            .cell_height = cell_height,
            .allocator = allocator,
        };
    }

    pub fn drawCircleOnGrid(_: *Grid, count: f32, zoomLevel: f32, offset: f32) void {
        const adjacent: f32 = 34.0 + zoomLevel;
        const opposite: f32 = 28.2 + zoomLevel;
        const hypotneuse: f32 = math.sqrt(math.pow(f32, adjacent, 2) + math.pow(f32, opposite, 2));
        const center = 400.0 + offset;
        const centeri32 = @as(i32, @intFromFloat(center));

        const circleHandleCenterX2 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 2)) * math.cos(count)));
        const circleHandleCenterY2 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 2)) * math.sin(count)));
        const circleHandleCenterX3 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.cos(count - 0.54)));
        const circleHandleCenterY3 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.sin(count - 0.54)));
        const circleHandleCenterX4 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.cos(count + 0.54)));
        const circleHandleCenterY4 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.sin(count + 0.54)));

        const circleHandleCenterX5 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 2)) * math.cos(count + 3.0)));
        const circleHandleCenterY5 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 2)) * math.sin(count + 3.0)));

        const circleHandleCenterX6 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.cos(count - 3.81)));
        const circleHandleCenterY6 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.sin(count - 3.81)));

        const circleHandleCenterX7 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.cos(count + 3.54)));
        const circleHandleCenterY7 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.sin(count + 3.54)));

        const circleHandleCenterX8 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 2)) * math.cos(count + 4.6)));
        const circleHandleCenterY8 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 2)) * math.sin(count + 4.6)));

        const circleHandleCenterX9 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.cos(count + 4.1)));
        const circleHandleCenterY9 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.sin(count + 4.1)));

        const circleHandleCenterX10 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.cos(count + 5.1)));
        const circleHandleCenterY10 = @as(i32, @intFromFloat(center + (hypotneuse + (hypotneuse / 4)) * math.sin(count + 5.1)));

        rl.drawCircle(centeri32, centeri32, hypotneuse, colors.blue);
        rl.drawCircle(circleHandleCenterX2, circleHandleCenterY2, hypotneuse / 2.0, colors.yellow);
        rl.drawCircle(circleHandleCenterX3, circleHandleCenterY3, hypotneuse / 4.0, colors.red);
        rl.drawCircle(circleHandleCenterX4, circleHandleCenterY4, hypotneuse / 4.0, colors.red);

        rl.drawCircle(circleHandleCenterX5, circleHandleCenterY5, hypotneuse / 2.0, colors.yellow);
        rl.drawCircle(circleHandleCenterX6, circleHandleCenterY6, hypotneuse / 4.0, colors.red);
        rl.drawCircle(circleHandleCenterX7, circleHandleCenterY7, hypotneuse / 4.0, colors.red);

        rl.drawCircle(circleHandleCenterX8, circleHandleCenterY8, hypotneuse / 2.0, colors.yellow);
        rl.drawCircle(circleHandleCenterX9, circleHandleCenterY9, hypotneuse / 4.0, colors.red);
        rl.drawCircle(circleHandleCenterX10, circleHandleCenterY10, hypotneuse / 4.0, colors.red);

        // self.drawTrigTriangleXY(hypotneuse, circleHandleCenterX2, circleHandleCenterY2, count);
        // self.drawTrigTriangle(hypotneuse, center, count);
    }

    pub fn drawTrigTriangleXY(_: Grid, hypotenuse: f32, centerX: f32, centerY: f32, count: f32) void {
        const centerPos = rl.Vector2{
            .x = centerX,
            .y = centerY,
        };
        rl.drawLineV(
            centerPos,
            .{
                .x = (centerX + (hypotenuse * math.cos(count))),
                .y = (centerY + (hypotenuse * math.sin(count))),
            },
            colors.green,
        );
        // draw adjacent line
        rl.drawLineV(
            centerPos,
            .{
                .x = centerX,
                .y = centerY + (hypotenuse * math.sin(count)),
            },
            colors.yellow,
        );
        //     // draw opposite line
        rl.drawLineV(
            centerPos.add(.{ .x = 0.0, .y = (hypotenuse * math.sin(count)) }),
            .{
                .x = centerX + (hypotenuse * math.cos(count)),
                .y = centerY + (hypotenuse * math.sin(count)),
            },
            colors.white,
        );
    }

    pub fn drawTrigTriangle(_: Grid, hypotenuse: f32, center: f32, count: f32) void {
        const centerPos = rl.Vector2{
            .x = center,
            .y = center,
        };
        rl.drawLineV(
            centerPos,
            .{
                .x = (center + (hypotenuse * math.cos(count))),
                .y = (center + (hypotenuse * math.sin(count))),
            },
            colors.green,
        );
        // draw adjacent line
        rl.drawLineV(
            centerPos,
            .{
                .x = center,
                .y = center + (hypotenuse * math.sin(count)),
            },
            colors.yellow,
        );
        //     // draw opposite line
        rl.drawLineV(
            centerPos.add(.{ .x = 0.0, .y = (hypotenuse * math.sin(count)) }),
            .{
                .x = center + (hypotenuse * math.cos(count)),
                .y = center + (hypotenuse * math.sin(count)),
            },
            colors.white,
        );
    }

    pub fn calculateGridIndex(self: *Grid, mouse_pos: rl.Vector2) ?usize {
        const yInt = @as(i32, @intFromFloat(mouse_pos.y));
        const xInt = @as(i32, @intFromFloat(mouse_pos.x));
        const gridBoxPosition = @divFloor(yInt, (self.cell_height + self.padding));
        const gridBoxPosition2 = @divFloor(xInt, (self.cell_width + self.padding));
        const index = indexing.toIndex(
            gridBoxPosition,
            gridBoxPosition2,
            self.num_cols,
            self.num_rows,
        );

        return index;
    }

    pub fn deinit(self: *Grid) void {
        self.allocator.free(self.girdCells);
    }
};
