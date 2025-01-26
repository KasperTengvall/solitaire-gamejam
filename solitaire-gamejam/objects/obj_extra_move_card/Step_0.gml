
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + sprite_width, y + sprite_height)) {
    hovered = true;
    if (mouse_check_button_pressed(mb_left) && global.extra_move_cards > 0) {
        global.moves += 50; // Add 50 moves
        global.extra_move_cards--;
    }
} else {
    hovered = false;
}
