$PBExportHeader$w_explorer_shopping_cart.srw
forward
global type w_explorer_shopping_cart from w_sheet
end type
type dw_cart from u_datawindow within w_explorer_shopping_cart
end type
type cb_select from u_commandbutton within w_explorer_shopping_cart
end type
type st_instruction from statictext within w_explorer_shopping_cart
end type
type cb_deselect from u_commandbutton within w_explorer_shopping_cart
end type
type tv_1 from treeview within w_explorer_shopping_cart
end type
type cb_ok from u_commandbutton within w_explorer_shopping_cart
end type
type cb_cancel from u_commandbutton within w_explorer_shopping_cart
end type
type str_tv_item from structure within w_explorer_shopping_cart
end type
type str_resource_moving from structure within w_explorer_shopping_cart
end type
end forward

type str_tv_item from structure
	long 		treeview_id
	long		data_id[10]
	long		dw_index
	nvo_datastore dd_handle
	string	tv_schem_desc
	string	description
	string	dw_name
	string	update_ind
	string	sender_dw
end type

type str_resource_moving from structure
	long data_id
	string description
	string wave_file
	string bitmap_file
	long pre_parent_id
	string pre_parent_description
	long cur_parent_id
	string cur_parent_description
end type

global type w_explorer_shopping_cart from w_sheet
integer width = 3927
integer height = 2028
string title = "Learning Helper Lesson Shopping-Cart"
boolean maxbox = false
windowstate windowstate = normal!
dw_cart dw_cart
cb_select cb_select
st_instruction st_instruction
cb_deselect cb_deselect
tv_1 tv_1
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_explorer_shopping_cart w_explorer_shopping_cart

type variables
private:
str_tv_item istr_tv_item
boolean ib_initialized = false
//str_resource_moving istr_pre_chapter[], istr_pre_content[]
protected:
TreeViewItem itvi_tmp
datastore ids_tv_data
string is_column_id_name[]
string is_column_des_name[]
string is_dwobject_name[]
string is_master_id_name
string is_details_id_name
string is_master_des_name
string is_details_des_name
string is_master_title
string is_details_title
long il_current_handle
long il_retrieve_ind = 0
integer ii_add_mode
integer ii_view_mode
string is_pres_type, is_pre_dir_list[], is_post_dir_list[], is_pre_file_list[], is_post_file_list[]
long il_chapter_id_list[], il_content_id_list[], il_libary_account_id = 1

nvo_datastore ids_sys_treeview, ids_account, ids_lesson_content
nvo_datastore ids_treeview_item[],ids_lesson_type,ids_lesson_list
 
end variables

forward prototypes
public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level)
public function integer wf_init_treeview ()
public function integer wf_populate_tv_from_dw (long al_handle, ref str_tv_item astr_tv_item)
public function integer wf_add_dd_parameters ()
public function integer wf_drop_to_target (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target)
public function integer wf_drop_to_lesson (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target)
public function integer wf_get_parent_tv_items (long al_handle, ref string as_key_col[], ref long al_key_val[])
public function string wf_get_ancestor_filter (long al_handle, ref nvo_datastore ads)
public function integer wf_cascade_popuplate (long al_parent_handle, long al_parent_id)
public function integer wf_load_lesson_content (string as_remote_file_path)
public function integer wf_make_lesson_type_tvitem (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target)
public function integer wf_populate_tv_from_sys_table (long al_handle)
end prototypes

public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level);long ll_row, ll_rowcount
/*long ll_parent_handle
datastore lds_tv_data
lds_tv_data = create datastore
lds_tv_data.dataobject = is_dwobject_name[ai_level]
lds_tv_data.SetTransObject(SQLCA)
ll_rowcount = lds_tv_data.Retrieve(aa_id)
treeviewitem ltvi_new 
ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_row = 1 to ll_rowcount
	istr_tv_item.data_id = lds_tv_data.GetItemNumber(ll_row, is_column_id_name[ai_level])
	istr_tv_item.description = lds_tv_data.GetItemString(ll_row, is_column_des_name[ai_level])							
	ltvi_new.label = istr_tv_item.description
	ltvi_new.data = istr_tv_item	
	ll_parent_handle = tv_1.InsertItemLast(al_parent_handle, ltvi_new)
	if ai_level < upperbound(is_dwobject_name) then
		wf_make_tv_multiple_dw(ll_parent_handle, istr_tv_item.data_id, ai_level + 1)
	end if
next
if ll_rowcount > 0 then
	tv_1.GetItem(al_parent_handle, itvi_tmp)
	itvi_tmp.children = true
	tv_1.SetItem(al_parent_handle, itvi_tmp)
end if
destroy lds_tv_data 

*/

end subroutine

public function integer wf_init_treeview ();string ls_filter

wf_add_dd_parameters()

ids_sys_treeview.data_retrieve()

wf_populate_tv_from_sys_table(0)

ib_initialized = true

return 1


end function

public function integer wf_populate_tv_from_dw (long al_handle, ref str_tv_item astr_tv_item);// determine if datastore has been initiated
integer li_i
long ll_i, ll_row, ll_rowcount, ll_parent_handle
boolean ib_is_ds_available = false
string ls_filter, ls_filter_ancestor, ls_item_description
treeviewitem ltvi_new 
nvo_datastore lds_tv_item
str_tv_item lstr_tv_item
lstr_tv_item = astr_tv_item
//MessageBox("wf_populate_tv_from_dw", "A")
for li_i = 1 to upperbound(ids_treeview_item)
	if lower(trim(astr_tv_item.dw_name)) = lower(ids_treeview_item[li_i].dataobject) then
		ib_is_ds_available = true
		lds_tv_item = ids_treeview_item[li_i]
		lstr_tv_item.dw_index = li_i
		lstr_tv_item.dd_handle = lds_tv_item
		exit
	end if
next
//MessageBox("wf_populate_tv_from_dw", "B")
if not ib_is_ds_available then 
	MessageBox("Error in wf_populate_tv_from_dw ", astr_tv_item.dw_name + ": datastore not found")	
	return 0
end if
//MessageBox("wf_populate_tv_from_dw", "B1")
if not isvalid(lds_tv_item) then
	MessageBox("wf_populate_tv_from_dw", "lds_tv_item not valid")
	return 0
end if
lds_tv_item.SetFilter("")
lds_tv_item.Filter()
//MessageBox("wf_populate_tv_from_dw", "B2")
if lds_tv_item.RowCount() = 0 then // if the datastore has not been retrieve, then retrieve it	
//MessageBox("wf_populate_tv_from_dw", "B2a")
//	if gn_appman.il_local_login_ind = 1 then
//		lds_tv_item.data_restore()
//	else	
		lds_tv_item.data_retrieve()
//	end if
//MessageBox("wf_populate_tv_from_dw", "B2c")
end if
//if lds_tv_item = ids_student_lesson then
//	lds_tv_item.ShareData(dw_1)
////	MessageBox("wf_populate_tv_from_dw", lds_tv_item.dataobject)
//end if
//MessageBox("wf_populate_tv_from_dw", "B3")
//MessageBox("lds_tv_item.RowCount()", lds_tv_item.RowCount())
//MessageBox(lds_tv_item.dataobject + " astr_tv_item.data_id", astr_tv_item.data_id)

ls_filter_ancestor = wf_get_ancestor_filter(al_handle, lds_tv_item)
ls_filter = ls_filter_ancestor
//if lds_tv_item = ids_student_lesson then
//	MessageBox("ls_filter", ls_filter)
//end if
//MessageBox("wf_populate_tv_from_dw", "C")
//if lds_tv_item.dataobject = "d_progress_report" then
//	MessageBox("ls_filter", ls_filter)
//end if
lds_tv_item.SetFilter(ls_filter)
lds_tv_item.Filter()
ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
//MessageBox("wf_populate_tv_from_dw", "D")
for ll_row = 1 to lds_tv_item.RowCount()
	for ll_i = 1 to upperbound(lds_tv_item.is_unique_col)
		lstr_tv_item.data_id[ll_i] = lds_tv_item.GetItemNumber(ll_row, lds_tv_item.is_unique_col[ll_i])
