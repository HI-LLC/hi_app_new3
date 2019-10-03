$PBExportHeader$nvo_sqlite.sru
forward
global type nvo_sqlite from nonvisualobject
end type
end forward

global type nvo_sqlite from nonvisualobject
end type
global nvo_sqlite nvo_sqlite

type variables
//
end variables

forward prototypes
public function string of_make_sql_statement (string as_table_name, string as_sql_type, string as_key_column_name[], string as_colum_name[], any aa_key_values[], any aa_values[])
public function integer of_execute_retrieve_sql (string as_sql, ref string as_col_name[], ref string as_result_set[])
public function integer of_load_to_dd (ref any a_dd, ref string as_col_name[], ref string as_result_set[])
public function integer of_load_to_datastore (ref datastore a_ds, ref string as_col_name[], ref string as_result_set[])
public function integer of_load_to_datawindow (ref datawindow a_dw, ref string as_col_name[], ref string as_result_set[])
public function integer of_retrieve_to_datastore (ref datastore a_ds, string as_table_name, string as_select_col[], string as_where_col[], any aa_where_value[])
public function integer of_retrieve_to_datawindow (ref datawindow a_dw, string as_table_name, string as_select_col[], string as_where_col[], any aa_where_value[])
public function integer of_retrieve_to_datastore (ref datastore a_ds, string as_sql)
public function integer of_retrieve_to_datawindow (ref datawindow a_dw, string as_sql)
public function integer of_update_dd (ref any a_dd, string as_table_name, string as_update_col[], string as_key_col[])
public function integer of_update_datastore (ref datastore a_ds, string as_table_name, string as_update_col[], string as_key_col[])
public function integer of_update_datawindow (ref datawindow a_dw, string as_table_name, string as_update_col[], string as_key_col[])
public function integer of_update_dd (ref any a_dd, string as_table_name, string as_update_col[], string as_key_col[], integer ai_update_row[])
public function integer of_update_datastore (ref datastore a_ds, string as_table_name, string as_update_col[], string as_key_col[], integer ai_update_row[])
public function integer of_update_datawindow (ref datawindow a_dw, string as_table_name, string as_update_col[], string as_key_col[], integer ai_update_row[])
end prototypes

