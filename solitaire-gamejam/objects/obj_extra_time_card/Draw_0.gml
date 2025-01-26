// Draw the sprite normally or with a highlight when hovered
if (hovered) {
    draw_sprite_ext(sprite_index, image_index, x, y, 1.1, 1.1, 0, c_white, 1); // Slightly larger when hovered
} else {
    draw_self(); // Default drawing
}

// Display the number of cards remaining
draw_set_color(c_white);
draw_text(room_width * 0.225, room_height /1.4, "x" + string(global.extra_time_cards));