//		if ll_row = 1 and lds_tv_item.dataobject = "d_lesson_list" then
//			MessageBox(lds_tv_item.is_unique_col[ll_i], lstr_tv_item.data_id[ll_i])
//		end if
	next
//MessageBox(lds_tv_item.dataobject + " " + lds_tv_item.is_unique_col[1], lstr_tv_item.data_id)
	ls_item_description = ""
	for li_i = 1 to upperbound(lds_tv_item.is_desc_col)
		ls_item_description = ls_item_description + lds_tv_item.GetItemString(ll_row, lds_tv_item.is_desc_col[li_i])
		if li_i < upperbound(lds_tv_item.is_desc_col) then
			ls_item_description = ls_item_description + lds_tv_item.is_seperator
		end if
	next
	ls_item_description = lds_tv_item.is_header + ls_item_description + lds_tv_item.is_trailer
//	MessageBox("astr_tv_item.subtree_des_col", astr_tv_item.subtree_des_col)
	lstr_tv_item.description = ls_item_description
	lstr_tv_item.update_ind = astr_tv_item.update_ind
	lstr_tv_item.dw_name = astr_tv_item.dw_name
	ltvi_new.label = ls_item_description
	ltvi_new.data = lstr_tv_item	
//	MessageBox("wf_populate_tv_from_dw", lstr_tv_item.description + " " + string(lstr_tv_item.treeview_id))
	ll_parent_handle = tv_1.InsertItemLast(al_handle, ltvi_new)
next
lds_tv_item.SetFilter("")
lds_tv_item.Filter()
//MessageBox("wf_populate_tv_from_dw", "E")
return 1
end function

public function integer wf_add_dd_parameters ();
string ls_sql_statement, ls_sql_account_id = "", ls_sql_account_id2 = "", ls_where_sl = ""

ids_sys_treeview.is_update_col = {"parent_id", "description", "update_ind","dw_name","sender_dw","note","sort_seq"}
ids_sys_treeview.is_key_col[] = {"tv_group_id", "treeview_id"}
ids_sys_treeview.is_database_table = "Treeview"
ids_sys_treeview.is_select_sql = "Select * From Treeview where tv_group_id =  " + string(999) + " And Status =  'A'"
ids_sys_treeview.is_where_col[1] = "tv_group_id"
ids_sys_treeview.ia_where_value[1] = 999
ids_sys_treeview.is_where_col[2] = "Status"
ids_sys_treeview.ia_where_value[2] = 'A'

ids_account.is_database_table = "Account"
ls_sql_account_id = "Where Account_id =  " + string(il_libary_account_id) + " "
ids_account.is_select_sql = "select Name, ID as account_id From Account Where ID =  " + string(il_libary_account_id)
//ids_account.is_where_col[1] = "account_id"
ids_account.is_where_col[1] = "id"
ids_account.ia_where_value[1] = il_libary_account_id
ids_account.is_unique_col[1] = "account_id"
ids_account.is_desc_col = {"Name"}
ids_account.is_header = "Lesson Libary: "
										
if gn_appman.ib_lesson_training_only then
	ls_where_sl = " sl.active_ind =  'A' and "
end if
ids_lesson_type.is_database_table = "Method"
ids_lesson_type.is_select_sql = "Select l.account_id as account_id, m.method_cat_id as method_cat_id, m.method_cat_desc as method_name " + &
						" From Method as m, Lesson as l Where m.method_id =  l.method_id and " + &
						"l.account_id =  " + string(1) + " Group By l.account_id, m.method_cat_id " 
//ids_lesson_type.is_key_col[] = {"account_id", "method_cat_id", "lesson_id"}
ids_lesson_type.is_where_col[1] = "account_id"
ids_lesson_type.ia_where_value[1] = il_libary_account_id
ids_lesson_type.is_unique_col[1] = "method_cat_id"
ids_lesson_type.is_desc_col = {"method_name"}
ids_lesson_type.is_constant_col[1] = "account_id"
ids_lesson_type.ia_constant_val[1] = il_libary_account_id

//MessageBox("wf_add_dd_parameters", ids_lesson_type.is_select_sql)

ids_lesson_list.is_database_table = "LessonAcquired"
ids_lesson_list.is_select_sql = "Select account_id, account_id as orig_acct_id, m.method_cat_desc as method_name, m.method_cat_id as method_cat_id, m.method_id as method_id, l.lesson_id as lesson_id, lesson_name " + &
						" From Lesson As l, Method as m Where l.method_id =  m.method_id and l.account_id =  " + string(il_libary_account_id)
ids_lesson_list.is_key_col[] = {"account_id", "orig_acct_id", "lesson_id"}
ids_lesson_list.is_unique_col[1] = "orig_acct_id"
ids_lesson_list.is_unique_col[2] = "lesson_id"
ids_lesson_list.is_desc_col = {"lesson_name"}


return 1
end function

public function integer wf_drop_to_target (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target);// check if the target tvitem has the children with target datawindow
long ll_i, ll_row, ll_rowcount, ll_source_row, ll_target_row, ll_parent_key_val[], ll_empty[]
long ll_parent_handle, ll_treeview_id, ll_account_id, ll_orig_acct_id, ll_target_account_id
boolean lb_found = false
string ls_filter, ls_dw_name, ls_sender_dw, ls_target_update_ind, ls_expression="", ls_parent_key_col[], ls_empty[]
str_tv_item lstr_tv_item, lstr_tv_item_new
treeviewitem ltvi_tmp, ltvi_new
nvo_datastore lds_source, lds_target

if tv_1.FindItem(ParentTreeItem!, al_source_handle) = al_target_handle then return 0

ls_filter = "parent_id = " + string(astr_tv_item_target.treeview_id)
ids_sys_treeview.SetFilter("")
ids_sys_treeview.Filter()
ids_sys_treeview.SetFilter(ls_filter)
ids_sys_treeview.Filter()
//MessageBox("astr_tv_item_source.dw_name", astr_tv_item_source.dw_name)
ll_rowcount = ids_sys_treeview.RowCount()
for ll_row = 1 to ll_rowcount
	ls_dw_name = trim(ids_sys_treeview.GetItemString(ll_row, "dw_name"))
	ls_sender_dw = trim(ids_sys_treeview.GetItemString(ll_row, "sender_dw"))
//MessageBox(ls_dw_name, ls_sender_dw)
	if isnull(ls_dw_name) then ls_dw_name = ""
	if isnull(ls_sender_dw) then ls_sender_dw = ""
	if ls_sender_dw = trim(astr_tv_item_source.dw_name) then
		ls_target_update_ind = trim(ids_sys_treeview.GetItemString(ll_row, "update_ind"))
		ll_treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
		lb_found = true
		exit
	end if
next
//MessageBox("wf_drop_to_target", "A")
if not lb_found then return 0
//MessageBox("wf_drop_to_target", "B")
// find the source and target datawindow
lds_source = astr_tv_item_source.dd_handle
for ll_i = 1 to upperbound(ids_treeview_item)
	if trim(ls_dw_name) = trim(ids_treeview_item[ll_i].dataobject) then //target
		lds_target = ids_treeview_item[ll_i]
		exit
	end if
next
if not isvalid(lds_source) then return 0
if not isvalid(lds_target) then return 0


wf_get_parent_tv_items(al_source_handle, ls_parent_key_col, ll_parent_key_val)
for ll_i = 1 to upperbound(ls_parent_key_col)
	if ls_parent_key_col[ll_i] = "account_id" then ll_account_id = ll_parent_key_val[ll_i]
	if ls_parent_key_col[ll_i] = "orig_acct_id" then ll_orig_acct_id = ll_parent_key_val[ll_i]	
next
ls_parent_key_col = ls_empty
ll_parent_key_val = ll_empty
wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val)
for ll_i = 1 to upperbound(ls_parent_key_col)
	if ls_parent_key_col[ll_i] = "account_id" then ll_target_account_id = ll_parent_key_val[ll_i]
next

if ll_account_id <> ll_target_account_id then
	if ll_account_id <> ll_orig_acct_id then return 0
end if

// get source data
lds_source.SetFilter("")
lds_source.Filter()
//MessageBox("wf_drop_to_target", "C")

