// Check if the card is hovered over
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + sprite_width, y + sprite_height)) {
    hovered = true;
     if (mouse_check_button_pressed(mb_left) && global.extra_time_cards > 0) {
        global.timer += 30; // Add 50 moves
        global.extra_time_cards--;
    }
} else {
    hovered = false;
}
