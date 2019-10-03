$PBExportHeader$w_material_merge.srw
forward
global type w_material_merge from w_sheet
end type
type tv_1 from treeview within w_material_merge
end type
type cb_ok from u_commandbutton within w_material_merge
end type
type cb_cancel from u_commandbutton within w_material_merge
end type
type str_tv_item from structure within w_material_merge
end type
type str_resource_moving from structure within w_material_merge
end type
end forward

type str_tv_item from structure
	long		data_id
	string		description
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

global type w_material_merge from w_sheet
integer width = 1961
integer height = 1984
string title = "Material Merging"
long backcolor = 15780518
tv_1 tv_1
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_material_merge w_material_merge

type variables
private:
str_tv_item istr_tv_item
str_resource_moving istr_pre_chapter[], istr_pre_content[]
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
end variables

forward prototypes
public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level)
public function boolean of_is_id_in_the_list (long al_source_id, integer ai_source_ind)
public subroutine of_add_change_id_list (long al_source_id, integer ai_source_ind)
public subroutine of_update_resource ()
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

on w_material_merge.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_material_merge.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event close;call super::close;if isvalid(ids_tv_data) then
	destroy ids_tv_data
end if
end event

event open;call super::open;string ls_sub_desc, ls_chapter_desc, ls_bitmap_file, ls_wave_file
/*is_pres_type = Message.StringParm
if is_pres_type = "Reading" then	
	is_column_id_name = {"subject_id", "chapter_id"}
	is_column_des_name = {"description", "description"} 
	is_dwobject_name = {"d_subject_for_make_lesson", "d_chapter"}
else
	is_column_id_name = {"subject_id", "chapter_id", "content_id"}
	is_column_des_name = {"description", "description", "description"} 
	is_dwobject_name = {"d_subject_for_make_lesson", "d_chapter", "d_content"}	
end if
tv_1.SetReDraw(false)
wf_make_tv_multiple_dw(0, is_pres_type, 1)
tv_1.SetReDraw(true)
*/
end event

type tv_1 from treeview within w_material_merge
integer x = 46
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
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 553648127
end type

event dragdrop;call super::dragdrop;long ll_source_handle, ll_target_handle, ll_parent_handle, ll_child_handle, ll_source_parent_handle
/*treeviewitem ltvi_target, ltvi_source, ltvi_child
ll_target_handle = handle
if source.TypeOf() = TreeView! then
	ll_source_handle = tv_1.FindItem(CurrentTreeItem! ,0)
	if tv_1.GetItem(ll_source_handle, ltvi_source) = -1 then return
	if tv_1.GetItem(ll_target_handle, ltvi_target) = -1 then return
	if (ltvi_source.level - ltvi_target.level) = 1 then // source is one level below target
		istr_tv_item = ltvi_source.data
		ll_source_parent_handle = tv_1.FindItem(ParentTreeItem!, ll_source_handle)
		if ll_source_parent_handle = ll_target_handle then return // same parent
		ll_parent_handle = tv_1.InsertItemLast(ll_target_handle, ltvi_source)	// insert the target tv item under
		ltvi_target.children = true
		tv_1.SetItem(ll_target_handle, ltvi_target) // make sure the target has chilren indicator on
		if ltvi_target.level = 1 then // root - subject
			of_add_change_id_list(istr_tv_item.data_id, 0)
			ll_child_handle =  tv_1.FindItem(ChildTreeItem!, ll_source_handle)
			do while ll_child_handle <> -1
				tv_1.GetItem(ll_child_handle, ltvi_child)
				tv_1.InsertItemLast(ll_parent_handle, ltvi_child)
				ll_child_handle = tv_1.FindItem(NextTreeItem!, ll_child_handle)
			loop
		else
			of_add_change_id_list(istr_tv_item.data_id, 1)
		end if
		tv_1.DeleteItem ( ll_source_handle ) // delete source treeview item and it's children
		if tv_1.FindItem(ChildTreeItem!, ll_source_parent_handle) = -1 then // the source parent does not have any children
			tv_1.GetItem(ll_source_parent_handle, ltvi_source)
			ltvi_source.children = false
			tv_1.SetItem(ll_source_parent_handle, ltvi_source) 
		end if
	end if
end if
drag(End!)*/
end event

type cb_ok from u_commandbutton within w_material_merge
integer x = 997
integer y = 1736
integer taborder = 50
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&OK"
end type

