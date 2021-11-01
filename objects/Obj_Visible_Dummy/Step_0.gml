/// @description Check Mobs

var xx, yy, m_xx, m_yy;
yy = (keyboard_check(ord("W")) - keyboard_check(ord("S")));
xx = (keyboard_check(ord("A")) - keyboard_check(ord("D")));
m_xx = xx * 4;
m_yy = yy * 4;


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
var _near, _nearest;

_near = collision_circle(x ,y, env_max_length, Obj_Entity, false, true)
if _near {
	var col = instance_place(x, y, Obj_Entity);
	if col && cool_time = 0 {
		cool_time = 60;
		global.self_text += col.ins_name + "과(와) 부딛혔다.\n"
	}
	
	if ds_list_find_index(checked_entity, other.id) = -1 {
		ds_list_add(checked_entity, other.id);
		global.env_text += "무언가가 가까이에 있다.\n";
		}
		
	_nearest = collision_circle(x ,y, (env_max_length / 2), Obj_Entity, false, true)
	if _nearest && scan_cool_time = 0 {
		scan_cool_time = 30;
		var dir = (point_direction(x, y, _nearest.x, _nearest.y) - 90) div 30;
		
		if !targeted {
			global.env_text += "무언가가 매우 가까이에 있다. " + string(dir + 1) + " 방향이다.\n";
		} else {
			global.env_text += "당신은 추격받고 있다! " + string(dir) + " 방향이다!\n";
		}
		switch(_nearest.ins_type) {

			case 0 : {
				if !targeted
				global.env_text += " 움직이지 않는 듯 하다.\n";
			} break;
			
			
			case 1 : {
				targeted = true;
				if !targeted {
					if _nearest.ins_speed < 3 {
						global.env_text += " 다가오고 있다!\n";
					} else {
						global.env_text += " 매우 빠르게 다가오고 있다!\n";
					}
				}
			} break;
			
		}

	}
} else {
	if ds_list_find_index(checked_entity, other.id) != -1 {
		var ds = ds_list_find_index(checked_entity, other.id);
		ds_list_delete(checked_entity, ds);
	}
}

cool_time -= 1;
cool_time = max(0, cool_time);

scan_cool_time -= 1;
scan_cool_time = max(0, scan_cool_time);