for ll_i = 1 to upperbound(lds_source.is_unique_col)
	if ls_expression <> "" then ls_expression = ls_expression + " and "
	ls_expression = ls_expression + lds_source.is_unique_col[ll_i] + " = " + string(astr_tv_item_source.data_id[ll_i])
next
ll_source_row = lds_source.find(ls_expression, 1, lds_source.RowCount())
if ll_source_row = -1 then
	MessageBox("Error", "Drag-drop System Error, Contact Software Vendor")
	return 0
end if
//MessageBox("wf_drop_to_target", "D")
// Insert A row to the target datawindow if is updatable
if ls_target_update_ind = "Y" then
//	wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val)
//	ls_expression = ""
//	for ll_i = 1 to upperbound(ls_parent_key_col)
//		if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
//		ls_expression = ls_expression + ls_parent_key_col[ll_i] + "=" + string(ll_parent_key_val[ll_i])
//	next	
//	MessageBox("ls_expression", ls_expression)	
//	if lds_target.Find(ls_expression, 1, lds_target.RowCount()) > 0 then return 0	
	wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val)
	// find if target already has the item
	ls_expression = ""
	for ll_i = 1 to upperbound(ls_parent_key_col)
		if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
		ls_expression = ls_expression + ls_parent_key_col[ll_i] + "=" + string(ll_parent_key_val[ll_i])
	next	
	if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
	for ll_i = 1 to upperbound(lds_source.is_unique_col)
		ls_expression = ls_expression + lds_source.is_unique_col[ll_i] + "=" + string(astr_tv_item_source.data_id[ll_i])	
	next
//MessageBox("wf_drop_to_target", "E")
	
	if lds_target.Find(ls_expression, 1, lds_target.RowCount()) > 0 then
		return 0
	end if
	
	ll_row = lds_target.InsertRow(0)
	if ll_row = -1 then
		MessageBox("Insert Failed", lds_target.dataobject)
		return 0
	end if		
	for ll_i = 1 to upperbound(lds_source.is_unique_col)
//		MessageBox(lds_source.is_unique_col[ll_i], astr_tv_item_source.data_id[ll_i])
		lds_target.SetItem(ll_row, lds_source.is_unique_col[ll_i], astr_tv_item_source.data_id[ll_i])
	next
	for ll_i = 1 to upperbound(ls_parent_key_col)
		lds_target.SetItem(ll_row, ls_parent_key_col[ll_i], ll_parent_key_val[ll_i])
	next
	for ll_i = 1 to upperbound(lds_target.is_constant_col)
		lds_target.SetItem(ll_row, lds_target.is_constant_col[ll_i], lds_target.ia_constant_val[ll_i])
	next
//MessageBox("wf_drop_to_target", "F")
	lstr_tv_item_new.dd_handle = lds_target
	lstr_tv_item_new.data_id = astr_tv_item_source.data_id
	lstr_tv_item_new.description = astr_tv_item_source.description
	lstr_tv_item_new.treeview_id = ll_treeview_id
	lstr_tv_item_new.update_ind = "Y"
	lstr_tv_item_new.dw_name = astr_tv_item_source.sender_dw
	ltvi_new.children = false
	ltvi_new.PictureIndex = 1
	ltvi_new.SelectedPictureIndex = 2
	ltvi_new.label = lstr_tv_item_new.description
	ltvi_new.data = lstr_tv_item_new	
	ll_parent_handle = tv_1.InsertItemLast(al_target_handle, ltvi_new)	
end if

return 1
end function

public function integer wf_drop_to_lesson (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target);// check if the target tvitem has the children with target datawindow
long ll_i, ll_row, ll_rowcount, ll_source_row, ll_target_row, ll_parent_key_val[], ll_empty[]
long ll_row_found, ll_source_parent_handle, ll_treeview_id, ll_handle_tmp, ll_target_handle, ll_account_id, ll_orig_acct_id
boolean lb_found = false
string ls_filter, ls_dw_name, ls_sender_dw, ls_target_update_ind, ls_expression="", ls_parent_key_col[], ls_empty[]
str_tv_item lstr_tv_item, lstr_tv_item_new, lstr_tv_item_source, lstr_tv_item_source_parent, lstr_tv_item_target
treeviewitem ltvi_tmp, ltvi_new
nvo_datastore lds_source, lds_target
// get source data
lds_source = astr_tv_item_source.dd_handle
lds_source.SetFilter("")
lds_source.Filter()

ll_source_parent_handle = tv_1.FindItem(ParentTreeItem!, al_source_handle)
tv_1.GetItem(ll_source_parent_handle, ltvi_tmp)
lstr_tv_item_source_parent = ltvi_tmp.data

//MessageBox("wf_drop_to_lesson", "A")
for ll_i = 1 to upperbound(lds_source.is_unique_col)
	if ls_expression <> "" then ls_expression = ls_expression + " and "
	ls_expression = lds_source.is_unique_col[ll_i] + " = " + string(astr_tv_item_source.data_id[ll_i])
next
tv_1.GetItem(al_target_handle, ltvi_tmp)

if ltvi_tmp.level= 2 then
	wf_get_parent_tv_items(al_source_handle, ls_parent_key_col, ll_parent_key_val)
	for ll_i = 1 to upperbound(ls_parent_key_col)
		if ls_parent_key_col[ll_i] = "account_id" then ll_account_id = ll_parent_key_val[ll_i]
		if ls_parent_key_col[ll_i] = "orig_acct_id" then ll_orig_acct_id = ll_parent_key_val[ll_i]	
	next
	ls_parent_key_col = ls_empty[]
	ll_parent_key_val = ll_empty[]
	if ll_account_id <> ll_orig_acct_id then return 0
end if
ll_source_row = lds_source.find(ls_expression, 1, lds_source.RowCount())
if ll_source_row < 1 then
	MessageBox("Error", "Drag-drop System Error, Contact Software Vendor")
	return 0
end if
// find the lesson type
ll_handle_tmp = tv_1.FindItem(ChildTreeItem!, al_target_handle)
tv_1.event clicked(al_target_handle)
//MessageBox("wf_drop_to_lesson", "C")
do while ll_handle_tmp <> -1
	tv_1.GetItem(ll_handle_tmp, ltvi_tmp)
	lstr_tv_item = ltvi_tmp.data
	
   if lstr_tv_item_source_parent.data_id[1] = lstr_tv_item.data_id[1] then		
//	if astr_tv_item_source.data_id[1] = lstr_tv_item.data_id[1] then
		lb_found = true
		ll_target_handle = ll_handle_tmp
		lstr_tv_item_new = lstr_tv_item
		exit
	end if
	ll_handle_tmp = tv_1.FindItem(NextTreeItem!, ll_handle_tmp)
loop 
// find Lesson Type Treeview ID
//MessageBox("wf_drop_to_lesson", "D")
ls_expression = "parent_id = " + string(astr_tv_item_target.treeview_id)
ids_sys_treeview.SetFilter("")
ids_sys_treeview.Filter()

ll_row_found = ids_sys_treeview.find(ls_expression, 1, ids_sys_treeview.RowCount())
if ll_row_found < 1 then
	MessageBox("Error", "Cannot Find Lesson Type Treeview ID, Contact Software Vendor")
	return 0
end if
ll_treeview_id = ids_sys_treeview.GetITemNumber(ll_row_found, "treeview_id")
ls_dw_name = ids_sys_treeview.GetItemString(ll_row_found, "dw_name")
for ll_i = 1 to upperbound(ids_treeview_item)
	if trim(ls_dw_name) = trim(ids_treeview_item[ll_i].dataobject) then //target
		lds_target = ids_treeview_item[ll_i]
		exit
	end if
next
//MessageBox("wf_drop_to_lesson", "E")
if not lb_found then // if method type not available
	wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val)
//MessageBox("wf_drop_to_lesson", "A")
	ll_row = lds_target.InsertRow(0)
	lds_target.SetItem(ll_row, "method_cat_id", lds_source.GetITemNumber(ll_source_row, "method_cat_id"))
	lds_target.SetItem(ll_row, "method_name", lds_source.GetITemString(ll_source_row, "method_name"))
	for ll_i = 1 to upperbound(ls_parent_key_col)
		lds_target.SetItem(ll_row, ls_parent_key_col[ll_i], ll_parent_key_val[ll_i])
	next
