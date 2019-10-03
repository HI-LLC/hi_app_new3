$PBExportHeader$w_explorer_task_manager.srw
forward
global type w_explorer_task_manager from w_sheet
end type
type tv_1 from treeview within w_explorer_task_manager
end type
type cb_print from u_commandbutton within w_explorer_task_manager
end type
type st_instruction from statictext within w_explorer_task_manager
end type
type cb_open from u_commandbutton within w_explorer_task_manager
end type
type p_delete from picture within w_explorer_task_manager
end type
type tv_2 from treeview within w_explorer_task_manager
end type
type cb_ok from u_commandbutton within w_explorer_task_manager
end type
type cb_cancel from u_commandbutton within w_explorer_task_manager
end type
type str_tv_item from structure within w_explorer_task_manager
end type
type str_resource_moving from structure within w_explorer_task_manager
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

global type w_explorer_task_manager from w_sheet
integer width = 4064
integer height = 2452
string title = "Learning Helper Curriculum"
boolean maxbox = false
windowstate windowstate = normal!
tv_1 tv_1
cb_print cb_print
st_instruction st_instruction
cb_open cb_open
p_delete p_delete
tv_2 tv_2
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_explorer_task_manager w_explorer_task_manager

type variables
private:
str_tv_item istr_tv_item
boolean ib_initialized = false
//str_resource_moving istr_pre_chapter[], istr_pre_content[]
protected:
treeview tv_current, tv_target
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
long il_chapter_id_list[], il_content_id_list[]
long il_curr_account_id = 0
long il_tv_account_handle = 0

nvo_datastore ids_sys_treeview_current, ids_sys_treeview_target
nvo_datastore ids_sys_treeview, ids_account, ids_treeview_item_current[], ids_treeview_item_target[]
nvo_datastore ids_treeview_item[]
nvo_datastore ids_task_group,ids_task,ids_task_content

nvo_datastore ids_sys_treeview2, ids_account2, ids_treeview_item2[],ids_student
nvo_datastore ids_student_iep,ids_student_iep_task,ids_student_iep_task_content

string is_task_content_sql = ""
end variables

forward prototypes
public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level)
public function integer wf_init_treeview ()
public function integer wf_add_dd_parameters ()
public function integer wf_drop_to_target (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target, ref nvo_datastore ads_sys_treeview, ref nvo_datastore ads_treeview_item[])
public function integer wf_drop_to_lesson (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target, ref nvo_datastore ads_sys_treeview, ref nvo_datastore ads_treeview_item[])
public function integer wf_drop_to_delete (long al_source_handle, ref str_tv_item astr_tv_item_source)
public function long wf_cascade_delete (long al_handle)
public function integer wf_load_lesson_content (string as_remote_file_path)
public function integer wf_make_lesson_type_tvitem (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target)
public function integer wf_populate_tv_from_sys_table (long al_handle)
public function integer wf_get_parent_tv_items (long al_handle, ref string as_key_col[], ref long al_key_val[], ref treeview atv_current)
public function long wf_get_list_value (ref string as_key_col[], ref long al_key_val[],string as_col_name)
public function string wf_get_ancestor_filter (long al_handle, ref nvo_datastore ads, ref treeview atv_current)
public function integer wf_populate_tv_from_dw (long al_handle, ref str_tv_item astr_tv_item, ref nvo_datastore ads_treeview_item[])
public function integer wf_cascade_popuplate (long al_parent_handle, long al_parent_id, ref nvo_datastore ads_sys_treeview, ref nvo_datastore ads_treeview_item[])
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

ids_sys_treeview.is_select_sql = "Select * From Treeview1 where Status = 'A' And tv_group_id = 101"
ids_sys_treeview2.is_select_sql = "Select * From Treeview1 where Status = 'A' And tv_group_id = 102"

ids_sys_treeview.data_retrieve()
ids_sys_treeview2.data_retrieve()

ids_account.is_unique_col[1] = "account_id"
ids_account.is_desc_col = {"LastName"}

ids_account.is_select_sql = "select Name, LastName,FirstName,ID account_id From Account Where ID in (" + &
			" select account_id from CurrAccountGroup where group_id = " + string(gn_appman.il_curr_group_id) + " union " + &
			" select account_id from TaskGroup where account_id = " + string(gn_appman.il_account_id) + &
			" or account_id = " + string(gn_appman.il_parent_account_id) + " group by account_id )"
tv_current = tv_1

wf_add_dd_parameters()
wf_populate_tv_from_sys_table(0)

ib_initialized = true


//ids_account.is_header = "Account: "



return 1
end function

public function integer wf_add_dd_parameters ();string ls_sql_statement, ls_sql_account_id = "", ls_sql_account_id2 = "", ls_where_sl = ""

//ids_sys_treeview.is_select_sql = "Select * From Treeview1 where Status = 'A' And tv_group_id = 101"
//ids_sys_treeview2.is_select_sql = "Select * From Treeview1 where Status = 'A' And tv_group_id = 102"
//
//ids_account.is_select_sql = "select Name,  LastName,FirstName,ID account_id From Account Where ID = " + string(il_curr_account_id)
//ids_account.is_unique_col[1] = "account_id"
//ids_account.is_desc_col = {"LastName"}
////ids_account.is_header = "Account: "

//if 
ids_task_group.is_select_sql = "select account_id,account_id orig_acct_id,group_id,description,group_code From TaskGroup Where account_id = " + string(il_curr_account_id)
ids_task_group.is_unique_col[1] = "group_id"
ids_task_group.is_desc_col = {"group_code","description"}
ids_task_group.is_seperator = " - "

ids_task.is_select_sql = "select account_id,group_id,account_id orig_acct_id,task_id,task_name,task_code" + &
								" From Task Where account_id = " + string(il_curr_account_id) + " order by task_code"
//MessageBox("ids_task.is_select_sql", ids_task.is_select_sql)
ids_task.is_unique_col[1] = "task_id"
ids_task.is_unique_col[2] = "orig_acct_id"
ids_task.is_desc_col = {"task_code","task_name"}
//ids_task.is_seperator = " - "
ids_task.is_prefix = {""," - "}

ids_task_content.is_select_sql = " Select t.account_id account_id,t.account_id orig_acct_id,t.group_id group_id,t.task_id task_id," + &
											" content_id,instruction,response " + &
											" From TaskContent tc,Task t Where tc.task_id = t.task_id and tc.account_id = t.account_id and t.account_id = " + string(il_curr_account_id)

is_task_content_sql = ids_task_content.is_select_sql + " and tc.task_id = "

ids_task_content.is_unique_col[1] = "content_id"
ids_task_content.is_desc_col = {"instruction","response"}
ids_task_content.is_seperator = "/"

//MessageBox("ids_task_content.is_select_sql", ids_task_content.is_select_sql)

ids_account2.is_select_sql = "select Name, LastName, ID account_id From Account Where ID = " + string(gn_appman.il_account_id) 
ids_account2.is_unique_col[1] = "account_id"
ids_account2.is_desc_col = {"LastName"}
//ids_account2.is_header = "Account: "

ids_student.is_select_sql = "select account_id,student_id,last_name,first_name From Student Where account_id = " + string(gn_appman.il_account_id) 
ids_student.is_unique_col[1] = "student_id"
ids_student.is_desc_col = {"last_name", "first_name"}
ids_student.is_seperator = ", "

ids_student_iep.is_select_sql = &
	"select account_id,student_id,iep_id,start_period,end_period,school_year From StudentIEP Where account_id = " + string(gn_appman.il_account_id) 
ids_student_iep.is_unique_col[1] = "iep_id"
ids_student_iep.is_desc_col = {"school_year"}
ids_student_iep.is_header = "IEP For School Year: "
//ids_student_iep.is_seperator = ", "

ids_student_iep_task.is_select_sql = &
		"select st.account_id account_id,student_id,iep_id,t.account_id orig_acct_id,t.task_id task_id,task_name,task_code " + &
		" From StudentIEPTask st,Task t Where st.orig_acct_id =t.account_id and st.task_id = t.task_id and st.account_id = " + string(gn_appman.il_account_id)
