/// This is a simple implementation of Conway's Game of Life using Zig and raylib.
const exit = @import("std").process.exit;
const rl = @import("raylib");
const displayGameMenu = @import("./visual/game-menu.zig").displayGameMenu;
const gameState = @import("./states/game.zig").gameState;

pub fn main() !void {
    var appState: u2 = 1;

    rl.setConfigFlags(.{ .msaa_4x_hint = true, .window_highdpi = true });
    rl.initWindow(800, 800, "CIRCLE FUN");
    defer rl.closeWindow();
    errdefer rl.closeWindow();
    rl.setTargetFPS(60);

    // Main game loop
    while (!rl.windowShouldClose()) {
        if (rl.isKeyPressed(.escape)) // Press Esc to exit the game
            exit(1);

        //STATES
        displayGameMenu(&appState);
        try gameState(&appState);
    }
}