public function string of_make_sql_statement (string as_table_name, string as_sql_type, string as_key_column_name[], string as_colum_name[], any aa_key_values[], any aa_values[]);
integer li_i
string ls_sql_statement
choose case as_sql_type
	case "SELECT"
		if upperbound(as_colum_name) = 0 then
			ls_sql_statement = "SELECT * "
		else
			for li_i = 1 to upperbound(as_colum_name)				
				if li_i < upperbound(as_colum_name) then
					ls_sql_statement = ls_sql_statement + " " + as_colum_name[li_i] + ","
				else
					ls_sql_statement = ls_sql_statement + " " + as_colum_name[li_i] + " "
				end if
			next
		end if
		ls_sql_statement = ls_sql_statement + " FROM " + as_table_name + " "
		if upperbound(as_key_column_name) > 0 then
			ls_sql_statement = ls_sql_statement + " WHERE "
			for li_i = 1 to upperbound(as_key_column_name)
				ls_sql_statement = ls_sql_statement + " " + as_key_column_name[li_i] + " eq "
				if isnull(aa_key_values[li_i]) then
					ls_sql_statement = ls_sql_statement + "NULL"
				else
					choose case ClassName(aa_key_values[li_i]) 
						case "string", "char"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_key_values[li_i]) + "'"
						case "number", "double", "decimal", "long"
							ls_sql_statement = ls_sql_statement + string(aa_key_values[li_i]) + ""
						case "date"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd") + "'"
						case "DateTime"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd hh:mm:ss") + "'"
					end choose
				end if
				if li_i < upperbound(as_key_column_name) then 
					ls_sql_statement = ls_sql_statement + " AND "
				else
					ls_sql_statement = ls_sql_statement + " "
				end if
			next
		else
			ls_sql_statement = ls_sql_statement + " "
		end if
	case "INSERT"
		ls_sql_statement = "INSERT INTO " + as_table_name + "(" 
		for li_i = 1 to upperbound(as_colum_name)
			if li_i < upperbound(as_colum_name) then
				ls_sql_statement = ls_sql_statement + as_colum_name[li_i] + ","
			else
				ls_sql_statement = ls_sql_statement + as_colum_name[li_i] + ") values("
			end if
		next
		for li_i = 1 to upperbound(aa_values)
			if isnull(aa_values[li_i]) then
				ls_sql_statement = ls_sql_statement + "NULL"
			else
				choose case ClassName(aa_values[li_i]) 
					case "string", "char"
						ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i]) + "'"
					case "number", "double", "decimal", "long"
						ls_sql_statement = ls_sql_statement + string(aa_values[li_i]) + ""
					case "date"
						ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd") + "'"
					case "datetime"
						ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd hh:mm:ss") + "'"
				end choose
			end if
			if li_i < upperbound(aa_values) then
				ls_sql_statement = ls_sql_statement + ", "
			else
				ls_sql_statement = ls_sql_statement + ")"
			end if
		next
	case "UPDATE"
		ls_sql_statement = "UPDATE " + as_table_name + " SET "
		for li_i = 1 to upperbound(as_colum_name)
			ls_sql_statement = ls_sql_statement + as_colum_name[li_i] + " eq "
			if isnull(aa_values[li_i]) then
				ls_sql_statement = ls_sql_statement + "NULL"
			else
				choose case ClassName(aa_values[li_i]) 
					case "string", "char"
						ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i]) + "'"
					case "number", "double", "decimal", "long"
						ls_sql_statement = ls_sql_statement + string(aa_values[li_i]) + ""
					case "date"
						ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd") + "'"
					case "DateTime"
						ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd hh:mm:ss") + "'"
				end choose
			end if
			if li_i < upperbound(as_colum_name) then
				ls_sql_statement = ls_sql_statement + ", "
			else
				ls_sql_statement = ls_sql_statement + " "
			end if
		next
		if upperbound(as_key_column_name) > 0 then
			ls_sql_statement = ls_sql_statement + " WHERE "
			for li_i = 1 to upperbound(as_key_column_name)
				ls_sql_statement = ls_sql_statement + " " + as_key_column_name[li_i] + " eq "
				if isnull(aa_key_values[li_i]) then
					ls_sql_statement = ls_sql_statement + "NULL"
				else
					choose case ClassName(aa_key_values[li_i]) 
						case "string", "char"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_key_values[li_i]) + "'"
						case "number", "double", "decimal", "long"
							ls_sql_statement = ls_sql_statement + string(aa_key_values[li_i]) + ""
						case "date"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd") + "'"
						case "DateTime"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd hh:mm:ss") + "'"
					end choose
				end if
				if li_i < upperbound(as_key_column_name) then 
					ls_sql_statement = ls_sql_statement + " AND "
				else
					ls_sql_statement = ls_sql_statement + " "
				end if
			next
		else
			ls_sql_statement = ls_sql_statement + " "
		end if
	case "DELETE"
		ls_sql_statement = "DELETE FROM " + as_table_name + " "
		if upperbound(as_key_column_name) > 0 then
			ls_sql_statement = ls_sql_statement + "WHERE "
			for li_i = 1 to upperbound(as_key_column_name)
				ls_sql_statement = ls_sql_statement + " " + as_key_column_name[li_i] + " eq "
				if isnull(aa_key_values[li_i]) then
					ls_sql_statement = ls_sql_statement + "NULL"
				else
					choose case ClassName(aa_key_values[li_i]) 
						case "string", "char"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_key_values[li_i]) + "'"
						case "number", "double", "decimal", "long"
							ls_sql_statement = ls_sql_statement + string(aa_key_values[li_i]) + ""
						case "date"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd") + "'"
						case "DateTime"
							ls_sql_statement = ls_sql_statement + "'" + string(aa_values[li_i], "yyyy-mm-dd hh:mm:ss") + "'"
					end choose
				end if
				if li_i < upperbound(as_key_column_name) then 
					ls_sql_statement = ls_sql_statement + " AND "
				else
					ls_sql_statement = ls_sql_statement + " "
				end if
			next
		else
			ls_sql_statement = ls_sql_statement + " "
		end if