ids_student_iep_task.is_unique_col[1] = "task_id"
ids_student_iep_task.is_desc_col = {"task_code","task_name"}
ids_student_iep_task.is_seperator = " - "
ids_student_iep_task.is_database_table = "StudentIEPTask"

ids_student_iep_task.is_key_col[] = {"account_id", "student_id", "orig_acct_id", "iep_id","task_id"}
ids_student_iep_task_content.is_select_sql = &
		" select stc.account_id account_id,stc.account_id orig_acct_id,student_id,iep_id,tc.task_id task_id," + &
		" stc.content_id content_id,instruction,tc.response response,Start_Date,Mastered_Date,stc.Note note, Lesson_Name" + &
		" From StudentIEPTaskContent stc,TaskContent tc " + &
		" Left Outer Join Lesson l On " + &
		" stc.lesson_orig_acct_id = l.account_id and stc.lesson_id = l.lesson_id " + &
		" Where stc.orig_acct_id =tc.account_id and stc.task_id = tc.task_id and stc.content_id = tc.content_id and stc.account_id = " + string(gn_appman.il_account_id) 
//MessageBox("ids_student_iep_task_content.is_select_sql", ids_student_iep_task_content.is_select_sql)
ids_student_iep_task_content.is_unique_col[1] = "content_id"
ids_student_iep_task_content.is_desc_col = {"instruction","response","Start_Date","Mastered_date","Note","Lesson_Name"}
//ids_student_iep_task_content.is_seperator = " - "

ids_student_iep_task_content.is_prefix = {"I - "," R - "," "," - "," N - "," L - "}
//ids_student_iep_task_content.is_desc_col_format = {"000","0000",""}

 
return 1
end function

public function integer wf_drop_to_target (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target, ref nvo_datastore ads_sys_treeview, ref nvo_datastore ads_treeview_item[]);// check if the target tvitem has the children with target datawindow
long ll_i, ll_row, ll_rowcount, ll_source_row, ll_target_row, ll_parent_key_val[], ll_empty[]
long ll_parent_handle, ll_treeview_id, ll_account_id, ll_orig_acct_id, ll_target_account_id
long ll_source_student_id,ll_target_student_id
boolean lb_found = false
string ls_filter, ls_dw_name, ls_sender_dw, ls_target_update_ind, ls_expression="", ls_parent_key_col[], ls_empty[]
long ll_source_parent_key_val[], ll_target_parent_key_val[]
string ls_source_parent_key_col[], ls_target_parent_key_col[]
str_tv_item lstr_tv_item, lstr_tv_item_new

treeviewitem ltvi_tmp, ltvi_new
nvo_datastore lds_source, lds_target

//MessageBox("wf_drop_to_target", "A")
if tv_current.FindItem(ParentTreeItem!, al_source_handle) = al_target_handle and tv_current = tv_2 then return 0

ls_filter = "parent_id = " + string(astr_tv_item_target.treeview_id)

ads_sys_treeview.SetFilter("")
ads_sys_treeview.Filter()

ads_sys_treeview.SetFilter(ls_filter)
ads_sys_treeview.Filter()
ll_rowcount = ads_sys_treeview.RowCount()
for ll_row = 1 to ll_rowcount
	ls_dw_name = trim(ads_sys_treeview.GetItemString(ll_row, "dw_name"))
	ls_sender_dw = trim(ads_sys_treeview.GetItemString(ll_row, "sender_dw"))
	if isnull(ls_dw_name) then ls_dw_name = ""
	if isnull(ls_sender_dw) then ls_sender_dw = ""
//	MessageBox(ls_sender_dw, astr_tv_item_source.dw_name)
	if pos(ls_sender_dw, trim(astr_tv_item_source.dw_name)) > 0 then
		ls_target_update_ind = trim(ads_sys_treeview.GetItemString(ll_row, "update_ind"))
		ll_treeview_id = ads_sys_treeview.GetItemNumber(ll_row, "treeview_id")
		lb_found = true
		exit
	end if
next
//MessageBox("wf_drop_to_target", "B")
if not lb_found then return 0
if ls_target_update_ind <> "Y" then return 0
//MessageBox("wf_drop_to_target", "C")
// find the source and target datawindow
lds_source = astr_tv_item_source.dd_handle

// find the datastore reference for the target
for ll_i = 1 to upperbound(ads_treeview_item)
	if trim(ls_dw_name) = trim(ads_treeview_item[ll_i].dataobject) then //target
		lds_target = ads_treeview_item[ll_i]
		exit
	end if
next

if not isvalid(lds_source) then return 0
if not isvalid(lds_target) then return 0

wf_get_parent_tv_items(al_source_handle, ls_source_parent_key_col, ll_source_parent_key_val, tv_current)
wf_get_parent_tv_items(al_target_handle, ls_target_parent_key_col, ll_target_parent_key_val, tv_target)

// get source data
lds_source.SetFilter("")
lds_source.Filter()
ls_expression = ""
for ll_i = 1 to upperbound(lds_source.is_unique_col)
	if ls_expression <> "" then ls_expression = ls_expression + " and "
	ls_expression = ls_expression + lds_source.is_unique_col[ll_i] + " = " + string(astr_tv_item_source.data_id[ll_i])
next
ll_source_row = lds_source.find(ls_expression, 1, lds_source.RowCount())
if ll_source_row = -1 then
	MessageBox("Error", "Drag-drop System Error, Contact Software Vendor")
	return 0
end if

//MessageBox("wf_drop_to_target", "C")

// Insert A row to the target datawindow if is updatable
// find if target already has the item
for ll_i = 1 to upperbound(ls_target_parent_key_col)
	if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
	ls_expression = ls_expression + ls_target_parent_key_col[ll_i] + "=" + string(ll_target_parent_key_val[ll_i])
next	
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
for ll_i = 1 to upperbound(ls_target_parent_key_col)
	lds_target.SetItem(ll_row, ls_target_parent_key_col[ll_i], ll_target_parent_key_val[ll_i])
next
for ll_i = 1 to upperbound(lds_target.is_constant_col)
	lds_target.SetItem(ll_row, lds_target.is_constant_col[ll_i], lds_target.ia_constant_val[ll_i])
next

//lds_target.SetItem(ll_row, "instruction", lds_source.GetItemString(ll_source_row, "instruction"))
//lds_target.SetItem(ll_row, "response", lds_source.GetItemString(ll_source_row, "response"))

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
ll_parent_handle = tv_target.InsertItemLast(al_target_handle, ltvi_new)	

long ll_tmp_handle

tv_current.event clicked(al_source_handle)	
ll_tmp_handle = tv_current.FindItem(ChildTreeItem!, al_source_handle)
do while ll_tmp_handle <> -1 
	tv_current.GetItem(ll_tmp_handle, ltvi_tmp)
	tv_target.InsertItemLast(ll_parent_handle, ltvi_tmp)
	ll_tmp_handle = tv_current.FindItem(NextTreeItem!, ll_tmp_handle)
loop

return 1
end function

public function integer wf_drop_to_lesson (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target, ref nvo_datastore ads_sys_treeview, ref nvo_datastore ads_treeview_item[]);// check if the target tvitem has the children with target datawindow
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

ll_source_parent_handle = tv_current.FindItem(ParentTreeItem!, al_source_handle)
tv_current.GetItem(ll_source_parent_handle, ltvi_tmp)
lstr_tv_item_source_parent = ltvi_tmp.data

//MessageBox("wf_drop_to_lesson", "A")
for ll_i = 1 to upperbound(lds_source.is_unique_col)
	if ls_expression <> "" then ls_expression = ls_expression + " and "
	ls_expression = lds_source.is_unique_col[ll_i] + " = " + string(astr_tv_item_source.data_id[ll_i])
next
tv_target.GetItem(al_target_handle, ltvi_tmp)

