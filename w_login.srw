$PBExportHeader$w_login.srw
forward
global type w_login from w_sheet
end type
type cb_ok from commandbutton within w_login
end type
type cb_cancel from commandbutton within w_login
end type
type cb_test from commandbutton within w_login
end type
type dw_create_account from datawindow within w_login
end type
end forward

global type w_login from w_sheet
integer width = 1714
integer height = 1152
string title = "Create Account"
cb_ok cb_ok
cb_cancel cb_cancel
cb_test cb_test
dw_create_account dw_create_account
end type
global w_login w_login

type variables
long il_login_id, il_trans_code
end variables

on w_login.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_test=create cb_test
this.dw_create_account=create dw_create_account
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_test
this.Control[iCurrent+4]=this.dw_create_account
end on

on w_login.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_test)
destroy(this.dw_create_account)
end on

event open;call super::open;string ls_Name, ls_Password, ls_fwName, ls_fwPassword
dw_create_account.InsertRow(0)
ls_Name = "han"
ls_Password = "password"
ls_fwName = "empt79"
ls_fwPassword = "zha0520"

dw_create_account.object.data[1, 1] = ls_Name
dw_create_account.object.data[1, 2] = ls_Password
dw_create_account.object.data[1, 3] = ls_fwName
dw_create_account.object.data[1, 4] = ls_fwPassword

end event

type cb_ok from commandbutton within w_login
integer x = 503
integer y = 900
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
end type

event clicked;string ls_Host, ls_Key, ls_Name, ls_Password, ls_fwName, ls_fwPassword, ls_ReturnStatus
string ls_sql, ls_col_name[], ls_result_set[]
integer li_i
long ll_login_id, ll_trans_code, ll_return
dw_create_account.AcceptText()
ls_Name = dw_create_account.object.data[1, 1]
ls_Password = dw_create_account.object.data[1, 2]
ls_fwName = dw_create_account.object.data[1, 3]
ls_fwPassword = dw_create_account.object.data[1, 4]

dw_create_account.SetItem(1, "fw_ind", 1)
ls_Host = "fithwor.pair.com"
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(200)
SetPointer(HourGlass!)
gn_appman.is_host_name = space(200)
if dw_create_account.GetItemNumber(1, "fw_ind") = 1 then
	SetFileWallInfo(ls_fwName, ls_fwPassword)
	if SetFileWallInfo(ls_fwName, ls_fwPassword) = 0 then
		MessageBox("Error", "Fail To Login To Firewall/Proxy Account (Or Internet Is Not Available)!")
		return
	end if
else
	if NativeInternetLogin() = 0 then
		MessageBox("Error", "Internet Is Not Available Or Firewall/Proxy Login Is Required!")
		return
	end if
end if

gn_appman.is_host_name = space(200)
gn_appman.is_remote_home_path = space(200)
GetHostName(gn_appman.is_host_name)
GetHomePath(gn_appman.is_remote_home_path)
if LHOA_Login(gn_appman.is_host_name, ls_Key, ls_Name, ls_Password, il_login_id, il_trans_code, ls_ReturnStatus) > 0 then
	gn_appman.il_login_id = il_login_id
	gn_appman.il_account_id = il_login_id
	gn_appman.il_transaction_code = il_trans_code
	ls_sql = "Select Student_count, site_path, tv_group_id " + &
			" from account where " + &
			" id eq " + string(gn_appman.il_account_id)	
	ll_return = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
	for li_i = 1 to upperbound(ls_result_set)
		if lower(ls_col_name[li_i]) = "student_count" then
			gn_appman.ii_student_count = integer(ls_result_set[li_i])
		end if
		if lower(ls_col_name[li_i]) = "site_path" then
			gn_appman.is_remote_site_path = ls_result_set[li_i]
		end if
		if lower(ls_col_name[li_i]) = "tv_group_id" then
			gn_appman.il_tv_group_id = long(ls_result_set[li_i])
		end if
	next
	if gn_appman.ii_student_count = 1 then
		gn_appman.il_student_id = 1
	end if
end if

SetPointer(Arrow!)

end event

type cb_cancel from commandbutton within w_login
integer x = 1275
integer y = 896
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_test from commandbutton within w_login
integer x = 873
integer y = 900
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Test"
end type

event clicked;string ls_Host, ls_Key, ls_Name, ls_Password, ls_ReturnStatus, ls_sql, ls_col_name[], ls_result_set[]
integer li_i, li_count
long ll_login_id, ll_trans_code
dw_create_account.AcceptText()
ls_Name = dw_create_account.object.data[1, 1]
ls_Password = dw_create_account.object.data[1, 2]
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(200)
//if LHOA_Login(ls_Host, ls_Key, ls_Name, ls_Password, il_login_id, il_trans_code, ls_ReturnStatus) > 0 then
//	MessageBox("ll_login_id", ll_login_id)
//	MessageBox("ll_trans_code", ll_trans_code)
//end if
ls_sql = "select LessonID from LessonGroup where GroupID eq 2"
//ls_sql = "select"
li_count = LHOA_SQL_retrieve(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus)
MessageBox("li_count", li_count)
//LHOA_SQL_retrieve(string Host, string Key, string SQL, long aID, long Trans_code,  ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_retrieve@24"
if li_count > 0 then
	for li_i = 1 to li_count
		ls_col_name[li_i] = space(100)
		ls_result_set[li_i] = space(100)
	next
	LHOA_SQL_load(ls_col_name, ls_result_set)
	for li_i = 1 to li_count
		MessageBox(ls_col_name[li_i], ls_result_set[li_i])
	next
else
	MessageBox("ls_ReturnStatus", ls_ReturnStatus)
end if
end event

type dw_create_account from datawindow within w_login
integer x = 32
integer y = 24
integer width = 1390
integer height = 820
integer taborder = 10
string title = "none"
string dataobject = "d_login"
boolean minbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

