/// Step Event: Handles timer, powerup application, and round progression

// === Timer Management ===
var _current_time = get_timer() / 1000000; // Current time in seconds
var _timer = _current_time - last_second;

// Update last_second only if a full second has passed
if (_timer >= 1) {
    last_second = _current_time;
}

// Decrease timer if not paused
if (!global.pause) {
    global.timer -= delta_time / 1000000; // Use delta_time for consistent frame-independent decrement
}

// Ensure last_second is updated at the end
last_second = _current_time;

// === Base Check Logic ===
var _base_no = instance_number(obj_base_parent);
var _bases = [];
bases_left = 4; // Reset the bases left counter

for (var _i = 0; _i < _base_no; ++_i) {
    _bases[_i] = instance_find(obj_base_parent, _i);
    if (_bases[_i].number_needed > 12) { // Check if the base is "complete"
        bases_left--;
    }
}

// === Challenge Logic ===
// Define challenge conditions based on the room
if (room == rm_play) { // Room 1: Timer challenge
    if (global.timer <= 0) {;
        global.loser = true;
    }
} else if (room == rm_play2) { // Room 2: Moves challenge
    if (global.moves <= 0) {
        global.loser = true;
    }
} else if (room == rm_play3) { // Room 3: Both challenges
    if (global.timer <= 0 || global.moves <= 0) {
        global.loser = true;
    }
}

// === Round Progression ===
var next_room = scr_get_next_room();
if (bases_left == 3) {
    if (room == rm_play3) {
        global.winner = true;
    } else {
        room_goto(next_room);
    }
}
