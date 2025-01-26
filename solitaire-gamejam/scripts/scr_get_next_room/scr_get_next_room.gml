function scr_get_next_room() {
    if (global.current_room_index + 1 < array_length(global.room_sequence)) {
        global.current_room_index++;
        return global.room_sequence[global.current_room_index];
    }
    return -1; // Indicates no more rooms
}