/// @description Define our card.
// Inherit the parent event
event_inherited();

// Let's get a list of all possible sprites that a card can be.
var _clubs = [spr_clubs_1, spr_clubs_2, spr_clubs_3, spr_clubs_4, spr_clubs_5, spr_clubs_6, spr_clubs_7, spr_clubs_8, spr_clubs_9, spr_clubs_10, spr_clubs_11, spr_clubs_12, spr_clubs_13];
var _spades = [spr_spades_1, spr_spades_2, spr_spades_3, spr_spades_4, spr_spades_5, spr_spades_6, spr_spades_7, spr_spades_8, spr_spades_9, spr_spades_10, spr_spades_11, spr_spades_12, spr_spades_13];
var _diamonds = [spr_diamonds_1, spr_diamonds_2, spr_diamonds_3, spr_diamonds_4, spr_diamonds_5, spr_diamonds_6, spr_diamonds_7, spr_diamonds_8, spr_diamonds_9, spr_diamonds_10, spr_diamonds_11, spr_diamonds_12, spr_diamonds_13];
var _hearts = [spr_hearts_1, spr_hearts_2, spr_hearts_3, spr_hearts_4, spr_hearts_5, spr_hearts_6, spr_hearts_7, spr_hearts_8, spr_hearts_9, spr_hearts_10, spr_hearts_11, spr_hearts_12, spr_hearts_13];

// After getting our list together, let's make a 2D array.
var _cards = [_clubs, _spades, _diamonds, _hearts];

// Finally, let's set our suit and number.
card_face = _cards[suit][number];
face = spr_card_back;

// Let's also figure out what our card color is so we can represent it better.
black = (suit == 0) || (suit == 1); // Clubs and Spades are black.

// These are used to set a point to stay at, e.g., if we're on a stack or somewhere else.
// We need to move to this position and then reset it.
goal_x = x;
goal_y = y;
act_depth = depth; // This is our card's normal depth.

// Amount of linear interpolation to apply when moving to our goal.
lerp_amount = 0.2;

// Determines whether we draw an outline around the card or not, as well as if we can grab it or not.
grabbable = true;

// Used for double-click-to-base functionality.
timer = 0;
double_click = 40; // Frames of delay to accept a double-click.

// What stack we're currently in.
stack = noone;
deck = noone; // This is so we have the deck's ID handy, as it's a bit unique of a stack.

// If this is toggled to true, we return to the deck, flip back upside down, and destroy ourselves.
destroy_self = false;

// This is used to disable lerp movement on cards picked up in a stack.
picked_up = false;

/// These are needed to create a card flip effect when pulling a card from our deck.
// Used to create a flipping card effect.
ac_timer = 0;
speed_ac = 1.2;

// Determines if we've flipped our card yet or not.
flipped = true;

// The animation curve for the flip.
ac = ac_card_flip;

// Functions
state_card = function() {
    // Ensure the card moves towards its goal unless picked up.
    if (obj_mouse_manager.grabbed_card != self) {
        if (!picked_up) {
            x = lerp(x, goal_x, lerp_amount);
            y = lerp(y, goal_y, lerp_amount);
            if (abs(x - goal_x) < 2 && abs(y - goal_y) < 2) {
                depth = act_depth;

                // Ensure stack and stack.card_holder are valid before iterating.
                if (stack != noone && variable_instance_exists(stack, "card_holder") && is_array(stack.card_holder)) {
                    for (var _i = 0; _i < array_length(stack.card_holder); _i++) {
                        stack.card_holder[_i].depth = depth - _i;
                    }
                }
            }
        }
        picked_up = false;
    } else { // If we're the grabbed card, handle the stack update.
        picked_up = true;
        depth = -10000;
        var _self = -1;
        var _goal = 0;

        // Ensure stack and stack.card_holder are valid before proceeding.
        if (stack != noone && variable_instance_exists(stack, "card_holder") && is_array(stack.card_holder)) {
            for (var _i = 0; _i < array_length(stack.card_holder); _i++) {
                if (stack.card_holder[_i] == id) {
                    _self = _i;
                }

                if (_self >= 0 && _i > _self) {
                    stack.card_holder[_i].picked_up = true;
                    stack.card_holder[_i].x = x;
                    stack.card_holder[_i].depth = depth - _i;

                    if (-obj_zone.number_of_cards + (array_length(stack.card_holder) - _self) > 0) {
                        _goal = (-obj_zone.number_of_cards + (array_length(stack.card_holder) - _self)) / obj_zone.adjustment;
                    }

                    stack.card_holder[_i].y = y + ((_i - _self) * (sprite_height / (2 + _goal)));
                }
            }
        }
    }
};

state_destroy = function() {
    // If the deck has told us to destroy ourselves.
    grabbable = false;

    // Flip our card again
    face = spr_card_back;
    // Set the animation speed high so we're flipped by the time we reach the deck.
    speed_ac = 6;

    // Lerp to the deck.
    x = lerp(x, obj_deck.x, lerp_amount);
    y = lerp(y, obj_deck.y, lerp_amount);

    // Once we're in a small bounding box around the deck
    if (abs(x - obj_deck.x) < 2 && abs(y - obj_deck.y) < 2) {
        instance_destroy();
    }
};

state = state_card;
