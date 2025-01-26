/// @description Do something when the button is pressed.
// Assuming the mouse is clicking on us,
if (clicked)
{
	global.pause = false;
	// Then the mouse button is released, restart the room.
	room_goto(rm_play);
	instance_destroy(obj_extra_move_card);
	instance_destroy(obj_extra_time_card);
}