//MessageBox("wf_drop_to_lesson", "F")
	lstr_tv_item_new.dd_handle = lds_target
	lstr_tv_item_new.data_id[1] = lds_source.GetITemNumber(ll_source_row, "method_cat_id")
	lstr_tv_item_new.description = lds_source.GetItemString(ll_source_row, "method_name")
	lstr_tv_item_new.treeview_id = ids_sys_treeview.GetITemNumber(ll_row_found, "treeview_id")
	lstr_tv_item_new.update_ind = "N"
	lstr_tv_item_new.dw_name = ids_sys_treeview.GetItemString(ll_row_found, "dw_name")
	ltvi_new.children = false
	ltvi_new.PictureIndex = 1
//MessageBox("wf_drop_to_lesson", "G")
	ltvi_new.SelectedPictureIndex = 2
	ltvi_new.label = lstr_tv_item_new.description
	ltvi_new.data = lstr_tv_item_new	
	ll_target_handle = tv_1.InsertItemLast(al_target_handle, ltvi_new)
end if	
tv_1.event clicked(ll_target_handle)
//MessageBox("wf_drop_to_lesson", "H")
wf_drop_to_target(al_source_handle, ll_target_handle, astr_tv_item_source, lstr_tv_item_new)
//MessageBox("wf_drop_to_lesson", "I")
return 1
end function

public function integer wf_get_parent_tv_items (long al_handle, ref string as_key_col[], ref long al_key_val[]);long ll_handle_tmp, ll_i
treeviewitem ltvi_tmp
str_tv_item lstr_tv_item
ll_handle_tmp = al_handle
do 
	if tv_1.GetItem(ll_handle_tmp, ltvi_tmp) = 1 then
		lstr_tv_item = ltvi_tmp.data
		if isvalid(lstr_tv_item.dd_handle) then
			for ll_i = 1 to upperbound(lstr_tv_item.dd_handle.is_unique_col)
				as_key_col[upperbound(as_key_col) + 1] = lstr_tv_item.dd_handle.is_unique_col[ll_i]
				al_key_val[upperbound(al_key_val) + 1] = lstr_tv_item.data_id[ll_i]
			next
		end if
	end if
	ll_handle_tmp = tv_1.FindItem(ParentTreeItem!, ll_handle_tmp)
loop while ll_handle_tmp <> -1 

return 1
end function

public function string wf_get_ancestor_filter (long al_handle, ref nvo_datastore ads);string ls_key_col[], ls_filter = "", ls_col_name, ls_expression
long ll_key_val[], ll_i, ll_col, ll_column_count
boolean lb_found
wf_get_parent_tv_items(al_handle, ls_key_col, ll_key_val)
ll_column_count = long(ads.Object.DataWindow.Column.Count)
for ll_i = 1 to upperbound(ls_key_col)
	lb_found = false
	for ll_col = 1 to ll_column_count		
		ls_expression = "#" + string(ll_col) + ".Name"
		ls_col_name = ads.describe(ls_expression)	
		if ls_col_name = ls_key_col[ll_i] then
			lb_found = true
			exit
		end if
	next
	if lb_found then
		if ls_filter <> "" then ls_filter = ls_filter + " and "
		ls_filter = ls_filter + ls_key_col[ll_i] + "=" + string(ll_key_val[ll_i])
	end if
next
return ls_filter

end function

public function integer wf_cascade_popuplate (long al_parent_handle, long al_parent_id);str_tv_item lstr_tv_item, lstr_tv_item_parent
string ls_filter, ls_dw_name
long ll_row, ll_rowcount
long ll_parent_handle, ll_child_handle, ll_handle_tmp
treeviewitem ltvi_tmp, ltvi_new, ltvi_parent
nvo_datastore lds_sys_treeview
ls_filter = "parent_id = " + string(al_parent_id)
ids_sys_treeview.SetFilter("")
ids_sys_treeview.Filter()
ids_sys_treeview.SetFilter(ls_filter)
//MessageBox("ls_filter", ls_filter)
ids_sys_treeview.Filter()
ids_sys_treeview.SetSort("sort_seq A")
ids_sys_treeview.Sort()

ll_rowcount = ids_sys_treeview.RowCount()
//MessageBox("ll_rowcount", ll_rowcount)
if ll_rowcount = 0 then return 0

lds_sys_treeview = create nvo_datastore
lds_sys_treeview.dataobject = "d_treeview_sys_table"
ids_sys_treeview.RowsCopy(1, ids_sys_treeview.RowCount(), Primary!, lds_sys_treeview, 1, Primary!)
//ll_rowcount = lds_sys_treeview.RowCount()

tv_1.GetItem(al_parent_handle, ltvi_parent)
//MessageBox("ltvi_parent.label", ltvi_parent.label)
lstr_tv_item_parent = ltvi_parent.data
if ltvi_parent.ExpandedOnce then // this level is populated, go each node to populate its children
	ll_handle_tmp = tv_1.FindItem(ChildTreeItem!, al_parent_handle)
	do while ll_handle_tmp <> -1
		tv_1.GetItem(ll_handle_tmp, ltvi_tmp)
		lstr_tv_item = ltvi_tmp.data
//		MessageBox("ltvi_tmp.label 1", ltvi_tmp.label)
//		if isnull(lstr_tv_item.treeview_id) then  MessageBox("lstr_tv_item.treeview_id", "IS NULL")
		wf_cascade_popuplate(ll_handle_tmp, lstr_tv_item.treeview_id)
//		MessageBox("ltvi_tmp.label 2", ltvi_tmp.label)
		ll_handle_tmp = tv_1.FindItem(NextTreeItem!, ll_handle_tmp)
	loop  
else // open populate the treeview node
	lstr_tv_item = lstr_tv_item_parent
	for ll_row = 1 to ll_rowcount
		ls_dw_name = lds_sys_treeview.GetItemString(ll_row, "dw_name")
//		MessageBox("desc", lds_sys_treeview.GetItemString(ll_row, "description"))
		if isnull(ls_dw_name) then
			ls_dw_name = ""
		else
			trim(ls_dw_name)
		end if
		lstr_tv_item.dw_name = ls_dw_name
		lstr_tv_item.tv_schem_desc = lds_sys_treeview.GetItemString(ll_row, "description")
		lstr_tv_item.update_ind = lds_sys_treeview.GetItemString(ll_row, "update_ind")
		lstr_tv_item.description = lds_sys_treeview.GetItemString(ll_row, "description")
		lstr_tv_item.treeview_id = lds_sys_treeview.GetItemNumber(ll_row, "treeview_id")
//		MessageBox("wf_cascade_populate", lstr_tv_item.description + " " + string(lstr_tv_item.treeview_id))
		if trim(ls_dw_name) <> "" then
			lstr_tv_item.sender_dw = lds_sys_treeview.GetItemString(ll_row, "sender_dw")
			wf_populate_tv_from_dw(al_parent_handle, lstr_tv_item)
		else
//			MessageBox("wf_cascade_populate", "populate non dw treeitems")
			lstr_tv_item.sender_dw = ""
			lstr_tv_item.dw_name = ""
			ltvi_new.children = false
			ltvi_new.PictureIndex = 1
			ltvi_new.SelectedPictureIndex = 2
			ltvi_new.label = lstr_tv_item.description
			ltvi_new.data = lstr_tv_item	
			ltvi_new.label = lds_sys_treeview.GetItemString(ll_row, "description")
			ll_parent_handle = tv_1.InsertItemLast(al_parent_handle, ltvi_new)	
		end if
	next
	tv_1.ExpandAll(al_parent_handle)	
	if ll_rowcount > 0 and tv_1.FindItem(ChildTreeItem!, al_parent_handle) <> -1 then
//		MessageBox("ltvi_parent.label", ltvi_parent.label)
		wf_cascade_popuplate(al_parent_handle, al_parent_id)
	end if
end if
destroy 	lds_sys_treeview
return 1
end function

