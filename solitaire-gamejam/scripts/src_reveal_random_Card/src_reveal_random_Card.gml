function src_reveal_random_Card() {
    // Create an array to store eligible cards
    var eligible_cards = [];

    // Loop through all card instances
    var card_count = instance_number(obj_card); // Replace obj_card with your card object name
    for (var i = 0; i < card_count; i++) {
        var card = instance_find(obj_card, i);

        // Generate the card_id
        var card_id = string(card.suit) + "" + string(card.number);

        // Check if the card is not flipped and not in the deck
        if (!card.flipped && !array_contains(obj_deck.card_holder, card_id)) {
            array_push(eligible_cards, card);
        }
    }

    // If there are eligible cards, randomly select one and reveal it
    if (array_length(eligible_cards) > 0) {
        var random_index = irandom(array_length(eligible_cards) - 1); // Randomly pick an index
        var selected_card = eligible_cards[random_index];  // Select the card from the list

        // Reveal the selected card
        selected_card.flipped = true; // Flip only the selected card
        // Debugging: Check how many cards are being added

    }
}