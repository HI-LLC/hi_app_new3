$PBExportHeader$w_make_lesson_discrete_trial.srw
forward
global type w_make_lesson_discrete_trial from w_make_lesson
end type
end forward

global type w_make_lesson_discrete_trial from w_make_lesson
end type
global w_make_lesson_discrete_trial w_make_lesson_discrete_trial

event open;call super::open;il_method_from_id = 2		
il_method_to_id = 2
title = "Lesson Setup - Discrete-trial"
is_pres_type = "Object"
super::event open()

end event

on w_make_lesson_discrete_trial.create
call super::create
end on

on w_make_lesson_discrete_trial.destroy
call super::destroy
end on

type tv_1 from w_make_lesson`tv_1 within w_make_lesson_discrete_trial
end type

type dw_master from w_make_lesson`dw_master within w_make_lesson_discrete_trial
string dataobject = "d_make_lesson_dtrial"
end type

type dw_details from w_make_lesson`dw_details within w_make_lesson_discrete_trial
end type

type cb_add_master from w_make_lesson`cb_add_master within w_make_lesson_discrete_trial
end type

type cb_delete_master from w_make_lesson`cb_delete_master within w_make_lesson_discrete_trial
end type

type cb_save from w_make_lesson`cb_save within w_make_lesson_discrete_trial
end type

type cb_close from w_make_lesson`cb_close within w_make_lesson_discrete_trial
end type

type cb_details_item from w_make_lesson`cb_details_item within w_make_lesson_discrete_trial
end type

