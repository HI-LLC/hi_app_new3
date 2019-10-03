$PBExportHeader$w_web_file_list.srw
forward
global type w_web_file_list from w_sheet
end type
type cb_3 from commandbutton within w_web_file_list
end type
type cb_2 from commandbutton within w_web_file_list
end type
type mle_1 from multilineedit within w_web_file_list
end type
type tv_1 from treeview within w_web_file_list
end type
type cb_1 from commandbutton within w_web_file_list
end type
end forward

global type w_web_file_list from w_sheet
integer width = 3296
integer height = 1776
cb_3 cb_3
cb_2 cb_2
mle_1 mle_1
tv_1 tv_1
cb_1 cb_1
end type
global w_web_file_list w_web_file_list

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
public function integer wf_load_account_lessons ()
end prototypes

public function integer wf_load_lesson_list ();boolean lb_lesson_type_found
string ls_expression, ls_lesson_type_list[]
long ll_i, ll_j, ll_k, ll_len, FileCount, ll_row, ll_lesson_type_id, ll_lesson_type_id_list[]
long ll_tv_handle, ll_tv_handle_root
gstr_tv_item lstr_tv_item

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
long ll_fsize, ll_i, ll_j, ll_line, ll_pos, ll_res_i, bytes_read
integer li_FileNum
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
//istr_resource_data = lstr_empty
//for ll_i = 1 to upperbound(ls_tmp_list)
//	if mod(ll_i, 2) = 1 then // resource file, not the length
//		RemoetFileName = "/usr/home/helper/LH_gimit/LH_resources/" + ls_tmp_list[ll_i]
//		LocalFileName = ""
//		for ll_j = len(ls_tmp_list[ll_i]) to 1 step -1
//			if mid(ls_tmp_list[ll_i], ll_j, 1) <> "/" then
//				LocalFileName = mid(ls_tmp_list[ll_i], ll_j, 1) + LocalFileName
//			else
//				exit
//			end if
//		next
//		ls_FileName = LocalFileName
//		LocalFileName = "C:\" + ls_FileName
//		extGetBinaryFile(LocalFileName, RemoetFileName)
//		ll_res_i = upperbound(gn_appman.istr_resource_data) + 1
//		gn_appman.istr_resource_data[ll_res_i].File_Name = ls_FileName
//		li_FileNum = FileOpen(LocalFileName, StreamMode!, Read!)		
//		do
//			bytes_read = FileRead(li_FileNum, lblb_data)
//			gn_appman.istr_resource_data[ll_res_i].data = gn_appman.istr_resource_data[ll_res_i].data + lblb_data
//		loop while bytes_read > 0
//		FileClose(li_FileNum)		
//	end if
//next
return 1
end function

public function integer wf_load_account_lessons ();boolean lb_lesson_type_found
string ls_expression, ls_lesson_type_list[]
long ll_i, ll_j, ll_k, ll_len, FileCount, ll_row, ll_lesson_type_id, ll_lesson_type_id_list[]
long ll_tv_handle, ll_tv_handle_root
string ls_Host, ls_Key, ls_Name, ls_Password, ls_ReturnStatus, ls_sql, ls_col_name[], ls_result_set[]
integer li_i, li_count
gstr_tv_item lstr_tv_item
treeviewitem ltvi_new 
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(200)
ls_sql = "select LessonID from LessonGroup where GroupID eq 2"
li_count = LHOA_SQL_retrieve(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus)
MessageBox("li_count", li_count)
if li_count > 0 then
	for li_i = 1 to li_count
		ls_col_name[li_i] = space(100)
		FileList[li_i] = space(200)
	next
	LHOA_SQL_load(ls_col_name, FileList)
else
	MessageBox("ls_ReturnStatus", ls_ReturnStatus)
	return 0
end if
for li_i = 1 to upperbound(il_method_id_list_from)
	ls_lesson_type_list[li_i] = ""
	ll_lesson_type_id_list[li_i] = 0
next
for li_i = 1 to upperbound(FileList)
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

on w_web_file_list.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.mle_1=create mle_1
this.tv_1=create tv_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.tv_1
this.Control[iCurrent+5]=this.cb_1
end on

on w_web_file_list.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.tv_1)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_web_file_list
integer x = 2743
integer y = 1120
integer width = 475
integer height = 96
integer taborder = 40
string text = "Get Resources"
end type

event clicked;call super::clicked;
string RemoetFileName, LocalFileName, LocalFileNameList[], ls_tmp_list[], LocalFileList[]
string ls_url, ls_data, ls_tmp, ls_new_line = "~n"
blob lblb_data
long ll_fsize, ll_i, ll_j, ll_line, ll_pos
integer li_file_num
treeviewitem ltvi_current
tv_1.GetItem(il_current_tv_handle, ltvi_current)
ltvi_current.data = istr_tv_item
ResourceFileList = EmptyList
FileSizeList = LongEmptyList
RemoetFileName = RemoteFilePath + "/" + string(istr_tv_item.data_id, "00") + istr_tv_item.description + ".res"
ll_fsize = extGetFileSize(RemoetFileName)
ls_data = space(ll_fsize)
extGetFileImage(RemoetFileName, ls_data)
//li_file_num = FileOpen("C:\FileTransfer\" + istr_tv_item.description + ".txt", StreamMode!, Write!, LockWrite!, Replace!)
//lblb_data = blob(ls_data)
//FileWrite(li_file_num, lblb_data)
//FileClose(li_file_num)
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
for ll_i = 1 to upperbound(ls_tmp_list)
	if mod(ll_i, 2) = 1 then
		ResourceFileList[upperbound(ResourceFileList) + 1] = "/usr/home/helper/LH_gimit/LH_resources/" + ls_tmp_list[ll_i]
		LocalFileName = ""
		for ll_j = len(ls_tmp_list[ll_i]) to 1 step -1
			if mid(ls_tmp_list[ll_i], ll_j, 1) <> "/" then
				LocalFileName = mid(ls_tmp_list[ll_i], ll_j, 1) + LocalFileName
			else
				exit
			end if
		next
		LocalFileName = "C:\FileTransfer\" + LocalFileName
		LocalFileNameList[upperbound(LocalFileNameList) + 1] = LocalFileName
	else
		FileSizeList[upperbound(FileSizeList) + 1] = long(ls_tmp_list[ll_i])
	end if 
