if (hovered) {
    draw_sprite_ext(sprite_index, image_index, x, y, 1.1, 1.1, 0, c_white, 1); // Slightly larger when hovered
} else {
    draw_self();
}

// Display the number of cards remaining
draw_set_color(c_white);
draw_text(room_width * 0.95, room_height /1.7, "x" + string(global.extra_move_cards));