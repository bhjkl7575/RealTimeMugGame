if !player_targeted && !ins_target_touched {
	if (irandom(200) = 0 || place_meeting(x, y, Obj_Wall)) {
		move_towards_point(irandom(room_width), irandom(room_height), ins_speed);
	}
} else {
	move_towards_point(ins_target.x, ins_target.y, ins_speed);
}

