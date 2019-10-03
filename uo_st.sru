$PBExportHeader$uo_st.sru
forward
global type uo_st from statictext
end type
end forward

global type uo_st from statictext
integer width = 192
integer height = 72
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
long backcolor = 15780518
string text = "None"
boolean focusrectangle = false
end type
global uo_st uo_st

type variables
dec cpu_time
long il_hi_light_color
long il_default_color
integer ii_index
string is_picture
w_reading_multi_pages iw_parent
end variables

event getfocus;cpu_time = cpu()/1000
backcolor = il_hi_light_color
end event

event constructor;il_default_color = backcolor
cpu_time = 0
end event

event losefocus;backcolor = il_default_color
end event

event clicked;iw_parent.ii_old_index = iw_parent.ii_current_index
iw_parent.ii_current_index = ii_index
send(handle(iw_parent), 1024, 0, 0)
end event

on uo_st.create
end on

on uo_st.destroy
end on