end choose
return ls_sql_statement
end function

public function integer of_execute_retrieve_sql (string as_sql, ref string as_col_name[], ref string as_result_set[]);integer li_count, li_i
string ls_host, ls_key, ls_ReturnStatus, ls_empty[]
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(500)
as_sql = lower(as_sql)

li_count = LHOA_SQL_retrieve(ls_Host, ls_Key, as_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus)

as_col_name = ls_empty
as_result_set = ls_empty
if li_count > 0 then
	for li_i = 1 to li_count
		as_col_name[li_i] = space(100)
		as_result_set[li_i] = space(500)
	next
	LHOA_SQL_load(as_col_name, as_result_set)
	return li_count
elseif li_count < 0 then
	MessageBox("ls_ReturnStatus", ls_ReturnStatus)
	return -1
else
	return 0
end if
return 1
end function

public function integer of_load_to_dd (ref any a_dd, ref string as_col_name[], ref string as_result_set[]);
string ls_coltype, ls_col_name, ls_col_list[];
datawindow ldw
datastore lds, lds_a_dd
date ld_tmp
time lt_tmp
integer li_row, li_i, li_row_count, li_col, li_col_count, li_col_index[]
boolean lb_col_found
if not isvalid(a_dd) then
	MessageBox("of_load_to_dd", "Invalid Object!")
	return 0
end if
if classname(a_dd) = "datastore" or classname(a_dd) = "nvo_datastore" then
	lds = a_dd
else
	ldw = a_dd
	lds = create datastore
	lds.dataobject = ldw.dataobject
	ldw.ShareData(lds)
end if
lds.Reset()
// find total rows - number of same col_name repeat
ls_col_list[1] = as_col_name[1]
ls_col_name = as_col_name[1]
li_row_count = 1
if upperbound(as_col_name) > 1 then
	for li_i = 2 to upperbound(as_col_name)
		if ls_col_name = as_col_name[li_i] then
			li_row_count = li_row_count + 1
		end if
		lb_col_found = false
		for li_col = 1 to upperbound(ls_col_list)
			if as_col_name[li_i] = ls_col_list[li_col] then
				lb_col_found = true
				exit
			end if
		next
		if not lb_col_found then
			ls_col_list[upperbound(ls_col_list) + 1] = as_col_name[li_i]
		end if
	next
end if
li_col_count = upperbound(ls_col_list)
for li_row = 1 to li_row_count
	li_i = lds.InsertRow(0)
next
for li_col = 1 to li_col_count
	li_col_index[li_col] = 0
next
ls_col_name = as_col_name[1]
for li_i = 1 to upperbound(as_col_name)
	for li_col = 1 to upperbound(ls_col_list)
		if as_col_name[li_i] = ls_col_list[li_col] then
			li_col_index[li_col] = li_col_index[li_col] + 1
			li_row = li_col_index[li_col]
			exit
		end if
	next
	if as_result_set[li_i] <> "NULL" then
		ls_coltype = lds.Describe(as_col_name[li_i] + ".ColType")
		if ls_coltype = "datetime" then
			ld_tmp = date(left(as_result_set[li_i], 10))
			lt_tmp = time(mid(as_result_set[li_i], 12, 8))
			lds.SetItem(li_row, trim(as_col_name[li_i]), datetime(ld_tmp, lt_tmp))
		elseif pos(ls_coltype, "date") > 0 then
			ld_tmp = date(left(as_result_set[li_i], 10))
			lds.SetItem(li_row, as_col_name[li_i], ld_tmp)
		elseif pos(ls_coltype, "char") > 0 then
			lds.SetItem(li_row, trim(as_col_name[li_i]), as_result_set[li_i])
		else
			lds.SetItem(li_row, trim(as_col_name[li_i]), long(as_result_set[li_i]))
		end if		
		lds.SetItemStatus(li_row, trim(as_col_name[li_i]), Primary!, NotModified!)
	end if
