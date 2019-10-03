$PBExportHeader$w_make_lesson_numbermatch_count.srw
forward
global type w_make_lesson_numbermatch_count from w_make_lesson
end type
end forward

global type w_make_lesson_numbermatch_count from w_make_lesson
end type
global w_make_lesson_numbermatch_count w_make_lesson_numbermatch_count

forward prototypes
public function integer wf_delete_others ()
end prototypes

public function integer wf_delete_others ();long ll_count
select count(*) into :ll_count 
from lesson_container
where lesson_id = :il_current_master_id;
if ll_count > 0 then
	delete lesson_container 
	where lesson_id = :il_current_master_id;
	if SQLCA.sqlcode <> 0 then
		f_log_error("lesson_container", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot delete the lesson source and destination!")
		rollback;
		return -1
	end if
end if
return 1
end function

event open;il_method_from_id = 14
il_method_to_id = 14
title = "Lesson Setup - Number Matching Counting"
is_pres_type = "Quantity"
super::event open()
dw_master.object.method_id.initial = "14"		
end event

on w_make_lesson_numbermatch_count.create
call super::create
end on

on w_make_lesson_numbermatch_count.destroy
call super::destroy
end on

type tv_1 from w_make_lesson`tv_1 within w_make_lesson_numbermatch_count
end type

type dw_master from w_make_lesson`dw_master within w_make_lesson_numbermatch_count
string dataobject = "d_make_lesson_nmcount"
end type

type dw_details from w_make_lesson`dw_details within w_make_lesson_numbermatch_count
end type

type cb_add_master from w_make_lesson`cb_add_master within w_make_lesson_numbermatch_count
end type

type cb_delete_master from w_make_lesson`cb_delete_master within w_make_lesson_numbermatch_count
end type

type cb_save from w_make_lesson`cb_save within w_make_lesson_numbermatch_count
end type

type cb_close from w_make_lesson`cb_close within w_make_lesson_numbermatch_count
end type

type cb_details_item from w_make_lesson`cb_details_item within w_make_lesson_numbermatch_count
end type

