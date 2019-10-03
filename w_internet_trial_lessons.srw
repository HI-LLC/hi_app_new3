$PBExportHeader$w_internet_trial_lessons.srw
forward
global type w_internet_trial_lessons from w_sheet
end type
type cb_close from commandbutton within w_internet_trial_lessons
end type
type cb_play_lesson from commandbutton within w_internet_trial_lessons
end type
type tv_1 from treeview within w_internet_trial_lessons
end type
end forward

global type w_internet_trial_lessons from w_sheet
integer width = 1595
integer height = 1596
cb_close cb_close
cb_play_lesson cb_play_lesson
tv_1 tv_1
end type
global w_internet_trial_lessons w_internet_trial_lessons

type variables
long il_method_id_list_from[] = {2, 3, 17, 25, 16, 15, 14, 23, 24, 21, 22}
long il_method_id_list_to[] = {2, 13, 19, 25, 16, 15, 14, 23, 24, 21, 22}
long il_current_tv_handle, FileSizeList[], LongEmptyList[]
string is_method_description_list[] = {"Object Identification", "Scale Comparison", "Object Comparison", "Object Matching", &
		"Object Grouping", "Drag-drop Counting", "Number-mathcing Counting", "Addition", "Subtraction", &
		"Unscramble Words (spelling)", "Unscramble Sentences (sentence composing)"}
string FileList[], RemoteFilePath = "/usr/home/helper/LH_gimit/LH_lessons/demo_lessons" 
string ResourceFileList[], EmptyList[]
gstr_tv_item istr_tv_item


end variables

forward prototypes
public function integer wf_load_lesson_list ()
public function integer wf_load_resource (string as_remote_file_path)
public subroutine wf_play_lesson (long al_method_id, string as_lesson_file)
public function integer wf_load_lesson_content (string as_remote_file_path)
public function integer wf_load_account_lessons ()
end prototypes

public function integer wf_load_lesson_list ();boolean lb_lesson_type_found
string ls_expression, ls_lesson_type_list[]
long ll_i, ll_j, ll_k, ll_len, FileCount, ll_row, ll_lesson_type_id, ll_lesson_type_id_list[]
long ll_tv_handle, ll_tv_handle_root
gstr_tv_item lstr_tv_item
MessageBox("wf_load_lesson_list: RemoteFilePath", RemoteFilePath)
FileCount = RemoteFileCount(RemoteFilePath)
if FileCount < 1 then
	MessageBox("Import Error", "No File Avaiable!")
	return 1
end if
SetPointer(HourGlass!)
FileList = EmptyList
for ll_i = 1 to FileCount
	FileList[ll_i] = space(200)
next
DirectoryList(RemoteFilePath, FileList, FileCount)
for ll_i = 1 to FileCount
	FileList[ll_i] = right(FileList[ll_i], len(FileList[ll_i]) - len(RemoteFilePath) - 1)
next
for ll_i = 1 to upperbound(il_method_id_list_from)
	ls_lesson_type_list[ll_i] = ""
	ll_lesson_type_id_list[ll_i] = 0
next
// parse lesson types
for ll_i = 1 to upperbound(FileList)
//	MessageBox("FileList", FileList[ll_i])
	if pos(FileList[ll_i], "_con.tx") > 0 then continue
	ll_len = len(FileList[ll_i])
	ll_lesson_type_id = long(left(FileList[ll_i], 2))
	lb_lesson_type_found = false
	for ll_j = 1 to upperbound(ll_lesson_type_id_list)
		if ll_lesson_type_id = ll_lesson_type_id_list[ll_j] then 
			lb_lesson_type_found = true
		end if
	next
	if not lb_lesson_type_found then
		for ll_k = 1 to upperbound(il_method_id_list_from)
			if ll_lesson_type_id >= il_method_id_list_from[ll_k] and ll_lesson_type_id <= il_method_id_list_to[ll_k] then
				exit
			end if
		next
		ll_lesson_type_id_list[ll_k] = ll_lesson_type_id
		ls_lesson_type_list[ll_k] = is_method_description_list[ll_k]
	end if