public function integer wf_load_lesson_content (string as_remote_file_path);string RemoetFileName, LocalFileName, ls_tmp_list[], ls_FileName
long ll_i, ll_count, ll_method_id
LocalFileName = ""
RemoetFileName = as_remote_file_path
for ll_i = len(RemoetFileName) to 1 step -1
	if mid(RemoetFileName, ll_i, 1) <> "/" then
		LocalFileName = mid(RemoetFileName, ll_i, 1) + LocalFileName
	else
		exit
	end if
next
ls_FileName = LocalFileName
LocalFileName = "C:\" + ls_FileName
extGetBinaryFile(LocalFileName, RemoetFileName) 
if upperbound(gn_appman.ids_lesson) > 0 then
	if isvalid(gn_appman.ids_lesson[1]) then
		destroy gn_appman.ids_lesson[1]
	end if
end if
gn_appman.ids_lesson[1] = create datastore
gn_appman.ids_lesson[1].dataobject = 'd_lesson'
ll_count = gn_appman.ids_lesson[1].ImportFile(LocalFileName)
FileDelete(LocalFileName)
if gn_appman.ids_lesson[1].RowCount() < 1 then
	MessageBox("Error", "No Lesson Content Loaded!")
	return 0
end if

ll_method_id = long(left(ls_FileName, 2))
if ll_method_id = 15 or ll_method_id = 16 then
	if upperbound(gn_appman.ids_lesson) > 1 then
		if isvalid(gn_appman.ids_lesson[2]) then
			destroy gn_appman.ids_lesson[2]
		end if
	end if
	RemoetFileName = left(as_remote_file_path, len(as_remote_file_path) - 4) + "_con.txt"
	LocalFileName = "C:\" + left(ls_FileName, len(ls_FileName) - 4) + "_con.txt"
	extGetBinaryFile(LocalFileName, RemoetFileName) 
	gn_appman.ids_lesson[2] = create datastore
	gn_appman.ids_lesson[2].dataobject = 'd_lesson_container'
	ll_count = gn_appman.ids_lesson[2].ImportFile(LocalFileName)
	FileDelete(LocalFileName)
end if
return 1
end function

public function integer wf_make_lesson_type_tvitem (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target);// check if the target tvitem has the children with target datawindow
long ll_i, ll_row, ll_rowcount, ll_source_row, ll_target_row, ll_parent_key_val[]
long ll_parent_handle, ll_treeview_id
boolean lb_found = false
string ls_filter, ls_dw_name, ls_sender_dw, ls_target_update_ind, ls_expression="", ls_parent_key_col[]
str_tv_item lstr_tv_item, lstr_tv_item_new
treeviewitem ltvi_tmp, ltvi_new
nvo_datastore lds_source, lds_target

//GetItem(handle, ltvi_tmp)
//lstr_tv_item = ltvi_tmp.data

ls_filter = "parent_id = " + string(astr_tv_item_target.treeview_id)
ids_sys_treeview.SetFilter("")
ids_sys_treeview.Filter()
ids_sys_treeview.SetFilter(ls_filter)
ids_sys_treeview.Filter()
//MessageBox("astr_tv_item_source.dw_name", astr_tv_item_source.dw_name)
ll_rowcount = ids_sys_treeview.RowCount()
for ll_row = 1 to ll_rowcount
	ls_dw_name = trim(ids_sys_treeview.GetItemString(ll_row, "dw_name"))
	ls_sender_dw = trim(ids_sys_treeview.GetItemString(ll_row, "sender_dw"))
//MessageBox(ls_dw_name, ls_sender_dw)
	if isnull(ls_dw_name) then ls_dw_name = ""
	if isnull(ls_sender_dw) then ls_sender_dw = ""
	if ls_sender_dw = trim(astr_tv_item_source.dw_name) then
		ls_target_update_ind = trim(ids_sys_treeview.GetItemString(ll_row, "update_ind"))
		ll_treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
		lb_found = true
		exit
	end if
next
//MessageBox("wf_drop_to_target", "A")
if not lb_found then return 0
//MessageBox("wf_drop_to_target", "B")
// find the source and target datawindow
lds_source = astr_tv_item_source.dd_handle
for ll_i = 1 to upperbound(ids_treeview_item)
	if trim(ls_dw_name) = trim(ids_treeview_item[ll_i].dataobject) then //target
		lds_target = ids_treeview_item[ll_i]
		exit
	end if
next
if not isvalid(lds_source) then return 0
if not isvalid(lds_target) then return 0
// get source data
lds_source.SetFilter("")
lds_source.Filter()

for ll_i = 1 to upperbound(lds_source.is_unique_col)
	if ls_expression <> "" then ls_expression = ls_expression + " and "
	ls_expression = lds_source.is_unique_col[ll_i] + " = " + string(astr_tv_item_source.data_id[ll_i])
next
ll_source_row = lds_source.find(ls_expression, 1, lds_source.RowCount())
if ll_source_row = -1 then
	MessageBox("Error", "Drag-drop System Error, Contact Software Vendor")
	return 0
end if
// Insert A row to the target datawindow if is updatable
if ls_target_update_ind = "Y" then
	wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val)
	// find if target already has the item
	for ll_i = 1 to upperbound(ls_parent_key_col)
		if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
		ls_expression = ls_expression + ls_parent_key_col[ll_i] + "=" + string(ll_parent_key_val[ll_i])
	next	
	ls_expression = ""
	if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
	for ll_i = 1 to upperbound(lds_source.is_unique_col)
		ls_expression = ls_expression + lds_source.is_unique_col[ll_i] + "=" + string(astr_tv_item_source.data_id[ll_i])	
	next
	if lds_target.Find(ls_expression, 1, lds_target.RowCount()) > 0 then
		return 0
	end if
	ll_row = lds_target.InsertRow(0)
	if ll_row = -1 then
//		MessageBox("Insert Failed", lds_target.dataobject)
		return 0
	end if
	for ll_i = 1 to upperbound(lds_source.is_unique_col)
		lds_target.SetItem(ll_row, lds_source.is_unique_col[ll_i], astr_tv_item_source.data_id[ll_i])
	next
	for ll_i = 1 to upperbound(ls_parent_key_col)
		lds_target.SetItem(ll_row, ls_parent_key_col[ll_i], ll_parent_key_val[ll_i])
	next
	for ll_i = 1 to upperbound(lds_target.is_constant_col)
		lds_target.SetItem(ll_row, lds_target.is_constant_col[ll_i], lds_target.ia_constant_val[ll_i])
	next
	lstr_tv_item_new.dd_handle = lds_target
	lstr_tv_item_new.data_id = astr_tv_item_source.data_id
	lstr_tv_item_new.description = astr_tv_item_source.description
	lstr_tv_item_new.treeview_id = ll_treeview_id
	lstr_tv_item_new.update_ind = "Y"
	lstr_tv_item_new.dw_name = astr_tv_item_source.sender_dw
	ltvi_new.children = false
	ltvi_new.PictureIndex = 1
	ltvi_new.SelectedPictureIndex = 2
	ltvi_new.label = lstr_tv_item_new.description
	ltvi_new.data = lstr_tv_item_new	
	ll_parent_handle = tv_1.InsertItemLast(al_target_handle, ltvi_new)	
end if

return 1
end function

public function integer wf_populate_tv_from_sys_table (long al_handle);string ls_filter, ls_dw_name
str_tv_item lstr_tv_item
long ll_row, ll_rowcount
long ll_parent_handle
treeviewitem ltvi_tmp, ltvi_new 
if al_handle <> 0 then
	tv_1.GetItem(al_handle, ltvi_tmp)
	lstr_tv_item = ltvi_tmp.data
	ls_filter = "parent_id = " + string(lstr_tv_item.treeview_id)
	if ltvi_tmp.ExpandedOnce then return 0
else
	if ib_initialized then return 0
	ls_filter = "parent_id = 0"	
end if

//if gn_appman.ib_lesson_training_only and al_handle <> 0 then
//	if ltvi_tmp.level = 2 and ltvi_tmp.label = "Student" then
//	elseif ltvi_tmp.level = 4 and ltvi_tmp.label = "Lesson" then
//	else
//		return 0
//	end if
//end if
ids_sys_treeview.SetFilter("")
ids_sys_treeview.Filter()
ids_sys_treeview.SetFilter(ls_filter)
ids_sys_treeview.Filter()
ids_sys_treeview.SetSort("sort_seq A")
ids_sys_treeview.Sort()
//MessageBox("wf_populate_tv_from_sys_table", ids_sys_treeview.RowCount())

