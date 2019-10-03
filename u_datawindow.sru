$PBExportHeader$u_datawindow.sru
forward
global type u_datawindow from datawindow
end type
type str_validation from structure within u_datawindow
end type
end forward

type str_validation from structure
	string		data_column
	integer		validation_type
	integer		required
	string		display_column
end type

global type u_datawindow from datawindow
integer width = 1120
integer height = 736
integer taborder = 10
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_dropdown pbm_dwndropdown
event ue_cal_clicked ( string as_old_date )
event type string ue_get_date ( )
event ue_key pbm_dwnkey
event ue_paint pbm_paint
end type
global u_datawindow u_datawindow

type variables


integer ii_count
Boolean ib_edit_mode = false
Boolean ib_sequence_used = false
Boolean ib_is_odbc = true
string is_select_sql = ""
string is_update_col[]
string is_key_col[]
string is_database_table
string is_constant_col[]
any	 ia_constant_val[]
string is_unique_col[]
string is_select_col[]
string is_where_col[]
string is_desc_col[]
string is_seperator = ""
any ia_where_value[]


u_pb_calendar_all uo_calendar
string is_dropdown_columns[]
string is_nullable_columns[]
nvo_validation_str invo_val

integer ii_validate_not_null = 1
integer ii_validate_numeric = 1
integer ii_validate_alphabetic = 2
integer ii_validate_alph_num = 3
integer ii_validate_all_uppers = 4
integer ii_validate_all_lowers = 5
integer ii_validate_none = 6


//MATCH FALSE TO TEST NUMBER
string is_not_number = '[!@#$%^&*()|?<>?/\_+,A-Za-z]'
//MATCH FALSE TO TEST A-Z
string is_not_upper_letters = '[-!@#$%^&*()|?<>?/\_+,.,a-z0-9]'
//MATCH FALSE TO TEST a-z
string is_not_lower_letters = '[-!@#$%^&*()|?<>?/\_+,.,A-Z0-9]'
//MATCH FALSE TO TEST A-Za-z
string is_not_alphabet_letters = '[-!@#$%^&*()|?<>?/\_+,.,0-9]'
//MATCH FALSE TO TEST A-Za-z0-9
string is_not_alphabet_number = '[-!@#$%^&*()|?<>?/\_+,.]'

// multiple row selection service
boolean ib_multiple_selection = false
long il_current_row
long il_first_selected_row = 0

end variables

forward prototypes
public subroutine of_set_dropdown_columns (string as_column)
public function boolean of_is_valid_column (string as_column)
public subroutine of_set_validate_column (string as_data_column, string as_display_column, integer ai_required, string as_validation_type)
public subroutine of_set_nullable_columns (string as_column)
public function integer update ()
public function integer update (boolean a)
public function integer update (boolean a, boolean c)
public subroutine of_set_verify_duplication (string as_data_column, string as_display_column)
public function string of_validate_duplication ()
public function long of_get_row (string as_column, string as_value)
public subroutine of_set_selection ()
public subroutine of_get_selectedrows (ref long al_row_list[])
public function string of_column_validation ()
public subroutine of_build_validation_from_tag ()
public function long of_get_row (string as_column, long al_value)
public function long of_get_max_id (string as_column)
public function integer add_row ()
public function integer save ()
public function integer cancel ()
public function integer data_retrieve ()
end prototypes

event ue_dropdown;DateTime ldt_tmp_date
Date ld_tmp_date
long ll_row
string ls_column
string ls_tmp_date
ls_column = this.getcolumnname()
if of_is_valid_column(ls_column) then
	ll_row = this.getrow()
	ldt_tmp_date = this.GetItemDateTime(ll_row, ls_column)
	ld_tmp_date = date(ldt_tmp_date)
	ls_tmp_date = string(ld_tmp_date)
	this.event ue_cal_clicked(ls_tmp_date)
	ls_tmp_date = this.event ue_get_date()
	//if ls_tmp_date <> "00/00/0000" then
		ld_tmp_date = date(ls_tmp_date)
		this.SetItem(ll_row, ls_column, ld_tmp_date)
	//end if
	return -1
end if
end event

