$PBExportHeader$w_explorer.srw
forward
global type w_explorer from w_sheet
end type
type cb_open from u_commandbutton within w_explorer
end type
type p_delete from picture within w_explorer
end type
type tv_1 from treeview within w_explorer
end type
type cb_ok from u_commandbutton within w_explorer
end type
type cb_cancel from u_commandbutton within w_explorer
end type
type str_tv_item from structure within w_explorer
end type
type str_resource_moving from structure within w_explorer
end type
end forward

type str_tv_item from structure
	long 		treeview_id
	long		data_id
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

global type w_explorer from w_sheet
integer width = 1989
integer height = 2088
string title = "Learning Helper Explorer"
long backcolor = 15780518
cb_open cb_open
p_delete p_delete
tv_1 tv_1
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_explorer w_explorer

type variables
private:
str_tv_item istr_tv_item
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
long il_chapter_id_list[], il_content_id_list[]


nvo_datastore ids_sys_treeview, ids_account
nvo_datastore ids_treeview_item[],ids_student, ids_group,ids_group_student,ids_lesson_type,ids_lesson_list,ids_student_lesson
nvo_datastore ids_report,ids_student_RTR,ids_student_RTW,ids_response_to_right,ids_response_to_wrong
 
end variables

forward prototypes
public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level)
public function boolean of_is_id_in_the_list (long al_source_id, integer ai_source_ind)
public subroutine of_add_change_id_list (long al_source_id, integer ai_source_ind)
public subroutine of_update_resource ()
public function integer wf_init_treeview ()
public function integer wf_populate_tv_from_dw (long al_handle, ref str_tv_item astr_tv_item)
public function integer wf_add_dd_parameters ()
public function integer wf_drop_to_target (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target)
public function integer wf_drop_to_delete (long al_source_handle, ref str_tv_item astr_tv_item_source)
public function integer wf_get_parent_tv_items (long al_handle, ref string as_key_col[], ref long al_key_val[])
public function long wf_cascade_delete (long al_handle)
public function integer wf_cascade_popuplate (long al_parent_handle, long al_parent_id)
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

public function boolean of_is_id_in_the_list (long al_source_id, integer ai_source_ind);integer li_i
/*if ai_source_ind = 0 then // add to chapter list
	for li_i = 1 to upperbound(il_chapter_id_list)
		if al_source_id = il_chapter_id_list[li_i] then return true
	next
else
	for li_i = 1 to upperbound(il_content_id_list)
		if al_source_id = il_content_id_list[li_i] then return true
	next
end if*/
return false
end function

public subroutine of_add_change_id_list (long al_source_id, integer ai_source_ind);integer li_i
/*boolean lb_found = false
if ai_source_ind = 0 then // add to chapter list
	for li_i = 1 to upperbound(il_chapter_id_list)
		if al_source_id = il_chapter_id_list[li_i] then
			lb_found = true
			exit
		end if
	next
	if not lb_found then
		il_chapter_id_list[upperbound(il_chapter_id_list) + 1] = al_source_id
	end if
else
	for li_i = 1 to upperbound(il_content_id_list)
		if al_source_id = il_content_id_list[li_i] then
			lb_found = true
			exit
		end if
	next
	if not lb_found then
		il_content_id_list[upperbound(il_content_id_list) + 1] = al_source_id
	end if	
end if*/
end subroutine