next
treeviewitem ltvi_new 
ltvi_new.children = true
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ltvi_new.label = "Learning Helper Free Trial Lessons"
ll_tv_handle_root = tv_1.InsertItemLast(0, ltvi_new)
for ll_i = 1 to upperbound(ll_lesson_type_id_list)
	if ll_lesson_type_id_list[ll_i] <> 0 then
		istr_tv_item.data_id = ll_lesson_type_id_list[ll_i]
		istr_tv_item.description = ls_lesson_type_list[ll_i]							
		ltvi_new.label = istr_tv_item.description
		ltvi_new.data = istr_tv_item	
		ltvi_new.children = true
		ll_tv_handle = tv_1.InsertItemLast(ll_tv_handle_root, ltvi_new)
		for ll_j = 1 to upperbound(FileList)
			if ll_lesson_type_id_list[ll_i] = long(left(FileList[ll_j], 2)) and &
				right(FileList[ll_j], 8) <> "_con.txt" and right(FileList[ll_j], 4) <> ".res" then
				istr_tv_item.data_id = ll_lesson_type_id_list[ll_i]
				istr_tv_item.description = mid(FileList[ll_j], 3, len(FileList[ll_j]) - 6)							
				ltvi_new.label = istr_tv_item.description
				ltvi_new.data = istr_tv_item	
				ltvi_new.children = false
				tv_1.InsertItemLast(ll_tv_handle, ltvi_new)				
			end if
		next
		tv_1.ExpandItem ( ll_tv_handle )
	end if
next

//if ll_rowcount > 0 then
	tv_1.ExpandAll(ll_tv_handle_root)
//	tv_1.GetItem(al_parent_handle, itvi_tmp)
//	itvi_tmp.children = true
//	tv_1.SetItem(al_parent_handle, itvi_tmp)
//end if


return 1
end function

public function integer wf_load_resource (string as_remote_file_path);string RemoetFileName, LocalFileName, ls_tmp_list[], ls_FileName
string ls_url, ls_data, ls_tmp, ls_new_line = "~n"
blob lblb_data
long ll_fsize, ll_findex = 0, ll_i, ll_j, ll_line, ll_pos, ll_res_i
str_resource_data lstr_empty[]
ll_fsize = extGetFileSize(as_remote_file_path)
ls_data = space(ll_fsize)
extGetFileImage(as_remote_file_path, ls_data)
ls_tmp = ""
// change DOS directory delimiter to Unix directory delimiter
for ll_i = 1 to len(ls_data)
	if mid(ls_data, ll_i, 1) = '\'  then
		ls_tmp = ls_tmp + "/"
	else
		ls_tmp = ls_tmp + mid(ls_data, ll_i, 1)
	end if
next
ll_line = 1
// parse line seperater
do 
	ll_pos = pos(ls_tmp, ls_new_line)
	if ll_pos > 0 then
		ls_tmp_list[ll_line] = left(ls_tmp, ll_pos - 2)
		ls_tmp = right(ls_tmp, len(ls_tmp) - ll_pos)
		ll_line = ll_line + 1
	end if
loop while ll_pos > 0
// seperate file name from file size
gn_appman.istr_resource_data = lstr_empty
for ll_i = 1 to upperbound(ls_tmp_list)
	if mod(ll_i, 2) = 1 then // resource file, not the length
		RemoetFileName = "/usr/home/helper/LH_gimit/LH_resources/" + ls_tmp_list[ll_i]
		LocalFileName = ""
		for ll_j = len(ls_tmp_list[ll_i]) to 1 step -1
			if mid(ls_tmp_list[ll_i], ll_j, 1) <> "/" then
				LocalFileName = mid(ls_tmp_list[ll_i], ll_j, 1) + LocalFileName
			else
				exit
			end if
		next
		ls_FileName = LocalFileName
		LocalFileName = "C:\" + ls_FileName
		extGetBinaryFile(LocalFileName, RemoetFileName)
		extAddFile(gn_appman.is_res_file_name, LocalFileName)
		ll_res_i = upperbound(gn_appman.istr_resource_data) + 1
		gn_appman.istr_resource_data[ll_res_i].File_Name = ls_FileName
		gn_appman.istr_resource_data[ll_res_i].fsize = FileLength(LocalFileName)
		gn_appman.istr_resource_data[ll_res_i].findex = ll_findex
		ll_findex = ll_findex + gn_appman.istr_resource_data[ll_res_i].fsize
	end if
