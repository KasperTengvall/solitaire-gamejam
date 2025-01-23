function reset_round() {
    bases_left = 4; // Reset the number of bases
    timer = 0; // Reset the timer or any other round-specific variables
    global.current_round++; // Increment to the next round
    reset_board(); // Reset only the board state for the new round
}

function reset_board() {
    // Destroy all existing instances of the base
    var _base_no = instance_number(obj_base_parent);
    for (var _i = 0; _i < _base_no; ++_i) {
        var _base = instance_find(obj_base_parent, _i);
        if (_base) {
            instance_destroy(_base);
        }
    }

    // Recreate new bases for the next round
    for (var _j = 0; _j < bases_left; ++_j) {
        instance_create_layer(random(room_width), random(room_height), "Instances", obj_base_parent);
    }
}