/// @description Physics Handle

// Get the Inputs
input_right        = keyboard_check(vk_right);
input_left         = keyboard_check(vk_left);
input_jump_pressed = keyboard_check_pressed(ord("Z")); 

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

// Jumping
if(input_jump_pressed && place_meeting(x, y+1, par_solid)){
	yspd = jspd;
}

// Y Collision
var _subpixel = 0.5; 
if(place_meeting(x, y+yspd, par_solid)){
	// Scoot up to the wall precicelly
	var _pixelcheck = _subpixel * sign(yspd);
	while(!place_meeting(x, y+_pixelcheck, par_solid)){
		y += _pixelcheck; 
	}
	
	// Set yspd to 0 to collide
	yspd = 0;
}

// Move Y
y += yspd;
#endregion