if ltvi_tmp.level= 2 then
	wf_get_parent_tv_items(al_source_handle, ls_parent_key_col, ll_parent_key_val, tv_current)
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
ll_handle_tmp = tv_target.FindItem(ChildTreeItem!, al_target_handle)
tv_target.event clicked(al_target_handle)
//MessageBox("wf_drop_to_lesson", "C")
do while ll_handle_tmp <> -1
	tv_target.GetItem(ll_handle_tmp, ltvi_tmp)
	lstr_tv_item = ltvi_tmp.data
	
   if lstr_tv_item_source_parent.data_id[1] = lstr_tv_item.data_id[1] then		
//	if astr_tv_item_source.data_id[1] = lstr_tv_item.data_id[1] then
		lb_found = true
		ll_target_handle = ll_handle_tmp
		lstr_tv_item_new = lstr_tv_item
		exit
	end if
	ll_handle_tmp = tv_target.FindItem(NextTreeItem!, ll_handle_tmp)
loop 
// find Lesson Type Treeview ID
//MessageBox("wf_drop_to_lesson", "D")
ls_expression = "parent_id = " + string(astr_tv_item_target.treeview_id)
ads_sys_treeview.SetFilter("")
ads_sys_treeview.Filter()

ll_row_found = ads_sys_treeview.find(ls_expression, 1, ads_sys_treeview.RowCount())
if ll_row_found < 1 then
	MessageBox("Error", "Cannot Find Lesson Type Treeview ID, Contact Software Vendor")
	return 0
end if
ll_treeview_id = ads_sys_treeview.GetITemNumber(ll_row_found, "treeview_id")
ls_dw_name = ads_sys_treeview.GetItemString(ll_row_found, "dw_name")
for ll_i = 1 to upperbound(ads_treeview_item)
	if trim(ls_dw_name) = trim(ads_treeview_item[ll_i].dataobject) then //target
		lds_target = ads_treeview_item[ll_i]
		exit
	end if
next
//MessageBox("wf_drop_to_lesson", "E")
if not lb_found then // if method type not available
	wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val, tv_target)
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
	lstr_tv_item_new.treeview_id = ads_sys_treeview.GetITemNumber(ll_row_found, "treeview_id")
	lstr_tv_item_new.update_ind = "N"
	lstr_tv_item_new.dw_name = ads_sys_treeview.GetItemString(ll_row_found, "dw_name")
	ltvi_new.children = false
	ltvi_new.PictureIndex = 1
//MessageBox("wf_drop_to_lesson", "G")
	ltvi_new.SelectedPictureIndex = 2
	ltvi_new.label = lstr_tv_item_new.description
	ltvi_new.data = lstr_tv_item_new	
	ll_target_handle = tv_target.InsertItemLast(al_target_handle, ltvi_new)
end if	
tv_target.event clicked(ll_target_handle)
//MessageBox("wf_drop_to_lesson", "H")
wf_drop_to_target(al_source_handle, ll_target_handle, astr_tv_item_source, lstr_tv_item_new, ads_sys_treeview, ads_treeview_item[])
//MessageBox("wf_drop_to_lesson", "I")
return 1
end function

public function integer wf_drop_to_delete (long al_source_handle, ref str_tv_item astr_tv_item_source);long ll_i, ll_row, ll_rowcount, ll_source_row, ll_child_handle
long ll_treeview_id, ll_parent_key_val[]
boolean lb_found = false
string ls_filter, ls_dw_name, ls_update_ind, ls_expression, ls_parent_key_col[]
str_tv_item lstr_tv_item, lstr_tv_item_new
treeviewitem ltvi_tmp, ltvi_new
nvo_datastore lds_source

lds_source = astr_tv_item_source.dd_handle
//MessageBox(lds_source.dataobject, astr_tv_item_source.update_ind)
if trim(astr_tv_item_source.Update_ind) <> "Y" then return 0
ll_child_handle = tv_current.FindItem(ChildTreeitem!, al_source_handle)
if ll_child_handle <> -1 then
	wf_cascade_delete(ll_child_handle)
end if	
//MessageBox("wf_drop_to_delete", "A")
wf_get_parent_tv_items(al_source_handle, ls_parent_key_col, ll_parent_key_val, tv_current)
lds_source.SetFilter("")
lds_source.Filter()
ls_expression = ""
for ll_i = 1 to upperbound(ls_parent_key_col)
	if not isnull(lds_source.GetItemNumber(1, ls_parent_key_col[ll_i])) then
		if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
		ls_expression = ls_expression + " " + ls_parent_key_col[ll_i] + "=" + string(ll_parent_key_val[ll_i])
	end if
next
ls_expression = ls_expression + " "
for ll_i = 1 to upperbound(lds_source.is_unique_col)
	if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
	ls_expression = ls_expression + " " + lds_source.is_unique_col[ll_i] + " = " + string(astr_tv_item_source.data_id[ll_i])
next
ll_source_row = lds_source.find(ls_expression, 1, lds_source.RowCount())	

lds_source.DeleteRow(ll_source_row)


tv_current.DeleteItem(al_source_handle)

return 1
end function

public function long wf_cascade_delete (long al_handle);long ll_handle_tmp, ll_row, ll_parent_handle
long ll_parent_key_val[], ll_child_handle, ll_i
string ls_expression, ls_parent_key_col[]
treeviewitem ltvi_tmp, ltvi_current
str_tv_item lstr_tv_item, lstr_tv_item_current
tv_current.GetItem(al_handle, ltvi_current)
tv_current.SelectItem(al_handle)
lstr_tv_item_current = ltvi_current.data
//MessageBox("wf_cascade_delete", ltvi_current.label)
//if not isvalid(lstr_tv_item_current.dd_handle) then
//	MessageBox("tv item info", "treeviewitem is not associated with datastore!")
//else
//MessageBox("ltvi_current.dd_handle.dataobject", lstr_tv_item_current.dd_handle.dataobject)
//MessageBox("ltvi_current.dw_name", lstr_tv_item_current.dw_name)
//end if
ll_handle_tmp = al_handle
do 
	ll_child_handle = tv_current.FindItem(ChildTreeItem!, ll_handle_tmp)
	if ll_child_handle <> -1 then
		wf_cascade_delete(ll_child_handle)
	end if
	ll_handle_tmp = tv_current.FindItem(NextTreeItem!, ll_handle_tmp)
loop while ll_handle_tmp <> -1  
ls_expression = ""
ll_parent_handle = tv_current.FindItem(ParentTreeItem!, al_handle)
wf_get_parent_tv_items(ll_parent_handle, ls_parent_key_col, ll_parent_key_val, tv_current)
tv_current.GetItem(al_handle, ltvi_tmp)
lstr_tv_item = ltvi_tmp.data
if trim(lstr_tv_item.dw_name) <> "" and isvalid(lstr_tv_item.dd_handle) then
//	MessageBox("dataobject 0", lstr_tv_item.dd_handle.dataobject)
	
	for ll_i = 1 to upperbound(ls_parent_key_col)
//	MessageBox("ls_parent_key_col[ll_i]", ls_parent_key_col[ll_i])
		if not isnull(lstr_tv_item.dd_handle.GetItemNumber(1, ls_parent_key_col[ll_i])) then
			if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
			ls_expression = ls_expression + ls_parent_key_col[ll_i] + "=" + string(ll_parent_key_val[ll_i])
		end if
	next
	lstr_tv_item.dd_handle.SetFilter("")
	lstr_tv_item.dd_handle.Filter()
//	MessageBox("wf_cascade_delete: ls_expression", ls_expression)
	lstr_tv_item.dd_handle.SetFilter(ls_expression)
	lstr_tv_item.dd_handle.Filter()
	for ll_row = lstr_tv_item.dd_handle.RowCount() to 1 step -1
//		MessageBox("delete", lstr_tv_item.dd_handle.dataobject + " row: " + string(ll_row))
		lstr_tv_item.dd_handle.DeleteRow(ll_row)
	next
end if		
ll_handle_tmp = al_handle
do 
	ll_handle_tmp = tv_current.FindItem(NextTreeItem!, al_handle)
	if ll_handle_tmp <> -1 then
		tv_current.GetItem(ll_handle_tmp, ltvi_tmp)
//		MessageBox("delete tv item", ltvi_tmp.label)
		tv_current.DeleteItem(ll_handle_tmp)
	end if
