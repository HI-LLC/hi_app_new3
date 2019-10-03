$PBExportHeader$w_create_account.srw
forward
global type w_create_account from w_sheet
end type
type cb_close from commandbutton within w_create_account
end type
type cb_submit from commandbutton within w_create_account
end type
type dw_create_account from datawindow within w_create_account
end type
end forward

global type w_create_account from w_sheet
integer width = 2949
integer height = 1988
string title = "Create Account"
cb_close cb_close
cb_submit cb_submit
dw_create_account dw_create_account
end type
global w_create_account w_create_account

forward prototypes
public function boolean wf_validate_account_name (string as_account_name)
end prototypes

public function boolean wf_validate_account_name (string as_account_name);boolean lb_account_name_found
string ls_expression, ls_col_name[], ls_result_set[]
long ll_i, ll_j, ll_k, ll_len, FileCount, ll_row
long ll_tv_handle, ll_tv_handle_root
string ls_Host, ls_Key, ls_Name, ls_Password, ls_ReturnStatus, ls_sql, ls_col_name[], ls_result_set[]
gstr_tv_item lstr_tv_item
treeviewitem ltvi_new 
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(200)
gn_appman.il_login_id = 0
gn_appman.il_transaction_code = 88888888
ls_sql = "select count(*) as a_count from Account where Name eq '" + trim(as_account_name) + "'"
FileCount = LHOA_SQL_retrieve(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus)
if FileCount > 0 then
	for ll_i = 1 to FileCount
		ls_col_name[ll_i] = space(100)
		ls_result_set[ll_i] = space(200)
	next
	LHOA_SQL_load(ls_col_name, ls_result_set)
	If integer(ls_result_set[1]) > 0 then		
		return false
	else
		return true
	end if
else
	MessageBox("System Error", ls_ReturnStatus)
	return false
end if
end function

on w_create_account.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_submit=create cb_submit
this.dw_create_account=create dw_create_account
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_submit
this.Control[iCurrent+3]=this.dw_create_account
end on

on w_create_account.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_submit)
destroy(this.dw_create_account)
end on

event open;call super::open;dw_create_account.InsertRow(0)
end event

type cb_close from commandbutton within w_create_account
integer x = 2505
integer y = 1772
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_submit from commandbutton within w_create_account
integer x = 2107
integer y = 1772
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Submit"
boolean default = true
end type

event clicked;string ls_Host, ls_Key, ls_Name, ls_Password, ls_LastName,ls_FirstName, ls_fwName, ls_fwPassword,ls_Email
string ls_PasswordHint, ls_Address, ls_City, ls_State, ls_Country, ls_Zipcode
string ls_Phone, ls_password2, ls_ReturnStatus
string ls_parm_name_list[] = {"Account Name","Password","Last Name","First Name","Email Address","Password Hint"}
string ls_parms[]
integer li_i

ls_parms = {ls_Name, ls_Password, ls_LastName,ls_FirstName,ls_Email,&
				ls_PasswordHint, ls_Address, ls_City, ls_State, ls_Country, ls_Zipcode,ls_phone}
dw_create_account.AcceptText()
dw_create_account.SetFocus()
for li_i = 1 to 12
	ls_parms[li_i] = dw_create_account.object.data[1, li_i]
	if li_i <= 6 then
		if isnull(ls_parms[li_i]) then
			MessageBox("Reminder", "Please Enter " + ls_parm_name_list[li_i] + "!")
			dw_create_account.SetColumn(li_i)
			return
		end if
	end if
	if isnull(ls_parms[li_i]) then
		ls_parms[li_i] = ""
	end if
next
ls_Password = ls_parms[2] 
ls_password2 = dw_create_account.GetItemString(1,"Password2")
if isnull(ls_password2) then
	ls_password2 = ""
end if
if ls_Password <> ls_password2 then
	MessageBox("Verification", "Please Re-Enter The Password!")
//	MessageBox(ls_Password, ls_password2)
	dw_create_account.SetColumn("Password2")
	return	
end if
ls_fwName = dw_create_account.object.data[1, 14]
ls_fwPassword = dw_create_account.object.data[1, 15]
//ls_Host = "fithwor.pair.com"
ls_ReturnStatus = space(200)
ls_Key = "luxiluyiluke"
dw_create_account.SetItem(1, "fw_ind", 1)
ls_fwName = "empt79"
ls_fwPassword = "zha0520"
if dw_create_account.GetItemNumber(1, "fw_ind") = 1 then
	if isnull(ls_fwName) then
		MessageBox("Reminder", "Please Enter Firewall/Proxy Account Name!")
		dw_create_account.SetColumn("fw_name")
		return
	end if		
	if isnull(ls_fwPassword) then
		MessageBox("Reminder", "Please Enter Firewall/Proxy Account Password!")
		dw_create_account.SetColumn("fw_password")
		return
	end if		
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
if not wf_validate_account_name(ls_parms[1]) then
	MessageBox("Validation", "The Account Name Is Already Used, Please Use Other Name!")
	dw_create_account.SetColumn("Name")
	return
end if
MessageBox("test", "after validation")
//return
CreateLHOA(gn_appman.is_host_name, ls_Key, ls_parms[1],ls_parms[2],ls_parms[3],ls_parms[4],ls_parms[5],ls_parms[6], &
	ls_parms[7],ls_parms[8],ls_parms[9],ls_parms[10],ls_parms[11],ls_parms[12],ls_ReturnStatus)
//MessageBox("ls_ReturnStatus", ls_ReturnStatus)
end event

type dw_create_account from datawindow within w_create_account
integer x = 32
integer y = 24
integer width = 2843
integer height = 1728
integer taborder = 10
string title = "none"
string dataobject = "d_create_account"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

