/// Step Event: Handles timer, powerup application, and round progression

// === Timer Management ===
// Calculate elapsed time since the last frame
var _timer = get_timer() / 1000000 - last_second;
if (_timer > 2) {
    last_second = get_timer() / 1000000;
    _timer = get_timer() / 1000000 - last_second;
}

// Decrease timer if not paused
if (!global.pause) {
    global.timer -= _timer;
}

// Ensure `last_second` is always updated
last_second = get_timer() / 1000000;

// === Base Check Logic ===
// Collect base instances and check their state
var _base_no = instance_number(obj_base_parent);
var _bases = [];
bases_left = 4; // Reset the bases left counter

for (var _i = 0; _i < _base_no; ++_i) {
    _bases[_i] = instance_find(obj_base_parent, _i);
    if (_bases[_i].number_needed > 12) { // Check if the base is "complete"
        bases_left--;
    }
}



// === Round Progression ===
// Check if all bases are cleared
if (bases_left == 3) {
    if (room == rm_play5) {
        // If the current room is rm_play5, set the state to state_winner
       global.winner = true;
    } else {
        // Otherwise, prepare for the next round
        global.powerup_cards = scr_get_random_cards();

        // Clear the applied powerup flags for the new round
        global.powerups_applied = [];

        // Transition to the powerup selection room
        room_goto(rm_powerup_selection);
    }
}