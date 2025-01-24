function reset_round() {
    // Clear round-specific variables
    bases_left = 4; // Reset the number of bases
    timer = 0; // Reset the timer
    global.current_round++; // Increment to the next round

    // Reset the board state
    reset_board(); // Clear the board (zones, cards, etc.)

    // Reshuffle and deal cards using obj_deck
    with (obj_deck) {
        // Clear existing cards from play
        var _cur_len = array_length(card_holder);
        for (var _i = 0; _i < _cur_len; _i++) {
            card_holder[_i].destroy_self = true;
        }
        card_holder = []; // Reset the card holder array

        // Reset the deck and reshuffle cards
        array_of_cards = []; // Clear the deck
        event_perform(ev_create, 0); // Re-execute the Create event
    }

    // Update zones to prepare for the next round
    with (obj_zone) {
        card_holder = [];
        event_user(0); // Call any custom zone setup logic
    }

    // Reinitialize bases if needed
    with (obj_base_parent) {
        card_holder = [];
    }
}

function reset_board() {
    // Destroy all existing cards
    with (obj_card) {
        instance_destroy();
    }

    // Reset zone stacks
    for (var _i = 0; _i < instance_number(obj_zone); _i++) {
        var _zone = instance_find(obj_zone, _i);
        _zone.card_holder = [];
    }

    // Destroy and recreate bases if needed
    with (obj_base_parent) {
        instance_destroy();
    }
    for (var _j = 0; _j < bases_left; _j++) {
        instance_create_layer(random(room_width), random(room_height), "Instances", obj_base_parent);
    }
}