event ue_cal_clicked;uo_calendar.em_date.text = as_old_date
uo_calendar.pb_dropdown_button.event getfocus()
end event

event ue_get_date;return uo_calendar.em_date.text
end event

event ue_key;string ls_column
long ll_i
decimal ld_null
string ls_null, ls_coltype
datetime ldt_null
setnull(ld_null)
setnull(ls_null)
setnull(ldt_null)

ls_column = GetColumnName()
if key = KeyDelete! then
	for ll_i = 1 to upperbound(is_nullable_columns)
		if ls_column = is_nullable_columns[ll_i] then
			ls_coltype = Describe(ls_column + ".ColType")
				if ls_coltype = "datetime" then
					SetItem(GetRow(), ls_column, ldt_null)
					return
				elseif pos(ls_coltype, "char") > 0 then
					SetItem(GetRow(), ls_column, ls_null)
					return
				else
					SetItem(GetRow(), ls_column, ld_null)
					return
				end if
		end if		
	next
end if

//ls_column = GetColumnName()
//if key = KeyDelete! then
//		ls_description = ls_column + ".dddw.AllowEdit"
//		ls_return1 = describe(ls_description)
//		ls_description = ls_column + ".ddlb.AllowEdit"
//		ls_return2 = describe(ls_description)
//		if (ls_return1 = 'no' and describe(ls_column + ".dddw.Required")='no') or &
//			(ls_return2 = 'no' and describe(ls_column + ".ddlb.Required")='no') then
//			ls_coltype = Describe(ls_column + ".ColType")
//				if ls_coltype = "datetime" then
//					SetItem(GetRow(), ls_column, ldt_null)
//					return
//				elseif pos(ls_coltype, "char") > 0 then
//					SetItem(GetRow(), ls_column, ls_null)
//					return
//				else
//					SetItem(GetRow(), ls_column, ld_null)
//					return
//				end if
//		end if		
//end if

end event

event ue_paint;long ll_handle
//if gb_appwatch then
//	ll_handle= handle(this)
//	ScreenShot(ll_handle, "c:\AppWatch.bmp")
//end if
end event

public subroutine of_set_dropdown_columns (string as_column);long ll_column_no
ll_column_no = upperbound(is_dropdown_columns) + 1
is_dropdown_columns[ll_column_no] = lower(as_column)

end subroutine

public function boolean of_is_valid_column (string as_column);long ll_column_no, ll_column_count
ll_column_count = upperbound(is_dropdown_columns)

if ll_column_count < 1 then
	return false
end if

for ll_column_no = 1 to ll_column_count 
	if is_dropdown_columns[ll_column_no] = as_column then
		return true
	end if
next

return false
end function

public subroutine of_set_validate_column (string as_data_column, string as_display_column, integer ai_required, string as_validation_type);
integer ll_i, ll_validation_type
ll_i = upperbound(invo_val.istr_validation)
ll_i++
invo_val.istr_validation[ll_i].data_column = as_data_column
invo_val.istr_validation[ll_i].display_column = as_display_column
invo_val.istr_validation[ll_i].required = ai_required

CHOOSE CASE as_validation_type
	CASE "Numeric"
		ll_validation_type = ii_validate_numeric
	CASE "Alphabetic"
		ll_validation_type = ii_validate_alphabetic
	CASE "Alpha_numeric"
		ll_validation_type = ii_validate_alph_num
	CASE "All_uppers"
		ll_validation_type = ii_validate_all_uppers
	CASE "All_lowers"
		ll_validation_type = ii_validate_all_lowers
	CASE ELSE
		ll_validation_type = 0
END CHOOSE
invo_val.istr_validation[ll_i].validation_type = ll_validation_type
end subroutine

public subroutine of_set_nullable_columns (string as_column);long ll_column_no
ll_column_no = upperbound(is_nullable_columns[]) + 1
is_nullable_columns[][ll_column_no] = lower(as_column)

end subroutine

public function integer update ();string ls_validation