loop while ll_handle_tmp <> -1 
tv_current.GetItem(al_handle, ltvi_tmp)
//	MessageBox("delete tv item", ltvi_tmp.label)
tv_current.DeleteItem(al_handle)
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
	MessageBox("wf_make_lesson_type_tvitem", "A")
	if not isvalid(tv_target) then MessageBox("tv_target", "IS NOT VALID")
	wf_get_parent_tv_items(al_target_handle, ls_parent_key_col, ll_parent_key_val, tv_target)
	MessageBox("wf_make_lesson_type_tvitem", "B")
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
	ll_parent_handle = tv_target.InsertItemLast(al_target_handle, ltvi_new)	
end if

return 1
end function

public function integer wf_populate_tv_from_sys_table (long al_handle);string ls_filter, ls_dw_name
str_tv_item lstr_tv_item
long ll_row, ll_rowcount, ll_handle
long ll_parent_handle
treeviewitem ltvi_tmp, ltvi_new 
//MessageBox("wf_populate_tv_from_sys_table al_handle", al_handle)
if al_handle <> 0 then
	tv_current.GetItem(al_handle, ltvi_tmp)
	if IsValid(ltvi_tmp.data) then
		lstr_tv_item = ltvi_tmp.data
		ls_filter = "parent_id = " + string(lstr_tv_item.treeview_id)
	else
		return 0
	end if
//	lstr_tv_item = ltvi_tmp.data
	ls_filter = "parent_id = " + string(lstr_tv_item.treeview_id)
	if ltvi_tmp.ExpandedOnce and ltvi_tmp.Children then return 0
	if tv_current = tv_1 then
		ids_sys_treeview.SetFilter("")
		ids_sys_treeview.Filter()
		ids_sys_treeview.SetFilter(ls_filter)
		ids_sys_treeview.Filter()
		ids_sys_treeview.SetSort("sort_seq A")
		ids_sys_treeview.Sort()
	else
		ids_sys_treeview2.SetFilter("")
		ids_sys_treeview2.Filter()
		ids_sys_treeview2.SetFilter(ls_filter)
		ids_sys_treeview2.Filter()
		ids_sys_treeview2.SetSort("sort_seq A")
		ids_sys_treeview2.Sort()
	end if
else
//MessageBox("wf_populate_tv_from_sys_table ", "al_handle=0")
	if ib_initialized then return 0
	ls_filter = "parent_id = 0"	
	ids_sys_treeview.SetFilter("")
	ids_sys_treeview.Filter()
	ids_sys_treeview.SetFilter(ls_filter)
	ids_sys_treeview.Filter()
	ids_sys_treeview.SetSort("sort_seq A")
	ids_sys_treeview.Sort()	
	ids_sys_treeview2.SetFilter("")
	ids_sys_treeview2.Filter()
	ids_sys_treeview2.SetFilter(ls_filter)
	ids_sys_treeview2.Filter()
	ids_sys_treeview2.SetSort("sort_seq A")
	ids_sys_treeview2.Sort()
	tv_current = tv_1
	ll_rowcount = ids_sys_treeview.RowCount()
//	MessageBox("wf_populate_tv_from_sys_table RowCount", ll_rowcount)
	for ll_row = 1 to ll_rowcount
		ls_dw_name = ids_sys_treeview.GetItemString(ll_row, "dw_name")
//		MessageBox("wf_populate_tv_from_sys_table ls_dw_name", ls_dw_name)
		lstr_tv_item.dw_name = ls_dw_name
		lstr_tv_item.tv_schem_desc = ids_sys_treeview.GetItemString(ll_row, "description")
		lstr_tv_item.update_ind = ids_sys_treeview.GetItemString(ll_row, "update_ind")
		lstr_tv_item.description = ids_sys_treeview.GetItemString(ll_row, "description")
		lstr_tv_item.treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
		lstr_tv_item.sender_dw = ids_sys_treeview.GetItemString(ll_row, "sender_dw")
		wf_populate_tv_from_dw(al_handle, lstr_tv_item, ids_treeview_item)
	next
	tv_1.ExpandAll(al_handle)
	tv_current = tv_2
	ll_rowcount = ids_sys_treeview2.RowCount()
	for ll_row = 1 to ll_rowcount
		ls_dw_name = ids_sys_treeview2.GetItemString(ll_row, "dw_name")
		lstr_tv_item.dw_name = ls_dw_name
		lstr_tv_item.tv_schem_desc = ids_sys_treeview2.GetItemString(ll_row, "description")
		lstr_tv_item.update_ind = ids_sys_treeview2.GetItemString(ll_row, "update_ind")
		lstr_tv_item.description = ids_sys_treeview2.GetItemString(ll_row, "description")
		lstr_tv_item.treeview_id = ids_sys_treeview2.GetItemNumber(ll_row, "treeview_id")
		lstr_tv_item.sender_dw = ids_sys_treeview2.GetItemString(ll_row, "sender_dw")
		wf_populate_tv_from_dw(al_handle, lstr_tv_item, ids_treeview_item2)
	next
	tv_2.ExpandAll(al_handle)
	return 1	
end if

//MessageBox("wf_populate_tv_from_sys_table RowCount", ids_sys_treeview.RowCount())
ll_rowcount = ids_sys_treeview_current.RowCount()

for ll_row = 1 to ll_rowcount
//MessageBox("wf_populate_tv_from_sys_table ll_row", ll_row)
	ls_dw_name = ids_sys_treeview_current.GetItemString(ll_row, "dw_name")
	if isnull(ls_dw_name) then
		ls_dw_name = ""
	else
		ls_dw_name = trim(ls_dw_name)
	end if
	lstr_tv_item.dw_name = ls_dw_name
	lstr_tv_item.tv_schem_desc = ids_sys_treeview_current.GetItemString(ll_row, "description")
	lstr_tv_item.update_ind = ids_sys_treeview_current.GetItemString(ll_row, "update_ind")
	lstr_tv_item.description = ids_sys_treeview_current.GetItemString(ll_row, "description")
	lstr_tv_item.treeview_id = ids_sys_treeview_current.GetItemNumber(ll_row, "treeview_id")
//MessageBox("wf_populate_tv_from_sys_table ls_dw_name", ls_dw_name)
	if not gn_appman.ib_lesson_training_only or &
		al_handle = 0 /* Account Level */ or &
		(ltvi_tmp.level = 1 and pos(lstr_tv_item.description, "Student") > 0) or &
		(ltvi_tmp.level = 2 and pos(ltvi_tmp.label, "Student") > 0) or &
		(ltvi_tmp.level = 3 and pos(lstr_tv_item.description, "Lesson") > 0) or &
			(ltvi_tmp.level >= 4 and ltvi_tmp.level <= 5) then
	else
		continue
	end if
//MessageBox("wf_populate_tv_from_sys_table 1", ll_row)
	if trim(ls_dw_name) <> "" then
//MessageBox("wf_populate_tv_from_sys_table 2", ll_row)
		lstr_tv_item.sender_dw = ids_sys_treeview_current.GetItemString(ll_row, "sender_dw")
		wf_populate_tv_from_dw(al_handle, lstr_tv_item, ids_treeview_item_current )
	else
//MessageBox("wf_populate_tv_from_sys_table 3", ll_row)
		lstr_tv_item.sender_dw = ""
		lstr_tv_item.dw_name = ""
		ltvi_new.children = false
		ltvi_new.PictureIndex = 1
		ltvi_new.SelectedPictureIndex = 2
		ltvi_new.label = lstr_tv_item.description
		ltvi_new.data = lstr_tv_item	
		ltvi_new.label = ids_sys_treeview_current.GetItemString(ll_row, "description")
		ll_parent_handle = tv_current.InsertItemLast(al_handle, ltvi_new)		
	end if
next
tv_current.ExpandAll(al_handle)
return 1
end function

