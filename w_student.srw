$PBExportHeader$w_student.srw
forward
global type w_student from w_generic_update
end type
end forward

global type w_student from w_generic_update
integer width = 3538
integer height = 1748
string title = "Student Setup"
end type
global w_student w_student

forward prototypes
public function integer wf_download_bitmap ()
public function integer wf_upload_bitmap ()
end prototypes

public function integer wf_download_bitmap ();integer li_row, li_i
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null
ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
for li_row = 1 to dw_1.RowCount()
	if isnull(dw_1.GetItemString(li_row, "photo")) then continue // no photo
	if trim(dw_1.GetItemString(li_row, "photo")) = "" then continue // no photo
	ls_remote_file_prefix = string(dw_1.GetItemNumber(li_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + "student" + string(dw_1.GetItemNumber(li_row, "student_id"), "000000")	
	ls_file_extension = trim(dw_1.GetItemString(li_row, "photo"))
	ls_remote_file = ls_remote_file_path + "/" + ls_remote_file_prefix + "." + ls_file_extension
	ls_local_file = ls_remote_file_prefix + "." + ls_file_extension
	extGetBinaryFile(ls_local_file, ls_remote_file)
	dw_1.SetItem(li_row, "photo_display", ls_local_file)
	dw_1.SetItemStatus(li_row, "photo_display", Primary!, NotModified!)
	is_garbage_file_list[upperbound(is_garbage_file_list) + 1] = ls_local_file
next
return 1
end function

public function integer wf_upload_bitmap ();integer li_row, li_i, li_update_row[]
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null
string ls_update_col[] = {"photo"}
string ls_key_col[] = {"account_id", "student_id"}
ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
for li_row = 1 to dw_1.RowCount()
	if isnull(dw_1.GetItemString(li_row, "photo_display")) then continue	
	ls_local_file = dw_1.GetItemString(li_row, "photo_display")	
	if not FileExists(ls_local_file) then continue
	if dw_1.GetItemStatus(li_row, "photo_display", Primary!) <> DataModified! then continue
	ls_remote_file_prefix = string(dw_1.GetItemNumber(li_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + "student" + string(dw_1.GetItemNumber(li_row, "student_id"), "000000")
	ls_file_extension = right(ls_local_file, 3)
	ls_remote_file = ls_remote_file_path + "/" + ls_remote_file_prefix + "." + dw_1.GetItemString(li_row, "photo")
	extPutBinaryFile(ls_local_file, ls_remote_file)
	dw_1.SetItemStatus(li_row, "photo_display", Primary!, NotModified!)
next
return 1
end function

on w_student.create
call super::create
end on

on w_student.destroy
call super::destroy
end on

event open;call super::open;ib_is_odbc = false
is_update_col = {"first_name", "last_name", "mid_name", "photo", "note"}
is_key_col[] = {"account_id", "student_id"}
is_database_table = "Student"
is_constant_col[1] = "account_id"
ia_constant_val[1] = gn_appman.il_account_id
is_unique_col[1] = "student_id"
is_where_col[1] = "account_id"
ia_where_value[1] = gn_appman.il_account_id
gn_appman.invo_sqlite.of_retrieve_to_datawindow (dw_1, "Student", is_select_col, is_where_col, ia_where_value)
wf_download_bitmap()
end event

type dw_1 from w_generic_update`dw_1 within w_student
integer x = 32
integer y = 28
integer width = 3415
string dataobject = "d_student"
borderstyle borderstyle = stylelowered!
end type

event dw_1::buttonclicked;call super::buttonclicked;integer li_value
string ls_Docname, ls_named
Pointer lp_oldpointer
lp_oldpointer = SetPointer ( HourGlass! )

li_value = GetFileOpenName("Photo or Logo For The Student", ls_Docname, ls_named, &
"BMP", "Bitmap, *.BMP, JPeg, *.JPG, GIF, *.GIF, Window Meta File, *.WMF")

if li_value = 1 then
	dw_1.SetItem(row, "photo_display", ls_Docname)
	dw_1.SetItem(row, "photo", lower(right(ls_Docname, 3)))
	ib_edit_mode = true
	cb_save.enabled = ib_edit_mode
	cb_cancel.enabled = ib_edit_mode
//	parent.event ue_buttons()
end if



end event

type cb_add from w_generic_update`cb_add within w_student
integer x = 1838
integer y = 1472
end type

type cb_delete from w_generic_update`cb_delete within w_student
integer x = 2176
integer y = 1472
end type

type cb_save from w_generic_update`cb_save within w_student
integer x = 2848
integer y = 1472
end type

event cb_save::clicked;dw_1.AcceptText()
wf_upload_bitmap()
super::event clicked()

end event

type cb_close from w_generic_update`cb_close within w_student
integer x = 3186
integer y = 1472
end type

type cb_cancel from w_generic_update`cb_cancel within w_student
integer x = 2510
integer y = 1472
end type