ll_rowcount = ids_sys_treeview.RowCount()

for ll_row = 1 to ll_rowcount
	ls_dw_name = ids_sys_treeview.GetItemString(ll_row, "dw_name")
	if isnull(ls_dw_name) then
		ls_dw_name = ""
	else
		ls_dw_name = trim(ls_dw_name)
	end if
	lstr_tv_item.dw_name = ls_dw_name
	lstr_tv_item.tv_schem_desc = ids_sys_treeview.GetItemString(ll_row, "description")
	lstr_tv_item.update_ind = ids_sys_treeview.GetItemString(ll_row, "update_ind")
	lstr_tv_item.description = ids_sys_treeview.GetItemString(ll_row, "description")
	lstr_tv_item.treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
	// 	lstr_tv_item.description = "Student" or 
//		(ltvi_tmp.level = 2 and pos(ltvi_tmp.label, "Student") > 0) or &
	if not gn_appman.ib_lesson_training_only or &
		al_handle = 0 /* Account Level */ or &
		(ltvi_tmp.level = 1 and pos(lstr_tv_item.description, "Student") > 0) or &
		(ltvi_tmp.level = 2 and pos(ltvi_tmp.label, "Student") > 0) or &
		(ltvi_tmp.level = 3 and pos(lstr_tv_item.description, "Lesson") > 0) or &
			(ltvi_tmp.level >= 4 and ltvi_tmp.level <= 5) then
	else
		continue
	end if
	if trim(ls_dw_name) <> "" then
		lstr_tv_item.sender_dw = ids_sys_treeview.GetItemString(ll_row, "sender_dw")
//		MessageBox(ls_dw_name, lstr_tv_item.sender_dw)
		wf_populate_tv_from_dw(al_handle, lstr_tv_item)
	else
		lstr_tv_item.sender_dw = ""
		lstr_tv_item.dw_name = ""
		ltvi_new.children = false
		ltvi_new.PictureIndex = 1
		ltvi_new.SelectedPictureIndex = 2
		ltvi_new.label = lstr_tv_item.description
		ltvi_new.data = lstr_tv_item	
		ltvi_new.label = ids_sys_treeview.GetItemString(ll_row, "description")
		ll_parent_handle = tv_1.InsertItemLast(al_handle, ltvi_new)
	end if
next
tv_1.ExpandAll(al_handle)
return 1


end function

on w_explorer_shopping_cart.create
int iCurrent
call super::create
this.dw_cart=create dw_cart
this.cb_select=create cb_select
this.st_instruction=create st_instruction
this.cb_deselect=create cb_deselect
this.tv_1=create tv_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cart
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.st_instruction
this.Control[iCurrent+4]=this.cb_deselect
this.Control[iCurrent+5]=this.tv_1
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.cb_cancel
end on

