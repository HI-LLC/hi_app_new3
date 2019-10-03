$PBExportHeader$w_lesson_program.srw
forward
global type w_lesson_program from w_master_details_treeview
end type
type cb_set_lesson from u_commandbutton within w_lesson_program
end type
type cb_1 from commandbutton within w_lesson_program
end type
end forward

global type w_lesson_program from w_master_details_treeview
integer width = 3328
integer height = 2108
event ue_process_batch pbm_custom01
event ue_key_enter pbm_custom02
cb_set_lesson cb_set_lesson
cb_1 cb_1
end type
global w_lesson_program w_lesson_program

type variables
str_lesson_program istr_lp
dec idec_start_time, idec_duration
boolean ib_timer_on = false

end variables

forward prototypes
public function long wf_get_method_id (long al_lesson_id)
public subroutine wf_open_batch_window (long al_current_row)
end prototypes

event ue_process_batch;dec idec_current_time
il_current_details_row = il_current_details_row + 1
if ib_timer_on then
	idec_current_time =  dec(Cpu())/(1000.00)
	if (idec_current_time - idec_start_time) < idec_duration then
		if il_current_details_row > dw_details.RowCount() then
			il_current_details_row = 1
		end if
		wf_open_batch_window(il_current_details_row)
	else
		if gb_auto_close then
			cb_set_lesson.event clicked()
			post close(this)
			post close(gn_appman.iw_frame)
		end if
	end if
else	
	if il_current_details_row <= dw_details.RowCount() then
		wf_open_batch_window(il_current_details_row)
	else
		il_current_details_row = il_current_details_row - 1
		if gb_auto_close then
			cb_1.event clicked()
		end if

	end if
end if


end event

event ue_key_enter;keybd_event(13, 28, 0, 0)
end event

public function long wf_get_method_id (long al_lesson_id);long ll_row, ll_method_id
string ls_expression
ls_expression = "lesson_id = " + string(al_lesson_id)
ll_row = ids_tv_data.Find(ls_expression, 1, ids_tv_data.RowCount())
ll_method_id = ids_tv_data.GetItemNumber(ll_row, "method_id")
return ll_method_id
end function

public subroutine wf_open_batch_window (long al_current_row);long ll_method_id
dwobject dwo
dwo = dw_details.object.lesson_id
dw_details.event clicked(0, 0, al_current_row, dwo)
istr_lp.lesson_id = dw_details.GetItemNumber(al_current_row, "lesson_id")
istr_lp.retry_num = dw_details.GetItemNumber(al_current_row, "replay_no")
istr_lp.current_try_num = 1

ll_method_id = wf_get_method_id(istr_lp.lesson_id)
choose case ll_method_id
	case 2
		post OpenSheetWithParm(w_lesson_discrete_trial, istr_lp, gn_appman.iw_frame, 0, original!)
	case 3 to 13
		post OpenSheetWithParm(w_lesson_comp_scale, istr_lp, gn_appman.iw_frame, 0, original!)
	case 14
		post OpenSheetWithParm(w_lesson_dragdrop_count, istr_lp, gn_appman.iw_frame, 0, original!)
	case 15
		post OpenSheetWithParm(w_lesson_numbermatch_count, istr_lp, gn_appman.iw_frame, 0, original!)
	case 16
		post OpenSheetWithParm(w_lesson_mw_cmmnd, istr_lp, gn_appman.iw_frame, 0, original!)
	case 17 to 19
		post OpenSheetWithParm(w_lesson_comp_object, istr_lp, gn_appman.iw_frame, 0, original!)
end choose

end subroutine

on w_lesson_program.create
int iCurrent
call super::create
this.cb_set_lesson=create cb_set_lesson
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_set_lesson
this.Control[iCurrent+2]=this.cb_1
end on

on w_lesson_program.destroy
call super::destroy
destroy(this.cb_set_lesson)
destroy(this.cb_1)
end on

event open;call super::open;long ll_rowcount, ll_current_lesson_id
string ls_expression
istr_lp.str_name = "BATCH"
istr_lp.handle = this
is_master_title = "Lesson Program"
is_details_title = "Lesson Program Content"
is_master_id_name = "lesson_program_id"
is_master_des_name = "description"
is_details_des_name = "description"
is_details_id_name = "lesson_program_content_id"
is_column_id_name = {"student_id", "method_id", "lesson_id"}
is_column_des_name = {"student_fullname", "method_description", "description"}
ids_tv_data = create datastore
ids_tv_data.dataobject = 'd_lesson_for_program_tv'
ids_tv_data.SetTransObject(SQLCA)
ids_tv_data.Retrieve()
tv_1.SetReDraw(false)
wf_make_tv_single_dw()
tv_1.SetReDraw(true)
dw_master.SetTransObject(SQLCA)
dw_details.SetTransObject(SQLCA)
select current_id into :il_current_master_id
from system_parms where parm_name = 'LESSON_PROGRAM';
if dw_master.Retrieve() > 0 then
	ll_rowcount = dw_master.RowCount()
	il_current_master_row = dw_master.of_get_row("lesson_program_id", il_current_master_id)
	dwobject dwo
	dw_master.event clicked(0, 0, il_current_master_row, dwo)
	if il_current_master_row > 0 then
		ll_current_lesson_id = dw_master.GetItemNumber(il_current_master_row, "current_lesson_id")
		il_current_details_row = dw_details.of_get_row("lesson_id", ll_current_lesson_id)
		dw_details.event clicked(0, 0, il_current_details_row, dwo)
	end if