public subroutine of_update_resource ();integer li_i, li_count
/*string ls_pre_sub_desc, ls_cur_sub_desc, ls_chapter_desc, ls_bitmap_file, ls_wave_file
string ls_pre_path, ls_cur_path
if upperbound(istr_pre_chapter) > 0 or upperbound(istr_pre_content) > 0 then
	for li_i = 1 to upperbound(istr_pre_chapter)
		if istr_pre_chapter[li_i].cur_parent_id <> istr_pre_chapter[li_i].pre_parent_id then
			// 1. move chapter resource directory
			ls_bitmap_file = istr_pre_chapter[li_i].bitmap_file
			ls_pre_path = gn_appman.is_bitmap_path + istr_pre_chapter[li_i].pre_parent_description + "\" + istr_pre_chapter[li_i].description
			ls_cur_path = gn_appman.is_bitmap_path + istr_pre_chapter[li_i].cur_parent_description + "\" + istr_pre_chapter[li_i].description
			MoveFileA (ls_pre_path, ls_cur_path)
			if isnull(ls_bitmap_file) then ls_bitmap_file = ""
			if ls_bitmap_file <> "" and ls_bitmap_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_bitmap_path + istr_pre_chapter[li_i].pre_parent_description + "\" +ls_bitmap_file
				ls_cur_path = gn_appman.is_bitmap_path + istr_pre_chapter[li_i].cur_parent_description + "\" +ls_bitmap_file
				fnCopyFile(ls_pre_path, ls_cur_path, 0)
			end if
			ls_pre_path = gn_appman.is_wavefile_path + istr_pre_chapter[li_i].pre_parent_description + "\"  + istr_pre_chapter[li_i].description
			ls_cur_path = gn_appman.is_wavefile_path + istr_pre_chapter[li_i].cur_parent_description + "\"  + istr_pre_chapter[li_i].description
			MoveFileA (ls_pre_path, ls_cur_path)
			ls_wave_file = istr_pre_chapter[li_i].wave_file
			if isnull(ls_wave_file) then ls_wave_file = ""
			if ls_wave_file <> "" and ls_wave_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_wavefile_path + istr_pre_chapter[li_i].pre_parent_description + "\" + ls_wave_file
				ls_cur_path = gn_appman.is_wavefile_path + istr_pre_chapter[li_i].cur_parent_description + "\" + ls_wave_file
				fnCopyFile(ls_pre_path, ls_cur_path, 0)
			end if
		end if
	next
	for li_i = 1 to upperbound(istr_pre_content)
		if istr_pre_content[li_i].cur_parent_id <> istr_pre_content[li_i].pre_parent_id then
			select subject.description into :ls_pre_sub_desc
			from chapter, subject
			where chapter.subject_id = subject.subject_id and
					chapter.chapter_id = :istr_pre_content[li_i].pre_parent_id;
			select subject.description into :ls_cur_sub_desc
			from chapter, subject
			where chapter.subject_id = subject.subject_id and
					chapter.chapter_id = :istr_pre_content[li_i].cur_parent_id;
			ls_bitmap_file = istr_pre_content[li_i].bitmap_file
			if isnull(ls_bitmap_file) then ls_bitmap_file = ""
			if ls_bitmap_file <> "" and ls_bitmap_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_bitmap_path + ls_pre_sub_desc + "\" + istr_pre_content[li_i].pre_parent_description + "\" + ls_bitmap_file
				ls_cur_path = gn_appman.is_bitmap_path + ls_cur_sub_desc + "\" + istr_pre_content[li_i].cur_parent_description + "\" + ls_bitmap_file
				fnCopyFile (ls_pre_path, ls_cur_path, 0)
			end if
			ls_wave_file = istr_pre_content[li_i].wave_file
			if isnull(ls_wave_file) then ls_wave_file = ""
			if ls_wave_file <> "" and ls_wave_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_wavefile_path + ls_pre_sub_desc + "\" + istr_pre_content[li_i].pre_parent_description + "\" + ls_wave_file
				ls_cur_path = gn_appman.is_wavefile_path + ls_cur_sub_desc + "\" + istr_pre_content[li_i].cur_parent_description + "\" + ls_wave_file
//MessageBox(ls_pre_path, ls_cur_path)
				fnCopyFile (ls_pre_path, ls_cur_path, 0)
			end if
		end if
	next
	// clean up moved resource
	for li_i = 1 to upperbound(istr_pre_chapter)
		if istr_pre_chapter[li_i].cur_parent_id <> istr_pre_chapter[li_i].pre_parent_id then
			ls_bitmap_file = istr_pre_chapter[li_i].bitmap_file
			if isnull(ls_bitmap_file) then ls_bitmap_file = ""
			if ls_bitmap_file <> "" and ls_bitmap_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_bitmap_path + istr_pre_chapter[li_i].pre_parent_description + "\" + ls_bitmap_file
				select count(*) into :li_count
				from chapter
				where bitmap_file = :ls_bitmap_file and subject_id = :istr_pre_chapter[li_i].pre_parent_id;
				if li_count = 0 then	fnDeleteFile(ls_pre_path)
			end if
			ls_wave_file = istr_pre_chapter[li_i].wave_file
			if isnull(ls_wave_file) then ls_wave_file = ""
			if ls_wave_file <> "" and ls_wave_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_wavefile_path + istr_pre_chapter[li_i].pre_parent_description + "\" + ls_wave_file
				select count(*) into :li_count
				from chapter
				where wave_file = :ls_wave_file and subject_id = :istr_pre_chapter[li_i].pre_parent_id;
				if li_count = 0 then	fnDeleteFile(ls_pre_path)
			end if
		end if
	next
	for li_i = 1 to upperbound(istr_pre_content)
		if istr_pre_content[li_i].cur_parent_id <> istr_pre_content[li_i].pre_parent_id then
			select subject.description into :ls_pre_sub_desc
			from subject, chapter
			where subject.subject_id = chapter.subject_id and
					chapter.chapter_id = :istr_pre_content[li_i].pre_parent_id;
			ls_bitmap_file = istr_pre_content[li_i].bitmap_file
			if isnull(ls_bitmap_file) then ls_bitmap_file = ""
			if ls_bitmap_file <> "" and ls_wave_file <> "DICTIONARY" then // move resource file 			
				ls_pre_path = gn_appman.is_bitmap_path + ls_pre_sub_desc + "\" + istr_pre_content[li_i].pre_parent_description + "\" + ls_bitmap_file
				select count(*) into :li_count
				from content
				where bitmap_file = :ls_bitmap_file and chapter_id = :istr_pre_content[li_i].pre_parent_id;
				if li_count = 0 then	fnDeleteFile(ls_pre_path)
			end if
			ls_wave_file = istr_pre_content[li_i].wave_file
			if isnull(ls_wave_file) then ls_wave_file = ""
			if ls_wave_file <> "" and ls_wave_file <> "DICTIONARY" then // move resource file 
				ls_pre_path = gn_appman.is_wavefile_path + ls_pre_sub_desc + "\" + istr_pre_content[li_i].pre_parent_description + "\" + ls_wave_file
				select count(*) into :li_count
				from content
				where wave_file = :ls_wave_file and chapter_id = :istr_pre_content[li_i].pre_parent_id;
				if li_count = 0 then	fnDeleteFile(ls_pre_path)
			end if
		end if
	next
end if*/
end subroutine

