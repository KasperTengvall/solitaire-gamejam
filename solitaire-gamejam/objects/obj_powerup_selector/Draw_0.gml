draw_set_font(fnt_righteous_small);

/// Draw powerup cards for selection
var _cards = global.powerup_cards;


for (var i = 0; i < array_length(_cards); i++) {
    var x_pos = 200 + (i * 250); // Increased spacing between cards
    var y_pos = 300; // Fixed vertical position

    // Draw card rectangle
    draw_set_color(c_white);
    draw_rectangle(x_pos - 100, y_pos - 150, x_pos + 100, y_pos + 150, false);

    // Display card name and effect
    draw_set_color(c_green);
    draw_text(x_pos - 80, y_pos - 100, string(_cards[i].name));  // Card name
    draw_text(x_pos - 80, y_pos - 50, string(_cards[i].effect)); // Card effect
}