next
lds.ResetUpdate()
if classname(a_dd) = "datawindow" then
	destroy lds
end if
return 1
end function

public function integer of_load_to_datastore (ref datastore a_ds, ref string as_col_name[], ref string as_result_set[]);
any la_parm
la_parm = a_ds
return of_load_to_dd(la_parm, as_col_name, as_result_set);
end function

public function integer of_load_to_datawindow (ref datawindow a_dw, ref string as_col_name[], ref string as_result_set[]);
any la_parm
la_parm = a_dw
return of_load_to_dd(la_parm, as_col_name, as_result_set);
end function

public function integer of_retrieve_to_datastore (ref datastore a_ds, string as_table_name, string as_select_col[], string as_where_col[], any aa_where_value[]);
string ls_sql_statement
any la_column_values[]
ls_sql_statement = of_make_sql_statement(as_table_name, "SELECT", as_where_col, as_select_col, aa_where_value, la_column_values)
return of_retrieve_to_datastore (a_ds, ls_sql_statement)
end function

public function integer of_retrieve_to_datawindow (ref datawindow a_dw, string as_table_name, string as_select_col[], string as_where_col[], any aa_where_value[]);
string ls_sql_statement
any la_column_values[]
ls_sql_statement = of_make_sql_statement(as_table_name, "SELECT", as_where_col, as_select_col, aa_where_value, la_column_values)
return of_retrieve_to_datawindow (a_dw, ls_sql_statement)
end function

public function integer of_retrieve_to_datastore (ref datastore a_ds, string as_sql);
string ls_col_name[], ls_result_set[]
if of_execute_retrieve_sql (as_sql, ls_col_name, ls_result_set[]) > 0 then
	return of_load_to_datastore(a_ds, ls_col_name, ls_result_set)
end if
return 0
end function

public function integer of_retrieve_to_datawindow (ref datawindow a_dw, string as_sql);
string ls_col_name[], ls_result_set[]
if of_execute_retrieve_sql (as_sql, ls_col_name, ls_result_set[]) > 0 then
	return of_load_to_datawindow(a_dw, ls_col_name, ls_result_set)
end if
return 0
end function

public function integer of_update_dd (ref any a_dd, string as_table_name, string as_update_col[], string as_key_col[]);
long ll_column_count, ll_col
string ls_key_column_names[], ls_column_names[], ls_empty_list[], ls_col_name
any la_key_column_values[], la_column_values[], la_empty_list[]
string ls_sql_statement, ls_update_type, ls_Host, ls_Key, ls_ReturnStatus, ls_expression
dwItemStatus l_ItemStatus
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(600)
datawindow ldw
datastore lds
integer li_row, li_i, li_row_count, li_key_col[], li_update_col[]
boolean lb_col_found
if not isvalid(a_dd) then
	MessageBox("of_update_dd", "Invalid Object!")
	return 0
end if
if classname(a_dd) = "datastore" or classname(a_dd) = "nvo_datastore" then
	lds = a_dd
else
	ldw = a_dd
	lds = create datastore
	lds.dataobject = ldw.dataobject
	ldw.ShareData(lds)
end if

ll_column_count = long(lds.Object.DataWindow.Column.Count)
// validate key columns
for li_i = 1 to upperbound(as_key_col)	
	lb_col_found = false
	for ll_col = 1 to ll_column_count		
		ls_expression = "#" + string(ll_col) + ".Name"
		ls_col_name = lds.describe(ls_expression)	
		if ls_col_name = as_key_col[li_i] then
			li_key_col[li_i] = ll_col
			lb_col_found = true
			exit
		end if
	next
	if not lb_col_found then
		MessageBox("of_update_dd", "Key Column(" + as_key_col[li_i] + ") Not Found")
		if isvalid(ldw) then destroy lds 
		return 0
	end if