public function integer wf_init_treeview ();string ls_filter

wf_add_dd_parameters()

ids_sys_treeview.data_retrieve()
//ls_filter = "parent_id = 0"
//ids_sys_treeview.SetFilter(ls_filter)
//ids_sys_treeview.Filter()
//ids_sys_treeview.SetSort("sort_seq A")
//ids_sys_treeview.Sort()

wf_populate_tv_from_sys_table(0)

//long ll_row, ll_rowcount
//long ll_parent_handle
//ll_rowcount = ids_sys_treeview.RowCount()
//treeviewitem ltvi_new 
//ltvi_new.children = false
//ltvi_new.PictureIndex = 1
//ltvi_new.SelectedPictureIndex = 2
//for ll_row = 1 to ll_rowcount
//	istr_tv_item.data_id = 0
//	istr_tv_item.description = ids_sys_treeview.GetItemString(ll_row, "description")
//	istr_tv_item.subtree_update_ind = ids_sys_treeview.GetItemString(ll_row, "subtree_update_ind")
//	istr_tv_item.subtree_dw = ids_sys_treeview.GetItemString(ll_row, "subtree_dw")
//	istr_tv_item.subtree_des_col = ids_sys_treeview.GetItemString(ll_row, "subtree_des_col")
//	ltvi_new.label = istr_tv_item.description
//	ltvi_new.data = istr_tv_item	
//	ltvi_new.label = ids_sys_treeview.GetItemString(ll_row, "description")
//	ll_parent_handle = tv_1.InsertItemLast(0, ltvi_new)
//next
//if ll_rowcount > 0 then
////	tv_1.GetItem(al_parent_handle, itvi_tmp)
////	itvi_tmp.children = true
////	tv_1.SetItem(al_parent_handle, itvi_tmp)
//end if

return 1
end function

public function integer wf_populate_tv_from_dw (long al_handle, ref str_tv_item astr_tv_item);// determine if datastore has been initiated
integer li_i
boolean ib_is_ds_available = false
string ls_filter, ls_item_description
nvo_datastore lds_tv_item
str_tv_item lstr_tv_item
lstr_tv_item = astr_tv_item
for li_i = 1 to upperbound(ids_treeview_item)
	if lower(trim(astr_tv_item.dw_name)) = lower(ids_treeview_item[li_i].dataobject) then
		ib_is_ds_available = true
		lds_tv_item = ids_treeview_item[li_i]
		lstr_tv_item.dw_index = li_i
		lstr_tv_item.dd_handle = lds_tv_item
		exit
	end if
next
if not ib_is_ds_available then 
	MessageBox("Error in wf_populate_tv_from_dw ", astr_tv_item.dw_name + ": datastore not found")	
	return 0
end if
lds_tv_item.SetFilter("")
lds_tv_item.Filter()
if lds_tv_item.RowCount() = 0 then // if the datastore has not been retrieve, then retrieve it
	
	lds_tv_item.data_retrieve()
end if
//MessageBox("lds_tv_item.RowCount()", lds_tv_item.RowCount())
//MessageBox(lds_tv_item.dataobject + " astr_tv_item.data_id", astr_tv_item.data_id)

if astr_tv_item.data_id > 0 then
	ls_filter = astr_tv_item.dd_handle.is_unique_col[1] + " = " + string(astr_tv_item.data_id)
//	MessageBox("ls_filter", ls_filter)
	lds_tv_item.SetFilter(ls_filter)
	lds_tv_item.Filter()
end if
long ll_row, ll_rowcount
long ll_parent_handle
treeviewitem ltvi_new 
ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_row = 1 to lds_tv_item.RowCount()
	lstr_tv_item.data_id = lds_tv_item.GetItemNumber(ll_row, lds_tv_item.is_unique_col[1])
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
return 1
end function

public function integer wf_add_dd_parameters ();string ls_sql_statement

ids_sys_treeview.is_update_col = {"parent_id", "description", "update_ind","dw_name","sender_dw","note","sort_seq"}
ids_sys_treeview.is_key_col[] = {"tv_group_id", "treeview_id"}
ids_sys_treeview.is_database_table = "Treeview"
ids_sys_treeview.is_select_sql = "Select * From Treeview where tv_group_id eq " + string(gn_appman.il_tv_group_id) + " And Status eq 'A'"
ids_sys_treeview.is_where_col[1] = "tv_group_id"
ids_sys_treeview.ia_where_value[1] = gn_appman.il_tv_group_id
ids_sys_treeview.is_where_col[2] = "Status"
ids_sys_treeview.ia_where_value[2] = 'A'