next
return 1
end function

public subroutine wf_play_lesson (long al_method_id, string as_lesson_file);long ll_winhandle
ll_winhandle = handle(this)
gn_appman.of_set_parm("Method ID", al_method_id)
ShowWindow(ll_winhandle, 6)
choose case al_method_id
	case 2 // Object Identification
		post OpenWithParm(w_lesson_discrete_trial, as_lesson_file)
	case 3 to 13 // Scale Comparison
		post OpenWithParm(w_lesson_comp_scale, as_lesson_file)
	case 14 // Counting - Number (Symbol) Match
		post OpenWithParm(w_lesson_numbermatch_count, as_lesson_file)
	case 15 // Counting - Drag-drop
		post OpenWithParm(w_lesson_dragdrop_count, as_lesson_file)
	case 16 // Object  Grouping
		post OpenWithParm(w_lesson_mw_cmmnd, as_lesson_file)
	case 17 to 19 // Object Comparison
		post OpenWithParm(w_lesson_comp_object, as_lesson_file)
	case 21 // Unscramble Words
		post OpenWithParm(w_lesson_unscramble_word, as_lesson_file)
	case 22 // Unscramble Sentences
		post OpenWithParm(w_lesson_unscramble_sentence, as_lesson_file)
	case 23 // Addition
		post OpenWithParm(w_lesson_addition, as_lesson_file)
	case 24 // Subtraction
		post OpenWithParm(w_lesson_subtraction, as_lesson_file)
	case 25 // Matching
		post OpenWithParm(w_lesson_matching, as_lesson_file)
end choose

end subroutine

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

public function integer wf_load_account_lessons ();boolean lb_lesson_type_found
string ls_expression, ls_lesson_type_list[]
long ll_i, ll_j, ll_k, ll_len, FileCount, ll_row, ll_lesson_type_id, ll_lesson_type_id_list[]
long ll_tv_handle, ll_tv_handle_root
string ls_Host, ls_Key, ls_Name, ls_Password, ls_ReturnStatus, ls_sql, ls_col_name[], ls_result_set[]
gstr_tv_item lstr_tv_item
treeviewitem ltvi_new 
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(200)
ls_sql = "select LessonID from LessonGroup where GroupID eq 1"
FileCount = LHOA_SQL_retrieve(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus)
if FileCount > 0 then
	for ll_i = 1 to FileCount
		ls_col_name[ll_i] = space(100)
		FileList[ll_i] = space(200)
	next
	LHOA_SQL_load(ls_col_name, FileList)
else
	MessageBox("ls_ReturnStatus", ls_ReturnStatus)
	return 0
end if
for ll_i = 1 to upperbound(il_method_id_list_from)
	ls_lesson_type_list[ll_i] = ""
	ll_lesson_type_id_list[ll_i] = 0
next
for ll_i = 1 to upperbound(FileList)
	ll_len = len(FileList[ll_i])
	ll_lesson_type_id = long(left(FileList[ll_i], 2))
	lb_lesson_type_found = false
	for ll_j = 1 to upperbound(ll_lesson_type_id_list)
		if ll_lesson_type_id = ll_lesson_type_id_list[ll_j] then 
			lb_lesson_type_found = true
		end if
	next
	if not lb_lesson_type_found then
		for ll_k = 1 to upperbound(il_method_id_list_from)
			if ll_lesson_type_id >= il_method_id_list_from[ll_k] and ll_lesson_type_id <= il_method_id_list_to[ll_k] then
				exit
			end if
		next
		ll_lesson_type_id_list[ll_k] = ll_lesson_type_id
		ls_lesson_type_list[ll_k] = is_method_description_list[ll_k]
	end if
