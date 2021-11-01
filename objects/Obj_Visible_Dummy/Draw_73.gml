/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_black);
draw_rectangle(view_xport[0], view_yport[0], view_xport[0] + 640, view_yport[0] + 480, false);

draw_set_color(c_aqua);
draw_set_valign(fa_bottom);
draw_set_font(Font_Gulim);
draw_text(view_xport[0] + 32, view_yport[0] + 448, global.self_text);

draw_text(view_xport[0] + 352, view_yport[0] + 448, global.env_text);

