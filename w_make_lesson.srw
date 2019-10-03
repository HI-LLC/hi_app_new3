$PBExportHeader$w_make_lesson.srw
forward
global type w_make_lesson from w_master_details_treeview
end type
type cb_new_report from u_commandbutton within w_make_lesson
end type
end forward

global type w_make_lesson from w_master_details_treeview
integer width = 3355
integer height = 2108
event ue_process_batch pbm_custom01
cb_new_report cb_new_report
end type
global w_make_lesson w_make_lesson

type variables
long il_method_from_id
long il_method_to_id
end variables

forward prototypes
public function long wf_master_retrieve ()
public function integer wf_delete_others ()
end prototypes

public function long wf_master_retrieve ();return dw_master.retrieve(il_method_from_id, il_method_to_id)

end function

public function integer wf_delete_others ();return 1
end function

on w_make_lesson.create
int iCurrent
call super::create
this.cb_new_report=create cb_new_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new_report
end on

on w_make_lesson.destroy
call super::destroy
destroy(this.cb_new_report)
end on

event open;long ll_rowcount, ll_current_lesson_id
dwobject dwo
string ls_expression
is_pres_type = Message.StringParm
super::event open()
is_master_title = "Lesson"
is_details_title = "Lesson Content"
is_master_id_name = "lesson_id"
is_details_id_name = "content_id"
is_master_des_name = "description"
is_details_des_name = "description"
is_column_id_name = {"subject_id", "chapter_id", "content_id"}
is_column_des_name = {"description", "description", "description"} 
is_dwobject_name = {"d_subject_for_make_lesson", "d_chapter", "d_content"}

tv_1.SetReDraw(false)
wf_make_tv_multiple_dw(0, is_pres_type, 1)
//wf_make_tv_multiple_dw(0, 1, 2)
tv_1.SetReDraw(true)
dw_master.SetTransObject(SQLCA)
dw_details.SetTransObject(SQLCA)

if wf_master_retrieve() > 0 then
	ll_rowcount = dw_master.RowCount()
	il_current_master_row = 1
	dw_master.event clicked(0, 0, il_current_master_row, dwo)
	if dw_details.retrieve(il_current_master_id) > 0 then
		il_current_details_row = 1
		dw_details.event clicked(0, 0, il_current_details_row, dwo)
	end if
end if

ls_expression = "method_id >= " + string(il_method_from_id) + " and method_id <= " + string(il_method_to_id)
DatawindowChild ldwc_method
dw_master.GetChild('method_id', ldwc_method)
ldwc_method.SetFilter(ls_expression)
ldwc_method.Filter()

end event

event close;call super::close;
if dw_master.ModifiedCount() > 0 or dw_details.ModifiedCount() > 0 then
	if MessageBox("Warning!", "Do you want to save the change?", Question!, YesNo!) = 1 then
		cb_save.event clicked()
	end if
end if
end event

type tv_1 from w_master_details_treeview`tv_1 within w_make_lesson
integer width = 882
integer height = 1192
end type

type dw_master from w_master_details_treeview`dw_master within w_make_lesson
string dataobject = "d_make_lesson"
end type

type dw_details from w_master_details_treeview`dw_details within w_make_lesson
integer x = 1019
string dataobject = "d_lesson_content"
boolean hscrollbar = true
end type

event dw_details::doubleclicked;call super::doubleclicked;OpenWithParm(w_content_catalogue, string(il_current_details_id))
end event

type cb_add_master from w_master_details_treeview`cb_add_master within w_make_lesson
integer width = 626
string text = "&Add Lesson"
end type

