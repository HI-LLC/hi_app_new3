$PBExportHeader$w_make_lesson_comp_scale.srw
forward
global type w_make_lesson_comp_scale from w_make_lesson
end type
end forward

global type w_make_lesson_comp_scale from w_make_lesson
end type
global w_make_lesson_comp_scale w_make_lesson_comp_scale

event open;il_method_from_id = 3
il_method_to_id = 13
title = "Lesson Setup - Comparison (Scale)"
is_pres_type = "Quantity"
super::event open()

end event

on w_make_lesson_comp_scale.create
call super::create
end on

on w_make_lesson_comp_scale.destroy
call super::destroy
end on

type tv_1 from w_make_lesson`tv_1 within w_make_lesson_comp_scale
end type

type dw_master from w_make_lesson`dw_master within w_make_lesson_comp_scale
string dataobject = "d_make_lesson_scomp"
end type

type dw_details from w_make_lesson`dw_details within w_make_lesson_comp_scale
end type

type cb_add_master from w_make_lesson`cb_add_master within w_make_lesson_comp_scale
end type

type cb_delete_master from w_make_lesson`cb_delete_master within w_make_lesson_comp_scale
end type

type cb_save from w_make_lesson`cb_save within w_make_lesson_comp_scale
end type

type cb_close from w_make_lesson`cb_close within w_make_lesson_comp_scale
end type

type cb_details_item from w_make_lesson`cb_details_item within w_make_lesson_comp_scale
end type

