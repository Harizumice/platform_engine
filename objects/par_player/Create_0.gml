/// @description Variables

// Setup Controls
scr_control_setup();

// Moving
movedir = 0; // 0 = Noone; 1 = Right; / -1 = Left;
movespd = 3.5; // Movement speed horizontal
xspd    = 0; 
yspd    = 0;

// Jumping
grav			 = 0.3125; // Force Gravity
termvel			 = 4;	   // Max Gravity Cap
jspd[0]			 = -6;   // Jump Height
jspd[1]			 = -5.4;     // Jump Height
jump_max		 = 2;      // Who jumps you can do it
jump_count		 = 0;      // Jumps Released
jump_hold_timer  = 0;	   // How so much time you pulsed the jump
jump_hold_frames[0] = 18;  // The number of frames you can push the jump 1
jump_hold_frames[1] = 12;  // The number of frames you can push the jump 2
ground			 = true;   // The player is on ground or dont