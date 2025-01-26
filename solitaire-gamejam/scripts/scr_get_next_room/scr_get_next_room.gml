function scr_get_next_room() {
    if (room == rm_play) {
        return rm_play2;
    } else if (room == rm_play2) {
        return rm_play3;
    } else if (room == rm_play3) {
        return rm_play; // Loop back to room 1
    } else {
        return -1; // Unknown room
    }
}