type cb_delete_master from w_master_details_treeview`cb_delete_master within w_make_lesson
integer x = 1760
integer width = 695
string text = "&Delete Lesson"
end type

event cb_delete_master::clicked;call super::clicked;long ll_count
dwobject ldwo
if il_current_master_id < 1 then
	MessageBox("Warning", "No data to delete!")
	return
end if
if MessageBox("Warning!", "Do you want to delete the selected item?", Question!, YesNo!) = 1 then
	if wf_delete_others() < 1 then
		return
	end if
	select count(*) into :ll_count 
	from lesson_program_content 
	where lesson_id = :il_current_master_id;
	if ll_count > 0 then
		delete lesson_program_content where lesson_id = :il_current_master_id;
		if SQLCA.sqlcode <> 0 then
			f_log_error("lesson_program_content", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
			MessageBox("Error", "Cannot delete the selected lesson in Lesson Program!")
			rollback;
			return
		end if
	end if
	select count(*) into :ll_count 
	from lesson_content 
	where lesson_id = :il_current_master_id;
	if ll_count > 0 then
		delete lesson_content where lesson_id = :il_current_master_id;
		if SQLCA.sqlcode <> 0 then
			f_log_error("lesson_content", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
			MessageBox("Error", "Cannot delete the lesson contents!")
			rollback;
			return
		end if
	end if
	dw_details.reset()
	dw_details.resetupdate()
	select count(*) into :ll_count 
	from lesson 
	where lesson_id = :il_current_master_id;
	if ll_count > 0 then
		delete lesson where lesson_id = :il_current_master_id;
		if SQLCA.sqlcode <> 0 then
			f_log_error("lesson", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
			MessageBox("Error", "Cannot delete selected lesson!")
			rollback;
			return
		else
			commit;
		end if
	end if
	dw_master.DeleteRow(il_current_master_row)
	dw_master.Resetupdate()
	if dw_master.RowCount() > 0 then
		if il_current_master_row > 1 then 
			il_current_master_row = il_current_master_row - 1
		end if
		dw_master.SelectRow(0, false)
		dw_master.SelectRow(il_current_master_row, true)
		dw_master.event clicked(0, 0, il_current_master_row, ldwo)
	else
		il_current_master_row = 0
		il_current_master_id = 0
		il_current_details_row = 0
		il_current_details_id = 0
	end if
end if
end event

type cb_save from w_master_details_treeview`cb_save within w_make_lesson
integer x = 2359
end type

event cb_save::clicked;long ll_row
for ll_row = 1 to dw_details.RowCount()
	if isnull(dw_details.GetItemNumber(ll_row, "lesson_content_sequence")) then
		dw_details.SetItem(ll_row, "lesson_content_sequence", ll_row)
	end if
next
super::event clicked()
end event

type cb_close from w_master_details_treeview`cb_close within w_make_lesson
integer x = 2793
end type

type cb_details_item from w_master_details_treeview`cb_details_item within w_make_lesson
integer width = 841
string text = "&Delete Lesson Content"
end type

event cb_details_item::clicked;call super::clicked;integer ll_count
dwobject ldwo
if il_current_details_id < 1 then
	MessageBox("Warning", "No Data to delete!")
	return
end if
if MessageBox("Warning!", "Do you want to delete the selected item?", Question!, YesNo!) = 1 then
	select count(*) into :ll_count 
	from lesson_content 
	where content_id = :il_current_details_id;
	if ll_count > 0 then
		delete lesson_content 
		where content_id = :il_current_details_id;
		commit;
	end if
	dw_details.DeleteRow(il_current_details_row)
	dw_details.Resetupdate()
	if dw_details.RowCount() > 0 then
		if il_current_details_row > 1 then 
			il_current_details_row = il_current_details_row - 1
		end if
//		ldwo = dw_details.object.reward_program_content_id
		dw_details.event clicked(0, 0, il_current_details_row, ldwo)
	else
		il_current_details_row = 0
		il_current_details_id = 0
	end if
end if
end event

type cb_new_report from u_commandbutton within w_make_lesson
integer x = 2560
integer y = 620
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string text = "&New Report"
end type

event clicked;call super::clicked;long ll_count, ll_progress_data_id, ll_row, ll_lesson_content_id
DateTime ldt_present
ldt_present = DateTime(today(), Now())
if il_current_master_id > 0 then
	select count(progress_data_id) into :ll_count
	from progress_data
	where lesson_id = :il_current_master_id;
	if ll_count > 0 then
		select max(progress_data_id) into :ll_progress_data_id
		from progress_data
		where lesson_id = :il_current_master_id;
		ll_progress_data_id++
	else
		ll_progress_data_id = 1
	end if
	for ll_row = 1 to dw_details.RowCount()
		ll_lesson_content_id = dw_details.GetItemNumber(ll_row, 'lesson_content_lesson_content_id')
		insert into progress_data(lesson_content_id, progress_data_id, lesson_id, begin_date, end_date)
		values (:ll_lesson_content_id, :ll_progress_data_id, :il_current_master_id, :ldt_present, :ldt_present);
	next
	commit;
end if
end event

