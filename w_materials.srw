$PBExportHeader$w_materials.srw
forward
global type w_materials from w_sheet
end type
type ole_1 from olecontrol within w_materials
end type
type tab_1 from tab within w_materials
end type
type tabpage_ob from u_tbpg_material within tab_1
end type
type tabpage_ob from u_tbpg_material within tab_1
end type
type tabpage_qy from u_tbpg_material within tab_1
end type
type tabpage_qy from u_tbpg_material within tab_1
end type
type tabpage_rd from u_tbpg_material within tab_1
end type
type tabpage_rd from u_tbpg_material within tab_1
end type
type tabpage_sp from u_tbpg_material within tab_1
end type
type tabpage_sp from u_tbpg_material within tab_1
end type
type tab_1 from tab within w_materials
tabpage_ob tabpage_ob
tabpage_qy tabpage_qy
tabpage_rd tabpage_rd
tabpage_sp tabpage_sp
end type
type st_1 from statictext within w_materials
end type
type st_2 from statictext within w_materials
end type
type st_3 from statictext within w_materials
end type
type st_4 from statictext within w_materials
end type
type rr_1 from roundrectangle within w_materials
end type
end forward

global type w_materials from w_sheet
string tag = "1300000"
integer width = 4023
integer height = 2616
string title = "Teaching Materials"
long backcolor = 15780518
event ue_set_bmp_rs_profile pbm_custom01
event ue_set_wav_rs_profile pbm_custom02
event ue_run_tail pbm_custom04
event ue_run_body pbm_custom03
ole_1 ole_1
tab_1 tab_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
rr_1 rr_1
end type
global w_materials w_materials

type prototypes

end prototypes

type variables
integer ii_add_mode
integer ii_view_mode
string is_bitmap_list[]
string is_wave_list[]
window iw_material
m_material im_material
u_datawindow idw_subject[4]
u_datawindow idw_chapter[4]
u_datawindow idw_content[4]
constant integer ici_tbpg_ob = 1
constant integer ici_tbpg_qy = 2
constant integer ici_tbpg_rd = 3
constant integer ici_tbpg_sp = 4
u_tbpg_material cur_tbpg
boolean ib_new_file = false
boolean ib_ole_opened = false
nvo_sound_ole_control inv_sound_ole
integer ii_wave_file_edit_source_ind = 0
integer ii_wave_data_row = 0
end variables

forward prototypes
public function integer wf_picture_add (ref string as_file_name)
public function integer wf_sound_add (ref string as_file_name)
public subroutine wf_close ()
public subroutine wf_set_wave_time (ref decimal adec_wave_time[])
public function long wf_get_chapter_id ()
public subroutine wf_get_bitmap_list (ref picturelistbox a_picturelistbox, string a_dirpath)
public subroutine wf_get_wave_list (datawindowchild a_datawindowchild, string a_column, string a_dirpath)
public subroutine wf_mk_subject_mod_list (integer ai_tbpg_index, ref string as_orig_list[], ref string as_mod_list[])
public subroutine wf_mk_subject_dir (integer ai_tbpg_index, string as_orig_list[], string as_mod_list[])
public subroutine wf_get_bitmap_list (datawindowchild a_datawindowchild, string a_column, string a_dirpath)
public subroutine wf_make_text_content ()
public function integer wf_save ()
public subroutine wf_scroll_ddw_wave_left ()
public function integer wf_picture_view (string as_file_name)
public subroutine wf_mk_chapter_mod_list (integer ai_tbpg_index, ref string as_orig_list[], ref string as_mod_list[])
public subroutine wf_time_text ()
public subroutine wf_load_files (string as_resource_type, string as_data_type)
public function integer wf_delete_files (string as_path)
public function integer wf_rm_chapter_dir (string as_path_list[])
public function integer wf_rm_subject_dir (string as_path_list[])
public subroutine wf_delete_subject ()
public subroutine wf_delete_chapter ()
public subroutine wf_delete_content ()
public subroutine wf_demo_body ()
public subroutine wf_demo ()
public subroutine wf_add_subject ()
public subroutine wf_delete_demo ()
public subroutine wf_save_wave_file ()
public subroutine wf_load_wave_file ()
public subroutine wf_add_dropdown_wave ()
public subroutine wf_mk_chapter_dir (integer ai_tbpg_index, string as_orig_list[], string as_mod_list[])
public subroutine wf_add_content ()
public subroutine wf_add_chapter ()
public subroutine wf_edit_wave_file (integer ai_source_ind, integer ai_row)
public subroutine wf_edit_speech_training (long row)
public subroutine wf_demo_tail ()
public subroutine of_merging ()
public subroutine of_exporting ()
public subroutine of_save_material_as_flat_file ()
end prototypes

event ue_set_bmp_rs_profile;SetProfileString (is_startupfile, "resources", "load_dir", "C:\Learning Helper\materials\bitmap\Foods\Breakfast Foods")


end event

event ue_set_wav_rs_profile;SetProfileString (is_startupfile, "resources", "load_dir", "C:\Learning Helper\materials\wave\Foods\Breakfast Foods")


end event

event ue_run_tail;wf_demo_tail()
end event

event ue_run_body;wf_demo_body()
end event

public function integer wf_picture_add (ref string as_file_name);OpenWithParm(w_picture, gnv_constant.bitmap_file)
as_file_name = Message.StringParm
if as_file_name = '' then
	return 0
end if
return 1
end function

public function integer wf_sound_add (ref string as_file_name);OpenWithParm(w_picture, gnv_constant.wave_file)
as_file_name = Message.StringParm
if as_file_name = '' then
	return 0
end if
return 1
end function

public subroutine wf_close ();close(this)
end subroutine

public subroutine wf_set_wave_time (ref decimal adec_wave_time[]);integer li_i, li_count
if tab_1.Selectedtab <> ici_tbpg_rd then
	return
end if
li_count = upperbound(adec_wave_time)
if idw_content[ici_tbpg_rd].RowCount() < li_count then
	li_count = idw_content[ici_tbpg_rd].RowCount()
end if

for li_i = 1 to li_count
	idw_content[ici_tbpg_rd].SetItem(li_i, 'wave_time', adec_wave_time[li_i])
next
end subroutine

public function long wf_get_chapter_id ();return cur_tbpg.il_current_chapter_id
end function

public subroutine wf_get_bitmap_list (ref picturelistbox a_picturelistbox, string a_dirpath);
if gn_appman.invo_filedir.of_get_bitmap_list(a_picturelistbox, a_dirpath ) = -1 then
	MessageBox("Error", "Cannot find bitmap file!")
end if
end subroutine

public subroutine wf_get_wave_list (datawindowchild a_datawindowchild, string a_column, string a_dirpath);
if gn_appman.invo_filedir.of_get_wave_list(a_datawindowchild, a_column, a_dirpath ) = -1 then
	MessageBox("Error", "Cannot wave file!")
end if
end subroutine

public subroutine wf_mk_subject_mod_list (integer ai_tbpg_index, ref string as_orig_list[], ref string as_mod_list[]);long ll_row, ll_row_count, ll_return, ll_subject_id, ll_i = 1
dwItemStatus ldwItemStatus
ll_row_count = idw_subject[ai_tbpg_index].RowCount()
for ll_row = 1 to ll_row_count
	ldwItemStatus = idw_subject[ai_tbpg_index].GetItemStatus(ll_row, 'description', primary!)
	ll_subject_id = idw_subject[ai_tbpg_index].GetItemNumber(ll_row, 'subject_id')
	if ldwItemStatus = NewModified! or isnull(ll_subject_id) then // new
		as_orig_list[ll_i] = ""
		as_mod_list[ll_i] = idw_subject[ai_tbpg_index].GetItemString(ll_row, 'description')
		ll_i++
	elseif ldwItemStatus = DataModified! then // change 
		as_orig_list[ll_i] = idw_subject[ai_tbpg_index].GetItemString(ll_row, 'description', Primary!, true)
		as_mod_list[ll_i] = idw_subject[ai_tbpg_index].GetItemString(ll_row, 'description')
		ll_i++
	end if
next
end subroutine

public subroutine wf_mk_subject_dir (integer ai_tbpg_index, string as_orig_list[], string as_mod_list[]);
long ll_row, ll_row_count, ll_return, ll_i
string ls_subject_dir, ls_subject_new_dir
for ll_i = 1 to upperbound(as_mod_list)
	if as_orig_list[ll_i] = "" then
		ls_subject_new_dir = gn_appman.is_wavefile_path + as_mod_list[ll_i]
		ll_return = fnMkDir(ls_subject_new_dir)
		ls_subject_new_dir = gn_appman.is_bitmap_path + as_mod_list[ll_i]
		ll_return = fnMkDir(ls_subject_new_dir)
	else
		ls_subject_new_dir = gn_appman.is_wavefile_path + as_mod_list[ll_i]
		ls_subject_dir = gn_appman.is_wavefile_path + as_orig_list[ll_i]
		MoveFileA(ls_subject_dir, ls_subject_new_dir)
		ls_subject_new_dir = gn_appman.is_bitmap_path + as_mod_list[ll_i]
		ls_subject_dir = gn_appman.is_bitmap_path + as_orig_list[ll_i]
		MoveFileA(ls_subject_dir, ls_subject_new_dir)
	end if
next
end subroutine

public subroutine wf_get_bitmap_list (datawindowchild a_datawindowchild, string a_column, string a_dirpath);
if gn_appman.invo_filedir.of_get_bitmap_list(a_datawindowchild, a_column, a_dirpath ) = -1 then
	MessageBox("Error", "Cannot find bitmap files")
end if
end subroutine

public subroutine wf_make_text_content ();string ls_details, ls_content[]
integer li_i
if tab_1.Selectedtab <> ici_tbpg_rd then
	return
end if
if cur_tbpg.il_current_chapter_id > 0 then
	ls_details = idw_chapter[ici_tbpg_rd].GetItemString(cur_tbpg.il_current_chapter_row, 'details')
	if not isnull(ls_details) and len(ls_details) > 0 then
		if MessageBox("Warning", "Making the content will overwrite previous conent, do you want to proceed ?", Question!, YesNo!) = 2 then
			return
		end if
		idw_chapter[ici_tbpg_rd].SetFocus()	
		idw_chapter[ici_tbpg_rd].SelectRow(0, false)
		idw_chapter[ici_tbpg_rd].SelectRow(cur_tbpg.il_current_chapter_row, true)	
		gf_make_content_list(ls_details, ls_content)
		delete content where chapter_id = :cur_tbpg.il_current_chapter_id;
		commit;
		idw_content[ici_tbpg_rd].reset()
		for li_i = 1 to upperbound(ls_content)
			cur_tbpg.il_current_content_row = idw_content[ici_tbpg_rd].InsertRow(0)
			idw_content[ici_tbpg_rd].SetItem(cur_tbpg.il_current_content_row, 'chapter_id', cur_tbpg.il_current_chapter_id)
			idw_content[ici_tbpg_rd].SetItem(cur_tbpg.il_current_content_row, 'description', ls_content[li_i])
			idw_content[ici_tbpg_rd].SetItem(cur_tbpg.il_current_content_row, 'details', ls_content[li_i])
		next
		idw_content[ici_tbpg_rd].ScrollToRow(cur_tbpg.il_current_content_row)
		idw_content[ici_tbpg_rd].SelectRow(0, false)
		idw_content[ici_tbpg_rd].SelectRow(cur_tbpg.il_current_content_row, true)
		idw_content[ici_tbpg_rd].SetColumn('description')
		cur_tbpg.il_current_content_id = idw_content[ici_tbpg_rd].GetItemNumber(cur_tbpg.il_current_content_row, 'content_id')
	end if
end if

end subroutine

