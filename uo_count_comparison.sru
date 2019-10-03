$PBExportHeader$uo_count_comparison.sru
forward
global type uo_count_comparison from uo_count
end type
end forward

global type uo_count_comparison from uo_count
integer width = 279
integer height = 204
event clicked pbm_lbuttonclk
end type
global uo_count_comparison uo_count_comparison

event clicked;iw_parent.event clicked(flags, x + xpos, y + ypos)
end event

on uo_count_comparison.create
call super::create
end on

on uo_count_comparison.destroy
call super::destroy
end on

type st_number from uo_count`st_number within uo_count_comparison
end type

type p_1 from uo_count`p_1 within uo_count_comparison
end type

event p_1::clicked;call super::clicked;parent.event clicked(0, 0, 0)
end event

type oval_1 from uo_count`oval_1 within uo_count_comparison
end type

