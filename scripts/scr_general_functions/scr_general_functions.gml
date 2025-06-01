function scr_control_setup(){
	buffer_time             = 14;
	input_jump_buffered     = 0;
	input_jump_buffer_timer = 0;
}

function scr_getcontrols() {
	// Directional
	input_right = keyboard_check(vk_right);
	input_right = clamp(input_right, 0, 1); 
	input_left  = keyboard_check(vk_left);
	input_left  = clamp(input_left, 0, 1); 
	
	// Actions
	input_jump_pressed = keyboard_check_pressed(ord("Z")); 
	input_jump_pressed = clamp(input_jump_pressed, 0, 1); 
	input_jump = keyboard_check(ord("Z")); 
	input_jump = clamp(input_jump, 0, 1); 
	
	// Jump Key Buffers
	if(input_jump_pressed){
		input_jump_buffer_timer = buffer_time;
	}
	
	if(input_jump_buffer_timer > 0){
		input_jump_buffered = 1;
		input_jump_buffer_timer --;
	} else {
		input_jump_buffered = 0;
	}
}