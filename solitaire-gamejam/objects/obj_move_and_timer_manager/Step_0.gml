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

// === Apply Active Powerups ===
for (var i = 0; i < array_length(global.active_powerups); i++) {
    var powerup = global.active_powerups[i];
    
    // Only apply if not yet applied
    if (!powerup.applied) {
        switch (powerup.effect) {
            case "add_time":
                global.timer += 10; // Add 10 seconds to the timer (or any desired value)
                show_debug_message("Applied powerup: " + powerup.name + ", effect: " + powerup.effect);
                break;

            case "add_moves":
                global.moves += 3; // Add 3 moves (or any desired value)
                show_debug_message("Applied powerup: " + powerup.name + ", effect: " + powerup.effect);
                break;
            case "reveal_card":
                reveal_random_card(powerup.value); // Assumes this function exists
                break;
        }

        // Mark this powerup as applied for this round
        array_push(global.powerups_applied, i);
    }
}

// === Round Progression ===
// Check if all bases are cleared
if (bases_left <= 0) {
    // Add new powerup cards for the next round
    global.powerup_cards = scr_get_random_cards();

    // Clear the applied flags for the new round
    global.powerups_applied = [];

    // Transition to the powerup selection room
    room_goto(rm_powerup_selection);
}
