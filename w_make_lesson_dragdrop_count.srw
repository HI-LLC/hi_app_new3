$PBExportHeader$w_make_lesson_dragdrop_count.srw
forward
global type w_make_lesson_dragdrop_count from w_make_lesson
end type
type cb_add_dest from u_commandbutton within w_make_lesson_dragdrop_count
end type
type dw_destination from u_datawindow within w_make_lesson_dragdrop_count
end type
type dw_source from u_datawindow within w_make_lesson_dragdrop_count
end type
type cb_add_source from u_commandbutton within w_make_lesson_dragdrop_count
end type
end forward

global type w_make_lesson_dragdrop_count from w_make_lesson
integer width = 3767
integer height = 2116
cb_add_dest cb_add_dest
dw_destination dw_destination
dw_source dw_source
cb_add_source cb_add_source
end type
global w_make_lesson_dragdrop_count w_make_lesson_dragdrop_count

type variables
long il_current_source_row
long il_current_destination_row
long il_current_source_id
long il_current_destination_id
end variables

forward prototypes
public function boolean wf_is_valid_container (string as_container_id, ref datawindow adw_container)
public function integer wf_delete_others ()
end prototypes

public function boolean wf_is_valid_container (string as_container_id, ref datawindow adw_container);long ll_row
string ls_expression
ls_expression = "container_id = " + as_container_id
if adw_container.Find(ls_expression, 1, adw_container.RowCount()) > 0 then
	return false
else
	return true
end if
end function

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

event open;il_method_from_id = 0
il_method_to_id = 0
title = "Lesson Setup - Drag-drop Counting"
is_pres_type = "Quantity"
dw_source.SetTransObject(SQLCA)
dw_Destination.SetTransObject(SQLCA)
dw_master.object.method_id.initial = "15"
super::event open()
if il_current_master_id > 0 then
	if dw_source.Retrieve(il_current_master_id) > 0 then
		il_current_source_row = 1
		dw_source.SelectRow(0, false)
		dw_source.SelectRow(1, true)
	end if
	if dw_Destination.Retrieve(il_current_master_id) > 0 then
		il_current_Destination_row = 1
		dw_Destination.SelectRow(0, false)
		dw_Destination.SelectRow(1, true)
	end if
end if
end event

on w_make_lesson_dragdrop_count.create
int iCurrent
call super::create
this.cb_add_dest=create cb_add_dest
this.dw_destination=create dw_destination
this.dw_source=create dw_source
this.cb_add_source=create cb_add_source
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add_dest
this.Control[iCurrent+2]=this.dw_destination
this.Control[iCurrent+3]=this.dw_source
this.Control[iCurrent+4]=this.cb_add_source
end on

on w_make_lesson_dragdrop_count.destroy
call super::destroy
destroy(this.cb_add_dest)
destroy(this.dw_destination)
destroy(this.dw_source)
destroy(this.cb_add_source)
end on

type tv_1 from w_make_lesson`tv_1 within w_make_lesson_dragdrop_count
integer x = 37
integer y = 592
integer width = 736
end type

type dw_master from w_make_lesson`dw_master within w_make_lesson_dragdrop_count
integer x = 41
integer y = 48
integer width = 3547
string dataobject = "d_make_lesson_ddcount"
end type

event dw_master::clicked;call super::clicked;if il_current_master_id > 0 and not isnull(dw_source.GetItemNumber(1, "container_id")) then
	if dw_source.Retrieve(il_current_master_id) > 0 then
		il_current_source_row = 1
		dw_source.SelectRow(0, false)
		dw_source.SelectRow(1, true)
	end if
	if dw_Destination.Retrieve(il_current_master_id) > 0 then
		il_current_Destination_row = 1
		dw_Destination.SelectRow(0, false)
		dw_Destination.SelectRow(1, true)
	end if
end if
end event

type dw_details from w_make_lesson`dw_details within w_make_lesson_dragdrop_count
integer x = 795
integer y = 776
integer width = 1701
string dataobject = "d_lesson_content_count"
end type

event dw_details::clicked;call super::clicked;if dw_source.Retrieve(il_current_master_id) > 0 then
	il_current_source_row = 1
	dw_source.SelectRow(0, false)
	dw_source.SelectRow(1, true)
end if
if dw_Destination.Retrieve(il_current_master_id) > 0 then
	il_current_Destination_row = 1
	dw_Destination.SelectRow(0, false)
	dw_Destination.SelectRow(1, true)
end if

end event

type cb_add_master from w_make_lesson`cb_add_master within w_make_lesson_dragdrop_count
integer x = 937
integer y = 592
end type

event clicked;call super::clicked;dw_source.reset()
il_current_source_row = dw_source.InsertRow(0)
dw_destination.reset()
il_current_destination_row = dw_destination.InsertRow(0)
il_current_destination_row = dw_destination.InsertRow(0)


end event