public function integer wf_get_parent_tv_items (long al_handle, ref string as_key_col[], ref long al_key_val[], ref treeview atv_current);long ll_handle_tmp, ll_i
treeviewitem ltvi_tmp
str_tv_item lstr_tv_item
ll_handle_tmp = al_handle
do 
	if atv_current.GetItem(ll_handle_tmp, ltvi_tmp) = 1 then
		lstr_tv_item = ltvi_tmp.data
		if isvalid(lstr_tv_item.dd_handle) then
			for ll_i = 1 to upperbound(lstr_tv_item.dd_handle.is_unique_col)
				as_key_col[upperbound(as_key_col) + 1] = lstr_tv_item.dd_handle.is_unique_col[ll_i]
				al_key_val[upperbound(al_key_val) + 1] = lstr_tv_item.data_id[ll_i]
			next
		end if
	end if
	ll_handle_tmp = atv_current.FindItem(ParentTreeItem!, ll_handle_tmp)
loop while ll_handle_tmp <> -1 

return 1
end function

public function long wf_get_list_value (ref string as_key_col[], ref long al_key_val[],string as_col_name);long ll_i
for ll_i = 1 to upperbound(as_key_col)
	if as_col_name = as_key_col[ll_i] then return al_key_val[ll_i]
next
return -1
end function

public function string wf_get_ancestor_filter (long al_handle, ref nvo_datastore ads, ref treeview atv_current);string ls_key_col[], ls_filter = "", ls_col_name, ls_expression
long ll_key_val[], ll_i, ll_col, ll_column_count
boolean lb_found
	if not isvalid(atv_current) then MessageBox("wf_get_ancestor atv_current", "IS NOT VALID")

wf_get_parent_tv_items(al_handle, ls_key_col, ll_key_val, atv_current)
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

public function integer wf_populate_tv_from_dw (long al_handle, ref str_tv_item astr_tv_item, ref nvo_datastore ads_treeview_item[]);// determine if datastore has been initiated
integer li_i, li_col_id
long ll_i, ll_row, ll_rowcount, ll_parent_handle, ll_parent_key_val[]
boolean ib_is_ds_available = false
string ls_filter, ls_filter_ancestor, ls_item_description, ls_parent_key_col[]
treeviewitem ltvi_new 
nvo_datastore lds_tv_item
str_tv_item lstr_tv_item
lstr_tv_item = astr_tv_item
//MessageBox("wf_populate_tv_from_dw", "A")
for li_i = 1 to upperbound(ads_treeview_item)
//	MessageBox(ads_treeview_item[li_i].dataobject, li_i)
	if lower(trim(astr_tv_item.dw_name)) = lower(trim(ads_treeview_item[li_i].dataobject)) then
		ib_is_ds_available = true
		lds_tv_item = ads_treeview_item[li_i]
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
//if lds_tv_item = ids_student_abbls_lesson_list then MessageBox("wf_populate_tv_from_dw", "B1")
if not isvalid(lds_tv_item) then
	MessageBox("wf_populate_tv_from_dw", "lds_tv_item not valid")
	return 0
end if
lds_tv_item.SetFilter("")
lds_tv_item.Filter()
//MessageBox("wf_populate_tv_from_dw", "B2")
if lds_tv_item.RowCount() = 0  or lds_tv_item = ids_task_content then // if the datastore has not been retrieve, then retrieve it	
long ll_task_id = 0
//	MessageBox("lds_tv_item.dataobject", lds_tv_item.dataobject)
//ids_task_content.is_select_sql
	if lds_tv_item = ids_task_content then
		lds_tv_item.Reset()
		wf_get_parent_tv_items(al_handle, ls_parent_key_col, ll_parent_key_val, tv_current)
		for ll_i = 1 to upperbound(ls_parent_key_col)
			if ls_parent_key_col[ll_i] = "task_id" then
				ll_task_id = ll_parent_key_val[ll_i]
			end if
		next
		if ll_task_id > 0 then
			lds_tv_item.is_select_sql = is_task_content_sql + string(ll_task_id)
//			MessageBox("ds_tv_item.is_select_sql", lds_tv_item.is_select_sql)
			lds_tv_item.data_retrieve()
		end if
	else
		lds_tv_item.data_retrieve()
	end if
//	if lds_tv_item = ids_ms_student_lesson_subject then MessageBox("lds_tv_item.rowcount()", lds_tv_item.rowcount())
end if
//MessageBox("wf_populate_tv_from_dw", "B2a")

ls_filter_ancestor = wf_get_ancestor_filter(al_handle, lds_tv_item, tv_current)
ls_filter = ls_filter_ancestor
//if lds_tv_item.dataobject = "d_ms_lesson_link" then MessageBox("lls_filter", ls_filter)
lds_tv_item.SetFilter(ls_filter)
lds_tv_item.Filter()
//if lds_tv_item = ids_student_abbls_lesson_list then MessageBox("lds_tv_item.rowcount()", lds_tv_item.rowcount())
ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_row = 1 to lds_tv_item.RowCount()
	for ll_i = 1 to upperbound(lds_tv_item.is_unique_col)
		lstr_tv_item.data_id[ll_i] = lds_tv_item.GetItemNumber(ll_row, lds_tv_item.is_unique_col[ll_i])
	next
//MessageBox(lds_tv_item.dataobject + " " + lds_tv_item.is_unique_col[1], lstr_tv_item.data_id)
	ls_item_description = ""
	for li_i = 1 to upperbound(lds_tv_item.is_desc_col)
		li_col_id = integer(lds_tv_item.Describe(lds_tv_item.is_desc_col[li_i] + ".id"))
		if not isnull(lds_tv_item.object.data[ll_row,li_col_id]) then 
			if li_i <= upperbound(lds_tv_item.is_prefix) then
				ls_item_description = ls_item_description + lds_tv_item.is_prefix[li_i]
			end if
			if pos(lds_tv_item.Describe(lds_tv_item.is_desc_col[li_i] +".ColType"), "char") > 0 then
				ls_item_description = ls_item_description + lds_tv_item.GetItemString(ll_row, lds_tv_item.is_desc_col[li_i])
			elseif pos(lds_tv_item.Describe(lds_tv_item.is_desc_col[li_i] +".ColType"), "date") > 0 then
				if pos(lds_tv_item.Describe(lds_tv_item.is_desc_col[li_i] +".ColType"), "time") > 0 then
					ls_item_description = ls_item_description + string(lds_tv_item.GetItemDateTime(ll_row, lds_tv_item.is_desc_col[li_i]))
				else
					ls_item_description = ls_item_description + string(lds_tv_item.GetItemDate(ll_row, lds_tv_item.is_desc_col[li_i]))
				end if
			else // number
				if li_i <= upperbound(lds_tv_item.is_desc_col_format) then
					if lds_tv_item.is_desc_col_format[li_i] <> "" then
						ls_item_description = ls_item_description + string(lds_tv_item.GetItemNumber(ll_row, lds_tv_item.is_desc_col[li_i]), lds_tv_item.is_desc_col_format[li_i])
					else
						ls_item_description = ls_item_description + string(lds_tv_item.GetItemNumber(ll_row, lds_tv_item.is_desc_col[li_i]))
					end if
				else
					ls_item_description = ls_item_description + string(lds_tv_item.GetItemNumber(ll_row, lds_tv_item.is_desc_col[li_i]))
				end if
			end if
			if li_i <= upperbound(lds_tv_item.is_suffix) then
				ls_item_description = ls_item_description + lds_tv_item.is_suffix[li_i]
			end if
			if li_i < upperbound(lds_tv_item.is_desc_col) then
				ls_item_description = ls_item_description + lds_tv_item.is_seperator
			end if
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
	ll_parent_handle = tv_current.InsertItemLast(al_handle, ltvi_new)
next
lds_tv_item.SetFilter("")
lds_tv_item.Filter()
//MessageBox("wf_populate_tv_from_dw", "E")
return 1
end function