ids_account.is_database_table = "Account"
if gn_appman.il_account_id = 1 then
	ids_account.is_select_sql = "select Name, ID as account_id From Account Order By Name"
else
	ids_account.is_select_sql = "select Name, ID as account_id From Account Where ID eq " + string(gn_appman.il_account_id)
end if
ids_account.is_where_col[1] = "account_id"
ids_account.ia_where_value[1] = gn_appman.il_account_id
ids_account.is_unique_col[1] = "account_id"
ids_account.is_desc_col = {"Name"}
ids_account.is_header = "Account: "

ids_student.is_database_table = "Student"
ids_student.is_where_col[1] = "account_id"
ids_student.ia_where_value[1] = gn_appman.il_account_id
ids_student.is_unique_col[1] = "student_id"
ids_student.is_desc_col = {"last_name", "first_name"}
ids_student.is_seperator = ", "

ids_group.is_database_table = "StudentGroup"
ids_group.is_where_col[1] = "account_id"
ids_group.ia_where_value[1] = gn_appman.il_account_id
ids_group.is_unique_col[1] = "group_id"
ids_group.is_desc_col = {"group_name"}

ids_group_student.is_database_table = "GroupStudent"
ids_group_student.is_select_sql = "Select g.account_id as account_id, g.group_id as group_id, g.student_id as student_id, " + &
											"s.last_name as last_name, s.first_name as first_name from GroupStudent As g left " + &
											"outer join Student As s on g.account_id eq s.account_id and " + &
											"g.student_id eq s.student_id where g.account_id eq " + string(gn_appman.il_account_id)
ids_group_student.is_key_col[] = {"account_id", "group_id", "student_id"}
ids_group_student.is_where_col[1] = "account_id"
ids_group_student.ia_where_value[1] = gn_appman.il_account_id
ids_group_student.is_unique_col[1] = "student_id"
ids_group_student.is_desc_col = {"last_name","first_name"}
ids_group_student.is_seperator = ", "
ids_group_student.is_constant_col[1] = "account_id"
ids_group_student.ia_constant_val[1] = gn_appman.il_account_id

ids_student_lesson.is_database_table = "StudentLesson"
ids_student_lesson.is_select_sql = "Select sl.account_id as account_id, sl.student_id as student_id, l.lesson_id as lesson_id, " + &
											"l.lesson_name as lesson_name from StudentLesson As sl left " + &
											"outer join Lesson As l on sl.account_id eq l.account_id and " + &
											"sl.lesson_id eq l.lesson_id where sl.account_id eq " + string(gn_appman.il_account_id)
ids_student_lesson.is_key_col[] = {"account_id", "student_id", "lesson_id"}
ids_student_lesson.is_where_col[1] = "account_id"
ids_student_lesson.ia_where_value[1] = gn_appman.il_account_id
ids_student_lesson.is_unique_col[1] = "lesson_id"
ids_student_lesson.is_desc_col = {"lesson_name"}
ids_student_lesson.is_constant_col[1] = "account_id"
ids_student_lesson.ia_constant_val[1] = gn_appman.il_account_id

ids_lesson_type.is_database_table = "Method"
ids_lesson_type.is_select_sql = "Select l.account_id as account_id, m.method_cat_id as method_cat_id, m.method_cat_desc as method_name " + &
						" From Method as m, Lesson as l Where m.method_id eq l.method_id and " + &
						"l.account_id eq " + string(gn_appman.il_account_id) + " Group By m.method_cat_id"
ids_lesson_type.is_key_col[] = {"account_id", "method_cat_id", "lesson_id"}
ids_lesson_type.is_where_col[1] = "account_id"
ids_lesson_type.ia_where_value[1] = gn_appman.il_account_id
ids_lesson_type.is_unique_col[1] = "method_cat_id"
ids_lesson_type.is_desc_col = {"method_name"}
ids_lesson_type.is_constant_col[1] = "account_id"
ids_lesson_type.ia_constant_val[1] = gn_appman.il_account_id

ids_lesson_list.is_database_table = "Lesson"
ids_lesson_list.is_select_sql = "Select account_id, m.method_cat_id as method_cat_id, lesson_id, lesson_name " + &
						" From Lesson As l, Method as m Where l.method_id eq m.method_id and account_id eq " + string(gn_appman.il_account_id)
ids_lesson_list.is_where_col[1] = "account_id"
ids_lesson_list.ia_where_value[1] = gn_appman.il_account_id
ids_lesson_list.is_unique_col[1] = "lesson_id"
ids_lesson_list.is_desc_col = {"lesson_name"}
ids_lesson_list.is_constant_col[1] = "account_id"
ids_lesson_list.ia_constant_val[1] = gn_appman.il_account_id
//MessageBox("ids_lesson_type.is_select_sql", ids_lesson_type.is_select_sql)

ids_response_to_right.is_database_table = "ResponseTR"
ids_response_to_right.is_where_col[1] = "account_id"
ids_response_to_right.ia_where_value[1] = gn_appman.il_account_id
ids_response_to_right.is_unique_col[1] = "response_id"
ids_response_to_right.is_desc_col = {"wave_file"}

