$PBExportHeader$nvo_datastore.sru
forward
global type nvo_datastore from datastore
end type
end forward

global type nvo_datastore from datastore
end type
global nvo_datastore nvo_datastore

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
end variables

forward prototypes
public function integer add_row ()
public function integer save ()
public function integer cancel ()
public function integer data_retrieve ()
end prototypes

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
datastore lds_this
lds_this = this
if gn_appman.invo_sqlite.of_update_datastore (lds_this, is_database_table, is_update_col, is_key_col) = 0 then
	MessageBox("Error", "Save fail!")
	return 0
end if
ResetUpdate()
return 1
end function

public function integer cancel ();datastore lds_this
lds_this = this
gn_appman.invo_sqlite.of_retrieve_to_datastore (lds_this, is_database_table, is_select_col, is_where_col, ia_where_value)	
return 1
end function

public function integer data_retrieve ();datastore lds_this
lds_this = this
if is_select_sql <> "" then
	gn_appman.invo_sqlite.of_retrieve_to_datastore (lds_this, is_select_sql)	
else
	gn_appman.invo_sqlite.of_retrieve_to_datastore (lds_this, is_database_table, is_select_col, is_where_col, ia_where_value)	
end if
return 1
end function

on nvo_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