public function integer wf_cascade_popuplate (long al_parent_handle, long al_parent_id, ref nvo_datastore ads_sys_treeview, ref nvo_datastore ads_treeview_item[]);str_tv_item lstr_tv_item, lstr_tv_item_parent
string ls_filter, ls_dw_name
long ll_row, ll_rowcount
long ll_parent_handle, ll_child_handle, ll_handle_tmp
treeviewitem ltvi_tmp, ltvi_new, ltvi_parent
nvo_datastore lds_sys_treeview
ls_filter = "parent_id = " + string(al_parent_id)
ads_sys_treeview.SetFilter("")
ads_sys_treeview.Filter()
ads_sys_treeview.SetFilter(ls_filter)
//MessageBox("ls_filter", ls_filter)
ads_sys_treeview.Filter()
ads_sys_treeview.SetSort("sort_seq A")
ads_sys_treeview.Sort()

ll_rowcount = ads_sys_treeview.RowCount()
//MessageBox("ll_rowcount", ll_rowcount)
if ll_rowcount = 0 then return 0

lds_sys_treeview = create nvo_datastore
lds_sys_treeview.dataobject = "d_treeview_sys_table"
ids_sys_treeview.RowsCopy(1, ads_sys_treeview.RowCount(), Primary!, lds_sys_treeview, 1, Primary!)
//ll_rowcount = lds_sys_treeview.RowCount()

tv_current.GetItem(al_parent_handle, ltvi_parent)
//MessageBox("ltvi_parent.label", ltvi_parent.label)
lstr_tv_item_parent = ltvi_parent.data
if ltvi_parent.ExpandedOnce then // this level is populated, go each node to populate its children
	ll_handle_tmp = tv_current.FindItem(ChildTreeItem!, al_parent_handle)
	do while ll_handle_tmp <> -1
		tv_current.GetItem(ll_handle_tmp, ltvi_tmp)
		lstr_tv_item = ltvi_tmp.data
//		MessageBox("ltvi_tmp.label 1", ltvi_tmp.label)
//		if isnull(lstr_tv_item.treeview_id) then  MessageBox("lstr_tv_item.treeview_id", "IS NULL")
		wf_cascade_popuplate(ll_handle_tmp, lstr_tv_item.treeview_id, ads_sys_treeview, ads_treeview_item)
//		MessageBox("ltvi_tmp.label 2", ltvi_tmp.label)
		ll_handle_tmp = tv_current.FindItem(NextTreeItem!, ll_handle_tmp)
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
			wf_populate_tv_from_dw(al_parent_handle, lstr_tv_item, ads_treeview_item)
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
			ll_parent_handle = tv_current.InsertItemLast(al_parent_handle, ltvi_new)	
		end if
	next
	tv_current.ExpandAll(al_parent_handle)	
	if ll_rowcount > 0 and tv_current.FindItem(ChildTreeItem!, al_parent_handle) <> -1 then
//		MessageBox("ltvi_parent.label", ltvi_parent.label)
		wf_cascade_popuplate(al_parent_handle, al_parent_id, ads_sys_treeview, ads_treeview_item)
	end if
end if
destroy 	lds_sys_treeview
return 1
end function

on w_explorer_task_manager.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.cb_print=create cb_print
this.st_instruction=create st_instruction
this.cb_open=create cb_open
this.p_delete=create p_delete
this.tv_2=create tv_2
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.st_instruction
this.Control[iCurrent+4]=this.cb_open
this.Control[iCurrent+5]=this.p_delete
this.Control[iCurrent+6]=this.tv_2
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.cb_cancel
end on

on w_explorer_task_manager.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.cb_print)
destroy(this.st_instruction)
destroy(this.cb_open)
destroy(this.p_delete)
destroy(this.tv_2)
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

event open;long li_i, ll_child_handle, ll_handle, ll_child_handle2, ll_handle2
string ls_sub_desc, ls_chapter_desc, ls_bitmap_file, ls_wave_file
move(1, 1)
wf_set_resize(true)
super::event open()

if gn_appman.il_parent_account_id = 0 then // this is a primary account itself
	il_curr_account_id = gn_appman.il_account_id
else	// secondary account
	il_curr_account_id = gn_appman.il_parent_account_id
end if
//cb_print.visible = false
ids_account = create nvo_datastore
ids_account.dataobject = "d_account"
ids_task_group = create nvo_datastore
ids_task_group.dataobject = "d_task_group"
ids_task = create nvo_datastore
ids_task.dataobject = "d_task"
ids_task_content = create nvo_datastore
ids_task_content.dataobject = "d_task_content"

ids_account2 = create nvo_datastore
ids_account2.dataobject = "d_account"
ids_student = create nvo_datastore
ids_student.dataobject = "d_student"

ids_student_iep = create nvo_datastore
ids_student_iep.dataobject = "d_student_iep"
ids_student_iep_task = create nvo_datastore
ids_student_iep_task.dataobject = "d_student_iep_task"
ids_student_iep_task_content = create nvo_datastore
ids_student_iep_task_content.dataobject = "d_student_iep_task_content"

ids_treeview_item = {ids_account,ids_task_group,ids_task,ids_task_content}

ids_treeview_item2 = {ids_account2,ids_student,ids_student_iep,ids_student_iep_task,ids_student_iep_task_content}

ids_sys_treeview = create nvo_datastore
ids_sys_treeview.dataobject = "d_treeview_sys_table"
ids_sys_treeview2 = create nvo_datastore
ids_sys_treeview2.dataobject = "d_treeview_sys_table"

wf_add_dd_parameters()
wf_init_treeview()
ll_handle = tv_1.FindItem(RootTreeItem!, 0)
tv_1.event clicked(ll_handle)	
//MessageBox("open", "C")
ll_handle2 = tv_2.FindItem(RootTreeItem!, 0)
tv_2.event clicked(ll_handle2)	
//MessageBox("open", "D")
tv_1.SetFocus()
tv_current = tv_1
this.Windowstate = normal!

cb_print.enabled = false
end event

event activate;call super::activate;this.Windowstate = normal!
end event

event resize;call super::resize;this.Windowstate = normal!
end event

type tv_1 from treeview within w_explorer_task_manager
integer x = 37
integer y = 28
integer width = 2002
integer height = 2008
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

event clicked;str_tv_item lstr_tv_item
long ll_parent_handle, ll_handle_tmp
integer li_i
il_current_handle = handle
treeviewitem ltvi_tmp, ltvi_tmp2, ltvi_new 
SelectItem(handle)
GetItem(handle, ltvi_tmp)
tv_current = tv_1
ids_treeview_item_current = ids_treeview_item
ids_sys_treeview_current = ids_sys_treeview

lstr_tv_item = ltvi_tmp.data
if ltvi_tmp.level = 1 then
	if lstr_tv_item.data_id[1] <> il_curr_account_id then
		if il_curr_account_id <> 0 then
			do 
				ll_handle_tmp = FindItem(ChildTreeItem!, il_tv_account_handle)
//				ll_handle_tmp = FindItem(ChildTreeItem!, il_curr_account_id)
				if ll_handle_tmp <> -1 then
					DeleteItem(ll_handle_tmp)
				end if
			loop while ll_handle_tmp <> -1 
			GetItem(il_tv_account_handle, ltvi_tmp2)
			ltvi_tmp2.children = false
			SetItem(il_tv_account_handle, ltvi_tmp2)
			for li_i = 1 to upperbound(ids_treeview_item)
				if isvalid(ids_treeview_item[li_i]) and ids_treeview_item[li_i].dataobject <> "d_account"  then 
					ids_treeview_item[li_i].Reset()
//					MessageBox(ids_treeview_item[li_i].dataobject, ids_treeview_item[li_i].RowCount())
				end if
			next
		end if
		il_curr_account_id = lstr_tv_item.data_id[1]
		wf_add_dd_parameters()
	end if
il_tv_account_handle = handle
end if
if ltvi_tmp.children = false then
//	MessageBox("clicked", "children = false")
	wf_populate_tv_from_sys_table(handle)
end if

cb_open.enabled = true
//if il_curr_account_id <> gn_appman.il_account_id then // not a primary account, cannot update curriculum
//	cb_open.enabled = false
//end if
if ltvi_tmp.level > 3 then // Task Content
	cb_open.enabled = false
end if


end event

event dragdrop;long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle, ll_i, ll_account_id, ll_orig_acct_id
treeviewitem ltvi_target, ltvi_source, ltvi_child, ltvi_tmp
str_tv_item lstr_tv_item_source, lstr_tv_item_target
ll_target_handle = handle
nvo_datastore lds_source
tv_target = this