on w_explorer_shopping_cart.destroy
call super::destroy
destroy(this.dw_cart)
destroy(this.cb_select)
destroy(this.st_instruction)
destroy(this.cb_deselect)
destroy(this.tv_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event close;call super::close;integer li_i

//if isvalid(ids_tv_data) then
//	destroy ids_tv_data
//end if

destroy ids_sys_treeview

for li_i = 1 to upperbound(ids_treeview_item)
	if isvalid(ids_treeview_item[li_i]) then
		destroy ids_treeview_item[li_i]
	end if
next
end event

event open;long li_i, ll_child_handle, ll_handle
//string ls_sub_desc, ls_chapter_desc, ls_bitmap_file, ls_wave_file
move(1, 1)
wf_set_resize(true)
super::event open()

inv_resize.of_Register(tv_1, inv_resize.SCALERIGHTBOTTOM)
//inv_resize.of_Register(cb_cancel, inv_resize.FIXEDBOTTOM)
//inv_resize.of_Register(cb_ok, inv_resize.FIXEDBOTTOM)
//inv_resize.of_Register(cb_open, inv_resize.FIXEDBOTTOM)
//inv_resize.of_Register(cb_play, inv_resize.FIXEDBOTTOM)
//inv_resize.of_Register(p_delete, inv_resize.FIXEDBOTTOM)
//inv_resize.of_Register(st_instruction, inv_resize.FIXEDBOTTOM)

//
//ids_student = create nvo_datastore
//ids_student.dataobject = "d_student"
//ids_group = create nvo_datastore
//ids_group.dataobject = "d_group"
ids_lesson_type = create nvo_datastore
ids_lesson_type.dataobject = "d_lesson_type"
ids_lesson_list = create nvo_datastore
ids_lesson_list.dataobject = "d_lesson_list"
ids_account = create nvo_datastore
ids_account.dataobject = "d_account"
ids_lesson_content = create nvo_datastore
ids_lesson_content.dataobject = "d_lesson_content_list"

ids_treeview_item = {ids_account,ids_lesson_type,ids_lesson_list,ids_lesson_content}


ids_sys_treeview = create nvo_datastore
ids_sys_treeview.dataobject = "d_treeview_sys_table"
//MessageBox("open", "A")
wf_init_treeview()
//if gn_appman.ib_lesson_training_only and gn_appman.is_account_type = "T" then
//	ll_handle = tv_1.FindItem(RootTreeItem!, 0)
//	for li_i = 1 to 5
//		tv_1.event clicked(ll_handle)
//		ll_child_handle = tv_1.FindItem(ChildTreeItem!, ll_handle)
//		ll_handle = ll_child_handle
//	next
//	tv_1.SelectItem ( ll_handle )
//else
	ll_handle = tv_1.FindItem(RootTreeItem!, 0)
	tv_1.event clicked(ll_handle)	
//end if
//this.Windowstate = normal!
end event

event activate;call super::activate;this.Windowstate = normal!
end event

event resize;call super::resize;this.Windowstate = normal!
end event

type dw_cart from u_datawindow within w_explorer_shopping_cart
integer x = 2213
integer y = 36
integer width = 1637
integer height = 1652
integer taborder = 20
string dataobject = "d_shopping_cart_lesson_list"
boolean hscrollbar = true
end type

type cb_select from u_commandbutton within w_explorer_shopping_cart
integer x = 1605
integer y = 520
integer width = 594
integer height = 96
integer taborder = 70
boolean bringtotop = true
string facename = "Tahoma"
string text = "Add To The Cart  >"
end type

event clicked;call super::clicked;long ll_i, ll_parent_handle, ll_row_found, ll_account_id, ll_orig_acct_id
long ll_row, ll_method_id, ll_lesson_id, ll_student_id
string ls_filter, ls_buf
treeviewitem ltvi_tmp, ltvi_new 
str_tv_item lstr_tv_item
if tv_1.GetItem(il_current_handle, ltvi_tmp) = -1 then return
lstr_tv_item = ltvi_tmp.data
if ltvi_tmp.level <> 4 then return
ll_parent_handle = tv_1.FindItem(ParentTreeItem!, tv_1.FindItem(ParentTreeItem!, il_current_handle ))
if tv_1.GetItem(ll_parent_handle, ltvi_new) = -1 then return
if pos(ltvi_new.label, "Lesson") = 0 then return
ls_filter = wf_get_ancestor_filter(il_current_handle, lstr_tv_item.dd_handle)
lstr_tv_item.dd_handle.SetFilter("")
lstr_tv_item.dd_handle.Filter()
ll_row_found = lstr_tv_item.dd_handle.Find(ls_filter, 1, lstr_tv_item.dd_handle.RowCount())
if ll_row_found < 1 then return
ll_row = dw_cart.InsertRow(0)
MessageBox("ll_row", ll_row)
dw_cart.object.data[ll_row] = lstr_tv_item.dd_handle.object.data[ll_row_found]
//
//ll_account_id = lstr_tv_item.dd_handle.GetItemNumber(ll_row_found, "account_id")
//ll_orig_acct_id = lstr_tv_item.dd_handle.GetItemNumber(ll_row_found, "orig_acct_id")
//ll_method_id = lstr_tv_item.dd_handle.GetItemNumber(ll_row_found, "method_id")
//ll_lesson_id = lstr_tv_item.dd_handle.GetItemNumber(ll_row_found, "lesson_id")
//gn_appman.of_set_parm("Account ID", ll_account_id)
//gn_appman.of_set_parm("Student Id", ll_student_id)
//gn_appman.of_set_parm("Orig Account ID", ll_orig_acct_id)
//gn_appman.of_set_parm("Method ID", ll_method_id)
//gn_appman.of_set_parm("Lesson ID", ll_lesson_id)
//
//
//MessageBox("ls_buf", ls_buf)
//MessageBox("ll_method_id", ll_method_id)
//MessageBox("ll_lesson_id", ll_lesson_id)
//if ll_method_id <> 2 and ll_method_id <> 21 and ll_method_id <> 25 and ll_method_id <> 22 then return
//OpenSheetWithParm(w_lesson_discrete_trial, "w_lesson_discrete_trial", gn_appman.iw_frame, 0, original!)

end event

type st_instruction from statictext within w_explorer_shopping_cart
boolean visible = false
integer x = 329
integer y = 1824
integer width = 1417
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_deselect from u_commandbutton within w_explorer_shopping_cart
integer x = 1605
integer y = 1092
integer width = 594
integer height = 96
integer taborder = 60
boolean bringtotop = true
string facename = "Tahoma"
string text = "< Remove From The Cart"
end type

event clicked;call super::clicked;long ll_i, ll_row, ll_parent_handle, ll_account_id, ll_student_id, ll_orig_acct_id
long ll_method_cat_id, ll_lesson_id,ll_progress_data_id
string ls_expression
treeviewitem ltvi_tmp, ltvi_cur
str_tv_item lstr_tv_item_tmp, lstr_tv_item_cur
if tv_1.GetItem(il_current_handle, ltvi_cur) = -1 then return
lstr_tv_item_cur = ltvi_cur.data
//
//choose case ltvi_cur.level
//	case 1 // Account
//		gn_appman.of_set_parm("Account ID", lstr_tv_item_cur.data_id[1])
//		OpenSheetWithParm(w_update_account, "w_update_account", gn_appman.iw_frame, 0, original!)		
//	case 2 //
//		ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, il_current_handle )
//		tv_1.GetItem(ll_parent_handle, ltvi_tmp)
//		lstr_tv_item_tmp = ltvi_tmp.data
//		gn_appman.of_set_parm("Account ID", lstr_tv_item_tmp.data_id[1])
//		choose Case trim(ltvi_cur.label)
//			case "Student"
//				OpenSheetWithParm(w_student, "w_stuent", gn_appman.iw_frame, 0, original!)
//			case "Group"
//			case "Lesson"
//				OpenSheetWithParm(w_lesson_parm, "w_lesson_parm", gn_appman.iw_frame, 0, original!)				
//			case "Response To Right"
//			case "Response To Wrong"
//			case "Reward"
//				OpenSheetWithParm(w_account_reward, "w_account_reward", gn_appman.iw_frame, 0, original!)				
//		end choose
//	case 4
//		ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, tv_1.FindItem ( ParentTreeItem!,tv_1.FindItem ( ParentTreeItem!,il_current_handle )))
//		tv_1.GetItem(ll_parent_handle, ltvi_tmp)
//		lstr_tv_item_tmp = ltvi_tmp.data
//		ll_account_id = lstr_tv_item_tmp.data_id[1]
//		ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, il_current_handle )
//		tv_1.GetItem(ll_parent_handle, ltvi_tmp)
//		lstr_tv_item_tmp = ltvi_tmp.data
//		ll_student_id = lstr_tv_item_tmp.data_id[1]
//		gn_appman.of_set_parm("Account ID", ll_account_id)
//		gn_appman.of_set_parm("Student ID", ll_student_id)	
//		choose Case trim(ltvi_cur.label)
//			case "Lesson"  	// student lesson, assign lesson to the student
//				OpenSheetWithParm(w_student_lesson_parm, "w_student_lesson_parm", gn_appman.iw_frame, 0, original!)								
//			case "Response To Right" // student's "R
//			case "Response To Wrong"
//			case "Reward"
//				OpenSheetWithParm(w_student_reward, "w_lesson_parm", gn_appman.iw_frame, 0, original!)								
//		end choose		
//		ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, tv_1.FindItem ( ParentTreeItem!,il_current_handle ))
//		tv_1.GetItem(ll_parent_handle, ltvi_tmp)
//		if trim(ltvi_tmp.label) = "Lesson" then
//			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle)
//			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
////			MessageBox("ls_expression", ls_expression)
//			if ll_row > 0 then
//				ll_method_cat_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "method_cat_id")
//				ll_lesson_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "lesson_id")
//				ll_orig_acct_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "orig_acct_id")
//				gn_appman.of_set_parm("Orig Acct ID", ll_orig_acct_id)
//				gn_appman.of_set_parm("Lesson ID", ll_lesson_id)	
//				gn_appman.of_set_parm("Method Cat ID", ll_method_cat_id)	
//				OpenSheetWithParm(w_lesson_content, "w_lesson_content", gn_appman.iw_frame, 0, original!)	
//			end if
//		end if		
//	case 6 // lesson		
//		ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, tv_1.FindItem ( ParentTreeItem!,il_current_handle ))
//		tv_1.GetItem(ll_parent_handle, ltvi_tmp)
//		if trim(ltvi_tmp.label) = "Lesson" then
//			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle)
//			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
////			MessageBox("ls_expression", ls_expression)
//			if ll_row > 0 then
//				ll_method_cat_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "method_cat_id")
//				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
//				ll_lesson_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "lesson_id")
//				ll_orig_acct_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "orig_acct_id")
//				gn_appman.of_set_parm("Orig Acct ID", ll_orig_acct_id)
//				gn_appman.of_set_parm("Lesson ID", ll_lesson_id)	
//				gn_appman.of_set_parm("Method Cat ID", ll_method_cat_id)	
//				OpenSheetWithParm(w_lesson_content, "w_lesson_content", gn_appman.iw_frame, 0, original!)	
//			end if
//		end if		
//	case 7 // report
//		ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle)
//		ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
//		if ll_row > 0 then
//			ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
//			ll_student_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "student_id")
//			ll_orig_acct_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "orig_acct_id")
//			ll_lesson_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "lesson_id")
//			ll_progress_data_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "progress_data_id")
//			gn_appman.of_set_parm("Account ID", ll_account_id)
//			gn_appman.of_set_parm("Student ID", ll_student_id)	
//			gn_appman.of_set_parm("Orig Acct ID", ll_orig_acct_id)
//			gn_appman.of_set_parm("Lesson ID", ll_lesson_id)	
//			gn_appman.of_set_parm("Orig Acct ID", ll_orig_acct_id)
//			gn_appman.of_set_parm("Progress Data ID", ll_progress_data_id)	
//			OpenSheetWithParm(w_progress_report_display, "w_progress_report_display", gn_appman.iw_frame, 0, original!)	
//		end if
//end choose

//for ll_i = 1 to upperbound(ids_treeview_item)
//	if ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 then
//		ids_treeview_item[ll_i].save()
//	end if
//next
end event

type tv_1 from treeview within w_explorer_shopping_cart
integer x = 37
integer y = 32
integer width = 1541
integer height = 1664
integer taborder = 10
boolean dragauto = true
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 12639424
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 553648127
end type

event dragdrop;long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle, ll_i, ll_account_id, ll_orig_acct_id
treeviewitem ltvi_target, ltvi_source, ltvi_child, ltvi_tmp
str_tv_item lstr_tv_item_source, lstr_tv_item_target
ll_target_handle = handle
nvo_datastore lds_source
if source.TypeOf() = TreeView! then
	ll_source_handle = tv_1.FindItem(CurrentTreeItem! ,0)
//	ll_source_handle = il_current_handle
//	ltvi_source = source
//	ll_source_handle = ltvi_source.ItemHandle
	if GetItem(ll_source_handle, ltvi_source) = -1 then return
	if GetItem(ll_target_handle, ltvi_target) = -1 then return
	if ltvi_source.level = ltvi_target.level and ltvi_target.level = 1 then
		InsertItem(0, ll_target_handle, ltvi_source)
		DeleteItem ( ll_source_handle )
		return
	end if
	if FindItem(ParentTreeItem!, ll_source_handle) = FindItem(ParentTreeItem!, ll_target_handle) then
		InsertItem(FindItem(ParentTreeItem!, ll_target_handle), ll_target_handle, ltvi_source)
		DeleteItem ( ll_source_handle )	
		return
	end if
	lstr_tv_item_source = ltvi_source.data
	lstr_tv_item_target = ltvi_target.data
	if (ltvi_source.level = 4 and ltvi_target.level = 4 and pos(ltvi_target.label, "Lesson") > 0) or &
		(ltvi_source.level = 4 and ltvi_target.level = 2 and pos(ltvi_target.label, "Lesson") > 0) then
		tv_1.GetItem(tv_1.FindItem(ParentTreeItem!, tv_1.FindItem(ParentTreeItem!, ll_source_handle)), ltvi_tmp)
		if pos(ltvi_tmp.label, "Lesson") > 0 then
			lds_source = lstr_tv_item_source.dd_handle		
			for ll_i = 1 to upperbound(lds_source.is_unique_col)
				if lds_source.is_unique_col[ll_i] = "account_id" then ll_account_id = lstr_tv_item_source.data_id[ll_i]
				if lds_source.is_unique_col[ll_i] = "orig_acct_id" then ll_orig_acct_id = lstr_tv_item_source.data_id[ll_i]	
			next			
			wf_drop_to_lesson(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target)
		end if
	else
		wf_drop_to_target(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target)
	end if
end if
drag(End!)
end event

event selectionchanged;//long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle, ll_i, ll_account_id, ll_orig_acct_id
//treeviewitem ltvi_target, ltvi_source, ltvi_child, ltvi_tmp
//str_tv_item lstr_tv_item_source, lstr_tv_item_target
//nvo_datastore lds_source
//GetItem(newhandle, ltvi_source)
//lstr_tv_item_source = ltvi_source.data
//lds_source = lstr_tv_item_source.dd_handle
//			for ll_i = 1 to upperbound(lds_source.is_unique_col)
//				if lds_source.is_unique_col[ll_i] = "account_id" then ll_account_id = lstr_tv_item_source.data_id[ll_i]
//				if lds_source.is_unique_col[ll_i] = "orig_acct_id" then ll_orig_acct_id = lstr_tv_item_source.data_id[ll_i]	
//			next
//			MessageBox("selectchanged", "account_id=" + string(ll_account_id) + " orig_acct__id=" + string(ll_orig_acct_id))

il_current_handle = newhandle


end event

event clicked;str_tv_item lstr_tv_item
long ll_parent_handle
il_current_handle = handle
treeviewitem ltvi_tmp, ltvi_tmp2, ltvi_new 
GetItem(handle, ltvi_tmp)

//cb_open.enabled = false
if ltvi_tmp.level = 1 then // account
//	if gn_appman.is_account_type = 'A' then
//		cb_open.enabled = true
//	end if
elseif ltvi_tmp.level = 2 then // student
	choose Case trim(ltvi_tmp.label)
		case "Student","Lesson", "Reward"
//			cb_open.enabled = true
	end choose
elseif ltvi_tmp.level = 4 then  // account level lesson
	choose Case trim(ltvi_tmp.label)
		case "Lesson", "Reward"  	
//			cb_open.enabled = true
	end choose
	ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, tv_1.FindItem ( ParentTreeItem!,il_current_handle ))
	GetItem(ll_parent_handle, ltvi_tmp2)
	if trim(ltvi_tmp2.label) = "Lesson" then
