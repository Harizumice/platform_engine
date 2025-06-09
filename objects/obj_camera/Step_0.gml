/// @description 

if(keyboard_check_pressed(vk_f4)){
	window_set_fullscreen(!window_get_fullscreen());
}

// Anul if the target don't exists
if(!instance_exists(target)){ exit; }

// Get Camera Size
var _camwidth  = camera_get_view_width(view_camera[0]);
var _camheight = camera_get_view_height(view_camera[0]);

// Get Camera Target Coordinates
var _camx = target.x - _camwidth/2; 
var _camy = target.y - _camheight/2;

// Constrain cam to room borders
_camx = clamp(_camx, 0, room_width - _camwidth);
_camy = clamp(_camy, 0, room_height - _camheight);

// Set cam coordinate variables
final_cam_x += (_camx-final_cam_x) * cam_trail_spd_x;
final_cam_y += (_camy-final_cam_y) * cam_trail_spd_y;

// Set camera coordinates
camera_set_view_pos(view_camera[0], final_cam_x, final_cam_y); 