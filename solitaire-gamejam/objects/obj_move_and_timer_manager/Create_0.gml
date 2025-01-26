/// @description Initialise Variables and Function

// Our timer, used for keeping track of how long the user is taking.
global.timer = 60;
global.active_powerups = []; // Stores all active powerups
global.powerups_applied = []; // Tracks which powerups have been applied this round
global.powerup_cards = []; // Holds available powerup cards for selection
global.current_room_index = 0; // Tracks the current room's index
global.room_sequence = [rm_play, rm_play2, rm_play3, rm_play4, rm_play5]; // Define the room sequence

// Our delay, used to add a delay between each carp lerping up to it's base at the top of the screen 
// during our auto solve. Adds to the satisfaction.
delay = 0;

// This is the actual delay, so every quarter of a second we 
delay_act = 0.25;

// Used to normalise our time gain.
last_second = get_timer()/1000000; 
global.moves = 0;
// === Apply Active Powerups ===
for (var i = 0; i < array_length(global.active_powerups); i++) {
    var powerup = global.active_powerups[i];
    
    // Only apply if not yet applied
    if (!powerup.applied) {
        switch (powerup.effect) {
            case "add_time":
                global.timer += 30; // Add 10 seconds to the timer (or any desired value)
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

// Keep track of how many bases we have to complete!
bases_left = 4;


// This whole section is dedicated to solving the game automatically when close enough to the end.
// Setting this to true will trigger the auto solver. This only functions if all cards are on the board
// and flipped.
auto_solve = false;
fail = true;
bool_solve = false;

var _zone_no = instance_number(obj_zone);
zones = []
	
// Find all our zones.
for (var _i = 0; _i < _zone_no; ++_i;)
{
	zones[_i] = instance_find(obj_zone,_i);
}


// If auto solve is ever true, we want to execute this function.
// This will only ever be triggered if all cards are on the board,
// and all are flipped.
solve = function()
{
	// Let's draw out the animation to make it more satisfying.
	if (delay < 0)
	{
		delay = delay_act;
		// Go through all of our zones.
		for(var _i = 0; _i < array_length(zones); _i++)
		{
			// For each zone, check each base.
			var _base_no = instance_number(obj_base_parent);
			var _base = noone;
			var _last = 0;
			// Check all our bases
			for (var _j = 0; _j < _base_no; ++_j;)
			{
				_base = instance_find(obj_base_parent,_j);
				// If the zone we're iterating on isn't empty.
				if (array_length(zones[_i].card_holder) != 0)
				{
		
					_last = array_last(zones[_i].card_holder);
					// If that bases number needed is our number, and that bases suit matches ours.
					if (_base.number_needed == _last.number) &&  (_base.suit_needed == _last.suit)
					{
						// Then transfer from our current stack, to the new one.
						_last.lerp_amount = 0.15;
						transfer_stack(_last.stack,_base, _last.id);
						
						break;
					}
				}
				else
				{
					// If it's not 0, we might as well not check all of the bases for this one since there's nothing to do.
					break;
				}
			}
			
			if (array_length(zones[_i].card_holder) != 0)
			{
				
				if (_base.number_needed == _last.number) &&  (_base.suit_needed == _last.suit)
				{
					break;
				}
			}
		}
	}
	else
	{
		delay -= delta_time / 200000;
	}
}