ids_response_to_wrong.is_database_table = "ResponseTW"
ids_response_to_wrong.is_where_col[1] = "account_id"
ids_response_to_wrong.ia_where_value[1] = gn_appman.il_account_id
ids_response_to_wrong.is_unique_col[1] = "response_id"
ids_response_to_wrong.is_desc_col = {"wave_file"}

ids_student_RTR.is_database_table = "StudentRTR"
ids_student_RTR.is_select_sql = "Select srtr.account_id as account_id, srtr.student_id as student_id, srtr.response_id as response_id, " + &
											"rtr.wave_file as wave_file from StudentRTR As srtr, ResponseTR as rtr " + &
											"where srtr.account_id eq rtr.account_id and " + &
											"srtr.response_id eq rtr.response_id and srtr.account_id eq " + string(gn_appman.il_account_id)
ids_student_RTR.is_key_col[] = {"account_id", "student_id", "response_id"}
ids_student_RTR.is_where_col[1] = "account_id"
ids_student_RTR.ia_where_value[1] = gn_appman.il_account_id
ids_student_RTR.is_unique_col[1] = "response_id"
ids_student_RTR.is_desc_col = {"wave_file"}
ids_student_RTR.is_constant_col[1] = "account_id"
ids_student_RTR.ia_constant_val[1] = gn_appman.il_account_id

ids_student_RTW.is_database_table = "StudentRTW"
ids_student_RTW.is_select_sql = "Select srtw.account_id as account_id, srtw.student_id as student_id, srtw.response_id as response_id, " + &
											"rtw.wave_file as wave_file from StudentRTW As srtw, ResponseTW as rtw " + &
											"where srtw.account_id eq rtw.account_id and " + &
											"srtw.response_id eq rtw.response_id and srtw.account_id eq " + string(gn_appman.il_account_id)
ids_student_RTW.is_key_col[] = {"account_id", "student_id", "response_id"}
ids_student_RTW.is_where_col[1] = "account_id"
ids_student_RTW.ia_where_value[1] = gn_appman.il_account_id
ids_student_RTW.is_unique_col[1] = "response_id"
ids_student_RTW.is_desc_col = {"wave_file"}
ids_student_RTW.is_constant_col[1] = "account_id"
ids_student_RTW.ia_constant_val[1] = gn_appman.il_account_id

ids_report.is_database_table = "Progress_data"
ids_report.is_select_sql = "Select account_id, student_id, lesson_id, begin_date, end_date, begin_date as begin_date_t, end_date as end_date_t  " + &
									"from  Progress_data " + &
									"where account_id eq " + string(gn_appman.il_account_id) + " and " + &
									" student_id eq " + string(gn_appman.il_student_id)
ids_report.is_unique_col[1] = "lesson_id"
ids_report.is_desc_col = {"begin_date_t", "end_date_t"}
ids_report.is_seperator = "To "

return 1
end function

public function integer wf_drop_to_target (long al_source_handle, long al_target_handle, ref str_tv_item astr_tv_item_source, ref str_tv_item astr_tv_item_target);// check if the target tvitem has the children with target datawindow
long ll_i, ll_row, ll_rowcount, ll_source_row, ll_target_row, ll_parent_key_val[]
long ll_parent_handle, ll_treeview_id
boolean lb_found = false
string ls_filter, ls_dw_name, ls_sender_dw, ls_target_update_ind, ls_expression, ls_parent_key_col[]
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
ls_expression = lds_source.is_unique_col[1] + " = " + string(astr_tv_item_source.data_id)
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
	if len(ls_expression) > 0 then ls_expression = ls_expression + " and "
	ls_expression = ls_expression + lds_source.is_unique_col[1] + "=" + string(astr_tv_item_source.data_id)	
	if lds_target.Find(ls_expression, 1, lds_target.RowCount()) > 0 then
		return 0
	end if
	ll_row = lds_target.InsertRow(0)
	if ll_row = -1 then
		MessageBox("Insert Failed", lds_target.dataobject)
		return 0
	end if
	lds_target.SetItem(ll_row, lds_source.is_unique_col[1], astr_tv_item_source.data_id)
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
ll_child_handle = tv_1.FindItem(ChildTreeitem!, al_source_handle)
if ll_child_handle <> -1 then
	wf_cascade_delete(ll_child_handle)
end if	
//MessageBox("wf_drop_to_delete", "A")
wf_get_parent_tv_items(al_source_handle, ls_parent_key_col, ll_parent_key_val)
lds_source.SetFilter("")
lds_source.Filter()
ls_expression = ""
//MessageBox("dataobject", lds_source.dataobject)
//MessageBox("rowcount", lds_source.rowcount())
for ll_i = 1 to upperbound(ls_parent_key_col)
//		if not isnull(ls_parent_key_col[ll_i]) then MessageBox(string(ll_i),ls_parent_key_col[ll_i])
//	MessageBox(string(ll_i),ls_parent_key_col[ll_i])
	if not isnull(lds_source.GetItemNumber(1, ls_parent_key_col[ll_i])) then
		ls_expression = ls_expression + ls_parent_key_col[ll_i] + "=" + string(ll_parent_key_val[ll_i]) + " and "
	end if
