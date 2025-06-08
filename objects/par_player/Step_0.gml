/// @description Physics Handle

// Get the Inputs
scr_getcontrols();

#region /// X movement

// Diretion
movedir = input_right - input_left;

// Get Xspeed2
run_type = input_run;
xspd = movedir * movespd[run_type];

// Get the face direction
if(movedir != 0){ 
	face  = movedir;
}

// X Collision
var _subpixel = 0.5;
if(place_meeting(x + xspd, y, par_solid)){
	// First Check if there is a slope to go up
	if(!place_meeting(x + xspd, y - abs(xspd)-1, par_solid)){
		while (place_meeting(x + xspd, y, par_solid)){ y -= _subpixel; }
	} 
	// Next, Check for ceiling slopes, otherwise, regular collision
	else {
		// Ceiling slopes
		if(!place_meeting(x + xspd, y + abs(xspd)+1, par_solid)){
			while(place_meeting(x + xspd, y, par_solid)){ y += _subpixel; }
		} 
		// normal collision
		else {
			// Scoot up to wall precisely
			var _pixelcheck = _subpixel * sign(xspd);
			while(!place_meeting(x + _pixelcheck, y, par_solid)){
				x += _pixelcheck;
			}

			// Set XSpeed to zero to "collision"
			xspd = 0;
		}
	}
}

// Go Down Slopes
if(yspd >= 0 && !place_meeting(x + xspd, y+1, par_solid) && place_meeting(x + xspd, y + abs(xspd)+1, par_solid)){
	while (!place_meeting(x+xspd, y+_subpixel, par_solid)){ y += _subpixel; }
}

// Move X
x += xspd;
#endregion

#region /// Y movement
// Gravity
if(coyote_hang_timer > 0){
	coyote_hang_timer --;
} else {
	// Apply gravity
	yspd += grav*fall;
	scr_set_on_ground(false);
}

// Cap Falling Speed
if(yspd > termvel){ yspd = termvel; }

// Reset the jumps
if(ground){
	if(jump_count != 0){
		scr_gummy(1.3,0.7);
		jump_count = 0;
	}
	jump_hold_timer = 0;
	coyote_jump_timer = coyote_jump_frames;
} else {
	// OPTIONAL if the player is	in the air, make sure they can't do an extra jump
	if(jump_count <= 0 && coyote_jump_timer <= 0){ jump_count = 1; }
	coyote_jump_timer --;
	coyote_hang_timer = 0;
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
	
	// Tell ourself we're no longer on the ground
	scr_set_on_ground(false);
	coyote_jump_timer = 0;
}

// Cut the Jump
if(!input_jump){
	jump_hold_timer = 0;
} else {
	fall = 1; 
}

// Jump Based in the timer/holding the buttom
if(jump_hold_timer > 0){
	// Constantly set Yspeed to the jumping speed
	yspd = jspd[jump_count-1];
	jump_hold_timer --;
} else {
	fall = lerp(fall, fallspd, fallacc); 
}

// Y Collision
var _subpixel = 0.5; 

// Upwards Y Collisions (With a Ceilin Slopes)
if(yspd < 0 && place_meeting(x, y + yspd, par_solid)){
	/// Jump into the slope Ceilings
	var _slope_slide = false;
	
	// Slide Upleft to slope	
	if( movedir == 0 && !place_meeting(x - abs(yspd)-1, y + yspd, par_solid)){
		while (place_meeting(x, y + yspd, par_solid)){ x --; }
		_slope_slide = true;
	}
	
	// Slide UpRight to slope	
	if(movedir == 0 && !place_meeting(x+abs(yspd)+1, y+yspd, par_solid)){
		while (place_meeting(x, y+yspd, par_solid)){ x ++; }
		_slope_slide = true;
	}
	
	// Normal Y Collision
	if(!_slope_slide){
		// Scoot up to the wall precicelly
		var _pixelcheck = _subpixel * sign(yspd);
		while(!place_meeting(x, y + _pixelcheck, par_solid)){
			y += _pixelcheck; 
		}
	
		// Bonk State [OPTIONAL] if(yspd < 0){ jump_hold_timer = 0;}
	
		// Set yspd to 0 to collide
		yspd = 0;
	}
}

// Downwards Collisions
if(yspd >= 0){
	if(place_meeting(x, y+yspd, par_solid)){
		// Scoot up to the wall precicelly
		var _pixelcheck = _subpixel * sign(yspd);
		while(!place_meeting(x, y+_pixelcheck, par_solid)){
			y += _pixelcheck; 
		}
	
		// Bonk State if(yspd < 0){ jump_hold_timer = 0;}
	
		// Set yspd to 0 to collide
		yspd = 0;
	}

	// set if i'm on the ground
	if(place_meeting(x, y+1, par_solid)){
		scr_set_on_ground(true);
	}
}

// Move Y
y += yspd;
#endregion

#region /// Control Sprites
// Walking && Running
if(ground){
	if(abs(xspd) > 0 && abs(xspd) < movespd[1]-1){ 
		ang  -= face * (grav*2);
		action = "walk"; 
	}	
	if(abs(xspd) >= movespd[1]){ 
		ang  -= face * (grav*3);
		action = "run"; 
	}
}
// Idle
if(xspd == 0){ 
	ang = lerp(ang, 0, fallacc*2);	
	action = "idle"; 
}
// Jump
if(!ground){ 
	ang  += face * grav;
	action = "jump"; 
}

// Squash and Strech
xscale = lerp(xscale, 1, fallacc/2);
yscale = lerp(yscale, 1, fallacc/2);
ang    = clamp(ang,-12,12);
#endregion