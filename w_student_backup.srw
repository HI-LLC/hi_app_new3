$PBExportHeader$w_student_backup.srw
forward
global type w_student_backup from w_sheet
end type
type cb_close from commandbutton within w_student_backup
end type
type cb_save from commandbutton within w_student_backup
end type
type cb_add from commandbutton within w_student_backup
end type
type dw_student from datawindow within w_student_backup
end type
end forward

global type w_student_backup from w_sheet
integer width = 3419
integer height = 1724
string title = "Student"
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
cb_add cb_add
dw_student dw_student
end type
global w_student_backup w_student_backup

forward prototypes
public function integer wf_upload_bitmap ()
public function integer wf_download_bitmap ()
end prototypes

public function integer wf_upload_bitmap ();integer li_row, li_i, li_update_row[]
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null
string ls_update_col[] = {"photo"}
string ls_key_col[] = {"account_id", "student_id"}
ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
for li_row = 1 to dw_student.RowCount()
	if isnull(dw_student.GetItemString(li_row, "photo_display")) then continue	
	if not FileExists(ls_local_file) then continue
	ls_local_file = dw_student.GetItemString(li_row, "photo_display")
	if dw_student.GetItemStatus(li_row, "photo_display", Primary!) <> DataModified! then continue
	ls_remote_file_prefix = string(dw_student.GetItemNumber(li_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + "student" + string(dw_student.GetItemNumber(li_row, "student_id"), "000000")
	ls_file_extension = right(ls_local_file, 3)
	ls_remote_file = ls_remote_file_path + "/" + ls_remote_file_prefix + "." + ls_file_extension
//	MessageBox(ls_local_file, ls_remote_file)
	extPutBinaryFile(ls_local_file, ls_remote_file)
//	dw_student.SetItem(li_row, "photo", right(ls_local_file, 3))
	dw_student.SetItemStatus(li_row, "photo_display", Primary!, NotModified!)
//	li_update_row[upperbound(li_update_row) + 1] = li_row
next
//if upperbound(li_update_row) > 0 then
//	gn_appman.invo_sqlite.of_update_datawindow (dw_student, "Student", ls_update_col, ls_key_col, li_update_row)	
//end if
return 1
end function

public function integer wf_download_bitmap ();integer li_row, li_i
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null
ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
for li_row = 1 to dw_student.RowCount()
	if isnull(dw_student.GetItemString(li_row, "photo")) then continue // no photo
	if trim(dw_student.GetItemString(li_row, "photo")) = "" then continue // no photo
	ls_remote_file_prefix = string(dw_student.GetItemNumber(li_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + "student" + string(dw_student.GetItemNumber(li_row, "student_id"), "000000")	
	ls_file_extension = trim(dw_student.GetItemString(li_row, "photo"))
	ls_remote_file = ls_remote_file_path + "/" + ls_remote_file_prefix + "." + ls_file_extension
	ls_local_file = ls_remote_file_prefix + "." + ls_file_extension
	extGetBinaryFile(ls_local_file, ls_remote_file)
	dw_student.SetItem(li_row, "photo_display", ls_local_file)
	dw_student.SetItemStatus(li_row, "photo_display", Primary!, NotModified!)
	is_garbage_file_list[upperbound(is_garbage_file_list) + 1] = ls_local_file
next
return 1
end function

on w_student_backup.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add=create cb_add
this.dw_student=create dw_student
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.dw_student
end on

on w_student_backup.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.dw_student)
end on

event open;call super::open;string ls_select_col[]
string ls_where_col[] = {"account_id"}
any la_where_value[]

la_where_value[1] = gn_appman.il_account_id
gn_appman.invo_sqlite.of_retrieve_to_datawindow (dw_student, "Student", ls_select_col, ls_where_col, la_where_value)
wf_download_bitmap()
end event

type cb_close from commandbutton within w_student_backup
integer x = 2939
integer y = 1448
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_student_backup
integer x = 2455
integer y = 1448
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;integer li_count
string ls_update_col[] = {"first_name", "last_name", "mid_name", "note"}
string ls_key_col[] = {"account_id", "student_id"}
dw_student.AcceptText()
wf_upload_bitmap()
//if gn_appman.invo_sqlite.of_update_datawindow (dw_student, "Student", ls_update_col, ls_key_col) = 1 then
//	wf_upload_bitmap()
//end if

end event

type cb_add from commandbutton within w_student_backup
integer x = 1975
integer y = 1456
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;long ll_row, ll_student_id, ll_row_count
ll_row_count = dw_student.RowCount()
//MessageBox("add", ll_row_count)
if ll_row_count = 0 then
	ll_student_id = 1
else
	ll_student_id = dw_student.GetItemNumber(ll_row_count, "student_id") + 1
end if
ll_row = dw_student.InsertRow(0)
dw_student.SetItem(ll_row, "account_id", gn_appman.il_account_id)
dw_student.SetItem(ll_row, "student_id", ll_student_id)



end event

type dw_student from datawindow within w_student_backup
integer x = 37
integer y = 36
integer width = 3305
integer height = 1392
integer taborder = 10
string title = "none"
string dataobject = "d_student"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer li_value
string ls_Docname, ls_named
Pointer lp_oldpointer
lp_oldpointer = SetPointer ( HourGlass! )

li_value = GetFileOpenName("Photo or Logo For The Student", ls_Docname, ls_named, &
"BMP", "Bitmap, *.BMP, JPeg, *.JPG, GIF, *.GIF, Window Meta File, *.WMF")

if li_value = 1 then
	dw_student.SetItem(row, "photo_display", ls_Docname)
	dw_student.SetItem(row, "photo", right(ls_Docname, 3))
end if



end event

