if (mouse_check_button_pressed(mb_left)) {
    show_debug_message("Mouse pressed"); // Debug message

    for (var i = 0; i < array_length(global.powerup_cards); i++) {
        var x_pos = 200 + (i * 250); // Match horizontal spacing
        var y_pos = 300; // Match vertical position

        // Debugging: Log card position and mouse position
        show_debug_message("Checking card " + string(i) + " at x: " + string(x_pos) + ", y: " + string(y_pos));
        show_debug_message("Mouse is at x: " + string(mouse_x) + ", y: " + string(mouse_y));

        // Check if mouse is over the card
        if (mouse_x > x_pos - 100 && mouse_x < x_pos + 100 &&
            mouse_y > y_pos - 150 && mouse_y < y_pos + 150) {

            // Debugging: Log which card was clicked
            show_debug_message("Card selected: " + global.powerup_cards[i].name);

            // Add the selected powerup to the player's active powerups
            var selected_powerup = global.powerup_cards[i];
            array_push(global.active_powerups, selected_powerup);

            // Debugging: Log active powerups
            for (var j = 0; j < array_length(global.active_powerups); j++) {
                show_debug_message("Active Powerup " + string(j) + ": " + global.active_powerups[j].name);
            }

            // Transition to the next room
            var next_room = scr_get_next_room();
            if (next_room != -1) {
				show_debug_message("Transitioning to next room..." + string(next_room));
                room_goto(next_room);
            }
        }
    }
}
