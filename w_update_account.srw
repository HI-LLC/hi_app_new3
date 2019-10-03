$PBExportHeader$w_update_account.srw
forward
global type w_update_account from w_sheet
end type
type cb_close from commandbutton within w_update_account
end type
type cb_submit from commandbutton within w_update_account
end type
type dw_update_account from u_datawindow within w_update_account
end type
end forward

global type w_update_account from w_sheet
integer width = 2949
integer height = 1988
string title = "Update Account"
cb_close cb_close
cb_submit cb_submit
dw_update_account dw_update_account
end type
global w_update_account w_update_account

forward prototypes
public function boolean wf_validate_account_name (string as_account_name)
end prototypes

public function boolean wf_validate_account_name (string as_account_name);boolean lb_account_name_found
string ls_expression, ls_col_name[], ls_result_set[]
long ll_i, ll_j, ll_k, ll_len, FileCount, ll_row
long ll_tv_handle, ll_tv_handle_root
string ls_Host, ls_Key, ls_Name, ls_Password, ls_ReturnStatus, ls_sql
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

on w_update_account.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_submit=create cb_submit
this.dw_update_account=create dw_update_account
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_submit
this.Control[iCurrent+3]=this.dw_update_account
end on

on w_update_account.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_submit)
destroy(this.dw_update_account)
end on

event open;call super::open;long ll_id
string ls_sql_statement
any la_id
gn_appman.of_get_parm("Account ID", la_id)
ll_id = la_id
dw_update_account.is_database_table = "Account"
dw_update_account.is_update_col = {"password", "lastname", "firstname","email","passwordhint","Address","City", &
			"State","Country","Zipcode","Phone","status","Student_count","Site_path","tv_group_id","Note","AccountType"}
dw_update_account.is_key_col[] = {"id"}
dw_update_account.is_database_table = "Account"
dw_update_account.is_select_sql = "Select * From Account where ID eq " + string(ll_id)
dw_update_account.data_retrieve()
end event

type cb_close from commandbutton within w_update_account
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

type cb_submit from commandbutton within w_update_account
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
string text = "Save"
boolean default = true
end type

event clicked;dw_update_account.save()
end event

type dw_update_account from u_datawindow within w_update_account
integer x = 32
integer y = 24
integer width = 2843
integer height = 1728
string title = "none"
string dataobject = "d_update_account"
end type

