/// @description Check Mobs

var xx, yy, m_xx, m_yy, _z_loud, step;
yy = (keyboard_check(ord("W")) - keyboard_check(ord("S")));
xx = (keyboard_check(ord("A")) - keyboard_check(ord("D")));
m_xx = xx * ins_speed;
m_yy = yy * ins_speed;

if !place_meeting(x - m_xx, y, Obj_Wall) {
	x -= m_xx;
}

if !place_meeting(x, y - m_yy, Obj_Wall) {
	y -= m_yy;
}	
	
if (xprevious != x || yprevious != y) {
	collision = false;

} else {

	if !collision && (xx != 0 || yy != 0) {
		collision = true;
		global.self_text += "벽에 닿았다.\n";
	}


	if keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("D")) {
		if (xx) = -1
			global.self_text += "오른쪽으로 벽이 있다.\n";
		else if (xx) = 1
			global.self_text += "왼쪽으로 벽이 있다.\n";
	}
	if keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")) {
		if (yy) = -1
			global.self_text += "아래쪽으로 벽이 있다.\n";
		else if (yy) = 1
			global.self_text += "위쪽으로 벽이 있다.\n";
	}
}

step = instance_place(x, y, Obj_Zone);

if abs(xx) || abs(yy){

	if step {
		_z_loud = step.zone_loudness;
		if step_cooldown = 0 && step.zone_loudness > 0 {
			step_cooldown = room_speed;
			global.env_text += step.zone_name + "을 밟는 소리가 난다.\n";

		}
	} else {
		_z_loud = ins_speed;
		step_cooldown = 0;
	}
} else {
	_z_loud = 0;
}

step_cooldown -= 1;
step_cooldown = max(step_cooldown, 0);

loudness = 16 * (_z_loud + abs(xx) + abs(yy))