if accepttext()<0 then return -1
if ModifiedCount()>0 then 
	ls_validation = of_column_validation()
	if len(ls_validation) > 0 then
		MessageBox(gn_appman.of_get_parentwindow(this).title, ls_validation)
		return -1
	end if	
	ls_validation = of_validate_duplication()
	if len(ls_validation) > 0 then
		MessageBox(gn_appman.of_get_parentwindow(this).title, ls_validation)
		return -1
	end if	
end if

return super::update()

end function

public function integer update (boolean a);string ls_validation

if a then 
	if accepttext()<0 then return -1
end if

if ModifiedCount()>0 then 
	ls_validation = of_column_validation()
	if len(ls_validation) > 0 then
		MessageBox(gn_appman.of_get_parentwindow(this).title, ls_validation)
		return -1
	end if	
	ls_validation = of_validate_duplication()
	if len(ls_validation) > 0 then
		MessageBox(gn_appman.of_get_parentwindow(this).title, ls_validation)
		return -1
	end if	
end if

return super::update(a)

end function

public function integer update (boolean a, boolean c);string ls_validation

if a then 
	if accepttext()<0 then return -1
end if

if ModifiedCount()>0 then 
	ls_validation = of_column_validation()
	if len(ls_validation) > 0 then
		MessageBox(gn_appman.of_get_parentwindow(this).title, ls_validation)
		return -1
	end if	
	ls_validation = of_validate_duplication()
	if len(ls_validation) > 0 then
		MessageBox(gn_appman.of_get_parentwindow(this).title, ls_validation)
		return -1
	end if	
end if

return super::update(a, c)

end function

public subroutine of_set_verify_duplication (string as_data_column, string as_display_column);integer ll_i, ll_validation_type
ll_i = upperbound(invo_val.istr_duplicate)
ll_i++
invo_val.istr_duplicate[ll_i].data_column = as_data_column
invo_val.istr_duplicate[ll_i].display_column = as_display_column

end subroutine

public function string of_validate_duplication ();long ll_row, ll_col, ll_row_found, ll_rowcount
string ls_data, ls_coltype, ls_description, ls_find
if upperbound(invo_val.istr_duplicate) = 0 then
	return ""
end if

this.AcceptText()
ll_rowcount = this.RowCount()
for ll_row = 1 to ll_rowcount
	for ll_col = 1 to upperbound(invo_val.istr_duplicate)	
		ls_coltype = this.Describe(invo_val.istr_duplicate[ll_col].data_column + ".ColType")
		if ls_coltype = "datetime" then
			ls_data = string(this.GetItemDateTime(ll_row, invo_val.istr_duplicate[ll_col].data_column))
			ls_find = invo_val.istr_duplicate[ll_col].data_column + ' = "' + ls_data + '"'
		elseif pos(ls_coltype, "char") > 0 then
			ls_data = this.GetItemString(ll_row, invo_val.istr_duplicate[ll_col].data_column)
			ls_find = invo_val.istr_duplicate[ll_col].data_column + ' = "' + ls_data + '"'
		else
			ls_data = string(this.GetItemNumber(ll_row, invo_val.istr_duplicate[ll_col].data_column))
			ls_find = invo_val.istr_duplicate[ll_col].data_column + " = " + ls_data 			
		end if
		ll_row_found = Find(ls_find, 1, ll_rowcount) 
		if ll_row_found <> ll_row then // duplicate row
			ScrollToRow(ll_row)
			SelectRow(0, false)
			SelectRow(1, true)
			SetColumn(invo_val.istr_duplicate[ll_col].data_column)
			return "Data duplicate in field " + invo_val.istr_duplicate[ll_col].display_column
		else
			ll_row_found = Find(ls_find, ll_row_found + 1, ll_rowcount) 
			if ll_row_found > 0 then
				ScrollToRow(ll_row)
				SelectRow(0, false)
				SelectRow(1, true)
				SetColumn(invo_val.istr_duplicate[ll_col].data_column)
				return "Data duplicate in field " + invo_val.istr_duplicate[ll_col].display_column
			end if
		end if		
	next	
next

return ""

end function

public function long of_get_row (string as_column, string as_value);long ll_row
string ls_expression
if RowCount() < 1 then
	return 0