if source.TypeOf() = TreeView! then
	ll_source_handle = tv_current.FindItem(CurrentTreeItem! ,0)
	if tv_current.GetItem(ll_source_handle, ltvi_source) = -1 then return
	if GetItem(ll_target_handle, ltvi_target) = -1 then return
	if ltvi_source.level = ltvi_target.level and ltvi_target.level = 1 then
		InsertItem(0, ll_target_handle, ltvi_source)
		tv_current.DeleteItem ( ll_source_handle )
		return
	end if
	if tv_current.FindItem(ParentTreeItem!, ll_source_handle) = FindItem(ParentTreeItem!, ll_target_handle) then
		InsertItem(FindItem(ParentTreeItem!, ll_target_handle), ll_target_handle, ltvi_source)
		tv_current.DeleteItem ( ll_source_handle )	
		return
	end if
	lstr_tv_item_source = ltvi_source.data
	lstr_tv_item_target = ltvi_target.data
	if (ltvi_source.level = 4 and ltvi_target.level = 4 and pos(ltvi_target.label, "Lesson") > 0) or &
		(ltvi_source.level = 4 and ltvi_target.level = 2 and pos(ltvi_target.label, "Lesson") > 0) then
		tv_current.GetItem(FindItem(ParentTreeItem!, tv_current.FindItem(ParentTreeItem!, ll_source_handle)), ltvi_tmp)
		if pos(ltvi_tmp.label, "Lesson") > 0 then
			lds_source = lstr_tv_item_source.dd_handle		
			for ll_i = 1 to upperbound(lds_source.is_unique_col)
				if lds_source.is_unique_col[ll_i] = "account_id" then ll_account_id = lstr_tv_item_source.data_id[ll_i]
				if lds_source.is_unique_col[ll_i] = "orig_acct_id" then ll_orig_acct_id = lstr_tv_item_source.data_id[ll_i]	
			next			
			wf_drop_to_lesson(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target, ids_sys_treeview, ids_treeview_item)
		end if
	else
		wf_drop_to_target(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target, ids_sys_treeview, ids_treeview_item)
	end if
end if
drag(End!)
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
tv_current = tv_1


end event

type cb_print from u_commandbutton within w_explorer_task_manager
integer x = 2350
integer y = 2068
integer width = 480
integer height = 96
integer taborder = 70
boolean bringtotop = true
string facename = "Tahoma"
string text = "&Print Student Task"
end type

event clicked;call super::clicked;long ll_i, ll_row, ll_parent_handle, ll_tmp_handle
long ll_account_id, ll_student_id,ll_iep_id,ll_orig_acct_id,ll_task_id,ll_content_id,ll_group_id
long ll_method_cat_id, ll_lesson_id,ll_progress_data_id, ll_parent_key_val[]
string ls_expression, ls_parent_key_col[]
treeviewitem ltvi_tmp, ltvi_cur
str_tv_item lstr_tv_item_tmp, lstr_tv_item_cur
nvo_datastore lds_tv_item

if not isvalid(tv_current) then return

if tv_current.GetItem(il_current_handle, ltvi_cur) = -1 then return
lstr_tv_item_cur = ltvi_cur.data

if tv_current = tv_2 then
	choose case ltvi_cur.level
		case 4 // Student Task
			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle, tv_current)
			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
			if ll_row > 0 then
				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
				ll_student_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "student_id")
				ll_orig_acct_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "orig_acct_id")
				ll_task_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "task_id")
				ll_iep_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "iep_id")
				gn_appman.of_set_parm("Account ID", ll_account_id)
				gn_appman.of_set_parm("Student ID", ll_student_id)	
				gn_appman.of_set_parm("Orig Account ID", ll_orig_acct_id)
				gn_appman.of_set_parm("IEP ID", ll_iep_id)	
				gn_appman.of_set_parm("Task ID", ll_task_id)
				Open(w_student_iep_task_print)	
			end if
	end choose
end if 

end event

type st_instruction from statictext within w_explorer_task_manager
boolean visible = false
integer x = 329
integer y = 2188
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

type cb_open from u_commandbutton within w_explorer_task_manager
integer x = 2871
integer y = 2068
integer width = 352
integer height = 96
integer taborder = 60
boolean bringtotop = true
string facename = "Tahoma"
string text = "&Open"
end type

event clicked;call super::clicked;long ll_i, ll_row, ll_parent_handle, ll_tmp_handle
long ll_account_id, ll_student_id,ll_iep_id,ll_orig_acct_id,ll_task_id,ll_content_id,ll_group_id
long ll_method_cat_id, ll_lesson_id,ll_progress_data_id, ll_parent_key_val[]
string ls_expression, ls_parent_key_col[]
treeviewitem ltvi_tmp, ltvi_cur
str_tv_item lstr_tv_item_tmp, lstr_tv_item_cur
nvo_datastore lds_tv_item

if not isvalid(tv_current) then return

if tv_current.GetItem(il_current_handle, ltvi_cur) = -1 then return
lstr_tv_item_cur = ltvi_cur.data

if tv_current = tv_2 then
	choose case ltvi_cur.level
		case 2 // Student IEP
			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle, tv_current)
			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
			if ll_row > 0 then
				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
				ll_student_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "student_id")
				gn_appman.of_set_parm("Account ID", ll_account_id)
				gn_appman.of_set_parm("Student ID", ll_student_id)	
				Open(w_student_school_year_iep)	
				parent.SetRedraw(false)
				do
					ll_tmp_handle = tv_current.FindItem(ChildTreeItem!, il_current_handle)
					if ll_tmp_handle <> -1 then
						tv_current.DeleteItem(ll_tmp_handle)
					end if
				loop while ll_tmp_handle <> -1
				ids_student_iep.reset()
				ids_student_iep.data_retrieve()
				ids_student_iep_task.reset()
				ids_student_iep_task.data_retrieve()
				ids_student_iep_task_content.Reset()
				ids_student_iep_task_content.data_retrieve()	
				ltvi_cur.children = false
				ltvi_cur.ExpandedOnce = false
//				MessageBox("rowcount", ids_student_iep_task.RowCount())
				tv_current.SetItem(il_current_handle, ltvi_cur)
				tv_current.event clicked(il_current_handle)	
				parent.SetRedraw(true)
			end if
		case 4 // Student Task
			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle, tv_current)
			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
			if ll_row > 0 then
				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
				ll_student_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "student_id")
				ll_orig_acct_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "orig_acct_id")
				ll_task_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "task_id")
				ll_iep_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "iep_id")
				gn_appman.of_set_parm("Account ID", ll_account_id)
				gn_appman.of_set_parm("Student ID", ll_student_id)	
				gn_appman.of_set_parm("Orig Account ID", ll_orig_acct_id)
				gn_appman.of_set_parm("IEP ID", ll_iep_id)	
				gn_appman.of_set_parm("Task ID", ll_task_id)
//				OpenSheetWithParm(w_student_iep_task_content, "w_student_iep_task_content", gn_appman.iw_frame, 0, original!)	
				Open(w_student_iep_task_content)	
				parent.SetRedraw(false)
				do
					ll_tmp_handle = tv_current.FindItem(ChildTreeItem!, il_current_handle)
					if ll_tmp_handle <> -1 then
						tv_current.DeleteItem(ll_tmp_handle)
					end if
				loop while ll_tmp_handle <> -1
				ids_student_iep_task_content.Reset()
				ids_student_iep_task_content.data_retrieve()	
				ltvi_cur.children = false
				ltvi_cur.ExpandedOnce = false
				tv_current.SetItem(il_current_handle, ltvi_cur)
				tv_current.event clicked(il_current_handle)	
				parent.SetRedraw(true)				
			end if
		case 5 // Student Task Content 	
	end choose
