/// @description figure out states
// Inherit first
event_inherited();

// If we've not yet flipped, make sure we're not grabbable, and out face is spr_card_back.
if (flipped = false)
{
	face = spr_card_back;
	grabbable = false;
}
else // Otherwise we've flipped update our face!
{
	// Since we made fancy code in our draw, doing this will automatically flip and reveal our card.
	// Neat!
	face = card_face;
}

// If the deck has told us to destroy ourself
if (destroy_self)
{
	// Switch our state over to do so.
	state = state_destroy;
}
/*var card_id = string(suit) + "_" + string(number);
    if (flipped && is_small == true && !bonus_applied) {
		
		 if (!array_contains(global.card_name, card_id)) {
			 
			              // Add 5 seconds to the timer	
			if (number == 0){
				 global.timer += 10;
			}
				if (number == 1){
				 global.timer += 5;
			}
     
	 			if (number == 2){
				 global.timer += 3;
			}
			 	
     
     
     

        // Add the card_id to the global.card_name array to prevent adding time again
        array_push(global.card_name, card_id);
		 show_debug_message("global.card_name after push: " + string(global.card_name));
        // Log to check if bonus is applied correctly
		show_debug_message("Contents of global.card_name:");
for (var i = 0; i < array_length(global.card_name); i++) {
    show_debug_message("Index " + string(i) + ": " + string(global.card_name[i]));
	        
        // Log to check if bonus is applied correctly
        show_debug_message("Bonus Applied: " + string(global.timer));
}
    

    } else {
			show_debug_message("Card already processed: " + card_id);
        
    } 
        
		
        // Set bonus_applied to true to prevent adding time again
        bonus_applied = true;

    }
    
    // Reset bonus_applied when the card is no longer flipped (or after it has been processed)
    if (!flipped) {
        bonus_applied = false;
    }*/


// Call our (small) state machine.
state();
timer--;