end if
ls_expression = as_column + " = " + "'" + as_value + "'"
ll_row = Find(ls_expression, 1, RowCount())
return ll_row
end function

public subroutine of_set_selection ();long ll_row
if keydown(keyshift!) then
	if keydown(keycontrol!) then // clicked with SHIFT and CONTROL 
		if il_current_row > il_first_selected_row then
			for ll_row = il_first_selected_row  to il_current_row
				SelectRow(ll_row, true)
			next
		else
			for ll_row = il_current_row  to il_first_selected_row
				SelectRow(ll_row, true)
			next				
		end if
	else // clicked with SHIFT ONLY
		SelectRow(0, false)
		if il_current_row > il_first_selected_row then
			for ll_row = il_first_selected_row  to il_current_row
				SelectRow(ll_row, true)
			next
		else
			for ll_row = il_current_row  to il_first_selected_row
				SelectRow(ll_row, true)
			next				
		end if
	end if
elseif keydown(keycontrol!) then // clicked with keycontrol 
	if GetSelectedRow(il_current_row - 1) <> il_current_row then
		SelectRow(il_current_row, true)
	else
		SelectRow(il_current_row, false)
	end if
else // click only
	SelectRow(0, false)
	SelectRow(il_current_row, true)
end if
end subroutine

public subroutine of_get_selectedrows (ref long al_row_list[]);long ll_row, ll_selected_row, ll_rowcount, ll_i = 1
ll_rowcount = RowCount()
ll_selected_row = 1
do 
	ll_selected_row = GetSelectedRow(ll_selected_row - 1)
	if ll_selected_row > 0 and ll_selected_row <= ll_rowcount then
		al_row_list[ll_i] = ll_selected_row
		ll_i = ll_i + 1
		ll_selected_row = ll_selected_row + 1
	end if
loop while ll_selected_row > 0

end subroutine

public function string of_column_validation ();long ll_row, ll_col
string ls_data, ls_coltype, ls_description, ls_null
datetime ldt_null
decimal ldec_null
setnull(ls_null)
setnull(ldt_null)
setnull(ldec_null)

if upperbound(invo_val.istr_validation) = 0 then
	return ""
end if

this.AcceptText()

for ll_row = 1 to this.RowCount()
	for ll_col = 1 to upperbound(invo_val.istr_validation)	
		ls_coltype = this.Describe(invo_val.istr_validation[ll_col].data_column + ".ColType")
		if ls_coltype = "datetime" then
			ls_data = string(this.GetItemDateTime(ll_row, invo_val.istr_validation[ll_col].data_column))
		elseif pos(ls_coltype, "char") > 0 then
			ls_data = this.GetItemString(ll_row, invo_val.istr_validation[ll_col].data_column)
		else
			ls_data = string(this.GetItemNumber(ll_row, invo_val.istr_validation[ll_col].data_column))
		end if
		if invo_val.istr_validation[ll_col].required = 1 and &
		   invo_val.istr_validation[ll_col].validation_type <> ii_validate_none then
			if isnull(ls_data) or len(trim(ls_data)) = 0 then
				SetColumn(invo_val.istr_validation[ll_col].data_column)
				return invo_val.istr_validation[ll_col].display_column + " " + "is a required field and must be filled."
			end if
		end if		

		CHOOSE CASE invo_val.istr_validation[ll_col].validation_type
		CASE ii_validate_alphabetic
			if (not isnull(ls_data)) and (len(trim(ls_data)) > 0) and match(ls_data, is_not_alphabet_letters) then
				SetColumn(invo_val.istr_validation[ll_col].data_column)
				return "No other symbols except letters allowed in column" + " " + &
						invo_val.istr_validation[ll_col].display_column + "."
			end if
		CASE ii_validate_numeric
			if (not isnull(ls_data)) and (len(trim(ls_data)) > 0) and match(ls_data, is_not_number) then
				SetColumn(invo_val.istr_validation[ll_col].data_column)
				return "No other symbols except numbers allowed in column" + " " + &
						invo_val.istr_validation[ll_col].display_column + "."
			end if			
		CASE ii_validate_alph_num
			if (not isnull(ls_data)) and (len(trim(ls_data)) > 0) and match(ls_data, is_not_alphabet_number) then
				SetColumn(invo_val.istr_validation[ll_col].data_column)
				return "No other symbols except numbers and letters allowed in column" + " " + &
						invo_val.istr_validation[ll_col].display_column + "."
			end if		
		CASE ii_validate_all_uppers
			if (not isnull(ls_data)) and (len(trim(ls_data)) > 0) and match(ls_data, is_not_upper_letters) then
				SetColumn(invo_val.istr_validation[ll_col].data_column)
				return "No other symbols except upper letters allowed in column" + " " + &
						invo_val.istr_validation[ll_col].display_column + "."
			end if	
		CASE ii_validate_all_lowers
			if (not isnull(ls_data)) and (len(trim(ls_data)) > 0) and match(ls_data, is_not_lower_letters) then
				SetColumn(invo_val.istr_validation[ll_col].data_column)
				return "No other symbols except lower letters allowed in column" + " " + &
						invo_val.istr_validation[ll_col].display_column + "."
			end if	
		END CHOOSE
		if (not isnull(ls_data)) and (len(trim(ls_data)) = 0) then
			if ls_coltype = "datetime" then
				SetItem(ll_row, invo_val.istr_validation[ll_col].data_column, ldt_null)
			elseif pos(ls_coltype, "char") > 0 then
				SetItem(ll_row, invo_val.istr_validation[ll_col].data_column, ls_null)
			else
				SetItem(ll_row, invo_val.istr_validation[ll_col].data_column, ldec_null)
			end if			
		end if	
		
	next	