public function integer wf_save ();string ls_material_type[] = {"Object", "Quantity", "Reading", "Speech"}
dwobject dwo
boolean lb_subject_updated[4] = {false, false, false, false}
boolean lb_chapter_updated[4] = {false, false, false, false}
boolean lb_content_updated[4] = {false, false, false, false}
string ls_orig_list[], ls_mod_list[], ls_empty_list[]
long ll_rowcount, ll_row, ll_orig_row, ll_new_id
integer li_curtab
u_tbpg_material luo_current_tbpg
for li_curtab = 1 to 4 
	luo_current_tbpg = tab_1.control[li_curtab]
	idw_subject[li_curtab].AcceptText()
	if idw_subject[li_curtab].ModifiedCount() > 0 then
		ls_orig_list = ls_empty_list
		ls_mod_list = ls_empty_list
		wf_mk_subject_mod_list(li_curtab, ls_orig_list, ls_mod_list)
		if idw_subject[li_curtab].update(true, true) = 1 then
			commit;
			wf_mk_subject_dir(li_curtab, ls_orig_list, ls_mod_list)
			lb_subject_updated[li_curtab] = true
		else
			f_log_error("update subject", SQLCA.SQLCODE, SQLCA.SQLDBCODE, SQLCA.SQLERRTEXT)
		end if
	end if
	idw_chapter[li_curtab].AcceptText()	
	if idw_chapter[li_curtab].ModifiedCount() > 0 then
		ls_orig_list = ls_empty_list
		ls_mod_list = ls_empty_list		
		wf_mk_chapter_mod_list(li_curtab, ls_orig_list, ls_mod_list)
		if idw_chapter[li_curtab].update(true, true) = 1 then
			commit;
			wf_mk_chapter_dir(li_curtab, ls_orig_list, ls_mod_list)
			lb_chapter_updated[li_curtab] = true
		else
			f_log_error("update chapter", SQLCA.SQLCODE, SQLCA.SQLDBCODE, SQLCA.SQLERRTEXT)
		end if		
	end if 
	if idw_content[li_curtab].ModifiedCount() > 0 then
		if idw_content[li_curtab].update(true, true) = 1 then
			commit;
			lb_content_updated[li_curtab] = true
		else
			f_log_error("update content", SQLCA.SQLCODE, SQLCA.SQLDBCODE, SQLCA.SQLERRTEXT)
		end if
	end if	 
	if lb_subject_updated[li_curtab] then
		if luo_current_tbpg.dw_subject.Retrieve(ls_material_type[li_curtab]) > 0 then
			ll_orig_row = luo_current_tbpg.dw_subject.of_get_row("subject_id", luo_current_tbpg.il_current_subject_id)
			if ll_orig_row = 0 then 
				ll_new_id = luo_current_tbpg.dw_subject.of_get_max_id("subject_id")
				ll_orig_row = luo_current_tbpg.dw_subject.of_get_row("subject_id", ll_new_id)
			end if
			luo_current_tbpg.dw_subject.event clicked(0, 0, ll_orig_row, dwo)
		else
			luo_current_tbpg.il_current_subject_row = 0
			luo_current_tbpg.il_current_subject_id = 0
			luo_current_tbpg.is_current_subject = ""
			luo_current_tbpg.il_current_chapter_row = 0
			luo_current_tbpg.il_current_chapter_id = 0
			luo_current_tbpg.is_current_chapter = ""
			luo_current_tbpg.il_current_content_row = 0
			luo_current_tbpg.il_current_content_id = 0
			luo_current_tbpg.is_current_content = ""
		end if
	elseif lb_chapter_updated[li_curtab] then
		if luo_current_tbpg.dw_chapter.Retrieve(luo_current_tbpg.il_current_subject_id) > 0 then
			ll_orig_row = luo_current_tbpg.dw_chapter.of_get_row("chapter_id", luo_current_tbpg.il_current_chapter_id)
			if ll_orig_row = 0 then 
				ll_new_id = luo_current_tbpg.dw_chapter.of_get_max_id("chapter_id")
				ll_orig_row = luo_current_tbpg.dw_chapter.of_get_row("chapter_id", ll_new_id)
			end if
			luo_current_tbpg.dw_chapter.event clicked(0, 0, ll_orig_row, dwo)
		else
			luo_current_tbpg.il_current_chapter_row = 0
			luo_current_tbpg.il_current_chapter_id = 0
			luo_current_tbpg.is_current_chapter = ""
			luo_current_tbpg.il_current_content_row = 0
			luo_current_tbpg.il_current_content_id = 0
			luo_current_tbpg.is_current_content = ""
		end if
	elseif lb_content_updated[li_curtab] then
		if luo_current_tbpg.dw_content.Retrieve(luo_current_tbpg.il_current_chapter_id) > 0 then
			ll_orig_row = luo_current_tbpg.dw_content.of_get_row("content_id", luo_current_tbpg.il_current_content_id)
			if ll_orig_row = 0 then 
				ll_new_id = luo_current_tbpg.dw_content.of_get_max_id("content_id")
				ll_orig_row = luo_current_tbpg.dw_content.of_get_row("content_id", ll_new_id)
			end if
			luo_current_tbpg.dw_content.event clicked(0, 0, ll_orig_row, dwo)
		else
			luo_current_tbpg.il_current_content_row = 0
			luo_current_tbpg.il_current_content_id = 0
			luo_current_tbpg.is_current_content = ""
		end if
	end if
next		
for li_curtab = 1 to 4 
	lb_subject_updated[li_curtab] = false
	lb_chapter_updated[li_curtab] = false
	lb_content_updated[li_curtab] = false
next		

return 1
end function

public subroutine wf_scroll_ddw_wave_left ();
datawindowchild ldwc_wave
string ls_return
if idw_content[tab_1.SelectedTab].GetChild('wave_add', ldwc_wave) = -1 then
	MessageBox("Error", "Unable to retireve Wave List")
	return
end if
//ldwc_wave.object.datawindow.HorizontalScrollPosition = 0
ls_return = ldwc_wave.Modify("datawindow.HorizontalScrollPosition = 0")
if len(ls_return) > 0 then
	MessageBox("Error", ls_return)
end if
end subroutine

public function integer wf_picture_view (string as_file_name);OpenWithParm(w_picture, as_file_name)
return 1

end function

public subroutine wf_mk_chapter_mod_list (integer ai_tbpg_index, ref string as_orig_list[], ref string as_mod_list[]);
long ll_chapter_id, ll_row, ll_row_count, ll_return, ll_i = 1
dwItemStatus ldwItemStatus
ll_row_count = idw_chapter[ai_tbpg_index].RowCount()

for ll_row = 1 to ll_row_count
	ldwItemStatus = idw_chapter[ai_tbpg_index].GetItemStatus(ll_row, 'description', primary!)
	ll_chapter_id = idw_chapter[ai_tbpg_index].GetItemNumber(ll_row, 'chapter_id')
	if ldwItemStatus = NewModified! or isnull(ll_chapter_id) then // new
		as_orig_list[ll_i] = ""
		as_mod_list[ll_i] = idw_chapter[ai_tbpg_index].GetItemString(ll_row, 'description')
		ll_i++
	elseif ldwItemStatus = DataModified! then // change 
		as_orig_list[ll_i] = idw_chapter[ai_tbpg_index].GetItemString(ll_row, 'description', Primary!, true)
		as_mod_list[ll_i] = idw_chapter[ai_tbpg_index].GetItemString(ll_row, 'description')
		ll_i++
	end if
next
end subroutine

public subroutine wf_time_text ();w_materials iw_window
if tab_1.Selectedtab <> ici_tbpg_rd then
	return
end if
if cur_tbpg.il_current_subject_row < 1 then
	return
end if
iw_window = this
if cur_tbpg.il_current_chapter_id > 0 then
	idw_chapter[ici_tbpg_rd].SetFocus()
	idw_chapter[ici_tbpg_rd].SelectRow(0, false)
	idw_chapter[ici_tbpg_rd].SelectRow(cur_tbpg.il_current_chapter_row, true)	
	OpenWithParm(w_timing_text, iw_window)	
end if

end subroutine

public subroutine wf_load_files (string as_resource_type, string as_data_type);
string ls_win_title, ls_path, ls_filetype, ls_location
dwobject dwo
if as_data_type = "Subject" then
	if cur_tbpg.il_current_subject_row < 1 and len(cur_tbpg.is_current_subject) < 1 then
		return
	end if
	ls_location = cur_tbpg.is_current_subject
	if as_resource_type = "Picture" then
		ls_win_title = "Load picture files to the subject"
		ls_path = gn_appman.is_bitmap_path + cur_tbpg.is_current_subject
		ls_filetype = "*.*"
	else // Sound
		ls_win_title = "Load sound files to the subject"
		ls_path = gn_appman.is_wavefile_path + cur_tbpg.is_current_subject		
		ls_filetype = "*.wav"
	end if
else // chapter
	if cur_tbpg.il_current_chapter_row < 1 and len(cur_tbpg.is_current_chapter) < 1 then
		return
	end if
	ls_location = cur_tbpg.is_current_subject + "\" + cur_tbpg.is_current_chapter
	if as_resource_type = "Picture" then
		ls_win_title = "Load picture files to the chapter"
		ls_path = gn_appman.is_bitmap_path + cur_tbpg.is_current_subject + "\" + cur_tbpg.is_current_chapter		
		ls_filetype = "*.*"		
	else // Sound
		ls_win_title = "Load sound files to the chapter"
		ls_path = gn_appman.is_wavefile_path + cur_tbpg.is_current_subject + "\" + cur_tbpg.is_current_chapter		
		ls_filetype = "*.wav"		
	end if
end if
gn_appman.of_set_parm("Win Title", ls_win_title)
gn_appman.of_set_parm("File Path",  ls_path)
gn_appman.of_set_parm("File Type",  ls_filetype)
gn_appman.of_set_parm("Location",  ls_location)
gn_appman.of_set_parm("Parent Handle",  handle(this))
Open(w_resource_loading)
if as_resource_type = "Subject" then
	idw_subject[tab_1.selectedtab].event clicked(0, 0, cur_tbpg.il_current_subject_row, dwo)
else // sound
	idw_chapter[tab_1.selectedtab].event clicked(0, 0, cur_tbpg.il_current_chapter_row, dwo)
end if

end subroutine