end if
if gb_auto_open then
	cb_1.post event clicked()
end if


end event

event closequery;call super::closequery;long ll_count, ll_count2, ll_lesson_id
if il_current_master_id > 0 then
	update system_parms
	set current_id = :il_current_master_id
	where parm_name = 'LESSON_PROGRAM';
	commit;
end if

if il_current_details_row > 0 then
	ll_lesson_id = dw_details.GetItemNumber(il_current_details_row, "lesson_id")
	update lesson_program
	set current_lesson_id = :ll_lesson_id
	where lesson_program_id = :il_current_master_id;
	commit;
end if

end event

type tv_1 from w_master_details_treeview`tv_1 within w_lesson_program
integer x = 82
integer width = 882
integer height = 1192
end type

type dw_master from w_master_details_treeview`dw_master within w_lesson_program
string dataobject = "d_lesson_program"
end type

type dw_details from w_master_details_treeview`dw_details within w_lesson_program
integer x = 1019
string dataobject = "d_lesson_program_content"
end type

type cb_add_master from w_master_details_treeview`cb_add_master within w_lesson_program
integer width = 626
string text = "&Add Lesson Program"
end type

type cb_delete_master from w_master_details_treeview`cb_delete_master within w_lesson_program
integer x = 1664
integer width = 695
string text = "&Delete Lesson Pragram"
end type

event cb_delete_master::clicked;call super::clicked;long ll_count
dwobject ldwo
if il_current_master_id < 1 then
	MessageBox("Warning", "No data to delete!")
	return
end if
if MessageBox("Warning!", "Do you want to delete the selected item?", Question!, YesNo!) = 1 then
	select count(*) into :ll_count 
	from lesson_program_content 
	where lesson_program_id = :il_current_master_id;
	if ll_count > 0 then
		delete lesson_program_content where lesson_program_id = :il_current_master_id;
	end if
	dw_details.reset()
	select count(*) into :ll_count 
	from lesson_program 
	where lesson_program_id = :il_current_master_id;
	if ll_count > 0 then
		delete lesson_program where lesson_program_id = :il_current_master_id;
	end if
	commit;
	dw_master.DeleteRow(il_current_master_row)
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

type cb_save from w_master_details_treeview`cb_save within w_lesson_program
integer x = 2363
end type

event cb_save::clicked;call super::clicked;long ll_lesson_id
long ll_row
dwobject dwo
ll_lesson_id = dw_master.GetItemNumber(il_current_master_row, "current_lesson_id")
ll_row = dw_details.of_get_row("lesson_id", ll_lesson_id)
if ll_row > 0 then
	dw_details.event clicked(0, 0, ll_row, dwo)
end if
end event

type cb_close from w_master_details_treeview`cb_close within w_lesson_program
integer x = 2798
end type

type cb_details_item from w_master_details_treeview`cb_details_item within w_lesson_program
integer x = 1029
integer width = 485
string text = "&Delete Lesson"
end type

event cb_details_item::clicked;call super::clicked;integer ll_count
dwobject ldwo
if il_current_details_id < 1 then
	MessageBox("Warning", "No Data to delete!")
	return
end if
if MessageBox("Warning!", "Do you want to delete the selected item?", Question!, YesNo!) = 1 then
	select count(*) into :ll_count 
	from lesson_program_content 
	where lesson_program_content_id = :il_current_details_id;
	if ll_count > 0 then
		delete lesson_program_content 
		where lesson_program_content_id = :il_current_details_id;
		commit;
	end if
	dw_details.DeleteRow(il_current_details_row)
	if dw_details.RowCount() > 0 then
		if il_current_details_row > 1 then 
			il_current_details_row = il_current_details_row - 1
		end if
//		ldwo = dw_details.object.reward_program_content_id
		dw_details.event clicked(0, 0, il_current_details_id, ldwo)
	else
		il_current_details_row = 0
		il_current_details_id = 0
	end if
end if
end event

type cb_set_lesson from u_commandbutton within w_lesson_program
integer x = 1573
integer y = 1832
integer width = 599
integer taborder = 40
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "Set Current Lesson"
end type

event clicked;call super::clicked;long ll_lesson_id
if il_current_details_id > 0 then
	ll_lesson_id = dw_details.GetItemNumber(il_current_details_row, "lesson_id")
	dw_master.SetItem(il_current_master_row, "current_lesson_id", ll_lesson_id)
end if
end event

type cb_1 from commandbutton within w_lesson_program
integer x = 2811
integer y = 616
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run Batch"
end type

event clicked;long ll_rowcount
ll_rowcount = dw_details.Rowcount()
if isnull(ll_rowcount) then
	MessageBox("Message", "null")
	return
end if	
if dw_details.Rowcount() < 1 then
	MessageBox("Message", "No lesson in the selected lesson program")
	return
end if
if isnull(il_current_details_row) then
	MessageBox("Message", "null")
	return
end if
if il_current_details_row < 1 or il_current_details_row > dw_details.Rowcount() then
	il_current_details_row = 1
end if
long ll_timer
ll_timer = dw_master.GetItemNumber(il_current_master_row, "timer")
if not isnull(ll_timer) and ll_timer > 0 then
	ib_timer_on = true
	idec_duration = dec(ll_timer)*60.0
	idec_start_time = dec(cpu())/(1000.00)
end if
wf_open_batch_window(il_current_details_row)

end event