next

return ""
end function

public subroutine of_build_validation_from_tag ();destroy invo_val
invo_val = create nvo_validation_str

string ls_name, ls_des_input, ls_des_result
string ls_tmp, ls_required, ls_display_column, ls_validation_type
long ll_column_count, ll_col, ll_pos, ll_required
ll_column_count = long(this.Object.DataWindow.Column.Count)

//setting = dw_1.Describe("#4.Name")
for ll_col = 1 to ll_column_count
	ls_des_input = "#" + string(ll_col) + ".Name"
	ls_name = describe(ls_des_input)
	ls_des_input = ls_name + ".tag"
	ls_des_result = this.describe(ls_des_input)
	if (not isnull(ls_des_result)) and pos(ls_des_result, "validate") > 0 then
		ls_tmp = right(ls_des_result, len(ls_des_result) - 9)
		ll_pos = pos(ls_tmp, '#')
		ls_display_column = left(ls_tmp, ll_pos - 1)
		ls_tmp = right(ls_tmp, len(ls_tmp) - ll_pos)
		ll_pos = pos(ls_tmp, '#')
		ls_required = left(ls_tmp, ll_pos - 1)
		ll_required = long(ls_required)
		ls_tmp = right(ls_tmp, len(ls_tmp) - ll_pos)
		ls_validation_type = ls_tmp
		of_set_validate_column(ls_name, ls_display_column, ll_required, ls_validation_type)
	end if
next
end subroutine

public function long of_get_row (string as_column, long al_value);long ll_row
string ls_expression
if RowCount() < 1 then
	return 0
end if
ls_expression = as_column + " = " + string(al_value)
ll_row = Find(ls_expression, 1, RowCount())
return ll_row
end function

public function long of_get_max_id (string as_column);long ll_row, ll_max_id = 0
string ls_expression
if RowCount() < 1 then
	return 0
end if
for ll_row = 1 to RowCount()
	if GetItemNumber(ll_row, as_column) > ll_max_id then
		ll_max_id = GetItemNumber(ll_row, as_column)
	end if
next
return ll_max_id

end function

public function integer add_row ();long ll_row, ll_row_count, ll_id, ll_i
ll_row_count = RowCount()
ll_row = InsertRow(0)		
//MessageBox("add", ll_row_count)
if upperbound(is_unique_col) > 0 then
	if ll_row_count = 0 then
		ll_id = 1
	else
		ll_id = GetItemNumber(ll_row_count, is_unique_col[1]) + 1
	end if
	SetItem(ll_row, is_unique_col[1], ll_id)