public function integer wf_delete_files (string as_path);
long ll_row, ll_row_count, ll_return, ll_file_count, ll_file_index
string ls_chapter_dir, ls_file_name, ls_file_list[]
gn_appman.invo_filedir.of_get_dir_list(as_path, ls_file_list)
for ll_file_index = 1 to upperbound(ls_file_list)
	ls_file_name = as_path + '\' + ls_file_list[ll_file_index]
	f_filter_double_char('\', ls_file_name)
//	MessageBox("file", ls_file_list[ll_file_index])
	fnDeleteFile(ls_file_name)
next		

return 1
end function

public function integer wf_rm_chapter_dir (string as_path_list[]);long ll_row, ll_row_count, ll_return
string ls_chapter_dir
ll_row_count = upperbound(as_path_list)
for ll_row = 1 to ll_row_count
	ls_chapter_dir = gn_appman.is_wavefile_path + cur_tbpg.is_current_subject + '\' + as_path_list[ll_row]
	f_filter_double_char('\', ls_chapter_dir)
	if wf_delete_files(ls_chapter_dir) = 1 then		 
		fnRmDir(ls_chapter_dir)
	else
		MessageBox("Warning", "Error in delete wave files in " + ls_chapter_dir)
	end if
	ls_chapter_dir = gn_appman.is_bitmap_path + cur_tbpg.is_current_subject + '\' + as_path_list[ll_row]
	f_filter_double_char('\', ls_chapter_dir)
	if wf_delete_files(ls_chapter_dir) = 1 then
		fnRmDir(ls_chapter_dir)
	else
		MessageBox("Warning", "Error in delete bitmap files in " + ls_chapter_dir)
	end if

next

return 1
end function

public function integer wf_rm_subject_dir (string as_path_list[]);
long ll_row, ll_row_count, ll_return
string ls_subject_dir
ll_row_count = upperbound(as_path_list)

for ll_row = 1 to ll_row_count
	ls_subject_dir = gn_appman.is_wavefile_path + as_path_list[ll_row]
	f_filter_double_char('\', ls_subject_dir)
	if wf_delete_files(ls_subject_dir) = 1 then
		fnRmDir(ls_subject_dir)
	else
		MessageBox("Warning", "Error in delete files in " + ls_subject_dir)
	end if
	ls_subject_dir = gn_appman.is_bitmap_path + as_path_list[ll_row]
	f_filter_double_char('\', ls_subject_dir)
	if wf_delete_files(ls_subject_dir) = 1 then
		fnRmDir(ls_subject_dir)
	else
		MessageBox("Warning", "Error in delete files in " + ls_subject_dir)
	end if

next

return 1

end function

public subroutine wf_delete_subject ();long ll_chapter_list[], ll_row, ll_count
string ls_subject_list[], ls_chapter_list[]
dwobject dwo
if gn_appman.ib_trial_version then
	MessageBox("Error", "This copy of the software is a trial version, cannot delete the subject!")
	return
end if


if cur_tbpg.il_current_subject_row > 0 then
	idw_subject[tab_1.SelectedTab].SetFocus()	
	idw_subject[tab_1.SelectedTab].SelectRow(0, false)
	idw_subject[tab_1.SelectedTab].SelectRow(cur_tbpg.il_current_subject_row, true)
	if MessageBox("Warning", "Deleting the selected subjects will also delete the related resources " + &
		"(pictures and sound) and subsequent chapters and contents, and their resources, " + &
		"back them up first if you want to save these resources, do you still want to delete the selected subject -" + &
				cur_tbpg.is_current_subject + '?', Question!, YesNo!) = 1 then
		if idw_chapter[tab_1.SelectedTab].RowCount() > 0 then
			for ll_row = 1 to idw_chapter[tab_1.SelectedTab].RowCount()
				ll_chapter_list[ll_row] = idw_chapter[tab_1.SelectedTab].GetItemNumber(ll_row, "chapter_id")
				ls_chapter_list[ll_row] = idw_chapter[tab_1.SelectedTab].GetItemString(ll_row, "description")
			next
			gn_appman.of_set_parm("Argument List", ll_chapter_list)
			gn_appman.of_set_parm("Dataobject",  "d_related_lesson")
			open(w_related_items)
			if Message.StringParm = "0" then // Cancel deleting
				return
			end if
		end if
		select content.content_id into :ll_count 
		from content, chapter 
		where content.chapter_id = chapter.chapter_id and chapter.subject_id = :cur_tbpg.il_current_subject_id;
		if ll_count > 0 then
			delete content where chapter_id in (
				select content.chapter_id 
				from content, chapter 
				where content.chapter_id = chapter.chapter_id and chapter.subject_id = :cur_tbpg.il_current_subject_id);
			if SQLCA.sqlcode <> 0 then
				f_log_error("content", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
				MessageBox("Error", "Cannot delete the contents!")
				return
			end if
			idw_content[tab_1.SelectedTab].reset()
		end if
		select count(chapter_id) into :ll_count 
		from chapter 
		where subject_id = :cur_tbpg.il_current_subject_id;
		if ll_count > 0 then
			delete chapter where subject_id = :cur_tbpg.il_current_subject_id;
			if SQLCA.sqlcode <> 0 then
				f_log_error("chapter", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
				MessageBox("Error", "Cannot delete the contents!")
				return
			end if
			idw_chapter[tab_1.SelectedTab].reset()
		end if
		select count(subject_id) into :ll_count 
		from subject 
		where subject_id = :cur_tbpg.il_current_subject_id;
		if ll_count > 0 then
			delete subject where subject_id = :cur_tbpg.il_current_subject_id;
			if SQLCA.sqlcode <> 0 then
				f_log_error("subject", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
				MessageBox("Error", "Cannot delete the contents!")
				return
			end if
			ls_subject_list[1] = cur_tbpg.is_current_subject
			commit;
		end if		
		wf_rm_chapter_dir(ls_chapter_list)
		wf_rm_subject_dir(ls_subject_list)
		idw_subject[tab_1.SelectedTab].DeleteRow(cur_tbpg.il_current_subject_row)
		if ll_count > 0 then 
			idw_subject[tab_1.SelectedTab].ReSetUpdate()
			for ll_row = 1 to idw_subject[tab_1.selectedtab].RowCount()
				if isnull(idw_subject[tab_1.selectedtab].object.subject_id[ll_row]) or &
				  idw_subject[tab_1.selectedtab].object.subject_id[ll_row] = 0 then
					idw_subject[tab_1.selectedtab].SetItemStatus(ll_row, 0, Primary!, NewModified!)
				end if
			next
		end if
		if idw_subject[tab_1.SelectedTab].RowCount() > 0 then
			if cur_tbpg.il_current_subject_row > 1 then 
				cur_tbpg.il_current_subject_row = cur_tbpg.il_current_subject_row - 1
			end if
			idw_subject[tab_1.SelectedTab].SelectRow(0, false)
			idw_subject[tab_1.SelectedTab].SelectRow(cur_tbpg.il_current_subject_row, true)
			idw_subject[tab_1.SelectedTab].event clicked(0, 0, cur_tbpg.il_current_subject_row, dwo)
		else
			cur_tbpg.il_current_subject_row = 0
			cur_tbpg.il_current_subject_id = 0
			cur_tbpg.il_current_chapter_row = 0
			cur_tbpg.il_current_chapter_id = 0
			cur_tbpg.il_current_content_row = 0
			cur_tbpg.il_current_content_id = 0
		end if
	end if	
end if

end subroutine

public subroutine wf_delete_chapter ();long ll_chapter_list[], ll_row, ll_count
string ls_chapter_list[], ls_delete_chapter
dwobject dwo

if gn_appman.ib_trial_version then
	MessageBox("Warning", "This copy of the software is a trial version, cannot delete the chapter!")
	return
end if

if cur_tbpg.il_current_chapter_row > 0 then
	if cur_tbpg.il_current_chapter_id = 0 then 
		idw_chapter[tab_1.SelectedTab].DeleteRow(cur_tbpg.il_current_chapter_row)	
		if idw_chapter[tab_1.SelectedTab].RowCount() > 0 then
			if cur_tbpg.il_current_chapter_row > 1 then 
				cur_tbpg.il_current_chapter_row = cur_tbpg.il_current_chapter_row - 1
			end if
			idw_chapter[tab_1.SelectedTab].SelectRow(0, false)
			idw_chapter[tab_1.SelectedTab].SelectRow(cur_tbpg.il_current_chapter_row, true)
			dwo = idw_chapter[tab_1.SelectedTab].Object.Description
			idw_chapter[tab_1.SelectedTab].event clicked(0, 0, cur_tbpg.il_current_chapter_row, dwo)
		else
			cur_tbpg.il_current_chapter_row = 0
			cur_tbpg.il_current_chapter_id = 0
			cur_tbpg.il_current_content_row = 0
			cur_tbpg.il_current_content_id = 0
		end if
		return
	end if
	ls_delete_chapter = cur_tbpg.is_current_chapter
	idw_chapter[tab_1.SelectedTab].SetFocus()	
	idw_chapter[tab_1.SelectedTab].SelectRow(0, false)
	idw_chapter[tab_1.SelectedTab].SelectRow(cur_tbpg.il_current_chapter_row, true)
	if MessageBox("Warning", "Deleting the selected chapter will also delete the related resources " + &
		"(pictures and sound) and subsequent contents, " + &
		"back them up first if you want to save these resources, do you still want to delete the selected chapter -" + &
					cur_tbpg.is_current_chapter + '?', Question!, YesNo!) = 1 then
		ll_chapter_list[1] = cur_tbpg.il_current_chapter_id
		gn_appman.of_set_parm("Argument List", ll_chapter_list)
		gn_appman.of_set_parm("Dataobject",  "d_related_lesson")
		open(w_related_items)
		if Message.StringParm = "0" then // Cancel deleting
			return
		end if
		select count(*) into :ll_count 
		from content 
		where content.chapter_id = :cur_tbpg.il_current_chapter_id;
		if ll_count > 0 then
			delete content where chapter_id  = :cur_tbpg.il_current_chapter_id;
			if SQLCA.sqlcode <> 0 then
				f_log_error("content", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
				MessageBox("Error", "Cannot delete the contents!")
				return
			end if
			idw_content[tab_1.SelectedTab].reset()
		end if
		select count(chapter_id) into :ll_count 
		from chapter 
		where chapter_id = :cur_tbpg.il_current_chapter_id;
		if ll_count > 0 then
			delete chapter where chapter_id = :cur_tbpg.il_current_chapter_id;
			if SQLCA.sqlcode <> 0 then
				f_log_error("chapter", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
				MessageBox("Error", "Cannot delete the contents!")
				return
			end if
			commit;	
		end if
		
		idw_chapter[tab_1.SelectedTab].DeleteRow(cur_tbpg.il_current_chapter_row)
		if ll_count > 0 then
			idw_chapter[tab_1.SelectedTab].ResetUpdate()
		end if
		for ll_row = 1 to idw_chapter[tab_1.selectedtab].RowCount()
			if isnull(idw_chapter[tab_1.selectedtab].object.chapter_id[ll_row]) or &
			  idw_chapter[tab_1.selectedtab].object.chapter_id[ll_row] = 0 then
				idw_chapter[tab_1.selectedtab].SetItemStatus(ll_row, 0, Primary!, NewModified!)
			end if
		next
		if idw_chapter[tab_1.SelectedTab].RowCount() > 0 then
			if cur_tbpg.il_current_chapter_row > 1 then 
				cur_tbpg.il_current_chapter_row = cur_tbpg.il_current_chapter_row - 1
			end if
			idw_chapter[tab_1.SelectedTab].SelectRow(0, false)
			idw_chapter[tab_1.SelectedTab].SelectRow(cur_tbpg.il_current_chapter_row, true)
			dwo = idw_chapter[tab_1.SelectedTab].Object.Description
			idw_chapter[tab_1.SelectedTab].event clicked(0, 0, cur_tbpg.il_current_chapter_row, dwo)
		else
			cur_tbpg.il_current_chapter_row = 0
			cur_tbpg.il_current_chapter_id = 0
			cur_tbpg.il_current_content_row = 0
			cur_tbpg.il_current_content_id = 0
		end if
		ls_chapter_list[1] = ls_delete_chapter
		wf_rm_chapter_dir(ls_chapter_list)
	end if
end if



end subroutine

public subroutine wf_delete_content ();long ll_content_list[], ll_content_row_list[], ll_row, ll_count, ll_i
dwobject dwo
idw_content[tab_1.selectedtab].of_get_selectedrows(ll_content_row_list)

if gn_appman.ib_trial_version then
	MessageBox("Error", "This copy of the software is a trial version, cannot delete the content!")
	return
end if

if upperbound(ll_content_row_list) > 0 then
	idw_content[tab_1.selectedtab].SetFocus()	
//	idw_content[tab_1.selectedtab].SelectRow(0, false)
//	idw_content[tab_1.selectedtab].SelectRow(cur_tbpg.il_current_content_row, true)
	if MessageBox("Warning", "Do you want to delete the selected content?", Question!, YesNo!) = 1 then
		idw_content[tab_1.selectedtab].of_get_selectedrows(ll_content_row_list)
		for ll_i = 1 to upperbound(ll_content_row_list)
			ll_content_list[ll_i] = idw_content[tab_1.selectedtab].GetItemNumber(ll_content_row_list[ll_i], "content_id")
		next
//		ll_content_list[1] = cur_tbpg.il_current_content_row
		gn_appman.of_set_parm("Argument List", ll_content_list)
		gn_appman.of_set_parm("Dataobject",  "d_related_lesson_content")
		open(w_related_items)
		if Message.StringParm = "0" then // Cancel deleting
			return
		end if
		for ll_i = 1 to upperbound(ll_content_list)
			delete content where content.content_id = :ll_content_list[ll_i];
			if SQLCA.sqlcode <> 0 then
				f_log_error("content", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
				MessageBox("Error", "Cannot delete the contents!")
				return
			end if
			idw_content[tab_1.selectedtab].DeleteRow(ll_content_row_list[ll_i])
		next		
		commit;
		idw_content[tab_1.SelectedTab].ResetUpdate()
		for ll_row = 1 to idw_content[tab_1.selectedtab].RowCount()
			if isnull(idw_content[tab_1.selectedtab].object.content_id[ll_row]) or &
			  idw_content[tab_1.selectedtab].object.content_id[ll_row] = 0 then
				idw_content[tab_1.selectedtab].SetItemStatus(ll_row, 0, Primary!, NewModified!)
			end if
		next
		if idw_content[tab_1.selectedtab].RowCount() > 0 then
			if cur_tbpg.il_current_content_row > 1 then 
				cur_tbpg.il_current_content_row = 1
			end if
			idw_content[tab_1.selectedtab].event clicked(0, 0, cur_tbpg.il_current_content_row, dwo)
		else
			cur_tbpg.il_current_content_row = 0
			cur_tbpg.il_current_content_id = 0
		end if
	end if
end if
end subroutine

public subroutine wf_demo_body ();long ll_x, ll_y, ll_i
integer li_dummy[]
li_dummy = {0, 13}	
gnvo_is.of_reset_parms()

ll_x = st_1.x + st_1.width/2 + WorkspaceX()
ll_y = st_1.y + st_1.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)

gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 1.0, '', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 40, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Load Sound File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x + 120,  ll_y + 40, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, '', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x + 120,  ll_y + 60, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Chapter" Menu Item', false, li_dummy,handle(this),1025)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Chapter' + '" Menu Item', false, li_dummy,0,0)


gnvo_is.of_set_index(1)
gnvo_is.start(3)	

end subroutine

public subroutine wf_demo ();long ll_x, ll_y, ll_i
integer li_dummy[]
li_dummy = {0, 13}	
gnvo_is.of_reset_parms()

ll_x = st_2.x + st_2.width/2 + WorkspaceX()
ll_y = st_2.y + st_2.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Add" Menu Item', false, li_dummy,handle(gnvo_is.iw_status),1025)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'Add" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 25, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Subject" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Subject' + '" Menu Item', false, li_dummy,0,0)
li_dummy = {0, 16}	
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, 'Type "A DEMO SUBJECT' + '"', true, li_dummy,0,0)
gnvo_is.of_type_string("A DEMO SUBJECT", 0.1)
li_dummy = {2, 16}	
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, "", true, li_dummy,0,0)
ll_x = st_1.x + st_1.width/2 + WorkspaceX()
ll_y = st_1.y + st_1.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 60, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Save" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Save' + '" Menu Item', false, li_dummy,0,0)

ll_x = st_2.x + st_2.width/2 + WorkspaceX()
ll_y = st_2.y + st_2.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Add" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'Add" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 45, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Chapter" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Chapter' + '" Menu Item', false, li_dummy,0,0)
li_dummy = {0, 16}	
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, 'Type "A DEMO CHAPTER', true, li_dummy,0,0)
gnvo_is.of_type_string("A DEMO CHAPTER", 0.1)
li_dummy = {2, 16}	
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, "", true, li_dummy,0,0)
ll_x = st_1.x + st_1.width/2 + WorkspaceX()
ll_y = st_1.y + st_1.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 60, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Save" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Save' + '" Menu Item', false, li_dummy,handle(this),1024)
// open resource
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 20, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Load Picture File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x + 120,  ll_y + 20, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, '', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x + 120,  ll_y + 40, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Chapter" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Chapter' + '" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_index(1)
gnvo_is.start(2)	

end subroutine

public subroutine wf_add_subject ();datetime ldttm_create
if not gnvo_is.ib_demo_is_going and gn_appman.ib_trial_version then
	if idw_subject[tab_1.selectedtab].rowcount() > 2  or tab_1.selectedtab = 3 then
		OpenWithParm(w_trial_version_message, "Subject")
		return
	end if
end if

cur_tbpg.il_current_subject_row = idw_subject[tab_1.selectedtab].InsertRow(cur_tbpg.il_current_subject_row)
ldttm_create = datetime(today(), now())
idw_subject[tab_1.selectedtab].SetItem(cur_tbpg.il_current_subject_row, "Creation_date", ldttm_create)
idw_subject[tab_1.selectedtab].ScrollToRow(cur_tbpg.il_current_subject_row)
idw_subject[tab_1.selectedtab].SelectRow(0, false)
idw_subject[tab_1.selectedtab].SelectRow(cur_tbpg.il_current_subject_row, true)
dwobject dwo
dwo = idw_subject[tab_1.selectedtab].object.description
idw_subject[tab_1.selectedtab].event clicked(0, 0, cur_tbpg.il_current_subject_row, dwo)
idw_subject[tab_1.selectedtab].SetFocus()
idw_subject[tab_1.selectedtab].SetColumn("Description")
end subroutine

public subroutine wf_delete_demo ();long ll_subject_id, ll_lesson_id, ll_chapter_id, ll_count, ll_i = 1
string ls_chapter_tmp, ls_chapter[]
SELECT count(*) into :ll_count
FROM LESSON
WHERE upper(description) = 'A DEMO LESSON';
if ll_count > 0 then
	SELECT max(lesson_id) into :ll_lesson_id
	FROM LESSON
	WHERE description = 'A DEMO LESSON';
	DELETE FROM LESSON_CONTENT
	WHERE lesson_id = :ll_lesson_id;
	DELETE FROM LESSON 
	WHERE lesson_id = :ll_lesson_id;
end if
SELECT count(*) into :ll_count
FROM SUBJECT
WHERE upper(description) = 'A DEMO SUBJECT';
if ll_count = 0 then return
SELECT max(subject_id) into :ll_subject_id
FROM SUBJECT
WHERE upper(description) = 'A DEMO SUBJECT';
DECLARE chapter_cur CURSOR FOR
SELECT description
	FROM CHAPTER
	WHERE subject_id = :ll_subject_id;
	
OPEN chapter_cur;
FETCH chapter_cur into :ls_chapter_tmp; 
DO WHILE SQLCA.sqlcode = 0
	ls_chapter[ll_i] = ls_chapter_tmp
	FETCH chapter_cur INTO :ls_chapter_tmp;
	gnvo_is.of_add_message_to_status_window('wf_delete_demo ls_chapter: ' + string(ls_chapter[ll_i]))
	ll_i++
LOOP
CLOSE chapter_cur;

DELETE FROM CONTENT
WHERE chapter_id IN 
	(
	SELECT chapter_id
	FROM CHAPTER
	WHERE subject_id = :ll_subject_id);
//gnvo_is.of_add_message_to_status_window('wf_delete_demo after delete CONTENT sqlcode: ' + string(SQLCA.sqlcode))

DELETE FROM CHAPTER
WHERE subject_id = :ll_subject_id;
DELETE FROM SUBJECT 
WHERE subject_id = :ll_subject_id;
commit;
long ll_row, ll_row_count, ll_return
string ls_chapter_dir
ll_row_count = upperbound(ls_chapter)
// delete chapters
for ll_row = 1 to ll_row_count
	ls_chapter_dir = gn_appman.is_wavefile_path + 'A DEMO SUBJECT' + '\' + ls_chapter[ll_row]
	f_filter_double_char('\', ls_chapter_dir)
	if wf_delete_files(ls_chapter_dir) = 1 then		 
		fnRmDir(ls_chapter_dir)
	else
		MessageBox("Warning", "Error in delete wave files in " + ls_chapter_dir)
	end if
	ls_chapter_dir = gn_appman.is_bitmap_path + 'A DEMO SUBJECT' + '\' + ls_chapter[ll_row]
	f_filter_double_char('\', ls_chapter_dir)
	if wf_delete_files(ls_chapter_dir) = 1 then
		fnRmDir(ls_chapter_dir)
	else
		MessageBox("Warning", "Error in delete bitmap files in " + ls_chapter_dir)
	end if

next
// delete subject
string ls_subject_dir
ls_subject_dir = gn_appman.is_wavefile_path + 'A DEMO SUBJECT'
f_filter_double_char('\', ls_subject_dir)
if wf_delete_files(ls_subject_dir) = 1 then
	fnRmDir(ls_subject_dir)
else
	MessageBox("Warning", "Error in delete files in " + ls_subject_dir)
end if
ls_subject_dir = gn_appman.is_bitmap_path + 'A DEMO SUBJECT' 
f_filter_double_char('\', ls_subject_dir)
if wf_delete_files(ls_subject_dir) = 1 then
	fnRmDir(ls_subject_dir)
else
	MessageBox("Warning", "Error in delete files in " + ls_subject_dir)
end if


end subroutine

public subroutine wf_save_wave_file ();//inv_sound_ole.of_save_wave_file("C:\spell_new3.wav")
end subroutine

public subroutine wf_load_wave_file ();//inv_sound_ole.of_load_wave_file("C:\spell.wav")
end subroutine

public subroutine wf_add_dropdown_wave ();
long ll_itemcount, ll_index, ll_row
datawindowchild lddc_wave
idw_content[tab_1.selectedtab].GetChild('wave_file', lddc_wave)
gf_get_wave_dddw(lddc_wave)
idw_chapter[tab_1.selectedtab].GetChild('wave_file', lddc_wave)
gf_get_wave_dddw(lddc_wave)
end subroutine

public subroutine wf_mk_chapter_dir (integer ai_tbpg_index, string as_orig_list[], string as_mod_list[]);
long ll_row, ll_row_count, ll_return, ll_i
string ls_chapter_dir, ls_chapter_new_dir
string ls_subject
u_tbpg_material luo_current_tbpg
	luo_current_tbpg = tab_1.control[ai_tbpg_index]
	ls_subject = luo_current_tbpg.is_current_subject
for ll_i = 1 to upperbound(as_mod_list)
	if as_orig_list[ll_i] = "" then
		ls_chapter_new_dir = gn_appman.is_wavefile_path + ls_subject + "\" + as_mod_list[ll_i]
		ll_return = fnMkDir(ls_chapter_new_dir)
		ls_chapter_new_dir = gn_appman.is_bitmap_path + ls_subject + "\" + as_mod_list[ll_i]
		ll_return = fnMkDir(ls_chapter_new_dir)
	else
		ls_chapter_new_dir = gn_appman.is_wavefile_path + ls_subject + "\"+ as_mod_list[ll_i]
		ls_chapter_dir = gn_appman.is_wavefile_path + ls_subject + "\"+ as_orig_list[ll_i]
		MoveFileA(ls_chapter_dir, ls_chapter_new_dir)
		ls_chapter_new_dir = gn_appman.is_bitmap_path + ls_subject + "\"+ as_mod_list[ll_i]
		ls_chapter_dir = gn_appman.is_bitmap_path + ls_subject + "\"+ as_orig_list[ll_i]
		MoveFileA(ls_chapter_dir, ls_chapter_new_dir)
	end if
next

//long ll_row, ll_row_count, ll_chapter_row, ll_chapter_row_count, ll_subject_id, ll_return
//string ls_subject_dir, ls_chapter_dir
//integer li_curtab
//datastore lds_chapter
//lds_chapter = create datastore
//lds_chapter.dataobject = 'd_chapter'
//lds_chapter.SetTransObject(SQLCA)
//
//ll_row_count = idw_subject[ai_tbpg_index].RowCount()
//for ll_row = 1 to ll_row_count
//	ls_subject_dir = idw_subject[ai_tbpg_index].GetItemString(ll_row, 'description')
//	ll_subject_id = idw_subject[ai_tbpg_index].GetItemNumber(ll_row, 'subject_id')
//	ll_chapter_row_count = lds_chapter.Retrieve(ll_subject_id)	
//	for ll_chapter_row = 1 to ll_chapter_row_count
//		ls_chapter_dir = gn_appman.is_wavefile_path + ls_subject_dir + '\' + lds_chapter.GetItemString(ll_chapter_row, 'description')
//		if gn_appman.invo_filedir.of_is_empty_dir(ls_chapter_dir) then
//			ll_return = fnMkDir(ls_chapter_dir)
//		end if
//		ls_chapter_dir = gn_appman.is_bitmap_path + ls_subject_dir + '\' + lds_chapter.GetItemString(ll_chapter_row, 'description')
//		if gn_appman.invo_filedir.of_is_empty_dir(ls_chapter_dir) then
//			ll_return = fnMkDir(ls_chapter_dir)
//		end if
//	next
//next
end subroutine

public subroutine wf_add_content ();if not gnvo_is.ib_demo_is_going and gn_appman.ib_trial_version then
	if idw_content[tab_1.selectedtab].rowcount() > 4 then
		OpenWithParm(w_trial_version_message, "Content")
		return
	end if
end if

cur_tbpg.il_current_content_row = idw_content[tab_1.selectedtab].InsertRow(cur_tbpg.il_current_content_row)
idw_content[tab_1.selectedtab].SetItem(cur_tbpg.il_current_content_row, 'chapter_id', cur_tbpg.il_current_chapter_id)
idw_content[tab_1.selectedtab].ScrollToRow(cur_tbpg.il_current_content_row)
idw_content[tab_1.selectedtab].SelectRow(0, false)
idw_content[tab_1.selectedtab].SelectRow(cur_tbpg.il_current_content_row, true)
idw_content[tab_1.selectedtab].SetFocus()
idw_content[tab_1.selectedtab].SetColumn('description')
cur_tbpg.il_current_content_id = 0

end subroutine

public subroutine wf_add_chapter ();if not gnvo_is.ib_demo_is_going and gn_appman.ib_trial_version then
	if idw_chapter[tab_1.selectedtab].rowcount() > 1 or tab_1.selectedtab = 3 then
		OpenWithParm(w_trial_version_message, "Chapter")
		return
	end if
end if

cur_tbpg.il_current_chapter_row = idw_chapter[tab_1.selectedtab].InsertRow(cur_tbpg.il_current_chapter_row)
idw_chapter[tab_1.selectedtab].SetItem(cur_tbpg.il_current_chapter_row, 'subject_id', cur_tbpg.il_current_subject_id)
idw_chapter[tab_1.selectedtab].ScrollToRow(cur_tbpg.il_current_chapter_row)
idw_chapter[tab_1.selectedtab].SelectRow(0, false)
idw_chapter[tab_1.selectedtab].SelectRow(cur_tbpg.il_current_chapter_row, true)
dwobject dwo
dwo = idw_chapter[tab_1.selectedtab].object.description
idw_chapter[tab_1.selectedtab].event clicked(0, 0, cur_tbpg.il_current_chapter_row, dwo)
idw_chapter[tab_1.selectedtab].SetFocus()
idw_chapter[tab_1.selectedtab].SetColumn("Description")
end subroutine

public subroutine wf_edit_wave_file (integer ai_source_ind, integer ai_row);long ll_row, ll_row_count, ll_return, ll_i
string ls_chapter_dir, ls_subject_dir, ls_wave_file
string ls_subject, ls_chapter, ls_content, ls_wave_path
string ls_1st_letter, ls_word, ls_dict_sound_file
datawindowchild ldwc
u_tbpg_material luo_current_tbpg
luo_current_tbpg = cur_tbpg
ls_subject = luo_current_tbpg.is_current_subject
ii_wave_file_edit_source_ind = ai_source_ind
ii_wave_data_row = ai_row
if ai_source_ind = 1 then // sound file for chapter
	ls_subject_dir = gn_appman.is_wavefile_path + ls_subject
	ls_chapter = luo_current_tbpg.dw_chapter.GetItemString(ai_row, "wave_file")
	if isnull(ls_chapter) then ls_chapter = ""
	if trim(ls_chapter) = "" then		
		ls_chapter = luo_current_tbpg.dw_chapter.GetItemString(ai_row, "description")
		if isnull(ls_chapter) then ls_chapter = ""
		if trim(ls_chapter) = "" then
			MessageBox("Error", "The chapter is not valid, cannot create the sound file!")
			return
		end if
	end if
	ls_wave_file = ls_chapter
	ls_wave_path = ls_subject_dir + "\" + ls_chapter
	if pos(ls_wave_path, ".wav") = 0 then ls_wave_path = ls_wave_path + ".wav"
	luo_current_tbpg.dw_chapter.GetChild("wave_file", ldwc)
else //sound file for content
	ls_chapter = luo_current_tbpg.is_current_chapter
	ls_chapter_dir = gn_appman.is_wavefile_path + ls_subject + "\" + ls_chapter
	ls_content = luo_current_tbpg.dw_content.GetItemString(ai_row, "wave_file")
	if isnull(ls_content) then ls_content = ""
	if trim(ls_content) = "" then
		ls_content = luo_current_tbpg.dw_content.GetItemString(ai_row, "description")	
		if isnull(ls_content) then ls_content = ""
		if trim(ls_content) = "" then
			MessageBox("Error", "The content is not valid, cannot create the sound file!")
			return
		end if
	end if
	ls_wave_file = ls_content
	ls_wave_path = ls_chapter_dir + "\" + ls_content
	if pos(ls_wave_path, ".wav") = 0 then ls_wave_path = ls_wave_path + ".wav"
	if pos(ls_wave_path, ".wav") > 0 then
		luo_current_tbpg.dw_content.GetChild("wave_file", ldwc)
	end if
end if
if inv_sound_ole.ib_object_open then
	MessageBox("Error", "Sound editor is opened, close it before editing another file!")
	return
end if
if pos(ls_wave_file, ".wav") = 0 then ls_wave_file = ls_wave_file + ".wav"
if pos(ls_wave_file, "DICTIONARY") > 0 THEN
	ls_word = luo_current_tbpg.dw_content.GetItemString(ai_row, "details")
	if isnull(ls_word) then ls_word = ""
	if trim(ls_word) <> "" then
		ls_1st_letter = upper(left(ls_word, 1))
		ls_wave_path = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
//		MessageBox("ls_wave_file", ls_wave_file)
		if not FileExists(ls_wave_path) then
			MessageBox("Error", "The sound file is not available in the dictionary!")
			return
		end if
	end if
end if
if FileExists(ls_wave_path) then
	ib_new_file = false
	ls_wave_file = ls_wave_file + "(existing)"
else
	ib_new_file = true
	ls_wave_file = ls_wave_file + "(new)"
end if
//inv_sound_ole.of_activate()
ole_1.DisplayName = ls_wave_file
ole_1.objectdata = inv_sound_ole.iblb_empty_objectdata
ole_1.activate(offsite!)
inv_sound_ole.of_load_wave_file(ls_wave_path)
timer(0.2, this)
//inv_sound_ole.of_load_wave_file("C:\spell_new4.wav")		
end subroutine

public subroutine wf_edit_speech_training (long row);long ll_row, ll_row_count, ll_return, ll_i, ll_content_id
string ls_chapter_dir, ls_subject_dir, ls_wave_file
string ls_subject, ls_chapter, ls_content, ls_wave_path
string ls_1st_letter, ls_word, ls_dict_sound_file
datawindowchild ldwc
u_tbpg_material luo_current_tbpg
luo_current_tbpg = cur_tbpg
ls_subject = luo_current_tbpg.is_current_subject
ii_wave_data_row = row
ls_chapter = luo_current_tbpg.is_current_chapter
ls_chapter_dir = gn_appman.is_wavefile_path + ls_subject + "\" + ls_chapter
ls_content = luo_current_tbpg.dw_content.GetItemString(row, "wave_file")
ll_content_id = luo_current_tbpg.dw_content.GetItemNumber(row, "content_id")
if isnull(ls_content) then ls_content = ""
if trim(ls_content) = "" then
	ls_content = luo_current_tbpg.dw_content.GetItemString(row, "description")	
	if isnull(ls_content) then ls_content = ""
	if trim(ls_content) = "" then
		MessageBox("Error", "The content is not valid, cannot proceed speech training!")
		return
	end if
end if
ls_wave_file = ls_content
ls_wave_path = ls_chapter_dir
gn_appman.of_set_parm("Wave File Path", ls_wave_path)
gn_appman.of_set_parm("Wave File Prefix",  ls_wave_file)
gn_appman.of_set_parm("Content ID",  ll_content_id)
open(w_speech_training)

end subroutine

public subroutine wf_demo_tail ();long ll_x, ll_y, ll_i, ll_height, ll_height_pixel
integer li_dummy[]
string ls_content_list[] = {"BACON","BAGEL","BREAD","DONUT HOLE"}
li_dummy = {0, 13}	
gnvo_is.of_reset_parms()
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Content' + '" Menu Item', false, li_dummy,0,0)
for ll_i = 1 to upperbound(ls_content_list)
	ll_x = st_2.x + st_2.width/2 + WorkspaceX()
	ll_y = st_2.y + st_2.height/2 + WorkSpaceY()
	ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
	ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Add" Menu Item', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'Add" Menu Item', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 65, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Content" Menu Item', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Content' + '" Menu Item', false, li_dummy,0,0)
	li_dummy = {0, 16}	
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, 'Type "' + ls_content_list[ll_i] + '"', true, li_dummy,0,0)
	gnvo_is.of_type_string(ls_content_list[ll_i], 0.1)
	li_dummy = {2, 16}
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, "", true, li_dummy,0,0)
	li_dummy = {0, asc("~t")}
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, "", true, li_dummy,0,0)
	gnvo_is.of_type_string(ls_content_list[ll_i], 0.1)
	ll_x = tab_1.x + tab_1.tabpage_ob.x + idw_content[tab_1.selectedtab].x + WorkspaceX()
	ll_x = ll_x + long(idw_content[tab_1.selectedtab].object.bitmap_file.x) 
	ll_x = ll_x + long(idw_content[tab_1.selectedtab].object.bitmap_file.width)*4/5 
	ll_y = tab_1.y + tab_1.tabpage_ob.y + idw_content[tab_1.selectedtab].y + WorkSpaceY()
	ll_y = ll_y + long(idw_content[tab_1.selectedtab].object.t_2.height) 
	ll_height = long(idw_content[tab_1.selectedtab].object.bitmap_file.height)
	ll_y = ll_y + ll_height*4/5 
	ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
	ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
	ll_height_pixel = UnitsToPixels(ll_height, YUnitsToPixels!)
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Picture" Column', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'Picture" Column to Pull DropDown Listbox', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + (ll_i)*ll_height_pixel, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To the bitmap file for "' + ls_content_list[ll_i] + '"', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On the item to select the bitmap file', false, li_dummy,0,0)

	ll_x = tab_1.x + tab_1.tabpage_ob.x + idw_content[tab_1.selectedtab].x + WorkspaceX()
	ll_x = ll_x + long(idw_content[tab_1.selectedtab].object.wave_file.x) 
	ll_x = ll_x + long(idw_content[tab_1.selectedtab].object.wave_file.width)*4/5 
	ll_y = tab_1.y + tab_1.tabpage_ob.y + idw_content[tab_1.selectedtab].y + WorkSpaceY()
	ll_y = ll_y + long(idw_content[tab_1.selectedtab].object.t_2.height) 
	ll_height = long(idw_content[tab_1.selectedtab].object.wave_file.height)
	ll_y = ll_y + ll_height*4/5 
	ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
	ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Sound" Column', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'Sound" Column to Pull DropDown Listbox', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + (ll_i + 1)*ll_height_pixel, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To the wave file for "' + ls_content_list[ll_i] + '"', false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On the item to select the wave file', false, li_dummy,0,0)

next
li_dummy = {2, 16}	
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, false, false, false, false, false, "", 2.0, "", true, li_dummy,0,0)
ll_x = st_1.x + st_1.width/2 + WorkspaceX()
ll_y = st_1.y + st_1.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 60, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Save" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Save' + '" Menu Item', false, li_dummy,0,0)

gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "' + 'File" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 80, 10, 100, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To "' + 'Close" Menu Item', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, 'Click On "Close' + '" Menu Item', false, li_dummy,handle(gnvo_is.iw_status),1024)
if gnvo_is.iw_demo_selection.cbx_2.checked then
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 80, 10, 100, true, false, false, false, false, false, true, false, "", 0.0, '', false, li_dummy,handle(gnvo_is.iw_demo_selection),1024)
else
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y + 80, 10, 100, true, false, false, false, false, false, true, false, "", 0.0, '', false, li_dummy,handle(gnvo_is.iw_status),1027)	
end if
gnvo_is.ib_demo_selection_on = true
gnvo_is.of_set_index(1)
gnvo_is.start(2)	


end subroutine

public subroutine of_merging ();long ll_row_count
string ls_presentation_type
dwobject dwo
ls_presentation_type = string(idw_subject[tab_1.selectedtab].object.presentation_type.initial)
OpenwithParm(w_material_merge, ls_presentation_type)
If Message.StringParm = "OK" then
	ll_row_count = idw_subject[tab_1.selectedtab].Retrieve(ls_presentation_type)
	if ll_row_count > 0 then
		idw_subject[tab_1.selectedtab].event clicked(0, 0, 1, dwo)
	end if
end if

end subroutine

public subroutine of_exporting ();integer li_row, li_value
long ll_subject_id, ll_chapter_id, ll_content_id
boolean lb_process_import = false, lb_subject_inserted = false, lb_chapter_inserted = false
string ls_export_selection
pointer lp_orig_pointer
datawindow ldw_selected
nvo_export_import lnv_export_import
open(w_export_selection)
ls_export_selection = Message.StringParm
if ls_export_selection = "CANCEL" then return
lnv_export_import = create nvo_export_import
lnv_export_import.of_init_export()
string ls_Docname, ls_named
ls_Docname = "C:\" + ls_export_selection + ".exp"
li_value = GetFileSaveName("Select File", ls_Docname, ls_named, "EXP", "Export File (*.EXP),*.EXP")
if ls_named = "" then
	MessageBox("Error", "Not a valid file name specified")
	destroy lnv_export_import	
	return
end if
if ls_named = "" then
	MessageBox("Error", "Not a valid file name specified")
	return
end if
choose case ls_export_selection
	case "SUBJECT"
		ldw_selected = idw_subject[tab_1.selectedtab]
		for li_row = 1 to ldw_selected.RowCount()
			if ldw_selected.GetItemString(li_row, "export_ind") = '1' then
				lb_process_import = true
				ll_subject_id = ldw_selected.GetItemNumber(li_row, "subject_id") 
				lp_orig_pointer = SetPointer(HourGlass!)
				lnv_export_import.of_export_subject(ll_subject_id, 1, 1)
			end if
		next
	case "CHAPTER"
		ldw_selected = idw_chapter[tab_1.selectedtab]
		for li_row = 1 to ldw_selected.RowCount()
			if ldw_selected.GetItemString(li_row, "export_ind") = '1' then
				lb_process_import = true
				ll_chapter_id = ldw_selected.GetItemNumber(li_row, "chapter_id") 
				if not lb_subject_inserted then
					lb_subject_inserted = true
					select subject_id into :ll_subject_id from chapter where chapter_id = :ll_chapter_id;
					lnv_export_import.of_export_subject(ll_subject_id, 1, 0)
				end if
				lp_orig_pointer = SetPointer(HourGlass!)
				lnv_export_import.of_export_chapter(ll_subject_id, ll_chapter_id, 1, 1)
			end if
		next
	case "CONTENT"
		ldw_selected = idw_content[tab_1.selectedtab]
		for li_row = 1 to ldw_selected.RowCount()
			if ldw_selected.GetItemString(li_row, "export_ind") = '1' then
				lb_process_import = true
				ll_content_id = ldw_selected.GetItemNumber(li_row, "content_id") 
				if not lb_subject_inserted then
					lb_subject_inserted = true
					select chapter_id into :ll_chapter_id from content where content_id = :ll_content_id;
					select subject_id into :ll_subject_id from chapter where chapter_id = :ll_chapter_id;
					lnv_export_import.of_export_subject(ll_subject_id, 1, 0)
					lnv_export_import.of_export_chapter(ll_subject_id, ll_chapter_id, 1, 0)
				end if
				lp_orig_pointer = SetPointer(HourGlass!)
				lnv_export_import.of_export_content(ll_chapter_id, ll_content_id, 1)
			end if
		next
end choose		

if not lb_process_import then
	MessageBox("Warning", "No materials selected for exporting!")
	
else
	lnv_export_import.of_post_exporting(ls_named, ls_export_selection, 1)
	lp_orig_pointer = SetPointer(lp_orig_pointer)
end if
destroy lnv_export_import 
end subroutine

public subroutine of_save_material_as_flat_file ();integer li_row, li_value, li_i, li_i2, li_FileNum,  li_count, li_sel_list[4]
long ll_subject_id, ll_chapter_id, ll_chapter_ids[]
string ls_subject_desc, ls_presentation_type, ls_chapter_desc, ls_chapter_details, ls_content_desc, ls_content_detials
string ls_Docname, ls_named, ls_field_selection, ls_output

ll_subject_id = cur_tbpg.il_current_subject_id
if ll_subject_id = 0 then
	MessageBox("Error", "No Subject Is Selected!")
end if

open(w_text_file_field_selection)
ls_field_selection = Message.StringParm

for li_i = 1 to 4
	li_sel_list[li_i] = integer(mid(ls_field_selection, li_i, 1))
next

select description, presentation_type
into :ls_subject_desc, :ls_presentation_type
from subject
where subject_id = :ll_subject_id;
ls_Docname = "C:\" + ls_subject_desc + ".txt"
li_value = GetFileSaveName("Select File", ls_Docname, ls_named, "TXT", "TEXT File (*.TXT),*.TXT")
if ls_named = "" then
	MessageBox("Error", "Not a valid file name specified")
	return
end if
li_FileNum = FileOpen(ls_named, LineMode!, Write!, LockWrite!, Replace!)
FileWrite(li_FileNum, ls_subject_desc)
DECLARE chapter_cur CURSOR FOR
	SELECT chapter_id
	FROM chapter
	WHERE subject_id = :ll_subject_id;
OPEN chapter_cur;
do 
	FETCH chapter_cur INTO :ll_chapter_id;
	IF SQLCA.sqlcode <> 0 THEN exit
	ll_chapter_ids[upperbound(ll_chapter_ids) + 1] = ll_chapter_id
LOOP WHILE SQLCA.sqlcode = 0
CLOSE chapter_cur;

for li_i = 1 to upperbound(ll_chapter_ids)
	ll_chapter_id = ll_chapter_ids[li_i]
	SELECT description, details INTO :ls_chapter_desc, :ls_chapter_details
	FROM chapter
	WHERE chapter_id = :ll_chapter_id;
	if isnull(ls_chapter_desc) then ls_chapter_desc = ""
	if isnull(ls_chapter_details) then ls_chapter_details = ""
	
	ls_output = ""
	if li_sel_list[1] = 1 then ls_output = "~t" + ls_chapter_desc
	if li_sel_list[2] = 1 then ls_output = ls_output + "~t" + ls_chapter_details
	
	FileWrite(li_FileNum, ls_output)
	DECLARE content_cur CURSOR FOR
		SELECT description, details
		FROM content
		WHERE chapter_id = :ll_chapter_id;
	OPEN content_cur;
	do 
		FETCH content_cur INTO :ls_content_desc, :ls_content_detials;
		IF SQLCA.sqlcode <> 0 THEN exit		
		if isnull(ls_content_desc) then ls_content_desc = ""
		if isnull(ls_content_detials) then ls_content_detials = ""
		ls_output = "~t"
		if li_sel_list[3] = 1 then ls_output = ls_output + "~t" + ls_content_desc
		if li_sel_list[4] = 1 then ls_output = ls_output + "~t" + ls_content_detials
		FileWrite(li_FileNum, ls_output)		
	LOOP WHILE SQLCA.sqlcode = 0
	CLOSE content_cur; 
next
FileClose(li_FileNum) 
end subroutine

on w_materials.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.tab_1=create tab_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.rr_1
end on

on w_materials.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.tab_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.rr_1)
end on

event open;call super::open;
long ll_row_count, ll_subject_id, ll_content_id
integer ll_total_count, li_i
string ls_material_type[] = {"Object", "Quantity", "Reading", "Speech"}
string ls_stringparm
dwobject dwo
ls_stringparm = Message.StringParm
ole_1.visible = false
iw_material = this
im_material = create m_material
inv_sound_ole = create nvo_sound_ole_control
inv_sound_ole.of_set_ole(ole_1, handle(this))
im_material.mf_set_window(iw_material)
tab_1.tabpage_ob.il_tabpage_id = 1
tab_1.tabpage_qy.il_tabpage_id = 2
tab_1.tabpage_rd.il_tabpage_id = 3
tab_1.tabpage_sp.il_tabpage_id = 4
idw_subject[1] = tab_1.tabpage_ob.dw_subject
idw_subject[2] = tab_1.tabpage_qy.dw_subject
idw_subject[3] = tab_1.tabpage_rd.dw_subject
idw_subject[4] = tab_1.tabpage_sp.dw_subject
idw_chapter[1] = tab_1.tabpage_ob.dw_chapter
idw_chapter[2] = tab_1.tabpage_qy.dw_chapter
idw_chapter[3] = tab_1.tabpage_rd.dw_chapter
idw_chapter[4] = tab_1.tabpage_sp.dw_chapter
idw_content[1] = tab_1.tabpage_ob.dw_content
idw_content[2] = tab_1.tabpage_qy.dw_content
idw_content[3] = tab_1.tabpage_rd.dw_content
idw_content[4] = tab_1.tabpage_sp.dw_content
idw_content[4].dataobject = "d_content_speech"
idw_content[1].object.wave_time.protect = 1
idw_content[2].object.wave_time.protect = 1
tab_1.tabpage_ob.iw_main = this
tab_1.tabpage_qy.iw_main = this
tab_1.tabpage_rd.iw_main = this
tab_1.tabpage_sp.iw_main = this
if gnvo_is.ib_demo_is_going then
	wf_delete_demo()
end if

// set home license
if gn_appman.ib_home_version then
	// lesson setup
	tab_1.tabpage_rd.visible = (fnGetLicenseBit(5, gn_appman.iu_home_license_num) = 1)
	tab_1.tabpage_sp.visible = (fnGetLicenseBit(5, gn_appman.iu_home_license_num) = 1)
end if


for li_i = 1 to 4 
	idw_subject[li_i].SetTransObject(SQLCA)
	idw_subject[li_i].object.presentation_type.initial = ls_material_type[li_i]
	idw_chapter[li_i].SetTransObject(SQLCA)
	idw_content[li_i].SetTransObject(SQLCA)	
	ll_row_count = idw_subject[li_i].Retrieve(ls_material_type[li_i])
	if ll_row_count > 0 then
		idw_subject[li_i].event clicked(0, 0, 1, dwo)
	end if
next

if gnvo_is.ib_demo_is_going then
	post wf_demo()
elseif gn_appman.ib_trial_version then
	open(w_announcement)
end if

if ls_stringparm = "Reading" then
//	tab_1.post event selectionchanged(1, 3)
	tab_1.post SelectTab ( 3 )
end if

end event

event close;call super::close;//destroy ilb_bitmap
//destroy ilb_wave
//
destroy im_material
destroy inv_sound_ole
end event

event timer;call super::timer;inv_sound_ole.of_post_loading()
timer(0, this)
end event

type ole_1 from olecontrol within w_materials
integer x = 1426
integer y = 16
integer width = 146
integer height = 128
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_materials.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

event datachange;//MessageBox("datachanged","datachanged")
inv_sound_ole.ib_ole_data_changed = true
end event

event close;long ll_row, ll_row_count, ll_return, ll_i
string ls_content, ls_wave_file
datawindowchild ldwc
u_tbpg_material luo_current_tbpg
inv_sound_ole.of_save_wave_file()

if not inv_sound_ole.ib_data_save and inv_sound_ole.ib_ole_data_changed then
	if fnCheckClipboardData(handle(this)) < 1 then // empty buffer
		if MessageBox("Do you want to save the sound file?", "If Yes, please click Edit-Copy before exit the recorder!", Question!, YesNo!) = 1 then
			ole_1.post activate(offsite!)
			return
		end if	
	end if
end if
inv_sound_ole.ib_object_open = false
if not inv_sound_ole.ib_data_save then return
if not ib_new_file then return
if ii_wave_file_edit_source_ind < 1 then return 
if ii_wave_data_row < 1 then return
luo_current_tbpg = cur_tbpg
if ii_wave_file_edit_source_ind = 1 then // sound file for chapter
	ls_wave_file = luo_current_tbpg.dw_chapter.GetItemString(ii_wave_data_row, "description")
	luo_current_tbpg.dw_chapter.SetItem(ii_wave_data_row, "wave_file", ls_wave_file + ".wav")
	if luo_current_tbpg.dw_chapter.GetChild("wave_file", ldwc) < 1 then return
	ll_row = ldwc.InsertRow(1)
	ldwc.SetItem(1, "filename", ls_wave_file + ".wav")
else //sound file for content
	ls_wave_file = luo_current_tbpg.dw_content.GetItemString(ii_wave_data_row, "description")
	luo_current_tbpg.dw_content.SetItem(ii_wave_data_row, "wave_file", ls_wave_file + ".wav")
	if luo_current_tbpg.dw_content.GetChild("wave_file", ldwc) < 1 then return
	ll_row = ldwc.InsertRow(1)
	ldwc.SetItem(1, "filename", ls_wave_file + ".wav")
end if

end event

type tab_1 from tab within w_materials
string tag = "1302000"
integer y = 156
integer width = 3950
integer height = 2336
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_ob tabpage_ob
tabpage_qy tabpage_qy
tabpage_rd tabpage_rd
tabpage_sp tabpage_sp
end type

on tab_1.create
this.tabpage_ob=create tabpage_ob
this.tabpage_qy=create tabpage_qy
this.tabpage_rd=create tabpage_rd
this.tabpage_sp=create tabpage_sp
this.Control[]={this.tabpage_ob,&
this.tabpage_qy,&
this.tabpage_rd,&
this.tabpage_sp}
end on

on tab_1.destroy
destroy(this.tabpage_ob)
destroy(this.tabpage_qy)
destroy(this.tabpage_rd)
destroy(this.tabpage_sp)
end on

event selectionchanged;call super::selectionchanged;dwobject dwo
cur_tbpg = control[newindex]
gi_material_tabpage = newindex
if (cur_tbpg.dw_subject.RowCount() > 0) and cur_tbpg.il_current_subject_row = 0 then
	cur_tbpg.il_current_subject_row = 1
	cur_tbpg.dw_subject.event clicked(0, 0, cur_tbpg.il_current_subject_row, dwo)
end if
end event

type tabpage_ob from u_tbpg_material within tab_1
string tag = "1302010"
integer x = 18
integer y = 112
integer width = 3913
integer height = 2208
string text = "Object"
end type

type tabpage_qy from u_tbpg_material within tab_1
string tag = "1302020"
integer x = 18
integer y = 112
integer width = 3913
integer height = 2208
string text = "Quantity"
end type

type tabpage_rd from u_tbpg_material within tab_1
string tag = "1302030"
integer x = 18
integer y = 112
integer width = 3913
integer height = 2208
string text = "Reading"
end type

type tabpage_sp from u_tbpg_material within tab_1
string tag = "1302040"
integer x = 18
integer y = 112
integer width = 3913
integer height = 2208
string text = "Speech"
end type

type st_1 from statictext within w_materials
integer x = 27
integer y = 36
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8421376
string text = "File"
alignment alignment = center!
boolean border = true
long bordercolor = 8421376
boolean focusrectangle = false
end type

event clicked;im_material.m_file.popmenu(gn_appman.iw_frame.workspaceX() + parent.x + x , &
gn_appman.iw_frame.workspaceY() + parent.y + y + 2.5*height)
end event

type st_2 from statictext within w_materials
integer x = 283
integer y = 36
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8421376
string text = "Add"
alignment alignment = center!
boolean border = true
long bordercolor = 8421376
boolean focusrectangle = false
end type

event clicked;im_material.m_add.popmenu(gn_appman.iw_frame.workspaceX() + parent.x + x , &
gn_appman.iw_frame.workspaceY() + parent.y + y + 2.5*height)
end event

type st_3 from statictext within w_materials
integer x = 539
integer y = 36
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8421376
string text = "Delete"
alignment alignment = center!
boolean border = true
long bordercolor = 8421376
boolean focusrectangle = false
end type

event clicked;im_material.m_delete.popmenu(gn_appman.iw_frame.workspaceX() + parent.x + x , &
gn_appman.iw_frame.workspaceY() + parent.y + y + 2.5*height)
end event

type st_4 from statictext within w_materials
integer x = 795
integer y = 36
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 8421376
string text = "Tools"
alignment alignment = center!
boolean border = true
long bordercolor = 8421376
boolean focusrectangle = false
end type

event clicked;im_material.m_tool.popmenu(gn_appman.iw_frame.workspaceX() + parent.x + x , &
gn_appman.iw_frame.workspaceY() + parent.y + y + 2.5*height)
end event

type rr_1 from roundrectangle within w_materials
long linecolor = 797411200
integer linethickness = 4
long fillcolor = 32896
integer y = 16
integer width = 1065
integer height = 112
integer cornerheight = 40
integer cornerwidth = 46
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_materials.bin 1540 
20000001a08024003e735f6f75000000740000026800008024000001a08024003e74786574000000000000028000060018000000208025004a746e6f635f746e656373656474706972006e6f69c000008f000000c2000001a08024003e0000020c0001000600010000000001c70000000000000000000001a08024003e0000028000060018000001a08024003e685f6c69696c5f695f7468676f6c6f6300000072000002ec00020022000002ec0002003b000001a08024003e0000020c00010006000001a08024003e6e65706f72657375656a626f00007463c000005200000328000001a08024003ec000005200000328000001a08024003e6973697600656c620000035800070002000001a08024003e0000020c0001000600010000000001c70000000000000000735f6469646e756f70616c5f00006573000003880005003d000000208025004a657661776d69745f65670065657469746d756e6d00726562c0000089000003b2000000180001000c0000002c0001000c0000004c0001000c000000600001000d000000680001000c000000a80001000c000000b00001000c000000d00001000d000000e80001000c000000f00001000c000001040001000d000001180001000c000001200001000c0000013c0001000d000001440001000c0000014c0001000c000001580001000c0000016c0001000c000001840001000c0000018c0001000c000001980001000c000001a80001000c000001b00001000c000001b80001000c000001d00001000d000001d80001000c000001e00001000c000001ec0001000c000001f40001000c000001fc0001000c000002040001000c000002140001000c0000021c0001000c000002280001000c000002300001000c000002380001000c000002400001000c000002500001000c000002580001000c000002600001000c0000027000010012000002780001000c000002880001000c000002900001000c000002ac0001000d000002b40001000c000002bc0001000c000002c400010005000002d40001000c000002dc0001000c000002e40001000c000003000001000c000003080001000c000003100001000c000003180001000c000003200001000c000003380001000d000003400001000c000003480001000d000003500001000c000003600001000c000003680001000c000003700001000c0000037800010005000003980001000c000003a00001000c000003c00001000d000a013c0012000400000000000880010138000000130000001d001e0000001c0001011f0024002a00870000001e00020038001d011f0000002a00010000004000020087001d001e000000500001011f0058002a00870000001e00020064001d011f0000002a00010000006c000200870000011a001d001e0000007c00000024000101b90001008b0000007d001d001e000000840000001b00010031003c00000052000201d001af001d001e0000008c0000002400020087001d001e000000940000001b00020031003c00000052000201d001af001d001e0000009c0000002400020087001d001e000000a40000001b00030031003c00000052000201d001af001d001e000000ac0000002400020087001d001e000000b40000001b00040031003c00000052000201d001af001d001e000000bc000000240002008700000000000300000004000000050012000600280007003e000800540009006a000a0086000b00b2000c00de0010010a000800640000001100000000202020200020202072756369746e657200001400ff000000080000ff0000000000000000c40001058800000020000000202020206300202074616572626300656165725f676e69640f000000360000000f800d000d000000630000806c635f620065736f2c635f6c370000002c801b001b0000007400008000315f76480000003800000048801d001d000000700000806000315f3900000060802100210000006300008072746e6f74006c6f1600000074406700160000000f4067003600000074800d00160000002c4067003700000074801b0016000000484067003800000074801d001600000060406700390000001c8021000c0000002400010012000000380001000c0000004000010012000000500001000c0000005800010012000000640001000c0000006c000100120000007c0001000c000000840001000c0000008c0001000c000000940001000c0000009c0001000c000000a40001000c000000ac0001000c000000b40001000c000000bc0001000c0000005000010002000500010012000100000000000880000138001e0013001c001d0024000000100000001d001e0000003000000024001e00100040001d0024000000100000001d001e0000004c000000240000001000000000000000020012000300200004002e0005003c0006006400100008000800000000002000000020202020000020200000540000002000202020002020202073656400796f72745f6263006461657200676e69000010000d0036005f626380736f6c635f620065000024631b0037005f7674801b000031000038801d003800315f7080000048002100390000001c8001000c000000300001000c000000400001000c0000004c0001000c000a01b6001a000700120000010000360008800100380000007f0000011e00000020001d001f000000310001010000ff0001008b00800031008b000000310001000000ff0001008b001001bc00bd40b90103011001380000007f000301
201e0002003c001d001f00000038000101000044000101300058003800300000003800010100006200010130006b00380030000000bc000101b900f901f901bd400000040004013800020085001d001e000000780001011f008c016a00870000001e00020094001d00240000001d00000000009c0002011f00a400380030000000850001011e000200b0001d00240000002c000000290022000000c80000000100020138001e001300d8001d002400000039000000290000000000ec0000000100020138001e001300f400380030000000310001010000000000003100310000000000010001008b0003003800300000013800010100010e0001013000280029000600000138000000130007011d001e000001300000002400010039003800290001000001380000001300020126002c000101950031019c000000000001000000030000002c01aa001d0026000001400000002400010000000000000001000000000001001800060058000700a2000900b8000a00dc000b00fc000d001c000e0062000f0182001101640010013a000800000000002000000020202020610020207365636e72726f74727574656c61766e6c00657568635f6c6574706164695f726c7173003a00616373656d3a6567617300005000ff000000080000ff00000000000000000000021dff0000001c0000ff00000000000000000000021dff0000002a0000ff220000004000000000802616ff000000300000ff2600000040000000488028167000000120000000202020206f002020006e6570685f6c69696c5f695f7468676f6c6f630d0000723b0000006900020061775f7369666576705f656c0068746128000000420000004c0006006e72616520676e69706c6548492e72655200494e756f736573656372766177006c69666569000065635f736465746e6f6c00746e4a000000648025007361746165726f7480000000250000006c0000804a000000ff802500010000ff640006006165725f676e69646c0001004a00000073802500727474656f736e6163656a62ed000074b8c000007400000000315f76d00001003800000073801d00657274657761726431000000e0c00000640000006275735f7463656a7865745f7573007463656a6264695f7473656400706972636e6f69745f667700656b616d0076745f8d0000001ac00000d00000013800000031801d00e0c00000ff000000060000ff200002000c0000003c0001000c000000780001000c0000008c00010012000000940001000c0000009c0001000c000000b00001000c000000c80001000d000000d80001000c000000ec0001000d000000280001000d000001300001000c000001380001000d000001400001000c0000015c000100040008011d001e000000140001011f000200f5001e00000024001d00240000001e0000002c001d0024000000af0000001d0025010000400002011f001d001e0000005c000000240002007f001d001e0000006400000024001d001e0000006c000000240001003100590000002501af0074001d001f0000001e0002017c001d00240000001e00000084001d00240000003100000000000100af0059001d013d010000a0000000240002007f001d001e000000a800000024001d001e000000c0000000240001003c000200c5003100f000000000000100490001012b003f01bc00bd40b90101013f013800000013000101280003001d001e010000d800000024001d001e000000e000000024004301af0001004e0101013b003f01bc00bd40b90101013f01380000001300010126002c0001019500310142000000000001000000030000002c0150001d0026000000e80000002400010000000000000001000000000001001200020048000300a8000400ca000500ec000600f000070028000a0064001001120008000000000020000000202020203a00202073656d3a6567617300001400ff000000080000ff2600000040000000f08028168000000020000000202020206900202074735f6c646e695f080078653c00000069000200735f6f751c0000743e000000088024003c00000062000200636b6361726f6c6f34000000160000006900020069685f6c67696c5f635f7468726f6c6f480000003b0000001c0002003e000000088024003c00000034000200160000001c0002003e000000088024003c0000006900020065645f6c6c7561666f635f7400726f6c8c022b0523000000080002003c000000690002006f725f696f635f7700746e75b0022b0d44000000690001006f735f645f646e757370616cc80000653d000000080005003c000000ff000200060000ff140002000c000000240001000c0000002c0001000c000000400001000c0000005c0001000c000000640001000c0000006c0001000c000000740001000c0000007c0001000c000000840001000c000000a00001000c000000a80001000c000000c00001000c000000d80001000c000000e00001000c000000e80001000c000000e00001000300070000011a002700120001000000000008800001380000007f0001011a00010031008b0000007d000100030000001a003800f3000101000000001d001e0000001800000024000101b90001001b0001003c000200dd001e009e001d001e00000020000000240001001b0001003c003d01af00380029010100000038000000130002011d001e00000040000000240001001b0001003c002501af00030010001e002e0054001d00240000001000000026002c0001019500
203100c6000000000001000000030000002c00d4001d00260000005c0000002400010000000000000001000000000001001800020056000300800004009a0005009e000700ac000800640010002b000800000000002000000020202020610020207365636e72726f74727574656c61766e6c00657500695f69656d3a3a67617373003c0065000000000000ffff000000080000000000021d00000000000000ffff0000001c0000000000010500000000000000ffff00000021000000268028164000000064000000302020202000202020736f6c637569006574735f6f000000000000000e8024003e0000000e8024003e736f6c63657375656a626f7200746365c0000044000000280000000e8024003e5f736469746e6f6300746e65000000488025004a0000ffff00020006000000180001000c000000200001000c000000380001000d000000400001000c000000540001000c0000005c0001000c00030000000180028002000400070027003680028002000500060041008c8002800200000001008d008e8002800200020025000000270046002800470088019c003601b1003701b2008a01b3003e01f3008701f90041020e003200100052000b000000002020000020202020752b002061745f65667700626b616d5f76745f655f66770074696e697865745f696c5f742b007473616572632b0065747473656400796f7265706f2b742b006e72656d696c632b000065736f000000a0ffff00000008000000000000150000000000c000ffff00000010000000010000150000000000c000ffff0000001b000000020000150000000000c000ffff0000002d000000030000150000000000c000ffff00000035000000040000150000000000c000ffff0000003e000000050000150000000000c000ffff00000044000000060000150000000000c000ffff0000004b000000070000150000000010c000000b003200000153000000182020202000202020746469776568006874686769746974006200656c636b6361726f6c6f5f6263006461657200676e69635f626365736f6c5f7674005f7000316c6900316665645f746c75616c6f635f6900726f69685f6c67696c5f635f7468726f6c6f5f6c6900695f74737865646e5f6469006e756f73616c5f64006573700f3e000100000000000000005f6f7569000074730f0000010000000000000000775f73695f657661656c69665f7369006d746962665f706100656c69735f7369656a62756900746361775f7369666576705f656c006874616c5f7369007473690f0000010000000000000000725f6969635f776f746e756f7473690076745f726574695f7469006d745f69766900706d75635f6c6e65727261685f74656c646e5f6c69007274657265766569646e695f5f6c6900727275635f746e65706168635f72657469006469635f736465746e6f8000746e080000009400010008000000e000010008000000f40001000000080100ffff0000000800000f3b00010500008900080000ffff0100000e0000079400010500009800080000ffff400000150000020400061100800000080000ffff0000001b00c0c0c000021d00040100000000ffff0100002500000000000d0d00006200008000ffff4000003000000000001b0d00000000008000ffff0000003900000000001d0d00000100008000ffff0100003e0000000000210d00007100008000ffff400000420000000000021f00000000000000ffff000000530000000000021f00000100000000ffff010000650000000100021f000060000000000080400000710000000000052f3e00000000000000940000008c0000000000242f00000200008000ffff760000a00000000000060f00001400000000ffff800000ad0000000000060f00000000000000ffff000000bc0000000000060f00000000000000ffff000000c70000000000060f0000000000000000e0000000d80000000000062f00000000000000ffff000000ec0000000000010700000000500000ffff000000f90000000000224f04000000508000ffff000001060000000000194f04006800508000ffff4000010f0000000000025f00000000500000ffff000001210000000000025f00008600500000ffff400001310000000000025f00000000500000ffff000001470000000000254f0000000000800a5d000000000000060d0000000001000705000000000000030d040000040e800105000000020c0001050000000f3b0001050000000794000105000080000100070500010000010007050000000204000611008000000000060d000000000000040d0000ee00018007050001ee00010007050001ee0001000705000100000000070500000000000007050000ee0001000705000180000100070500018000000005050201000002800605020000024c8007310080c0c0c080021d00040000b8000611008000000000060d000000000000010500000000000001050000000000000105000000000000010500000000000007050000000001000705004000000100080502400000008001050000000000000105000000000000010500000000000001050000000000000705000000000100070500400000000007050000000000000705000000000000070500000000000007050000000000000107000000000000010700000000000001070000000000000107000000000000010700000000000001070000000001000707000000000000090f000000000080021f000000000000021f0000
20000000000a0f0000000000800d0d0000000000801b0d0000000000801d0d000000000080210d000000000080021f000000000000021f000000000100021f00000002740005333e8000029c002433008000000080060f000000000000060f000000000000060f000000000000060f00000002c40006330080000000000107000000000000224f040000000080194f040000000080025f000000000000025f000000000000025f000000000000254f000000001580000020000000080000ffff000000000000008c0000ffff00020002000200c201000000000000000000ffff00000067000000740000002c0000ffff000000000001008d00000000000600000002ffff80000000000000000000ffff000000720000007c0000ffff0000ffff000000000002008e00000001000000000002ffff80000000000000000000ffff000000840000007c0000ffff0000ffff000000000003000000008002000000000000ffff81000000000000000000ffff0000008c0000007c0000ffff0000ffff000000000004000100008003000000000000ffff81000000000000000000ffff000000950000007e0000ffff0000ffff00000000000500360000800400000002000001b181000000000000000000ffff0000009b0000007e0000ffff0000ffff000000000006004100008005000000020000020e81000000000000000000ffff000000a20000007e0000ffff0000ffff000000000007002700008006000000020000004681000000000000000000ffff0001000100d600000004000a011d001f000000180000002400000031003c000000a50002004400020020003800300000003800010100002600010130009b01bc00bd40b90002009b0138000000130002011d001f0000005000000024001d001f00000058000000240001003c002501af006c001d001f0000001f00020174001d00240000001f0000007c001d00240000003c000000af0001001d013d01000098000000240002007f0008003a00bc404700b9011d011d01bd4000000101010138002c0013001d0024000000b400000024001d001f000000c8000000240025007a00d00038017a0000001f012600e0001d00240000007a0000003101260000000100010090000101bc00bd8002000200340138000000130002015201bc00bd40b90100015201240000001f001301f4001d001f000000310001010000010002007f001d001f000000fc00000024001d001f0000010400000024002501af000c001d001f0000011f00020128001d00240000017f0000001f00020040001d00240000011f00000048001d0024000001af0000004e0143013b000100bc000101b9013f013f01bd4000000101010138002c00130095002600bc000101000031010000000000000100ca00030026002c0150001d0024000001000000000000010000000000010001000200000004001c000500440006009c000700b60008010c0009011e000a0134000e016a001001a2000800640000001c000000000020202000202020205f6e67006d7070613a006e6173656d3a6567617300002800ff000000080000ff240000004000000000802717ff000000120000ff260000004000000058802816900000012000000020202020690020206f725f696f635f7700746e75080000004400000045000100726f7272206f4e00747865746176612062616c696920656c6874206e632073697470616869007265735f6f75480000743e000000088024004400000062000100636b6361726f6c6f6000000016000000480002003e00000008802400440000006900010065645f6c6c7561666f635f7400726f6c84000705230000006900020061775f7369666576705f656c00687461a08000010a0000006900060075735f7363656a62bc000074410000005c0006005f736900657661776c69665fd20000653f0000006900060074735f6c646e695fe80078653c000000480002003e000000e88024003c00000060000200160000006900020069685f6c67696c5f635f7468726f6c6f140000003b000001690002006f735f645f646e757370616c300000653d000001e80005003c000000ff000200060000ff180002000c000000500001000c000000580001000c0000006c0001000c000000740001000c0000007c0001000c000000980001000c000000b40001000c000000c80001000c000000e00001000c000000f40001000c000000fc0001000c000000040001000c0000010c0001000c000001280001000c000001400001000c000001480001000c000001500001000c000001320001000d00000032000880320010001f000b000000000020000000202020202b00202063696c630064656b70646e737379616c646e756f00280061000000080000ffff0000000800000000c0001500000000080000ffff0000001100000028c000150200320010006c000b0000000020200000202020200078002069770079006874646769656874007468726f6261007265646e697262746f74677400706f7374786500657a69676965776600746863746e6f737261686600746570746e6f686374696e6f66006d61667400796c6965636166656d616e7865740001040074000000080000ffff0000000800000b2900010500000000080000ffff0000000a0000004400010500000000080000ffff0000000c0000020e00010500000000080000ffff000000120000006c00010500000000080000ffff000000190000000a00010500000000080000ffff00000022
200000000100070500000000080000ffff0000002dfffffff600010500000000080000ffff00000036000002bc00010500000000080000ffff0000003d00000000800e0502000000080000ffff0000004900000002800f0502000000080000ffff000000530000000280100502000000080000ffff0000005e800002ec00061100000000080000ffff00000067800002f30006110000000000000a5d000000000000060d0000000001000705000000000080030d0400000b290001050000000044000105000000020e000105000000006c000105000000000a000105000000000000060d0000000000000705000000000100070500fffffff600010500000002bc0001050000000000800e050200000002800f05020000000280100502800002ec00061100000000000007050000000000000705000000000000060d004000000100070500800002f30006110000000000000705000000000000070500000000a90000007e0000ffff0000ffff000000000000003200008000810000020000000800000000000000000000ffff00010001004a00000002000201bc001f40b90012001201bd0000000100010138002c00130195002600300001000000310000000000000001003e00030026002c0008001d002400000000000000000001000000000001000100020000001000160008006400000012000000002020202000202020656d3a3a6761737300140065000000000000ffff000000080000002680281640000000100000000820202020002020200000ffff00020006000000080001000c000000320008801b00100032000b003200000011000000002020202000202020696c632b64656b6320001400ff202020080000ff0000000000635f0010c000150b00320000006c00000000002020200020202020790078006469770068006874686769656174007464726f6262007265676e69726f746f7465740070697374787700657a686769656f6600746863746e657372616f6600746970746e00686374746e6f66696d61666600796c6e65636100656d617478657408010400ff000000080000ff850000000000000d08000105ff31a9000a0000ff440000000000000008000105ff4018000c0000ff4e0000000000000108000105ff000000120000ff6c0000000000000008000105ff710100190000ff140000000000000008000105ff400600220000ff010000000000000008000705ff0000002d0000fff600000000ffffff08000105ff610100360000ffbc0000000000000208000105ff4070003d0000ff000000000200000008800e05ff000000490000ff020000000200000008800f05ff610100530000ff020000000200000008801005ff40bc005e0000ffec0000000080000208000611ff000000670000ff0200000000800003000006110000000000000a5d000000000100060d0000000000000705040000008580030d0000000d44000105000000004e000105000000016c00010500000000140001050000000000000105000000000000060d000000000100070500000000f600070500ffffffbc00010500000002000001050200000002800e050200000002800f0502000000ec801005008000020000061100000000000007050000000000000705000000000100060d00400000020007050080000300000611000000000000070500000000a90007057e000000ff000000ff0000ff000000ff320000000000000002000080088100000000000000000000ff000000010000ff000001000800f6001e00030001001b000301a9001000290002000000b6000000380001011300030103001b0018001d0024000000310000000000020002003c000200a5001f00c20030001d001f0000001b0001011d000300000038000001830001016700878022001a0002001f00020158001d00240000007f0000001f00000060001d001f0000001f00010168001d00240000001d000000000078000000240002007f0002001b001d001f0000008000000024000200b5001f00c2009c00290000000000380000001300010126002c00010195003100dc000000000001000000030000002c00ea001d0026000000a40000002400010000000000000001000000000004001e0006003c00070060000800740009009a000a00b0000b00c2000f0064001000400008000000000020000000202020206f0020206168646c656c646e77656e00646e61686c00656c6c6f5f6c68635f646574706164695f7276746c00706d745f6d3a3a0061737365640065670000000000ffff000000080000000000021d00000000000000ffff000000120000000000021d00000000000000ffff0000001c0000000000021d00000000000000ffff0000002e0000000000190d04000000008000ffff000000360000002600281640000000ac80000058002020200020202020746567006d65746900005c00000008c000ffff00010009007473690076745f726574695f0000006d000020002200450000ffff8008000f005f6c6900727275635f746e65706168635f726574000064690000400002004900000040000200490000002000220045007461648064695f61000070000200000000004000020049005f66770074696e697865745f696c5f740000747300008e2b000088c000ffff00020006000000100001000d000000180001000c000000300001000c000000380001000c000000580001000c000000600001000c000000680001000c000000780001000c000000800001000c0000009c00
2001000d000000a40001000c0000004c0024801d0010004c020b00320000001a0000000000202020002020202065732b007463656c636e6f69676e6168140064650000000000ffff00000008000600000000150000320010c0b9000b0008000000200000002020202078002020770079006874646969656800007468676f6261747265647261726400747561677262006f74676e69706f746f6965770000746867746e6f667261686300746573746e6f66637469706f6600686166746e796c696d636166006d616e656f620065726564726c797473696c00656173656e6f6f727469680074657365647463656c006e6f69746369706e65727500656d6101000000000d0000000000007000000075746369616d65726f636b7300726f6c0000009c0001000800080154ffff000000080000004500000500000000080001ffff0000000a0000004400000500000000080001ffff0000000c0000048e00000500000000080001ffff000000120000067c00000500000000080001ffff000000190000001e00000500000000080001ffff000000220000000100000500000000080007ffff0000002b0000000100000500000000080007ffff000000360000019000000500000000080001ffff0000003d000000000000050200000008800effff00000049000000020000050200000008800fffff000000530000000200000502000000088010ffff0000005e0000030900001100800000080006ffff00000067000000050000050201f70008801effff00000073000000010000050001f700080007ffff0000007f000000000000050001f700080007009c0000008d0000038800003100800000080006ffff000000a80000ffff00001d0020ff000000025d0000000000000a0d0000000001000605000000000000070d04000000458003050000000044000105000000048e000105000000067c000105000000001e000105000000000000010d0000000001000605000000000100070500000000000007450000000000000105000000019000010500000000000001050200000002800e050200000002800f05020000030980101100800000000006050000000000000705000000000000070d000000000000061d000000000000021d00400000010002050040000001000705004000000000070500000000050001050201f70000801e05000000000000010500000000000007050000000001000705004000000100070500400000010007050001f7000100070500400000000007050001f70001000705004000000000070500000000000007050000000000000705000000000000070500000000000007050200000328801f3100800000000006050000000000000105000000ffff00011d0020ff036000023100800000000006050000000000000105000000000000011d00000000c600020098000000800000ffff000000000000004c00008000000000020000022481020000000000000000ffff000000000000003200100008000b0000000020200000202020200000002000320010003b000b00000000202000002020202000780020697700790068746467696568620074686564726f6f620072726564726c7974736f6600657273756361746365656c676e08008c00ff202000080000ff200000000000000508000105ff7478000a0000ffd80000000000000008000105ff6374000c0000ffa50000000000000908000105ff6e6f00120000ffcc0000000000000508000105ff696600190000ff010000000000000008000705ff6c7900200000ff050000000200000008801e05ff6269002c0000ff0000000000000000000007050000000000000a5d000000000100060d0000000000000705040000002080030d00000005d800010500000000a500010500000009cc00010500000005000001050000000000000105000000000000060d00000000000007050000000000000705000000000100060d00400000000007050000000000000705000000000000060d000000000100070500000000050007050200000000801e0500000000000007050040000000000705000000000000060d3200100008000b0000000000200000002020202000002020320010001c000b00000000002000000020202020640020205f61746164006469726373656974706928006e6f2000000000ffff200000080000000000021d00006500000000ffff740000100000000000060d000000000000021d000000000000060d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_materials.bin 1540 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
