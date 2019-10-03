$PBExportHeader$w_group_student_lv.srw
forward
global type w_group_student_lv from w_sheet
end type
type lv_1 from listview within w_group_student_lv
end type
type p_1 from picture within w_group_student_lv
end type
type cb_demo from u_commandbutton within w_group_student_lv
end type
type cb_website from u_commandbutton within w_group_student_lv
end type
type cb_close from u_commandbutton within w_group_student_lv
end type
end forward

global type w_group_student_lv from w_sheet
integer width = 3323
integer height = 1912
lv_1 lv_1
p_1 p_1
cb_demo cb_demo
cb_website cb_website
cb_close cb_close
end type
global w_group_student_lv w_group_student_lv

type variables
nvo_datastore ids_group_student

end variables
on w_group_student_lv.create
int iCurrent
call super::create
this.lv_1=create lv_1
this.p_1=create p_1
this.cb_demo=create cb_demo
this.cb_website=create cb_website
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.cb_demo
this.Control[iCurrent+4]=this.cb_website
this.Control[iCurrent+5]=this.cb_close
end on

on w_group_student_lv.destroy
call super::destroy
destroy(this.lv_1)
destroy(this.p_1)
destroy(this.cb_demo)
destroy(this.cb_website)
destroy(this.cb_close)
end on

event open;call super::open;long ll_parent_handle, ll_row, ll_i, ll_p_i
string ls_student, ls_first_name, ls_last_name
integer li_row, li_i
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null
ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
ids_group_student = create nvo_datastore
ids_group_student.dataobject = "d_group_student"

gn_appman.il_student_group_id = 0
ids_group_student.is_database_table = "GroupStudent"
//ids_group_student.is_select_sql = "Select g.account_id as account_id, g.group_id as group_id, g.student_id as student_id, " + &
//											"s.last_name as last_name, s.first_name as first_name, s.photo as photo from GroupStudent As g left " + &
//											"outer join Student As s on g.account_id eq s.account_id and " + &
//											"g.student_id eq s.student_id where g.account_id eq " + string(gn_appman.il_account_id)

if gn_appman.il_student_group_id > 0 then											
ids_group_student.is_select_sql = "Select g.account_id as account_id, g.group_id as group_id, g.student_id as student_id, " + &
											"s.last_name as last_name, s.first_name as first_name, s.photo as photo from GroupStudent As g left " + &
											"outer join Student As s on g.account_id eq s.account_id and " + &
											"g.student_id eq s.student_id where g.account_id eq " + string(gn_appman.il_account_id)
	ids_group_student.is_select_sql = ids_group_student.is_select_sql + &
											" and g.group_id eq " + string(gn_appman.il_student_group_id)
else
	ids_group_student.is_select_sql = ""
ids_group_student.is_select_sql = "Select account_id, student_id, last_name, first_name, " + &
											"photo from Student where account_id eq " + string(gn_appman.il_account_id)
end if

ids_group_student.data_retrieve()
listviewitem ltvi_new 
//ltvi_new.PictureIndex = 1
//ltvi_new.SelectedPictureIndex = 2

for ll_row = 1 to ids_group_student.RowCount()
	ls_last_name = ids_group_student.GetItemString(ll_row, "last_name")
	ls_first_name = ids_group_student.GetItemString(ll_row, "first_name")
	if isnull(ls_last_name) then ls_last_name = ""
	if isnull(ls_first_name) then ls_first_name = ""
	ls_last_name = trim(ls_last_name)
	ls_first_name = trim(ls_first_name)
	if len(ls_last_name) > 0 and len(ls_first_name) > 0 then
		ls_student = ls_last_name + ", " + ls_first_name
	else
		ls_student = ls_last_name + ls_first_name
	end if
	if isnull(ids_group_student.GetItemString(ll_row, "photo")) then continue
	if trim(ids_group_student.GetItemString(ll_row, "photo")) = "" then continue
	ls_remote_file_prefix = string(ids_group_student.GetItemNumber(ll_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + string(ids_group_student.GetItemNumber(ll_row, "student_id"), "000000")	
	ls_file_extension = trim(ids_group_student.GetItemString(ll_row, "photo"))
	ls_remote_file = ls_remote_file_path + "/" + ls_remote_file_prefix + "." + ls_file_extension
	ls_local_file = ls_remote_file_prefix + "." + ls_file_extension
	extGetBinaryFile(ls_local_file, ls_remote_file)
	is_garbage_file_list[upperbound(is_garbage_file_list) + 1] = ls_local_file	
	ll_p_i = lv_1.AddLargePicture(ls_local_file)
	if ll_p_i <> -1 then
		ltvi_new.PictureIndex = ll_p_i
	else
		MessageBox("Add Picture Failed", ls_local_file)
	end if
	ltvi_new.label = ls_student
	lv_1.AddItem(ltvi_new)	
	
next

end event

type lv_1 from listview within w_group_student_lv
integer x = 9
integer y = 16
integer width = 3264
integer height = 1544
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string largepicturename[] = {"","","","","","","","","",""}
integer largepicturewidth = 32
long largepicturemaskcolor = 536870912
string smallpicturename[] = {""}
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type p_1 from picture within w_group_student_lv
integer x = 2418
integer y = 1104
integer width = 795
integer height = 548
boolean bringtotop = true
string picturename = "C:\PB Apps\Learning Helper\Light Ends\LogoAnim.gif"
boolean focusrectangle = false
end type

type cb_demo from u_commandbutton within w_group_student_lv
integer x = 1394
integer y = 1624
integer width = 699
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Lesson Demo"
end type

event clicked;run("Exhibition.exe")
end event

type cb_website from u_commandbutton within w_group_student_lv
integer x = 32
integer y = 1624
integer width = 654
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "&Website"
end type

event clicked;string ls_command
ls_command = '"C:\Program Files\Internet Explorer\IEXPLORE.EXE"' + ' "http://www.learninghelper.com"'
run(ls_command)
end event

type cb_close from u_commandbutton within w_group_student_lv
integer x = 2958
integer y = 1624
integer width = 407
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;close(parent)
end event

