function scr_control_setup(){
	buffer_time             = 16;
	input_jump_buffered     = 0;
	input_jump_buffer_timer = 0;
}

function scr_getcontrols() {
	// Directional
	input_right = input_check("right");
	input_right = clamp(input_right, 0, 1); 
	input_left  = input_check("left");
	input_left  = clamp(input_left, 0, 1); 
	
	// Actions
	input_jump_pressed = input_check_pressed("jump");
	input_jump_pressed = clamp(input_jump_pressed, 0, 1); 
	input_jump = input_check("jump");
	input_jump = clamp(input_jump, 0, 1); 
	
	input_run = input_check("special");
	input_run = clamp(input_run, 0, 1); 
	
	// Jump Key Buffers
	if(input_jump_pressed){
		input_jump_buffer_timer = buffer_time;
		
		// Squash Effect
		if(jump_count < jump_max){ scr_gummy(0.64,1.45); }
	}
	
	if(input_jump_buffer_timer > 0){
		input_jump_buffered = 1;
		input_jump_buffer_timer --;
	} else {
		input_jump_buffered = 0;
	}
}
	
function scr_gummy(_xscale,_yscale){
	xscale = _xscale;
	yscale = _yscale;
}	