type cb_delete_master from w_make_lesson`cb_delete_master within w_make_lesson_dragdrop_count
integer x = 1691
integer y = 592
end type

type cb_save from w_make_lesson`cb_save within w_make_lesson_dragdrop_count
integer x = 1664
integer y = 1820
integer width = 366
end type

event cb_save::clicked;long ll_row
super::event clicked()
if isnull(dw_master.GetItemNumber(dw_master.GetRow(), 'lesson_id')) then // new lesson not save successfully
	MessageBox("Error", "The new lesson is not saved.")
	return -1
end if
dw_source.AcceptText()
dw_destination.AcceptText()
if isnull(dw_source.GetItemNumber(1, 'lesson_id')) then
	dw_source.SetItem(1, 'lesson_id', il_current_master_id)
end if
if isnull(dw_source.GetItemNumber(1, "container_id")) then
	MessageBox("Error", "No container selected for the source.")
	dw_source.SetFocus()
	dw_Source.SetColumn("container_id")
	return -1
end if
if isnull(dw_source.GetItemNumber(1, "bean_id")) then
	MessageBox("Error", "No bean selected for the source.")
	dw_source.SetFocus()
	dw_Source.SetColumn("bean_id")
	return -1
end if
for ll_row = 1 to dw_destination.RowCount() 
	if isnull(dw_destination.GetItemNumber(ll_row, 'lesson_id')) then
		dw_destination.SetItem(ll_row, 'lesson_id', il_current_master_id)
	end if
	if isnull(dw_destination.GetItemNumber(ll_row, "container_id")) then
		MessageBox("Error", "No container selected for the destination.")
		dw_destination.SetFocus()
		dw_destination.SetColumn("container_id")
		dw_destination.SelectRow(0, false)
		dw_destination.SelectRow(ll_row, true)
		return -1
	end if
next
if dw_source.ModifiedCount() > 0 then
	dw_source.Update()
	if SQLCA.sqlcode <> 0 then
		f_log_error("source container", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Fail in saving data!")
		rollback;
		return
	end if
	commit;	
end if

if dw_destination.ModifiedCount() > 0 then
	dw_destination.Update()
	if SQLCA.sqlcode <> 0 then
		f_log_error("destination container", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Fail in saving data!")
		rollback;
		return
	end if
	commit;	
end if
dw_master.Resetupdate()
dw_details.Resetupdate()
dw_source.Resetupdate()
dw_destination.Resetupdate()


end event

type cb_close from w_make_lesson`cb_close within w_make_lesson_dragdrop_count
integer x = 2094
integer y = 1820
integer width = 389
end type

type cb_details_item from w_make_lesson`cb_details_item within w_make_lesson_dragdrop_count
integer x = 782
integer y = 1820
integer width = 759
end type

type cb_new_report from w_make_lesson`cb_new_report within w_make_lesson_dragdrop_count
boolean visible = false
integer x = 2642
integer y = 592
end type

type cb_add_dest from u_commandbutton within w_make_lesson_dragdrop_count
integer x = 2642
integer y = 1820
integer taborder = 90
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "Add Dest."
end type

event clicked;call super::clicked;long ll_row
if dw_destination.RowCount() = 2 then
	return
end if
il_current_destination_row = dw_destination.InsertRow(0)

end event

type dw_destination from u_datawindow within w_make_lesson_dragdrop_count
integer x = 2523
integer y = 1272
integer width = 1065
integer height = 516
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_math_count_destination"
boolean hscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then
	return
end if
this.SelectRow(0, false)
this.SelectRow(row,true)
il_current_destination_row = row
il_current_destination_id = GetItemNumber(il_current_destination_row, "container_id")

end event

event itemchanged;call super::itemchanged;if wf_is_valid_container(data, dw_source) and wf_is_valid_container(data, dw_destination) then
	return 0
else
	MessageBox("Error", "The container, " + data + ", is already selected, selected others.")
	return 1
end if	

end event

type dw_source from u_datawindow within w_make_lesson_dragdrop_count
integer x = 2523
integer y = 776
integer width = 1065
integer height = 304
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_math_count_source"
end type

event clicked;call super::clicked;if row < 1 then
	return
end if
this.SelectRow(0, false)
this.SelectRow(row,true)
il_current_source_row = row
il_current_source_id = GetItemNumber(il_current_source_row, "container_id")

end event

event itemchanged;call super::itemchanged;if wf_is_valid_container(data, dw_source) and wf_is_valid_container(data, dw_destination) then
	return 0
else
	MessageBox("Error", "The container, " + data + ", is already selected, selected others.")
	return 1
end if	

end event

type cb_add_source from u_commandbutton within w_make_lesson_dragdrop_count
integer x = 2642
integer y = 1112
integer taborder = 70
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "Add Source"
end type

event clicked;call super::clicked;long ll_row
if dw_source.RowCount() = 1 then
	return
end if
il_current_source_row = dw_source.InsertRow(0)

end event