next
//MessageBox("wf_drop_to_delete", "B")
if len(ls_expression) > 0 then
	ls_expression = ls_expression + lds_source.is_unique_col[1] + " = " + string(astr_tv_item_source.data_id)
else
	ls_expression = lds_source.is_unique_col[1] + " = " + string(astr_tv_item_source.data_id)
end if
//if isnull(ls_expression) then
//	MessageBox("ls_expression", "IS NULL")
//end if
ll_source_row = lds_source.find(ls_expression, 1, lds_source.RowCount())	
//MessageBox(ls_expression, ll_source_row)
lds_source.DeleteRow(ll_source_row)
//	MessageBox("deletedcount", lds_source.DeletedCount())

tv_1.DeleteItem(al_source_handle)

return 1
end function

public function integer wf_get_parent_tv_items (long al_handle, ref string as_key_col[], ref long al_key_val[]);long ll_handle_tmp
treeviewitem ltvi_tmp
str_tv_item lstr_tv_item

ll_handle_tmp = al_handle
do 
	tv_1.GetItem(ll_handle_tmp, ltvi_tmp)
	lstr_tv_item = ltvi_tmp.data
	if isvalid(lstr_tv_item.dd_handle) then
		if upperbound(lstr_tv_item.dd_handle.is_unique_col) > 0 then
			as_key_col[upperbound(as_key_col) + 1] = lstr_tv_item.dd_handle.is_unique_col[1]
			al_key_val[upperbound(al_key_val) + 1] = lstr_tv_item.data_id
		end if
	end if
	ll_handle_tmp = tv_1.FindItem(ParentTreeItem!, ll_handle_tmp)
loop while ll_handle_tmp <> -1 

return 1
end function

public function long wf_cascade_delete (long al_handle);long ll_handle_tmp, ll_row, ll_parent_handle
long ll_parent_key_val[], ll_child_handle, ll_i
string ls_expression, ls_parent_key_col[]
treeviewitem ltvi_tmp, ltvi_current
str_tv_item lstr_tv_item, lstr_tv_item_current
tv_1.GetItem(al_handle, ltvi_current)
tv_1.SelectItem(al_handle)
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
	ll_child_handle = tv_1.FindItem(ChildTreeItem!, ll_handle_tmp)
	if ll_child_handle <> -1 then
		wf_cascade_delete(ll_child_handle)
	end if
	ll_handle_tmp = tv_1.FindItem(NextTreeItem!, ll_handle_tmp)
loop while ll_handle_tmp <> -1  

ls_expression = ""
ll_parent_handle = tv_1.FindItem(ParentTreeItem!, al_handle)
wf_get_parent_tv_items(ll_parent_handle, ls_parent_key_col, ll_parent_key_val)
tv_1.GetItem(al_handle, ltvi_tmp)
lstr_tv_item = ltvi_tmp.data
if trim(lstr_tv_item.dw_name) <> "" and isvalid(lstr_tv_item.dd_handle) then
//	MessageBox("dataobject 0", lstr_tv_item.dd_handle.dataobject)
	for ll_i = 1 to upperbound(ls_parent_key_col)
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
	ll_handle_tmp = tv_1.FindItem(NextTreeItem!, al_handle)
	if ll_handle_tmp <> -1 then
		tv_1.GetItem(ll_handle_tmp, ltvi_tmp)
//		MessageBox("delete tv item", ltvi_tmp.label)
		tv_1.DeleteItem(ll_handle_tmp)
	end if
loop while ll_handle_tmp <> -1 
tv_1.GetItem(al_handle, ltvi_tmp)
//	MessageBox("delete tv item", ltvi_tmp.label)
tv_1.DeleteItem(al_handle)
return 1
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

public function integer wf_populate_tv_from_sys_table (long al_handle);//string ls_filter
//str_tv_item lstr_tv_item
//
//long ll_row
//long ll_parent_handle, ll_parent_tmp, ll_handle[], ll_treeview_id[]
//treeviewitem ltvi_new 
//nvo_datastore lds_sys_treeview
//
//ids_sys_treeview.data_retrieve()
//ls_filter = "parent_id = " + string(al_parent_id)
//ids_sys_treeview.SetFilter(ls_filter)
//ids_sys_treeview.Filter()
//ids_sys_treeview.SetSort("sort_seq A")
//ids_sys_treeview.Sort()
//
//lds_sys_treeview = create nvo_datastore
//lds_sys_treeview.dataobject = "d_sys_treeview_table"
//ids_sys_treeview.RowsCopy(1, lds_sys_treeview.RowCount(), Primary!, lds_sys_treeview, 1, Primary!)
//
//
//ltvi_new.children = false
//ltvi_new.PictureIndex = 1
//ltvi_new.SelectedPictureIndex = 2
//for ll_row = 1 to ids_sys_treeview.RowCount()
//	lstr_tv_item.treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
//	lstr_tv_item.description = ids_sys_treeview.GetItemString(ll_row, "description")
//	lstr_tv_item.tv_schem_desc = ids_sys_treeview.GetItemString(ll_row, "description")	
//	lstr_tv_item.update_ind = ids_sys_treeview.GetItemString(ll_row, "update_ind")
//	lstr_tv_item.dw_name = ids_sys_treeview.GetItemString(ll_row, "dw_name")
//	lstr_tv_item.data_id = 0
//	ltvi_new.label = lstr_tv_item.description
//	ltvi_new.data = lstr_tv_item	
//	ltvi_new.label = ids_sys_treeview.GetItemString(ll_row, "description")
//	ll_parent_handle = tv_1.InsertItemLast(al_handle, ltvi_new)
//	ll_handle[ll_row] = ll_parent_handle
//	ll_treeview_id[ll_row] = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
//next
//tv_1.ExpandAll(al_handle)
////for ll_row = 1 to upperbound(ll_handle)
////	wf_cascade_popuplate(ll_handle[ll_row], ll_treeview_id[ll_row])		
////next
//destroy lds_sys_treeview
//return 1
//