next
for ll_i = 1 to upperbound(LocalFileNameList) 
	extGetBinaryFile(LocalFileNameList[ll_i], ResourceFileList[ll_i])
	if FileLength(LocalFileNameList[ll_i]) <> FileSizeList[ll_i] then
//		MessageBox("Error", "The File: " + LocalFileNameList[ll_i] + " Is Mismatched!")
		MessageBox(LocalFileNameList[ll_i] + ": " + string(FileLength(LocalFileNameList[ll_i])), &
			ResourceFileList[ll_i] + ": " + string(FileSizeList[ll_i]))
//		exit
	end if
next
//gn_appman
//string ls_root
//ls_root = "/usr/home/helper/LH_gimit/LH_resources/"
//ResourceFile = EmptyList
//ResourceFile[1] = ls_root + "Static Table/wave/instruction/click.wav"
//LocalFileList[1] = "c:\click.wav"
//ResourceFile[2] = ls_root + "Static Table/wave/Response To Right/Yes, that is right!.wav"
//LocalFileList[2] = "c:\Yes, that is right!.wav"
//ResourceFile[3] = ls_root + "Static Table/wave/Response To Wrong/no try again.wav"
//LocalFileList[3] = "no try again.wav"
//ResourceFile[4] = ls_root + "materials/bitmap/Households/Appliances/Dryer.JPG"
//LocalFileList[4] = "Dryer.JPG"
//for ll_i = 1 to 4
//		extGetBinaryFile(LocalFileName, RemoetFileName) 
//next
end event

type cb_2 from commandbutton within w_web_file_list
integer x = 2231
integer y = 1120
integer width = 475
integer height = 96
integer taborder = 30
string text = "Get Resources"
end type

event clicked;call super::clicked;string RemoetFileName, LocalFileName
string ls_url, ls_data
blob lblb_data
long ll_fsize
InternetResult lir_data
treeviewitem ltvi_current
Inet linet
tv_1.GetItem(il_current_tv_handle, ltvi_current)
ltvi_current.data = istr_tv_item

//RemoetFileName = RemoteFilePath + "/" + string(istr_tv_item.data_id, "00") + istr_tv_item.description + ".res"
RemoetFileName = "/usr/home/helper/LH_gimit/LH_resources/materials/bitmap/Animals/Mammal/Camels.jpg"
ll_fsize = extGetFileSize(RemoetFileName)
//MessageBox("ll_fsize", string(ll_fsize))
ls_data = space(ll_fsize)
//extGetFileImage(RemoetFileName, ls_data)
LocalFileName = "c:\Camels.jpg"
extGetBinaryFile(LocalFileName, RemoetFileName) 
//mle_1.text = ls_data
//ls_url = "http://fithwor.pair.com/cgi-bin/cgiwrap/helper/GetFileSize.cgi?KEY:luxiluyilukeIN_PATH:" + RemoetFileName
//mle_1.text = ls_url
//GetContextService("Internet", linet)
////GetContextService("InternetData", lir_data)
//if linet.HyperlinkToURL (ls_url) = -1 then
//	MessageBox("HyperlinkToURL", "failed")
//end if
//if linet.GetURL (ls_url, lir_data) = -1 then
//	MessageBox("GetURL", "failed")
//end if
//
//lir_data.InternetData(lblb_data)

//FileCount = RemoteFileCount(RemoteFilePath)

end event

type mle_1 from multilineedit within w_web_file_list
integer x = 951
integer y = 1376
integer width = 183
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type tv_1 from treeview within w_web_file_list
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
cb_2.enabled = (ltvi_current.level = 3)
if not cb_2.enabled then return
if not ltvi_current.children then
	istr_tv_item = ltvi_current.data
end if

end event

type cb_1 from commandbutton within w_web_file_list
integer x = 1609
integer y = 1120
integer width = 585
integer height = 96
integer taborder = 20
string text = "Get Lesson List"
end type

event clicked;call super::clicked;//string FileList[], RemoteFilePath = "/usr/home/helper/LH_gimit/LH_lessons/demo_lessons" 
//string LocalFileName = "c:\report_tmp.txz"
//string LocalBinFileName = "c:\report_tmp.ex_"
//long li_i, FileCount, ll_row
//
//FileCount = RemoteFileCount(RemoteFilePath)
//if FileCount < 1 then
//	MessageBox("Import Error", "No File Avaiable!")
//	return
//end if
//SetPointer(HourGlass!)
//
//for li_i = 1 to FileCount
//	FileList[li_i] = space(200)
//next
//DirectoryList(RemoteFilePath, FileList, FileCount)
//for li_i = 1 to FileCount
//	ll_row = dw_1.InsertRow(0)
//	dw_1.SetItem(ll_row, "filename", FileList[li_i])
//next 
//SetPointer(Arrow!)
wf_load_lesson_list()

end event

