const std = @import("std");
const rl = @import("raylib");
const print = std.debug.print;
const mem = std.mem;
const os = std.os;
const random = std.crypto.random;
const automata = @import("../objects/automata.zig");
const grid = @import("../objects/grid.zig");
const indexing = @import("../utils/indexing.zig");
const displayGameMenu = @import("../visual/game-menu.zig").displayGameMenu;
const displayScore = @import("../visual/score.zig").displayScore;
const loggingDialog = @import("../utils/logging-dialog.zig").displayLogginDialog;
const cursors = @import("../visual/cursors.zig");
const Cell = automata.Cell;
const Grid = grid.Grid;
const mainState = @import("main-state.zig");
const AppState = @import("./app-state.zig");

var state = mainState.state{};

pub fn gameState(appState: *u2) !void {
    var gridAllocator = std.heap.c_allocator;
    var gameGrid = try Grid.init(
        400,
        400,
        1,
        4,
        4,
        &gridAllocator,
    );
    var count: f32 = 0.0;
    defer gameGrid.deinit();
    while (!rl.windowShouldClose() and appState.* == AppState.GAME) {
        const mouse_pos = rl.getMousePosition();

        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(.black);

        // Controls
        if (rl.isKeyPressed(.space)) { // Press space to start the game
            state.runGame = !state.runGame;
        }
        if (rl.isKeyPressed(.f)) // press f to show the FPS
            state.isFPSShowing = !state.isFPSShowing;

        if (rl.isKeyPressed(.l)) // Press l to toggle logging
            state.isLoggingEnabled = !state.isLoggingEnabled;
        if (rl.isKeyPressed(.r))
            state.isRotationPaused = !state.isRotationPaused;

        if (state.isFPSShowing) // Draw FPS
            rl.drawFPS(0, 0);

        if (rl.isKeyDown(.up)) {
            state.zoom += 0.1;
        } else if (rl.isKeyDown(.down)) {
            state.zoom -= 0.1;
        }

        if (rl.isKeyDown(.left)) {
            state.offset -= 1.0;
        } else if (rl.isKeyDown(.right)) {
            state.offset += 1.0;
        }

        // Determines where a cell index has been collided with and handles the collision logic
        gameGrid.drawCircleOnGrid(
            count,
            state.zoom,
            state.offset,
        );
        if (!state.runGame) {
            const index = gameGrid.calculateGridIndex(mouse_pos);

            if (index) |_| {
                // if (state.isLoggingEnabled)
                //     loggingDialog(i, &gameGrid, mouse_pos);

                cursors.displayMainCursor(mouse_pos);
            }
            if (!state.isRotationPaused) {
                if (count >= 360.0) {
                    count = 0.01;
                } else {
                    count += 0.01;
                }
            }
        }
    }
}