//		cb_open.enabled = true
	end if
elseif ltvi_tmp.level = 6 then // student level lesson
	ll_parent_handle = tv_1.FindItem ( ParentTreeItem!, tv_1.FindItem ( ParentTreeItem!,il_current_handle ))
	GetItem(ll_parent_handle, ltvi_tmp2)
	if trim(ltvi_tmp2.label) = "Lesson" then
//		cb_open.enabled = true
	end if
elseif ltvi_tmp.level = 7 then 
//		cb_open.enabled = true
end if
if ltvi_tmp.children = false then
	wf_populate_tv_from_sys_table(handle)
end if

end event

event rightclicked;long ll_parent_handle, ll_student_id, li_x, li_y
string ls_student_name
str_tv_item lstr_tv_item
str_mousepos i_mousepos
il_current_handle = handle
treeviewitem ltvi_tmp, ltvi_tmp2, ltvi_new 
GetItem(handle, ltvi_tmp)
m_student lm_student
GetCursorPos(i_mousepos)
//messagebox("dragwithin", "dragwithin")
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_y = li_y - y - gn_appman.iw_frame.workspaceY()
if ltvi_tmp.level = 3 then 
	ll_parent_handle = FindItem ( ParentTreeItem!, handle )
	GetItem(ll_parent_handle, ltvi_tmp2)
	if trim(ltvi_tmp2.label) = "Student" then
		lm_student = create m_student
		ls_student_name = ltvi_tmp.label
		lstr_tv_item = ltvi_tmp.data
		ll_student_id = lstr_tv_item.data_id[1]
		gn_appman.of_set_parm("STUDENT ID", ll_student_id)
		gn_appman.of_set_parm("STUDENT NAME", ls_student_name)
		lm_student.PopMenu(li_x, li_y)
		destroy lm_student
//		MessageBox(ls_student_name, ll_student_id)
	end if
end if
	


end event

type cb_ok from u_commandbutton within w_explorer_shopping_cart
integer x = 2505
integer y = 1824
integer width = 352
integer height = 96
integer taborder = 50
boolean bringtotop = true
string facename = "Tahoma"
string text = "&Save"
end type

event clicked;call super::clicked;long ll_i
if gn_appman.il_local_login_ind = 0 then // login to internet account
	if gn_appman.ib_lesson_training_only then // allow save to local account
		if ids_sys_treeview.Rowcount( ) > 0 then
			ids_sys_treeview.SetFilter( "" )
			ids_sys_treeview.Filter()
//			ids_sys_treeview.SaveAs(ids_sys_treeview.dataobject + ".txt", Text!, false)
//			ids_sys_treeview.SaveAs(ids_sys_treeview.dataobject + ".xml", XML!, false)
			ids_sys_treeview.SaveAs(ids_sys_treeview.dataobject + ".csv", CSV!, false)
		end if
		for ll_i = 1 to upperbound(ids_treeview_item)
			if ids_treeview_item[ll_i].RowCount() > 0 then
//				MessageBox("A", ids_treeview_item[ll_i].dataobject)
				ids_treeview_item[ll_i].SetFilter( "" )
				ids_treeview_item[ll_i].Filter()
				if ids_treeview_item[ll_i].SaveAs(ids_treeview_item[ll_i].dataobject + ".csv", CSV!, false) = -1 then
					MessageBox("Error", "Cannot SaveAs To Text")
				end if
			end if
		next	
	else	// save to internet account
		for ll_i = 1 to upperbound(ids_treeview_item)
			if upperbound(ids_treeview_item[ll_i].is_key_col) > 0 &
				and ( ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 ) then
				ids_treeview_item[ll_i].save()
			end if
		next
	end if
end if

end event

type cb_cancel from u_commandbutton within w_explorer_shopping_cart
integer x = 2866
integer y = 1844
integer width = 352
integer height = 96
integer taborder = 60
boolean bringtotop = true
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;call super::clicked;long ll_i
boolean lb_unsave_data = false
if gn_appman.il_local_login_ind = 0 then // login to internet account
	for ll_i = 1 to upperbound(ids_treeview_item)
		if ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 then
			lb_unsave_data = true
			exit
		end if
	next
	if lb_unsave_data then
		if MessageBox("Warning!", "There Are Unsaved Data, ~rDo You Want To Save Them Before Exiting the Window?", Question!, YesNO!) = 1 then
			for ll_i = 1 to upperbound(ids_treeview_item)
				if ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 then
					ids_treeview_item[ll_i].Save()
				end if
			next
		end if
	end if
end if
close(parent)
end event