event clicked;call super::clicked;long ll_subject_handle,ll_chapter_handle,ll_content_handle,ll_subject_id,ll_chapter_id, ll_content_id
/*long ll_pre_subject_id, ll_pre_chapter_id
string ls_subject_desc, ls_chapter_desc
integer il_tmp_i, li_i
treeviewitem ltvi_subject, ltvi_chapter, ltvi_content
ll_subject_handle = tv_1.FindItem(RootTreeItem! ,0)
if MessageBox("Warning", "You are about to proceed the material moving, do you want to continue?", Question!, YesNo!) = 2 then return
do while ll_subject_handle <> -1
	tv_1.GetItem(ll_subject_handle, ltvi_subject)
	istr_tv_item = ltvi_subject.data
	ll_subject_id = istr_tv_item.data_id
	ls_subject_desc = istr_tv_item.description
//	MessageBox("ls_subject_desc: " + ls_subject_desc, "ll_subject_id: " + string(ll_subject_id))
	ll_chapter_handle = tv_1.FindItem(ChildTreeItem! ,ll_subject_handle)
	do while ll_chapter_handle <> -1
		tv_1.GetItem(ll_chapter_handle, ltvi_chapter)
		istr_tv_item = ltvi_chapter.data
		ll_chapter_id = istr_tv_item.data_id
		ls_chapter_desc = istr_tv_item.description
//		MessageBox("ls_chapter_desc: " + ls_chapter_desc, "ll_chapter_id: " + string(ll_chapter_id))
		if of_is_id_in_the_list(ll_chapter_id, 0) then
			il_tmp_i = upperbound(istr_pre_chapter) + 1			
			istr_pre_chapter[il_tmp_i].data_id = ll_chapter_id
			istr_pre_chapter[il_tmp_i].description = istr_tv_item.description
			istr_pre_chapter[il_tmp_i].cur_parent_id = ll_subject_id
			istr_pre_chapter[il_tmp_i].cur_parent_description = ls_subject_desc
			Select subject.subject_id, subject.description 
			into :istr_pre_chapter[il_tmp_i].pre_parent_id,
					:istr_pre_chapter[il_tmp_i].pre_parent_description
			from subject, chapter 
			where subject.subject_id = chapter.subject_id and 
					chapter.chapter_id = :ll_chapter_id;
			Select wave_file, bitmap_file
			into 	:istr_pre_chapter[il_tmp_i].wave_file,
					:istr_pre_chapter[il_tmp_i].bitmap_file
			from chapter where chapter_id = :ll_chapter_id;
//			MessageBox("istr_pre_chapter[il_tmp_i].description", istr_pre_chapter[il_tmp_i].description)			
//			MessageBox("istr_pre_chapter[il_tmp_i].pre_parent_description", istr_pre_chapter[il_tmp_i].pre_parent_description)			
//			MessageBox("istr_pre_chapter[il_tmp_i].cur_parent_description", istr_pre_chapter[il_tmp_i].cur_parent_description)			
		end if
		ll_content_handle = tv_1.FindItem(ChildTreeItem! ,ll_chapter_handle)
		do while ll_content_handle <> -1
			tv_1.GetItem(ll_content_handle, ltvi_content)
			istr_tv_item = ltvi_content.data
			ll_content_id = istr_tv_item.data_id
			if of_is_id_in_the_list(ll_content_id, 1) then
				il_tmp_i = upperbound(istr_pre_content) + 1
				istr_pre_content[il_tmp_i].data_id = ll_content_id
				istr_pre_content[il_tmp_i].description = istr_tv_item.description
				istr_pre_content[il_tmp_i].cur_parent_id = ll_chapter_id
				istr_pre_content[il_tmp_i].cur_parent_description = ls_chapter_desc
				Select chapter.chapter_id, chapter.description 
				into :istr_pre_content[il_tmp_i].pre_parent_id,
						:istr_pre_content[il_tmp_i].pre_parent_description
				from chapter, content 
				where chapter.chapter_id = content.chapter_id and 
						content.content_id = :ll_content_id;
				Select wave_file, bitmap_file
				into 	:istr_pre_content[il_tmp_i].wave_file,
						:istr_pre_content[il_tmp_i].bitmap_file
				from content where content_id = :ll_content_id;
//			MessageBox("istr_pre_chapter[il_tmp_i].description", istr_pre_content[il_tmp_i].description)			
//			MessageBox("istr_pre_chapter[il_tmp_i].pre_parent_description", istr_pre_content[il_tmp_i].pre_parent_description)			
//			MessageBox("istr_pre_chapter[il_tmp_i].cur_parent_description", istr_pre_content[il_tmp_i].cur_parent_description)			
			end if
			ll_content_handle = tv_1.FindItem(NextTreeItem! ,ll_content_handle)
		loop
		ll_chapter_handle = tv_1.FindItem(NextTreeItem! ,ll_chapter_handle)
	loop
	ll_subject_handle = tv_1.FindItem(NextTreeItem! ,ll_subject_handle)
loop
if upperbound(istr_pre_chapter) > 0 or upperbound(istr_pre_content) > 0 then
	for li_i = 1 to upperbound(istr_pre_chapter)
		if istr_pre_chapter[li_i].cur_parent_id <> istr_pre_chapter[li_i].pre_parent_id then
			update chapter 
			set subject_id = :istr_pre_chapter[li_i].cur_parent_id 
			where chapter_id = :istr_pre_chapter[li_i].data_id;
		end if
	next
	for li_i = 1 to upperbound(istr_pre_content)
		if istr_pre_content[li_i].cur_parent_id <> istr_pre_content[li_i].pre_parent_id then
			update content 
			set chapter_id = :istr_pre_content[li_i].cur_parent_id 
			where content_id = :istr_pre_content[li_i].data_id;
		end if
	next
	if SQLCA.sqlcode = 0 then
		commit;
		of_update_resource()
		post CloseWithReturn(parent, "OK")
	else
		f_log_error("Cannot move material", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot move material")
		return
	end if
end if
*/
end event

type cb_cancel from u_commandbutton within w_material_merge
integer x = 1458
integer y = 1736
integer taborder = 60
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Cancel"
end type

event clicked;call super::clicked;CloseWithReturn(parent, "CANCEL")
end event