next
// validate update columns
ll_column_count = long(lds.Object.DataWindow.Column.Count)
for li_i = 1 to upperbound(as_update_col)	
	lb_col_found = false
	for ll_col = 1 to ll_column_count		
		ls_expression = "#" + string(ll_col) + ".Name"
		ls_col_name = lds.describe(ls_expression)	
		if ls_col_name = as_update_col[li_i] then
			li_update_col[li_i] = ll_col
			lb_col_found = true
			exit
		end if
	next
	if not lb_col_found then
		MessageBox("of_update_dd", "Update Column(" + as_update_col[li_i] + ") Not Found")
		if isvalid(ldw) then destroy lds 
		return 0
	end if
next

li_row_count = lds.RowCount()
for li_row = 1 to li_row_count
	// build 
	la_key_column_values = la_empty_list
	for li_i = 1 to upperbound(as_key_col)	
		la_key_column_values[li_i] = lds.object.data[li_row, li_key_col[li_i]]
	next
	la_column_values = la_empty_list
	ls_column_names = ls_empty_list
	l_ItemStatus = lds.GetItemStatus(li_row, 0, Primary!)
	if l_ItemStatus = New! or l_ItemStatus = NewModified! then // INSERT
		ls_update_type = "INSERT"
		for li_i = 1 to upperbound(as_key_col)			
			ls_column_names[li_i] = as_key_col[li_i]
			la_column_values[li_i] = la_key_column_values[li_i]
		next
		for li_i = 1 to upperbound(as_update_col)	
			ls_column_names[upperbound(ls_column_names) + 1] = as_update_col[li_i]
			la_column_values[upperbound(la_column_values) + 1] = lds.object.data[li_row, li_update_col[li_i]]
		next
	else
		ls_update_type = "UPDATE"		
		for li_i = 1 to upperbound(as_update_col)
			if lds.GetItemStatus(li_row, as_update_col[li_i], Primary!) = DataModified! then 
				ls_column_names[upperbound(ls_column_names) + 1] = as_update_col[li_i]
				la_column_values[upperbound(la_column_values) + 1] = lds.object.data[li_row, li_update_col[li_i]]
			end if
		next
	end if
	if upperbound(la_column_values) > 0 then
		ls_sql_statement = of_make_sql_statement(as_table_name, ls_update_type, as_key_col, ls_column_names, la_key_column_values, la_column_values)
		if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql_statement, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
			MessageBox("ReturnStatus", ls_ReturnStatus)
			return 0
		end if		
	end if
next

// delete 
ls_update_type = "DELETE"
for li_row = 1 to lds.DeletedCount()
	la_key_column_values = la_empty_list
	for li_i = 1 to upperbound(as_key_col)	
		la_key_column_values[li_i] = lds.object.data.delete[li_row, li_key_col[li_i]]
	next
	ls_sql_statement = of_make_sql_statement(as_table_name, ls_update_type, as_key_col, ls_column_names, la_key_column_values, la_column_values)
	if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql_statement, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
		MessageBox("ReturnStatus", ls_ReturnStatus)
		return 0
	end if		
next
lds.ResetUpdate()
if classname(a_dd) = "datawindow" then
	destroy lds
end if

return 1
end function

public function integer of_update_datastore (ref datastore a_ds, string as_table_name, string as_update_col[], string as_key_col[]);
any la_parm
la_parm = a_ds
return of_update_dd (la_parm, as_table_name, as_update_col, as_key_col)
end function

public function integer of_update_datawindow (ref datawindow a_dw, string as_table_name, string as_update_col[], string as_key_col[]);
any la_parm
la_parm = a_dw
return of_update_dd (la_parm, as_table_name, as_update_col, as_key_col)
end function

