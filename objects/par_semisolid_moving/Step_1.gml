/// @description 

// Move in circle
if(dir < 359){ dir += rot_spd; } else {
	dir = 0;
}

// Get our target positions
var _target_x = xstart + lengthdir_x(radius, dir);
var _target_y = ystart + lengthdir_y(radius, dir);

// Get our Xspd and Yspd
xspd = _target_x-x;
yspd = _target_y-y;

// Update position X and Y
x += xspd;
y += yspd;