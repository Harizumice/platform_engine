/// @description Variables

function scr_set_on_ground(_val = true)
{
	if(_val){
		ground = true;
		coyote_hang_timer = coyote_hang_frames;
	} else {
		ground = false;
		my_floor_plat = noone; 
		coyote_hang_timer = 0;
	}
}

function scr_check_for_semisolid_platform(_x, _y)
{
	// Create Returnable Variable
	var _return = noone;

	// we must not be moving upwards, and then we check for a normal collision
	if(yspd >= 0 && place_meeting(_x, _y, par_semisolid_wall)){
		// Create a DS list to store all colliding instances of semisolidwall
		var _list = ds_list_create();
		var _list_size = instance_place_list(_x, _y, par_semisolid_wall, _list, false);

		// Loop trough the colliding instances and only return one of it's top is below the player
		for(var i = 0; i < _list_size; i ++){
			var _list_inst = _list[| i];
			if(floor(bbox_bottom) <= ceil(_list_inst.bbox_top - _list_inst.yspd)){
				// Return the id of a semisolid platform
				_return = _list_inst;

				// Exit the loop early
				i = _list_size;
			}
		}

	}

	// Return our variable
	return _return;
}

// Setup Controls
scr_control_setup();

// Spri1es && Render
chara  = "player";
action = "idle";
xscale = 1;
yscale = 1;
ang    = 0;
depth  = -120;

// Moving
face       = 1;
movedir	   = 0;   // 0 = Noone; 1 = Right; / -1 = Left;
run_type   = 0;   // 0 = walk; 1 = run;

movespd[0] = 3.5; // Movement speed horizontal
movespd[1] = 5.4; // Movement speed horizontal
xspd       = 0;	  // Speed X
yspd       = 0;	  // Speed Y

// Jumping
grav			 = 0.3125; // Force Gravity
termvel			 = 16;	   // Max Gravity Cap
jspd[0]			 = -5.6;   // Jump Height
jspd[1]			 = -5;     // Jump Height
jump_max		 = 2;      // Who jumps you can do it
jump_count		 = 0;      // Jumps Released
jump_hold_timer  = 0;	   // How so much time you pulsed the jump
jump_hold_frames[0] = 18;  // The number of frames you can push the jump 1
jump_hold_frames[1] = 12;  // The number of frames you can push the jump 2
ground			 = true;   // The player is on ground or dont
fall		     = 1;	   // Multiply Vertical speed
fallspd		     = 2.4;	   // Max Multiply Vertical speed
fallacc		     = 0.16;    // Acceleration Vertical speed

// Coyote time
coyote_hang_frames = 4;
coyote_hang_timer  = 0;

// Jump buffer timer
coyote_jump_frames = 12;
coyote_jump_timer  = 0;

// Moving Platforms
my_floor_plat = noone;
move_plat_xspd = 0;
move_plat_max_yspd = termvel; // How to fast can the player follow a downwards moving platforms
down_slope_semisolid = noone;