/// @description Physics Handle

// Get the Inputs
scr_getcontrols();

#region /// X movement

// Diretion
movedir = input_right - input_left;

// Get Xspeed
xspd = movedir * movespd;

// X Collision
var _subpixel = 0.5;
if(place_meeting(x + xspd, y, par_solid)){
	// Scoot up to wall precisely
	var _pixelcheck = _subpixel * sign(xspd);
	while(!place_meeting(x + _pixelcheck, y, par_solid)){
		x += _pixelcheck;
	}

	// Set XSpeed to zero to "collision"
	xspd = 0; 
}

// Move X
x += xspd;
#endregion

#region /// Y movement
// Gravity
yspd += grav;

// Cap Falling Speed
if(yspd > termvel){ yspd = termvel; }

// Reset the jumps
if(ground){
	jump_count = 0;
	jump_hold_timer = 0;
} else {
	// if the player is	in the air, make sure they can't do an extra jump
	if(jump_count <= 0){ jump_count = 1; }
}

// Initialize Jump
if(input_jump_buffered && jump_count < jump_max){
	//Reset the buffer
	input_jump_buffered = false;
	input_jump_buffer_timer = 0;
	
	// Increase the jumps
	jump_count ++;
	
	// Set the jump timer 
	jump_hold_timer = jump_hold_frames[jump_count-1];
}

// Cut the Jump
if(!input_jump){
	jump_hold_timer = 0;
}

// Jump Based in the timer/holding the buttom
if(jump_hold_timer > 9){
	// Constantly set Yspeed to the jumping speed
	yspd = jspd[jump_count-1];
	jump_hold_timer --;
}

// Y Collision
var _subpixel = 0.5; 
if(place_meeting(x, y+yspd, par_solid)){
	// Scoot up to the wall precicelly
	var _pixelcheck = _subpixel * sign(yspd);
	while(!place_meeting(x, y+_pixelcheck, par_solid)){
		y += _pixelcheck; 
	}
	
	// Bonk State
	if(yspd < 0){
		jump_hold_timer = 0;
	}
	
	// Set yspd to 0 to collide
	yspd = 0;
}

// set if i'm on the ground
if(yspd >= 0  && place_meeting(x, y+1, par_solid)){
	ground = true;
} else { ground = false; }

// Move Y
y += yspd;
#endregion