end if
for ll_i = 1 to upperbound(is_constant_col)
	SetItem(ll_row, is_constant_col[ll_i], ia_constant_val[ll_i])
next
return 1
end function

public function integer save ();dec ld_sequence_no, ld_key_id
datawindow ldw_this
ldw_this = this
if gn_appman.invo_sqlite.of_update_datawindow (ldw_this, is_database_table, is_update_col, is_key_col) = 0 then
	MessageBox("Error", "Save fail!")
	return 0
end if
ResetUpdate()
return 1
end function

public function integer cancel ();datawindow ldw_this
ldw_this = this
gn_appman.invo_sqlite.of_retrieve_to_datawindow (ldw_this, is_database_table, is_select_col, is_where_col, ia_where_value)	
return 1
end function

public function integer data_retrieve ();datawindow ldw_this
ldw_this = this
if is_select_sql <> "" then
	gn_appman.invo_sqlite.of_retrieve_to_datawindow (ldw_this, is_select_sql)	
else
	gn_appman.invo_sqlite.of_retrieve_to_datawindow (ldw_this, is_database_table, is_select_col, is_where_col, ia_where_value)	
end if
return 1
end function

on u_datawindow.create
end on

on u_datawindow.destroy
end on

event constructor;uo_calendar = create u_pb_calendar_all
invo_val = create nvo_validation_str
end event

event destructor;destroy uo_calendar
destroy invo_val
end event

event dberror;CHOOSE CASE sqldbcode
	CASE 2601 	// 2601 - Duplicate key 
		MessageBox(This.Title, "Duplicate key", StopSign!)
	CASE 2292 // Integrity violation
		Messagebox(This.Title, "Cannot delete this item. Related information exists in another table.", StopSign!)
	CASE ELSE
		Messagebox(This.Title, string(sqldbcode) + "~n~r" + sqlerrtext) 
END CHOOSE

return 1
end event

event rbuttondown;//string ls_column, ls_return
//long ll_i
//decimal ld_null
//string ls_null, ls_coltype
//datetime ldt_null
//setnull(ld_null)
//setnull(ls_null)
//setnull(ldt_null)
//
//if string(dwo.type) = 'column' then
//	for ll_i = 1 to upperbound(is_nullable_columns)
//		if dwo.name = is_nullable_columns[ll_i] then
//			ls_coltype = Describe(dwo.name + ".ColType")
//			open(w_setnull)
//			ls_return = Message.StringParm
//			if ls_return = "Cancel" then
//				return
//			else
//				if ls_coltype = "datetime" then
//					SetItem(GetRow(), string(dwo.name), ldt_null)
//					return
//				elseif pos(ls_coltype, "char") > 0 then
//					SetItem(GetRow(), string(dwo.name), ls_null)
//					return
//				else
//					SetItem(GetRow(), string(dwo.name), ld_null)
//					return
//				end if
//			end if
//		end if		
//	next
//end if
//
end event

event doubleclicked;DateTime ldt_tmp_date
Date ld_tmp_date
string ls_column, ls_tmp_date, ls_type
long ll_col

ll_col=getclickedcolumn()
if ll_col>0 then
	ls_column = describe('#'+string(ll_col)+'.name')
	ls_type=describe(ls_column+'.type')
	if ls_type='column' then 
		if (dwo.ColType='date' or dwo.ColType='datetime') and &
			dwo.TabSequence>'0' and dwo.Protect='0' and row>0 then				
			ldt_tmp_date = this.GetItemDateTime(row, ls_column)
			ld_tmp_date = date(ldt_tmp_date)
			ls_tmp_date = string(ld_tmp_date)
			this.event ue_cal_clicked(ls_tmp_date)
			ls_tmp_date = this.event ue_get_date()
			ld_tmp_date = date(ls_tmp_date)
			this.SetItem(row, ls_column, ld_tmp_date)
		end if
	end if
end if
end event

event clicked;if row < 1 then return
if ib_multiple_selection then
	il_current_row = row
	if (il_first_selected_row = 0) or not keydown(keyshift!) then
		il_first_selected_row = row
	end if
	of_set_selection()
end if
end event

event losefocus;AcceptText()

end event

