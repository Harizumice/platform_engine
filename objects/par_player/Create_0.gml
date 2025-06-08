/// @description Variables

function scr_set_on_ground(_val = true){
	if(_val){
		ground = true;
		coyote_hang_timer = coyote_hang_frames;
	} else {
		ground = false;
		my_floor_plat = noone; 
		coyote_hang_timer = 0;
	}
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
coyote_hang_frames = 8;
coyote_hang_timer  = 0;

// Jump buffer timer
coyote_jump_frames = 12;
coyote_jump_timer  = 0;

// Moving Platforms
my_floor_plat = noone;
move_plat_xspd = 0;
move_plat_max_yspd = termvel; // How to fast can the player follow a downwards moving platforms