public function integer of_update_dd (ref any a_dd, string as_table_name, string as_update_col[], string as_key_col[], integer ai_update_row[]);
long ll_column_count, ll_col
string ls_key_column_names[], ls_column_names[], ls_empty_list[], ls_col_name
any la_key_column_values[], la_column_values[], la_empty_list[]
string ls_sql_statement, ls_update_type, ls_Host, ls_Key, ls_ReturnStatus, ls_expression
dwItemStatus l_ItemStatus
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(600)
datawindow ldw
datastore lds
integer li_row, li_i, li_row_count, li_key_col[], li_update_col[]
boolean lb_col_found
if not isvalid(a_dd) then
	MessageBox("of_update_dd", "Invalid Object!")
	return 0
end if
if classname(a_dd) = "datastore" or classname(a_dd) = "nvo_datastore" then
	lds = a_dd
else
	ldw = a_dd
	lds = create datastore
	lds.dataobject = ldw.dataobject
	ldw.ShareData(lds)
end if

ll_column_count = long(lds.Object.DataWindow.Column.Count)
// validate key columns
for li_i = 1 to upperbound(as_key_col)	
	lb_col_found = false
	for ll_col = 1 to ll_column_count		
		ls_expression = "#" + string(ll_col) + ".Name"
		ls_col_name = lds.describe(ls_expression)	
		if ls_col_name = as_key_col[li_i] then
			li_key_col[li_i] = ll_col
			lb_col_found = true
			exit
		end if
	next
	if not lb_col_found then
		MessageBox("of_update_dd", "Key Column(" + as_key_col[li_i] + ") Not Found")
		if isvalid(ldw) then destroy lds 
		return 0
	end if
next
// validate update columns
ll_column_count = long(lds.Object.DataWindow.Column.Count)
for li_i = 1 to upperbound(as_update_col)	
	lb_col_found = false
	for ll_col = 1 to ll_column_count		
		ls_expression = "#" + string(ll_col) + ".Name"
		ls_col_name = lds.describe(ls_expression)	
		if ls_col_name = as_update_col[li_i] then
			li_update_col[li_i] = ll_col
			lb_col_found = true
			exit
		end if
	next
	if not lb_col_found then
		MessageBox("of_update_dd", "Update Column(" + as_update_col[li_i] + ") Not Found")
		if isvalid(ldw) then destroy lds 
		return 0
	end if
next

li_row_count = lds.RowCount()
for li_i = 1 to upperbound(ai_update_row)
	li_row = ai_update_row[li_i]
	if li_row < 1 or li_row > li_row_count then continue
	// build 
	la_key_column_values = la_empty_list
	for li_i = 1 to upperbound(as_key_col)	
		la_key_column_values[li_i] = lds.object.data[li_row, li_key_col[li_i]]
	next
	la_column_values = la_empty_list
	ls_column_names = ls_empty_list
	ls_update_type = "UPDATE"		
	for li_i = 1 to upperbound(as_update_col)
		ls_column_names[upperbound(ls_column_names) + 1] = as_update_col[li_i]
		la_column_values[upperbound(la_column_values) + 1] = lds.object.data[li_row, li_update_col[li_i]]
	next
	if upperbound(la_column_values) > 0 then
		ls_sql_statement = of_make_sql_statement(as_table_name, ls_update_type, as_key_col, ls_column_names, la_key_column_values, la_column_values)
		if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql_statement, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
			MessageBox("ReturnStatus", ls_ReturnStatus)
			return 0
		end if		
	end if
next

if classname(a_dd) = "datawindow" then
	destroy lds
end if

return 1
end function

public function integer of_update_datastore (ref datastore a_ds, string as_table_name, string as_update_col[], string as_key_col[], integer ai_update_row[]);
any la_parm
la_parm = a_ds
return of_update_dd (la_parm, as_table_name, as_update_col, as_key_col, ai_update_row)
end function

public function integer of_update_datawindow (ref datawindow a_dw, string as_table_name, string as_update_col[], string as_key_col[], integer ai_update_row[]);
any la_parm
la_parm = a_dw
return of_update_dd (la_parm, as_table_name, as_update_col, as_key_col, ai_update_row)
end function

on nvo_sqlite.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_sqlite.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

