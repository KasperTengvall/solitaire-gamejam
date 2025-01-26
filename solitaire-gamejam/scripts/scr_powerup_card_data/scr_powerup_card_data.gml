function scr_powerup_card_data() {
    var cards = [];
    
    // Example card definitions
    cards[0] = {name: "Extra Time", effect: "add_time", value: 30};  // Adds 30 seconds
    cards[1] = {name: "Reveal Card", effect: "reveal_card", value: 1}; // Reveals 1 card
    cards[2] = {name: "Extra Moves", effect: "add_moves", value: 5}; // Adds 5 moves
    
    return cards;
}
