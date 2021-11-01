/// @description Insert description here
draw_self();
draw_circle(x, y, ins_loudness * 16, true);
draw_set_font(Font_Gulim)
draw_text(x, y, string(ins_target) + " " + string(ins_target_touched));
draw_text(x, y + 12, (point_direction(x, y, Obj_Visible_Dummy.x, Obj_Visible_Dummy.y) + 22.5) div 45)