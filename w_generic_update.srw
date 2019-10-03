$PBExportHeader$w_generic_update.srw
forward
global type w_generic_update from w_sheet
end type
type dw_1 from u_datawindow within w_generic_update
end type
type cb_add from u_commandbutton within w_generic_update
end type
type cb_delete from u_commandbutton within w_generic_update
end type
type cb_save from u_commandbutton within w_generic_update
end type
type cb_close from u_commandbutton within w_generic_update
end type
type cb_cancel from u_commandbutton within w_generic_update
end type
end forward

global type w_generic_update from w_sheet
integer width = 2661
integer height = 1868
string title = "Maintenance Tables Update"
event ue_buttons ( )
dw_1 dw_1
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
cb_cancel cb_cancel
end type
global w_generic_update w_generic_update

type variables
integer ii_count
TreeViewItem itvi_mt_table
Boolean ib_edit_mode = false
Boolean ib_sequence_used = false
Boolean ib_is_odbc = true
String is_key_column
String is_sequence_object
string is_update_col[]
string is_key_col[]
string is_database_table
string is_constant_col[]
any	 ia_constant_val[]
string is_unique_col[]
string is_select_col[]
string is_where_col[]
any ia_where_value[]

end variables

forward prototypes
public subroutine wf_set_sequence_use (boolean ab_sequence_use)
public subroutine wf_set_key_column (string as_column)
public subroutine wf_set_sequence_object (string as_sequence_object)
public function boolean wf_get_edit_mode ()
public subroutine wf_set_edit_mode (boolean as_edit_mode)
public function integer wf_confirmation ()
end prototypes

event ue_buttons();//if ib_edit_mode then
//	MessageBox("ue_buttons", " ib_edit_mode is TRUE")
//else
//	MessageBox("ue_buttons", " ib_edit_mode is NOT TRUE")
//end if
cb_save.enabled = ib_edit_mode
cb_cancel.enabled = ib_edit_mode

end event

public subroutine wf_set_sequence_use (boolean ab_sequence_use);ib_sequence_used = ab_sequence_use
end subroutine

public subroutine wf_set_key_column (string as_column);is_key_column = as_column
end subroutine

public subroutine wf_set_sequence_object (string as_sequence_object);is_sequence_object = as_sequence_object
end subroutine

public function boolean wf_get_edit_mode ();return ib_edit_mode
end function

public subroutine wf_set_edit_mode (boolean as_edit_mode);ib_edit_mode = as_edit_mode
end subroutine

public function integer wf_confirmation ();long il_status
if ib_edit_mode then
	il_status = MessageBox("Warning", "Do you want to save the change?", Information!, YesNoCancel!)
	if il_status = 1 then // yes, save the change
		return cb_save.event clicked()
	elseif il_status = 2 then // no, don't save
		return 0
	else
		ib_edit_mode = true
		return 1	// cancel
	end if
else
	return 0
end if


end function

on w_generic_update.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_cancel
end on

on w_generic_update.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_cancel)
end on

event closequery;return 0
end event

event open;call super::open;this.event ue_buttons()
end event

type dw_1 from u_datawindow within w_generic_update
integer x = 919
integer y = 60
integer width = 1637
integer height = 1404
boolean bringtotop = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event editchanged;ib_edit_mode = true
cb_save.enabled = ib_edit_mode
cb_cancel.enabled = ib_edit_mode

//parent.event ue_buttons()
end event

event itemchanged;ib_edit_mode = true
cb_save.enabled = ib_edit_mode
cb_cancel.enabled = ib_edit_mode

//parent.event ue_buttons()
end event

event losefocus;AcceptText()
end event

type cb_add from u_commandbutton within w_generic_update
string tag = "mt_table_cb_add"
integer x = 928
integer y = 1604
integer width = 256
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string text = "&Add"
end type

event clicked;long ll_row, ll_row_count, ll_id, ll_i

ib_edit_mode = true

if ib_is_odbc then
	ll_row = dw_1.InsertRow(0)
else
	ll_row_count = dw_1.RowCount()
	ll_row = dw_1.InsertRow(0)		
	//MessageBox("add", ll_row_count)
	if upperbound(is_unique_col) > 0 then
		if ll_row_count = 0 then
			ll_id = 1
		else
			ll_id = dw_1.GetItemNumber(ll_row_count, is_unique_col[1]) + 1
		end if
		dw_1.SetItem(ll_row, is_unique_col[1], ll_id)
	end if
	for ll_i = 1 to upperbound(is_constant_col)
		dw_1.SetItem(ll_row, is_constant_col[ll_i], ia_constant_val[ll_i])
	next
end if

dw_1.ScrollToRow(ll_row)

parent.event ue_buttons()

end event

type cb_delete from u_commandbutton within w_generic_update
string tag = "mt_table_cb_delete"
integer x = 1266
integer y = 1604
integer width = 256
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
string text = "&Delete"
end type

event clicked;call super::clicked;long ll_row, il_status

ll_row = dw_1.GetRow()
if ll_row > 0 then
	il_status = MessageBox("Warning", "Do you want to delete the selected item", Question!, YesNo!)
	if il_status = 2 then
		return
	end if
end if
dw_1.DeleteRow(ll_row)
if ib_is_odbc then
	if dw_1.Update() = -1 then
		if SQLCA.sqlcode <> 0 then
//			f_log_error(dw_1.dataobject, SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
			MessageBox("Error", "Fail to save!")
			rollback;
			return
		end if
		return
	else
		commit;
	end if	
end if
ib_edit_mode = true
parent.event ue_buttons()



end event

type cb_save from u_commandbutton within w_generic_update
string tag = "mt_table_cb_save"
integer x = 1938
integer y = 1604
integer width = 256
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
string text = "&Save"
end type

event clicked;call super::clicked;dec ld_sequence_no, ld_key_id
long ll_row
dw_1.AcceptText()

string ls_validation
ls_validation = dw_1.of_column_validation()
if len(ls_validation) > 0 then
	MessageBox("Error", ls_validation)
	return 1
end if
if ib_is_odbc then
	if dw_1.Update() = -1 then
		MessageBox("Error", "Save fail!")
		rollback;
		return 1
	else
		commit using SQLCA;
		MessageBox("Message", "Save Successfully!")
		ib_edit_mode = false
		parent.event ue_buttons()
		return 0
	end if
else
	if gn_appman.invo_sqlite.of_update_datawindow (dw_1, is_database_table, is_update_col, is_key_col) = 0 then
		MessageBox("Error", "Save fail!")
		return 1
	end if
	dw_1.ResetUpdate()
	ib_edit_mode = false
	parent.event ue_buttons()
	return 0
end if
end event

type cb_close from u_commandbutton within w_generic_update
string tag = "mt_table_cb_close"
integer x = 2277
integer y = 1604
integer width = 256
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
string text = "&Close"
end type

event clicked;if wf_confirmation() = 0 then
	close(parent)
end if
end event

type cb_cancel from u_commandbutton within w_generic_update
string tag = "mt_table_cb_cancel"
integer x = 1600
integer y = 1604
integer width = 256
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
string text = "C&ancel"
end type

event clicked;long ll_status

if MessageBox("Warning", "You are about to lose all changes made since last save, do you want to proceed?", Question!, YesNo!) = 2 then return
ib_edit_mode = false
if ib_is_odbc then
	dw_1.retrieve()
else
	gn_appman.invo_sqlite.of_retrieve_to_datawindow (dw_1, is_database_table, is_select_col, is_where_col, ia_where_value)	
end if

parent.event ue_buttons()

end event

