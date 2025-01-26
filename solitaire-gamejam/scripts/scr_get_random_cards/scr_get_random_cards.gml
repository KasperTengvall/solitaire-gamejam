function scr_get_random_cards() {
    var all_cards = scr_powerup_card_data(); // Fetch all possible cards
    var selected_cards = [];
    var indices = ds_list_create();

    // Populate and shuffle card indices
    for (var i = 0; i < array_length(all_cards); ++i) {
        ds_list_add(indices, i);
    }
    ds_list_shuffle(indices);

    // Select the first three shuffled cards
    for (var j = 0; j < 3; ++j) {
        var idx = ds_list_find_value(indices, j);
        array_push(selected_cards, all_cards[idx]);
    }

    ds_list_destroy(indices); // Cleanup
    return selected_cards;   // Return selected cards
}