string ls_filter, ls_dw_name
str_tv_item lstr_tv_item
long ll_row, ll_rowcount
long ll_parent_handle
treeviewitem ltvi_tmp, ltvi_new 
if al_handle <> 0 then
	tv_1.GetItem(al_handle, ltvi_tmp)
	lstr_tv_item = ltvi_tmp.data
	ls_filter = "parent_id = " + string(lstr_tv_item.treeview_id)
else
	if ltvi_tmp.ExpandedOnce then return 0
	ls_filter = "parent_id = 0"	
end if

ids_sys_treeview.SetFilter("")
ids_sys_treeview.Filter()
ids_sys_treeview.SetFilter(ls_filter)
ids_sys_treeview.Filter()
ids_sys_treeview.SetSort("sort_seq A")
ids_sys_treeview.Sort()

ll_rowcount = ids_sys_treeview.RowCount()

for ll_row = 1 to ll_rowcount
	ls_dw_name = ids_sys_treeview.GetItemString(ll_row, "dw_name")
	if isnull(ls_dw_name) then
		ls_dw_name = ""
	else
		trim(ls_dw_name)
	end if
	lstr_tv_item.dw_name = ls_dw_name
	lstr_tv_item.tv_schem_desc = ids_sys_treeview.GetItemString(ll_row, "description")
	lstr_tv_item.update_ind = ids_sys_treeview.GetItemString(ll_row, "update_ind")
	lstr_tv_item.description = ids_sys_treeview.GetItemString(ll_row, "description")
	lstr_tv_item.treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
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

on w_explorer.create
int iCurrent
call super::create
this.cb_open=create cb_open
this.p_delete=create p_delete
this.tv_1=create tv_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_open
this.Control[iCurrent+2]=this.p_delete
this.Control[iCurrent+3]=this.tv_1
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancel
end on

on w_explorer.destroy
call super::destroy
destroy(this.cb_open)
destroy(this.p_delete)
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

event open;call super::open;string ls_sub_desc, ls_chapter_desc, ls_bitmap_file, ls_wave_file

ids_student = create nvo_datastore
ids_student.dataobject = "d_student"
ids_group = create nvo_datastore
ids_group.dataobject = "d_group"
ids_lesson_type = create nvo_datastore
ids_lesson_type.dataobject = "d_lesson_type"
ids_lesson_list = create nvo_datastore
ids_lesson_list.dataobject = "d_lesson_list"
ids_group_student = create nvo_datastore
ids_group_student.dataobject = "d_group_student"
ids_student_lesson = create nvo_datastore
ids_student_lesson.dataobject = "d_student_lesson"
ids_report = create nvo_datastore
ids_report.dataobject = "d_progress_report"
ids_student_RTR = create nvo_datastore
ids_student_RTR.dataobject = "d_student_rtr"
ids_student_RTW = create nvo_datastore
ids_student_RTW.dataobject = "d_student_rtw"
ids_response_to_right = create nvo_datastore
ids_response_to_right.dataobject = "d_responsetr"
ids_response_to_wrong = create nvo_datastore
ids_response_to_wrong.dataobject = "d_responsetw"
ids_account = create nvo_datastore
ids_account.dataobject = "d_account"
ids_treeview_item = {ids_account,ids_student,ids_group,ids_group_student,ids_lesson_type,ids_lesson_list,ids_student_lesson,ids_report,ids_student_RTR,ids_student_RTW,ids_response_to_right,ids_response_to_wrong}

ids_sys_treeview = create nvo_datastore
ids_sys_treeview.dataobject = "d_treeview_sys_table"

wf_init_treeview()
end event

type cb_open from u_commandbutton within w_explorer
integer x = 471
integer y = 1736
integer taborder = 60
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Open"
end type

event clicked;call super::clicked;long ll_i
//for ll_i = 1 to upperbound(ids_treeview_item)
//	if ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 then
//		ids_treeview_item[ll_i].save()
//	end if
//next
end event

type p_delete from picture within w_explorer
integer x = 41
integer y = 1716
integer width = 261
integer height = 244
string picturename = "./delete.gif"
boolean focusrectangle = false
end type

