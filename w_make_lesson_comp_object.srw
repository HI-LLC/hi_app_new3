$PBExportHeader$w_make_lesson_comp_object.srw
forward
global type w_make_lesson_comp_object from w_make_lesson
end type
end forward

global type w_make_lesson_comp_object from w_make_lesson
end type
global w_make_lesson_comp_object w_make_lesson_comp_object

forward prototypes
public subroutine wf_set_pair ()
end prototypes

public subroutine wf_set_pair ();integer li_degree, li_row, li_pair_ind = 0, li_pair_tmp = 0
if dw_master.RowCount() > 0 then
	li_degree = dw_master.GetItemNumber(il_current_master_row, "degree")
	for li_row = 1 to dw_details.RowCount()
		dw_details.SetItem(li_row, "lesson_content_pair_ind", li_pair_ind)
		if mod(li_row, li_degree) = 0 then
			li_pair_ind = mod(li_pair_ind + 1, 2)
		end if
	next
end if
end subroutine

event open;call super::open;datawindowchild ldwc
string ls_expression
il_method_from_id = 17		
il_method_to_id = 19
title = "Lesson Setup - Comparison (Objects)"
is_pres_type = "Object"
super::event open()
dw_master.object.pair_ind.initial = "1"
dw_master.GetChild("lesson_type", ldwc)
if isvalid(ldwc) then
	ls_expression = 'method_id >= 17 and method_id <= 19'
	ldwc.SetFilter(ls_expression)
	ldwc.Filter()
end if
	
wf_set_pair()

end event

on w_make_lesson_comp_object.create
call super::create
end on

on w_make_lesson_comp_object.destroy
call super::destroy
end on

type tv_1 from w_make_lesson`tv_1 within w_make_lesson_comp_object
end type

type dw_master from w_make_lesson`dw_master within w_make_lesson_comp_object
integer width = 3145
string dataobject = "d_make_lesson_ocomp"
boolean vscrollbar = false
end type

type dw_details from w_make_lesson`dw_details within w_make_lesson_comp_object
end type

event dw_details::dragdrop;call super::dragdrop;wf_set_pair()
end event

type cb_add_master from w_make_lesson`cb_add_master within w_make_lesson_comp_object
end type

type cb_delete_master from w_make_lesson`cb_delete_master within w_make_lesson_comp_object
end type

type cb_save from w_make_lesson`cb_save within w_make_lesson_comp_object
end type

type cb_close from w_make_lesson`cb_close within w_make_lesson_comp_object
end type

type cb_details_item from w_make_lesson`cb_details_item within w_make_lesson_comp_object
end type