next
ltvi_new.children = true
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ltvi_new.label = "Learning Helper Free Trial Lessons"
ll_tv_handle_root = tv_1.InsertItemLast(0, ltvi_new)
for ll_i = 1 to upperbound(ll_lesson_type_id_list)
	if ll_lesson_type_id_list[ll_i] <> 0 then
		istr_tv_item.data_id = ll_lesson_type_id_list[ll_i]
		istr_tv_item.description = ls_lesson_type_list[ll_i]							
		ltvi_new.label = istr_tv_item.description
		ltvi_new.data = istr_tv_item	
		ltvi_new.children = true
		ll_tv_handle = tv_1.InsertItemLast(ll_tv_handle_root, ltvi_new)
		for ll_j = 1 to upperbound(FileList)
			if ll_lesson_type_id_list[ll_i] = long(left(FileList[ll_j], 2)) then
				istr_tv_item.data_id = ll_lesson_type_id_list[ll_i]
				istr_tv_item.description = FileList[ll_j]							
				ltvi_new.label = mid(FileList[ll_j], 3, len(FileList[ll_j]) - 16)
				ltvi_new.data = istr_tv_item	
				ltvi_new.children = false
				tv_1.InsertItemLast(ll_tv_handle, ltvi_new)	
			end if
		next
		tv_1.ExpandItem ( ll_tv_handle )
	end if
next
tv_1.ExpandAll(ll_tv_handle_root)
return 1
end function

on w_internet_trial_lessons.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_play_lesson=create cb_play_lesson
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_play_lesson
this.Control[iCurrent+3]=this.tv_1
end on

on w_internet_trial_lessons.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_play_lesson)
destroy(this.tv_1)
end on

event open;call super::open;//wf_load_lesson_list()
wf_load_account_lessons()
end event

type cb_close from commandbutton within w_internet_trial_lessons
integer x = 1024
integer y = 1344
integer width = 475
integer height = 96
integer taborder = 20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_play_lesson from commandbutton within w_internet_trial_lessons
integer x = 37
integer y = 1344
integer width = 475
integer height = 96
integer taborder = 40
string text = "Play Lesson"
end type

event clicked;string RemoetFileName, File_Prefix
treeviewitem ltvi_current
tv_1.GetItem(il_current_tv_handle, ltvi_current)
//ltvi_current.data = istr_tv_item
//istr_tv_item = ltvi_current.data
//File_Prefix = left(istr_tv_item.description, len(istr_tv_item.description) - 4)
//gn_appman.is_res_file_name = "c:\" + File_Prefix + ".res"
//gn_appman.is_current_lesson_name = string(istr_tv_item.data_id, "00") + istr_tv_item.description
//
//RemoetFileName = RemoteFilePath + "/" + string(istr_tv_item.data_id, "00") + istr_tv_item.description + ".res"
//wf_load_resource(RemoetFileName)
//RemoetFileName = RemoteFilePath + "/" + string(istr_tv_item.data_id, "00") + istr_tv_item.description + ".txt"
//wf_load_lesson_content( RemoetFileName)
//wf_play_lesson(istr_tv_item.data_id, string(istr_tv_item.data_id, "00") + istr_tv_item.description)
end event

type tv_1 from treeview within w_internet_trial_lessons
integer x = 37
integer y = 32
integer width = 1463
integer height = 1280
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;treeviewitem ltvi_current
GetItem(newhandle, ltvi_current)
il_current_tv_handle = newhandle
cb_play_lesson.enabled = (ltvi_current.level = 3)
if not cb_play_lesson.enabled then return
if not ltvi_current.children then
	istr_tv_item = ltvi_current.data
end if

end event