event dragdrop;long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle
treeviewitem ltvi_target, ltvi_source, ltvi_child
str_tv_item lstr_tv_item_source, lstr_tv_item_target
if source.TypeOf() = TreeView! then
	ll_source_handle = tv_1.FindItem(CurrentTreeItem! ,0)
	if tv_1.GetItem(ll_source_handle, ltvi_source) = -1 then return
	lstr_tv_item_source = ltvi_source.data
	tv_1.SetRedraw(false)
	wf_cascade_popuplate(ll_source_handle, lstr_tv_item_source.treeview_id)		
	wf_drop_to_delete(ll_source_handle, lstr_tv_item_source)
	tv_1.SetRedraw(true)
end if
drag(End!)
end event

type tv_1 from treeview within w_explorer
integer x = 41
integer y = 44
integer width = 1847
integer height = 1652
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

event dragdrop;long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle
treeviewitem ltvi_target, ltvi_source, ltvi_child
str_tv_item lstr_tv_item_source, lstr_tv_item_target
ll_target_handle = handle
if source.TypeOf() = TreeView! then
	ll_source_handle = tv_1.FindItem(CurrentTreeItem! ,0)
	if tv_1.GetItem(ll_source_handle, ltvi_source) = -1 then return
	if tv_1.GetItem(ll_target_handle, ltvi_target) = -1 then return
	lstr_tv_item_source = ltvi_source.data
	lstr_tv_item_target = ltvi_target.data
	wf_drop_to_target(ll_source_handle, ll_target_handle, lstr_tv_item_source, lstr_tv_item_target)
end if
drag(End!)
end event

event selectionchanged;
treeviewitem ltvi_tmp

GetItem(newhandle, ltvi_tmp)
end event

event clicked;wf_populate_tv_from_sys_table(handle)

//string ls_filter, ls_dw_name
//str_tv_item lstr_tv_item
//long ll_row, ll_rowcount
//long ll_parent_handle
//treeviewitem ltvi_tmp, ltvi_new 
//GetItem(handle, ltvi_tmp)
//lstr_tv_item = ltvi_tmp.data
//
////wf_cascade_popuplate(handle, lstr_tv_item.treeview_id)		
////return
//
//if ltvi_tmp.ExpandedOnce then return
////if lstr_tv_item.tv_schem_desc <> "Student" and lstr_tv_item.tv_schem_desc <> "Group" and lstr_tv_item.tv_schem_desc <> "Groups" then return
//ls_filter = "parent_id = " + string(lstr_tv_item.treeview_id)
//ids_sys_treeview.SetFilter("")
//ids_sys_treeview.Filter()
//ids_sys_treeview.SetFilter(ls_filter)
//ids_sys_treeview.Filter()
//ids_sys_treeview.SetSort("sort_seq A")
//ids_sys_treeview.Sort()
//
//ll_rowcount = ids_sys_treeview.RowCount()
//
//for ll_row = 1 to ll_rowcount
//	ls_dw_name = ids_sys_treeview.GetItemString(ll_row, "dw_name")
//	if isnull(ls_dw_name) then
//		ls_dw_name = ""
//	else
//		trim(ls_dw_name)
//	end if
//	lstr_tv_item.dw_name = ls_dw_name
//	lstr_tv_item.tv_schem_desc = ids_sys_treeview.GetItemString(ll_row, "description")
//	lstr_tv_item.update_ind = ids_sys_treeview.GetItemString(ll_row, "update_ind")
//	lstr_tv_item.description = ids_sys_treeview.GetItemString(ll_row, "description")
//	lstr_tv_item.treeview_id = ids_sys_treeview.GetItemNumber(ll_row, "treeview_id")
//	if trim(ls_dw_name) <> "" then
//		lstr_tv_item.sender_dw = ids_sys_treeview.GetItemString(ll_row, "sender_dw")
////		MessageBox(ls_dw_name, lstr_tv_item.sender_dw)
//		wf_populate_tv_from_dw(handle, lstr_tv_item)
//	else
//		lstr_tv_item.sender_dw = ""
//		lstr_tv_item.dw_name = ""
//		ltvi_new.children = false
//		ltvi_new.PictureIndex = 1
//		ltvi_new.SelectedPictureIndex = 2
//		ltvi_new.label = lstr_tv_item.description
//		ltvi_new.data = lstr_tv_item	
//		ltvi_new.label = ids_sys_treeview.GetItemString(ll_row, "description")
//		ll_parent_handle = tv_1.InsertItemLast(handle, ltvi_new)		
//	end if
//next
//ExpandAll(handle)

end event

type cb_ok from u_commandbutton within w_explorer
integer x = 997
integer y = 1736
integer taborder = 50
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Save"
end type

event clicked;call super::clicked;long ll_i
for ll_i = 1 to upperbound(ids_treeview_item)
	if ids_treeview_item[ll_i].ModifiedCount() > 0 or ids_treeview_item[ll_i].DeletedCount() > 0 then
		ids_treeview_item[ll_i].save()
	end if
next
end event

type cb_cancel from u_commandbutton within w_explorer
integer x = 1458
integer y = 1736
integer taborder = 60
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;call super::clicked;long ll_i
boolean lb_unsave_data = false
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
close(parent)
end event

