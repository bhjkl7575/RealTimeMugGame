/// @description Entity Moving

var xx, yy, step, _z_loud, _player_dir, _player_dist, _player_loud;

step = instance_place(x, y, Obj_Zone);
xx = abs(x - xprevious);
yy = abs(y - yprevious);

_player_dir = (point_direction(x, y, Obj_Visible_Dummy.x, Obj_Visible_Dummy.y) + 22.5) div 45;
_player_dist = point_distance(x, y, Obj_Visible_Dummy.x, Obj_Visible_Dummy.y);
_player_loud = Obj_Visible_Dummy.loudness;
switch(_player_dir) {

	case 0 : {
		_player_dir = "서쪽"
	} break;

	case 1 : {
		_player_dir = "남서쪽"
	} break;

	case 2 : {
		_player_dir = "남쪽"
	} break;

	case 3 : {
		_player_dir = "남동쪽"
	} break;

	case 4 : {
		_player_dir = "동쪽"
	} break;

	case 5 : {
		_player_dir = "북동쪽"
	} break;

	case 6 : {
		_player_dir = "북쪽"
	} break;

	case 7 : {
		_player_dir = "북서쪽"
	} break;

	case 8 : {
		_player_dir = "서쪽"
	} break;

	default : {
		_player_dir = "???"
	} break;

}


if (xx >= 0 || yy >= 0) && !player_targeted{
	if step && ins_type = "monster" {
		_z_loud = step.zone_loudness;
		if step_cooldown = 0 && step.zone_loudness > 0 {
			step_cooldown = room_speed;
			global.env_text += step.zone_name + "이 (가) 밟히는 소리가 들린다. " + _player_dir + "\n";

		}
	} else {
		_z_loud = ins_speed;
		step_cooldown = 0;
	}
} else {
	_z_loud = 0;
}

ins_self_loud -= 0.1;
ins_self_loud = max(ins_self_loud, 0);

step_cooldown -= 1;
step_cooldown = max(step_cooldown, 0);

sound_cooldown -= 1;
sound_cooldown = max(sound_cooldown, 0);

if irandom(100) = 1 && ins_type = "monster" {
	ins_self_loud = 10;
	if _player_dist <= (ins_self_loud * 16) {
		global.env_text += ins_name + "이 (가) 소리지른다.\n"
	}
	
}

if _player_dist <= global.length {
	if sound_cooldown = 0 {
		if !sound_targeted {
			global.env_text += "가까운 곳에 무언가 있다.\n";
			sound_targeted = true;
		}

	} else {
		sound_targeted = false;
	}

	sound_cooldown = 120;
	
}

if it_can_target {
	if !player_targeted && _player_dist <= max(Obj_Visible_Dummy.loudness, 64){
		ins_target_touched = false;
		player_cooldown = 120;
		player_targeted = true;
		global.env_text += ins_name + "가 당신을 추적한다!\n";
		ins_target = Obj_Visible_Dummy;

	if step_cooldown = 0 {
		step_cooldown = room_speed;
		global.env_text += ins_name + " 가 " + _player_dir + "에서 접근 중이다!\n"
	}
	}
}

if player_cooldown = 0 && player_targeted {
	player_targeted = false;
	global.env_text += ins_name + "가 잠잠해졌다.\n";
}

player_cooldown -= 1;
player_cooldown = max(player_cooldown, 0);


if _player_dist <= (global.length / 2) {

	if !nearest_targeted {
		global.env_text += ins_name + "에 매우 가까이 접근하였다. " + _player_dir + "\n";
		nearest_targeted = true;
	}	

} else {

	nearest_targeted = false;
}

ins_loudness = min(_z_loud + ins_self_loud + xx + yy, 20);

if place_meeting(x, y, Obj_Visible_Dummy) {
	if !player_touched {
		player_touched = true;
		global.self_text += ins_name + " 와 부딛혔다.\n";
		
		if irandom(5) = 0 && ins_type = "package_tower" {
			global.self_text += ins_name + "가 무너져내렸다!\n";
			ins_self_loud = 20;
			ins_type = "package";
			ins_name = "무너진 잔해";
			
			var _zone = instance_create_layer(x - 48, y - 48, "Instances", Obj_Zone)
			_zone.zone_loudness = 13;
			_zone.zone_type = 1;
			_zone.zone_name = "널부러진 잔해"
			_zone.image_xscale = 3;
			_zone.image_yscale = 3;
			with(Obj_Entity) {
				var _dist = point_distance(x, y, other.x, other.y);
				if ins_type = "monster" && _dist <= 320 {
					ins_target = other.id;
					ins_target_touched = true;
				}
			}
		}
	}
} else {
	player_touched = false;
}

if place_meeting(x, y, ins_target){
	ins_target_touched = false;
}