elseif tv_current = tv_1 then
	choose case ltvi_cur.level
		case 1 //	account level
			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle, tv_current)
			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
			if ll_row > 0 then
				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
				gn_appman.of_set_parm("Account ID", ll_account_id)
				Open(w_task_group)
				if Message.StringParm = "UNCHANGED" then return
				parent.SetRedraw(false)
				do
					ll_tmp_handle = tv_current.FindItem(ChildTreeItem!, il_current_handle)
					if ll_tmp_handle <> -1 then
						tv_current.DeleteItem(ll_tmp_handle)
					end if
				loop while ll_tmp_handle <> -1
				ids_task_group.Reset()
				ids_task_group.data_retrieve()	
				ids_task.Reset()
				ids_task.data_retrieve()	
//				ids_task_content.Reset()
//				ids_task_content.data_retrieve()	
				ltvi_cur.children = false
				ltvi_cur.ExpandedOnce = false
				tv_current.SetItem(il_current_handle, ltvi_cur)
				tv_current.event clicked(il_current_handle)	
				parent.SetRedraw(true)
			end if
		case 2 // task group 
//			MessageBox("case 2", ltvi_cur.label)
			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle, tv_current)
			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
			if ll_row > 0 then
				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
				ll_group_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "group_id")
				gn_appman.of_set_parm("Account ID", ll_account_id)
				gn_appman.of_set_parm("Task Group ID", ll_group_id)
				gn_appman.of_set_parm("Task Group Name", ltvi_cur.label)
				Open(w_task)
				if Message.StringParm = "UNCHANGED" then return
				parent.SetRedraw(false)
				do
					ll_tmp_handle = tv_current.FindItem(ChildTreeItem!, il_current_handle)
					if ll_tmp_handle <> -1 then
						tv_current.DeleteItem(ll_tmp_handle)
					end if
				loop while ll_tmp_handle <> -1
				ids_task.Reset()
				ids_task.data_retrieve()	
//				ids_task_content.Reset()
//				ids_task_content.data_retrieve()	
				ltvi_cur.children = false
				ltvi_cur.ExpandedOnce = false
				tv_current.SetItem(il_current_handle, ltvi_cur)
				tv_current.event clicked(il_current_handle)
				parent.SetRedraw(true)
			end if
		case 3 // Task
			ls_expression = wf_get_ancestor_filter(il_current_handle, lstr_tv_item_cur.dd_handle, tv_current)
			ll_row = lstr_tv_item_cur.dd_handle.Find(ls_expression, 1, lstr_tv_item_cur.dd_handle.RowCount())
			if ll_row > 0 then
				ll_account_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "account_id")
				ll_task_id = lstr_tv_item_cur.dd_handle.GetItemNumber(ll_row, "task_id")
				gn_appman.of_set_parm("Account ID", ll_account_id)
				gn_appman.of_set_parm("Task ID", ll_task_id)
				gn_appman.of_set_parm("Task Name", ltvi_cur.label)
//				OpenSheetWithParm(w_task_content, "w_task_content", gn_appman.iw_frame, 0, original!)	
				Open(w_task_content)	
				if Message.StringParm = "UNCHANGED" then return
				do
					ll_tmp_handle = tv_current.FindItem(ChildTreeItem!, il_current_handle)
					if ll_tmp_handle <> -1 then
						tv_current.DeleteItem(ll_tmp_handle)
					end if
				loop while ll_tmp_handle <> -1
//				lds_tv_item = create nvo_datastore
//				lds_tv_item.dataobject = "d_task_content_detail"
//				lds_tv_item.is_select_sql = &
//						" select account_id, task_id,content_id,instruction,response" + &
//						" From TaskContent " + &
//						" Where " + &
//						" account_id = " + string(ll_account_id) + &
//						" and task_id = " + string(ll_task_id) 
//				lds_tv_item.data_retrieve()
//				for ll_row = 1 to lds_tv_item.RowCount()
//					ltvi_cur.label = lds_tv_item.GetItemString(ll_row,"instruction") + "/" + &
//												lds_tv_item.GetItemString(ll_row,"response") 
//					MessageBox
////					MessageBox(lds_tv_item.GetItemString(ll_row,"instruction"), lds_tv_item.GetItemString(ll_row,"response")
//					ltvi_cur.Selected	= false
//					tv_current.InsertItemLast(il_current_handle, ltvi_cur)
//				next
//				tv_current.ExpandItem(il_current_handle)
//				destroy lds_tv_item
				tv_current.event clicked(il_current_handle)
				tv_current.SelectItem(il_current_handle)
			end if
	end choose
end if 

end event

type p_delete from picture within w_explorer_task_manager
integer x = 37
integer y = 2076
integer width = 261
integer height = 244
string picturename = "trash.jpg"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event dragdrop;long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle
treeviewitem ltvi_target, ltvi_source, ltvi_child
str_tv_item lstr_tv_item_source, lstr_tv_item_target
if source.TypeOf() = TreeView! then
	ll_source_handle = tv_current.FindItem(CurrentTreeItem! ,0)
	if tv_current.GetItem(ll_source_handle, ltvi_source) = -1 then return
	lstr_tv_item_source = ltvi_source.data
	tv_current.SetRedraw(false)
//	wf_cascade_popuplate(ll_source_handle, lstr_tv_item_source.treeview_id, ids_sys_treeview_current, ids_treeview_item_current)		
	wf_drop_to_delete(ll_source_handle, lstr_tv_item_source)
	tv_current.SetRedraw(true)
end if
drag(End!)
end event

type tv_2 from treeview within w_explorer_task_manager
integer x = 2075
integer y = 28
integer width = 1915
integer height = 2008
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
tv_target = this
if source.TypeOf() = TreeView! then
	ll_source_handle = tv_current.FindItem(CurrentTreeItem! ,0)
	if tv_current.GetItem(ll_source_handle, ltvi_source) = -1 then return
	if GetItem(ll_target_handle, ltvi_target) = -1 then return
	lstr_tv_item_source = ltvi_source.data
	lstr_tv_item_target = ltvi_target.data
	if ltvi_source.level = 3 /* Curriculum Task */ and ltvi_target.level = 3 /* Student IEP */ then
//		MessageBox("dragdrop", "B")
		wf_drop_to_target(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target, ids_sys_treeview2, ids_treeview_item2)
//	elseif  ltvi_source.level = 3 /* Curriculum Task */ and ltvi_target.level = 4 /* Student TASK */ then
//		wf_drop_to_target(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target, ids_sys_treeview2, ids_treeview_item2)
	end if
end if
//MessageBox("dragdrop", "E")
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
tv_current = tv_2


end event

event clicked;str_tv_item lstr_tv_item
long ll_parent_handle
il_current_handle = handle
tv_current = tv_2
ids_treeview_item_current = ids_treeview_item2
ids_sys_treeview_current = ids_sys_treeview2

treeviewitem ltvi_tmp, ltvi_tmp2, ltvi_new 
GetItem(handle, ltvi_tmp)

cb_open.enabled = false
cb_print.enabled = false
if ltvi_tmp.level = 2 or ltvi_tmp.level = 4 then // account
	cb_open.enabled = true
end if
if ltvi_tmp.level = 4 then // Student Task
	cb_print.enabled = true
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

type cb_ok from u_commandbutton within w_explorer_task_manager
integer x = 3246
integer y = 2068
integer width = 352
integer height = 96
integer taborder = 50
boolean bringtotop = true
string facename = "Tahoma"
string text = "&Save"
end type

event clicked;call super::clicked;long ll_i
if gn_appman.il_local_login_ind = 0 then // login to internet account
	for ll_i = 1 to upperbound(ids_treeview_item)
		if upperbound(ids_treeview_item[ll_i].is_key_col) > 0 &
			and ( ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 ) then
			ids_treeview_item[ll_i].save()
		end if
	next
	for ll_i = 1 to upperbound(ids_treeview_item2)
		if upperbound(ids_treeview_item2[ll_i].is_key_col) > 0 &
			and ( ids_treeview_item2[ll_i].ModifiedCount() > 0 or ids_treeview_item2[ll_i].DeletedCount() > 0 ) then
			ids_treeview_item2[ll_i].save()
		end if
	next
end if

end event

type cb_cancel from u_commandbutton within w_explorer_task_manager
integer x = 3630
integer y = 2068
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

