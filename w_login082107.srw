$PBExportHeader$w_login.srw
forward
global type w_login from w_sheet
end type
type cbx_local from checkbox within w_login
end type
type cbx_save_password from checkbox within w_login
end type
type rb_account_maintenance from radiobutton within w_login
end type
type rb_lesson_playing from radiobutton within w_login
end type
type cb_ok from commandbutton within w_login
end type
type cb_cancel from commandbutton within w_login
end type
type dw_login from datawindow within w_login
end type
end forward

global type w_login from w_sheet
integer width = 1472
integer height = 664
string title = "Account Login"
boolean controlmenu = false
boolean maxbox = false
windowstate windowstate = normal!
cbx_local cbx_local
cbx_save_password cbx_save_password
rb_account_maintenance rb_account_maintenance
rb_lesson_playing rb_lesson_playing
cb_ok cb_ok
cb_cancel cb_cancel
dw_login dw_login
end type
global w_login w_login

type variables
long il_login_id, il_trans_code, il_res_entry_count, il_dict_entry_count, il_lesson_entry_count
long il_total_res_update_fsize  =0, il_total_dict_update_fsize = 0, il_total_reward_update_fsize = 0
long il_total_lesson_update_fsize = 0
string is_resource_file_list[], is_timestamp_list[], is_file_size_list[]
string is_r_path[], is_r_tstamp[]
string is_local_dict_path[], is_local_dict_tstamp[]
string is_dict_file_list[], is_dict_timestamp_list[]
string is_dict_path[], is_dict_tstamp[], is_dict_file_size_list[]
string is_reward_path[], is_reward_fname[], is_reward_fsize[], is_reward_timestamp_list[]
string is_local_lesson_path[], is_local_lesson_tstamp[]
string is_lesson_file_list[], is_lesson_timestamp_list[]
string is_lesson_path[], is_lesson_tstamp[], is_lesson_file_size_list[]
boolean ib_resource_update[], ib_dictionary_update[]
integer ii_file_no1, ii_file_no2
nvo_datastore ids_lesson_list
nvo_datastore ids_reward
nvo_datastore ids_response_to_right
nvo_datastore ids_response_to_wrong


end variables

forward prototypes
public function integer wf_lesson_synch ()
public function integer wf_resource_synch ()
public function integer wf_resource_list ()
public function integer wf_add_to_resource_list (string as_file_name)
public function integer wf_make_resource ()
public function integer wf_update_resource ()
public function integer wf_load_lesson_content (string as_remote_file_path, string as_remote_site_path, integer as_row)
public function integer wf_resource_validate ()
public function integer wf_add_to_dict_list (string as_file_name)
public function integer wf_add_to_lesson_list (string as_file_name)
public function integer wf_update_dictionary ()
public function integer wf_update_lesson ()
public function integer wf_dictionary_validate ()
public function integer wf_lesson_validate ()
public function integer wf_make_world_list (string as_input_words, string as_mask, string as_distraction, ref string as_output_word_list[])
public function integer wf_reward_synch ()
public function integer wf_lesson_list ()
public function integer wf_cache_datastores ()
public function integer wf_upload_report ()
end prototypes

public function integer wf_lesson_synch ();if wf_lesson_list() = 1 then
	wf_lesson_validate()
	wf_update_lesson()
end if
return 1

end function

public function integer wf_resource_synch ();// check if resource synchronization is needed
long ll_return, ll_i, ll_resource_ret, ll_dictionary_ret, ll_total_update_file_size, ll_file_size
string ls_res_datetime, ls_remote_res_datetime, ls_remote_sys_datetime, ls_date, ls_time, ls_sql_statement
string ls_list, ls_col_name[], ls_result_set[], ls_local_file_name
DateTime ldt_res_datetime, ldt_dict_datetime, ldt_remote_sys_datetime, ldt_remote_res_datetime
boolean lb_not_update_for_resource=false, lb_not_update_for_dict=false

ls_res_datetime = space(20)
ls_remote_sys_datetime = space(20)
ls_remote_res_datetime = space(20)

ls_sql_statement = &
"select account_id from ResponseTR where account_id = " + string(gn_appman.il_account_id) + " union " + &
"select orig_acct_id as account_id from ResponseTRacquired where account_id = " + string(gn_appman.il_account_id) + " union " + &
"select account_id from ResponseTW where account_id = " + string(gn_appman.il_account_id) + " union " + &
"select orig_acct_id as account_id from ResponseTWacquired where account_id = " + string(gn_appman.il_account_id) + " union " + &
"select account_id from Lesson where account_id = " + string(gn_appman.il_account_id) + " union " + &
"select orig_acct_id as account_id from LessonAcquired where account_id = " + string(gn_appman.il_account_id)
ll_return = gn_appman.invo_sqlite.of_execute_retrieve_sql2(ls_sql_statement, ls_col_name, ls_result_set)
ls_list = ""
if upperbound(ls_result_set) < 1 then
	return 0
end if
for ll_i = 1 to upperbound(ls_result_set)
	if ll_i = 1 then ls_list = "("
	ls_list = ls_list + ls_result_set[ll_i]
   if upperbound(ls_result_set) > 1 and ll_i < upperbound(ls_result_set) then ls_list = ls_list + ","	
	if ll_i = upperbound(ls_result_set) then ls_list = ls_list + ")"
next
ls_sql_statement = &
"select Max(LastResourceDT) From Account Where id in " + ls_list 
ll_return = gn_appman.invo_sqlite.of_execute_retrieve_sql2(ls_sql_statement, ls_col_name, ls_result_set)
if ll_return > 0 then
	ls_remote_res_datetime = ls_result_set[1]
//	MessageBox("ls_remote_res_datetime", ls_remote_res_datetime)
	ls_date = left( ls_remote_res_datetime, 10)
	ls_time = mid(ls_remote_res_datetime, 12, 8)
	ldt_remote_res_datetime = DateTime(Date(ls_date), Time(ls_time))
	extGetSysDate(ls_remote_sys_datetime)
	ls_date = left(ls_res_datetime, 10)
	ls_time = mid(ls_res_datetime, 12, 8)
	ldt_remote_sys_datetime = DateTime(Date(ls_date), Time(ls_time))
	if ldt_remote_res_datetime > ldt_remote_sys_datetime then	
		ldt_remote_sys_datetime = ldt_remote_res_datetime
		ls_remote_sys_datetime = ls_remote_res_datetime
	end if
else
	return 0
end if
if FileExists(gn_appman.is_resource_index_file) then
	il_res_entry_count = extResIndexCount(gn_appman.is_resource_index_file, ls_res_datetime)
	ls_date = left(ls_res_datetime, 10)
	ls_time = mid(ls_res_datetime, 12, 8)
	ldt_res_datetime = DateTime(Date(ls_date), Time(ls_time))
//	MessageBox(ls_res_datetime, ls_date + " " + ls_time)
//	MessageBox(ls_res_datetime, ls_remote_res_datetime)
	if ldt_remote_res_datetime <= ldt_res_datetime then // earlier 		
		lb_not_update_for_resource = true
//		MessageBox("lb_not_update_for_resource", lb_not_update_for_resource)
	end if
end if

if FileExists(gn_appman.is_dict_index_file) then
	il_dict_entry_count = extResIndexCount(gn_appman.is_dict_index_file, ls_res_datetime)
	ls_date = left(ls_res_datetime, 10)
	ls_time = mid(ls_res_datetime, 12, 8)
	ldt_dict_datetime = DateTime(Date(ls_date), Time(ls_time))
	if ldt_remote_res_datetime <= ldt_dict_datetime then // earlier 
		lb_not_update_for_dict = true
	end if
end if

if lb_not_update_for_resource and lb_not_update_for_dict then return 0

wf_resource_list()
ll_resource_ret  = wf_resource_validate()
ll_dictionary_ret = wf_dictionary_validate()

if ll_resource_ret = 0 or ll_dictionary_ret = 0 then
	ll_total_update_file_size = il_total_res_update_fsize + il_total_dict_update_fsize
//	MessageBox("il_total_dict_update_fsize", il_total_dict_update_fsize)
	OpenWithParm(w_progress_bar, string(ll_total_update_file_size) + "Title:Download Resource Files Please Wait...")
	if ll_resource_ret = 0 then
		wf_update_resource()
	end if
	if FileExists(gn_appman.is_resource_index_file) then
//		MessageBox(ls_remote_sys_datetime, ls_remote_sys_datetime)
		UpdateResDTstamp(gn_appman.is_resource_index_file, gn_appman.is_resource_image_file, ls_remote_sys_datetime)
	end if
	if ll_dictionary_ret = 0 then
		wf_update_dictionary()
	end if
	if FileExists(gn_appman.is_dict_index_file) then
		UpdateResDTstamp(gn_appman.is_dict_index_file, gn_appman.is_dict_image_file, ls_remote_sys_datetime)
	end if 
	if isvalid(gn_appman.iw_progress_bar) then
		Send(Handle(gn_appman.iw_progress_bar), 1025, 0, 0)
	end if	
end if

return 1

end function

public function integer wf_resource_list ();long ll_row, ll_orig_acct_id, ll_method_id, ll_lesson_id
long ll_i, ll_count
string ls_remote_site_path, ls_remote_lesson_path, ls_lesson_name, ls_lesson_subpath
string ls_remote_resource_path, ls_resource_path, ls_local_filename
long ll_file_size

integer li_FileNum
li_FileNum = FileOpen("ResourceList1.txt", LineMode!, Write!, LockWrite!, Replace!)
//integer ii_file_no1, ii_file_no2

//ii_file_no1 = FileOpen("ResourceList1.txt", LineMode!, Write!, LockWrite!, Replace!)
//ii_file_no2 = FileOpen("ResourceList2.txt", LineMode!, Write!, LockWrite!, Replace!)
if FileExists(gn_appman.is_resource_index_file) then
	for ll_i = 1 to il_res_entry_count
		is_r_path[ll_i] = space(500)
		is_r_tstamp[ll_i] = space(14)
	next
	extRetrieveResIndex(gn_appman.is_resource_index_file, is_r_path, is_r_tstamp)
	for ll_i = 1 to il_res_entry_count
		is_r_tstamp[ll_i] = left(is_r_tstamp[ll_i], 14)
		FileWrite(li_FileNum, is_r_path[ll_i])
		FileWrite(li_FileNum, is_r_tstamp[ll_i])
	next	
end if
FileClose(li_FileNum)
li_FileNum = FileOpen("ResourceList2.txt", LineMode!, Write!, LockWrite!, Replace!)
if FileExists(gn_appman.is_dict_index_file) then
	for ll_i = 1 to il_res_entry_count
		is_local_dict_path[ll_i] = space(500)
		is_local_dict_tstamp[ll_i] = space(14)
	next
	extRetrieveResIndex(gn_appman.is_dict_index_file, is_local_dict_path, is_local_dict_tstamp)
	for ll_i = 1 to il_res_entry_count
		is_local_dict_tstamp[ll_i] = left(is_local_dict_tstamp[ll_i], 14)
		FileWrite(li_FileNum, is_local_dict_path[ll_i])
		FileWrite(li_FileNum, is_local_dict_tstamp[ll_i])
	next	
end if
FileClose(li_FileNum)

// Lesson Retrieving
ids_lesson_list = create nvo_datastore
ids_lesson_list.dataobject = "d_lesson_list"
ids_lesson_list.is_select_sql = &
	"select la.account_id as account_id,la.orig_acct_id as orig_acct_id,instruction_id,instruction_id2," + &
	" prompt_inst,l.lesson_id as lesson_id,m.method_id as method_id," + &
	" l.lesson_name as lesson_name,m.Lesson_subpath as Lesson_subpath,a.Site_path as Site_path" + &
	" From LessonAcquired As la,Lesson As l,Method as m,Account as a " + &
	" Where la.orig_acct_id eq l.account_id and la.lesson_id eq l.lesson_id and l.method_id eq m.method_id " + &
	" and l.account_id eq a.id and la.account_id eq " + string(gn_appman.il_account_id) + &
	" union " + &
   " Select l.account_id as account_id,l.account_id as orig_acct_id,instruction_id,instruction_id2," + &
	" prompt_inst,l.lesson_id as lesson_id,m.method_id as method_id," + &
	" l.lesson_name as lesson_name,m.Lesson_subpath as Lesson_subpath,a.Site_path as Site_path" + &
	" From Lesson As l,Method as m,Account as a" + &
	" Where l.method_id eq m.method_id and l.account_id eq a.id and l.account_id eq " + string(gn_appman.il_account_id)	

ids_lesson_list.Data_retrieve( )
// Lesson Loading
For ll_row = 1 to ids_lesson_list.RowCount()
	ll_orig_acct_id = ids_lesson_list.GetItemNumber(ll_row, "orig_acct_id")
	ll_method_id = ids_lesson_list.GetItemNumber(ll_row, "method_id")
	ll_lesson_id = ids_lesson_list.GetItemNumber(ll_row, "lesson_id")	
	ls_lesson_name = lower(ids_lesson_list.GetItemString(ll_row, "lesson_name"))
	ls_lesson_subpath = ids_lesson_list.GetItemString(ll_row, "Lesson_subpath")
	ls_remote_site_path = ids_lesson_list.GetItemString(ll_row, "site_path") + "/Account" + string(ll_orig_acct_id, "000000")
	ls_remote_lesson_path = ls_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + string(ll_method_id, "00") + ls_lesson_name + string(ll_lesson_id, "0000000000") + ".txt"	
//	ls_remote_lesson_path = ls_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + string(ll_method_id, "00") + ls_lesson_name + string(ll_lesson_id, "0000000000") + ".xml"	
	wf_load_lesson_content( ls_remote_lesson_path, ls_remote_site_path, ll_row)
Next

ids_response_to_right = create nvo_datastore
ids_response_to_right.dataobject = "d_responsetr"
ids_response_to_right.is_select_sql = &
	" Select account_id, account_id as orig_acct_id, response_id, wave_file, site_path " + &
	" From ResponseTR as r, Account as a " + & 
	" Where r.account_id eq a.id and r.account_id eq " + string(gn_appman.il_account_id) + &
	" UNION " + &
	" Select rtra.account_id as account_id, rtra.orig_acct_id as orig_acct_id, " + &
	" rtr.response_id as response_id, wave_file, site_path " + &
	" From ResponseTRacquired as rtra, ResponseTR as rtr, Account as a " + &
	" Where rtra.orig_acct_id eq rtr.account_id and rtr.account_id eq a.id " + &
	" and rtra.response_id eq rtr.response_id and rtra.account_id eq "  + string(gn_appman.il_account_id)
	
ids_response_to_right.Data_retrieve( )
For ll_row = 1 to ids_response_to_right.RowCount()
	ls_resource_path = ids_response_to_right.GetItemString(ll_row, "site_path") + "/Account" + string(ids_response_to_right.GetItemNumber(ll_row, "orig_acct_id"), "000000") + "/LH_resources/static table/wave/"
	ls_remote_resource_path = ls_resource_path + "response to right/" + string(ids_response_to_right.GetItemNumber(ll_row, "response_id"), "00000000") + lower(ids_response_to_right.GetItemString(ll_row, "wave_file"))	
	wf_add_to_resource_list( ls_remote_resource_path )
Next

ids_response_to_wrong = create nvo_datastore
ids_response_to_wrong.dataobject = "d_responsetw"
ids_response_to_wrong.is_select_sql = &
	" Select account_id, account_id as orig_acct_id, response_id, wave_file, site_path " + &
	" From ResponseTW as r, Account as a " + & 
	" Where r.account_id eq a.id and r.account_id eq " + string(gn_appman.il_account_id) + &
	" UNION " + &
	" Select rtwa.account_id as account_id, rtwa.orig_acct_id as orig_acct_id, " + &
	" rtw.response_id as response_id, wave_file, site_path " + &
	" From ResponseTWacquired as rtwa, ResponseTW as rtw, Account as a " + &
	" Where rtwa.orig_acct_id eq rtw.account_id and rtw.account_id eq a.id " + &
	" and rtwa.response_id eq rtw.response_id and rtwa.account_id eq "  + string(gn_appman.il_account_id)
	
ids_response_to_wrong.Data_retrieve( )
For ll_row = 1 to ids_response_to_wrong.RowCount()
	ls_resource_path = ids_response_to_wrong.GetItemString(ll_row, "site_path") + "/Account" + string(ids_response_to_wrong.GetItemNumber(ll_row, "orig_acct_id"), "000000") + "/LH_resources/static table/wave/"
	ls_remote_resource_path = ls_resource_path + "response to wrong/" + string(ids_response_to_wrong.GetItemNumber(ll_row, "response_id"), "00000000") + lower(ids_response_to_wrong.GetItemString(ll_row, "wave_file"))	
	wf_add_to_resource_list( ls_remote_resource_path )
Next


if upperbound(is_resource_file_list) > 0 then
	if extGetValidFileList(is_resource_file_list, is_timestamp_list, is_file_size_list, upperbound(is_resource_file_list)) = 0 then
		Messagebox("Error", "Cannot Get Remote File Timestamps For Resource!")
	end if
end if
//	MessageBox("upperbound(is_dict_file_list)", upperbound(is_dict_file_list))
if upperbound(is_dict_file_list) > 0 then
	if extGetValidFileList(is_dict_file_list, is_dict_timestamp_list, is_dict_file_size_list, upperbound(is_dict_file_list)) = 0 then
		Messagebox("Error", "Cannot Get Remote File Timestamps For Dictionary!")
	end if
end if


return 1

end function

public function integer wf_add_to_resource_list (string as_file_name);integer li_i
long ll_filelength
boolean lb_file_in_the_list
string ls_remote_file_time_stamp
lb_file_in_the_list = false
for li_i = 1 to upperbound(is_resource_file_list)
	if as_file_name = is_resource_file_list[li_i] then
		lb_file_in_the_list = true
		exit
	end if
next
if not lb_file_in_the_list then
	is_resource_file_list[upperbound(is_resource_file_list) + 1] = as_file_name
//	extGetRemoteFileDate(as_file_name, ls_remote_file_time_stamp)
	is_timestamp_list[upperbound(is_timestamp_list) + 1] = space(14)
	is_file_size_list[upperbound(is_file_size_list) + 1] = space(9)
//	FileWrite(ii_file_no1, as_file_name)

end if
return 1
end function

public function integer wf_make_resource ();long ll_i, ll_file_size
string ls_remote_resource_path, ls_resource_path, ls_local_filename, ls_remote_file_time_stamp
extCreateResourceFile(gn_appman.is_resource_index_file, gn_appman.is_resource_image_file)
ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
ls_remote_file_time_stamp = space(20)
for ll_i = 1 to upperbound(is_resource_file_list) 
	ls_remote_resource_path = is_resource_file_list[ll_i]
	if extGetBinaryFile(ls_local_filename, ls_remote_resource_path) = 0 then continue
	ll_file_size = FileLength(ls_local_filename)
	extGetRemoteFileDate(ls_remote_resource_path, ls_remote_file_time_stamp)	
	extPutImageFile(gn_appman.is_resource_index_file, gn_appman.is_resource_image_file, ls_local_filename, ls_remote_resource_path, ls_remote_file_time_stamp, ll_file_size)
//	extGetImageFile("D:\Resource_sync\resource.lhi", "D:\Resource_sync\resource.lhm", ls_remote_resource_path, ls_local_filename)
Next

return 1

end function

public function integer wf_update_resource ();long ll_r_row, ll_l_row, ll_file_size, ll_i, ll_count
string ls_remote_resource_path, ls_resource_path, ls_local_filename, ls_resource_tmp_i, ls_resource_tmp_m
boolean lb_found

MessageBox("wf_update_resource", "START")

//ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
ls_local_filename = "ttttmmmppp.bin"

if FileExists(gn_appman.is_resource_index_file) and FileExists(gn_appman.is_resource_image_file) then // update
	ls_resource_tmp_i = gn_appman.is_app_path + "\resourece_tmp.lhi"
	ls_resource_tmp_m = gn_appman.is_app_path + "\resourece_tmp.lhm"
	extCreateResourceFile(ls_resource_tmp_i, ls_resource_tmp_m)
	for ll_r_row = 1 to upperbound(is_resource_file_list)
		ls_remote_resource_path = is_resource_file_list[ll_r_row]
		lb_found = false
		for ll_l_row = 1 to upperbound(is_r_path)
			if is_resource_file_list[ll_r_row] = is_r_path[ll_l_row] and is_timestamp_list[ll_r_row] = is_r_tstamp[ll_l_row] then
				lb_found = true
				ls_remote_resource_path = is_resource_file_list[ll_r_row]
				extGetImageFile(gn_appman.is_resource_index_file, gn_appman.is_resource_image_file, is_resource_file_list[ll_r_row], ls_local_filename)
				ll_file_size = FileLength(ls_local_filename)
				extPutImageFile(ls_resource_tmp_i, ls_resource_tmp_m, ls_local_filename, is_resource_file_list[ll_r_row], is_timestamp_list[ll_r_row], ll_file_size)			
				exit
			end if
		next
		if not lb_found then
//			MessageBox("wf_update_resource", ls_remote_resource_path)
			extGetBinaryFile(ls_local_filename, ls_remote_resource_path)
			ll_file_size = FileLength(ls_local_filename)
			extPutImageFile(ls_resource_tmp_i, ls_resource_tmp_m, ls_local_filename, is_resource_file_list[ll_r_row], is_timestamp_list[ll_r_row], ll_file_size)					
		end if
		if isvalid(gn_appman.iw_progress_bar) then
			Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)
			gn_appman.iw_progress_bar.SetFocus()
		end if
	next
	FileDelete(gn_appman.is_resource_index_file)
	FileDelete(gn_appman.is_resource_image_file)
	FileMove(ls_resource_tmp_i, gn_appman.is_resource_index_file)
	FileMove(ls_resource_tmp_m, gn_appman.is_resource_image_file)
else // Create New Resource File
	extCreateResourceFile(gn_appman.is_resource_index_file, gn_appman.is_resource_image_file)
//	ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
	ls_local_filename = "ttttmmmppp.bin"
	for ll_r_row = 1 to upperbound(is_resource_file_list)
		ls_remote_resource_path = is_resource_file_list[ll_r_row]
		MessageBox(ls_local_filename, ls_remote_resource_path)
		extGetBinaryFile(ls_local_filename, ls_remote_resource_path)
		if not FileExists(ls_local_filename) then MessageBox(ls_local_filename, "NOT EXISTS")
		ll_file_size = FileLength(ls_local_filename)
		extPutImageFile(gn_appman.is_resource_index_file, gn_appman.is_resource_image_file, ls_local_filename, is_resource_file_list[ll_r_row], is_timestamp_list[ll_r_row], ll_file_size)					
		if isvalid(gn_appman.iw_progress_bar) then
//			Sleeping(50)
			Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)			
			gn_appman.iw_progress_bar.SetRedraw( false)
			gn_appman.iw_progress_bar.SetFocus()
			gn_appman.iw_progress_bar.SetRedraw( true)
		end if
	Next
end if

FileDelete(ls_local_filename)
return 1
end function

public function integer wf_load_lesson_content (string as_remote_file_path, string as_remote_site_path, integer as_row);string RemoetFileName, LocalFileName, ls_tmp_list[], ls_FileName, ls_word, ls_1st_letter, ls_word_list[]
string ls_bmp_name, ls_wave_name, ls_tmp, ls_resource_path, ls_local_filename, ls_details, ls_mask, ls_distraction
long ll_i, ll_count, ll_method_id, ll_row, ll_content_id, ll_pos, ll_len1, ll_len2
nvo_datastore lds_lesson, lds_lesson_container
any la_parm
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
//extGetBinaryFile(LocalFileName, RemoetFileName) 
f_getcachelessonfile(RemoetFileName, LocalFileName)
//MessageBox(LocalFileName, RemoetFileName)
if upperbound(gn_appman.ids_lesson) > 0 then
	if isvalid(gn_appman.ids_lesson[1]) then
		destroy gn_appman.ids_lesson[1]
	end if
end if
gn_appman.ids_lesson[1] = create nvo_datastore
gn_appman.ids_lesson[1].dataobject = 'd_lesson'
ll_count = gn_appman.ids_lesson[1].ImportFile(LocalFileName)
if ll_count < 1 then
	la_parm = gn_appman.ids_lesson[1]
	f_importfile_to_dd(la_parm, LocalFileName, "~t")
end if

lds_lesson = gn_appman.ids_lesson[1]
string ls_remote_file_time_stamp, ls_remote_resource_path
ls_remote_file_time_stamp = space(20)
long ll_file_size

//MessageBox(LocalFileName, lds_lesson.RowCount())
for ll_row = 1 to lds_lesson.RowCount()
	ls_resource_path = lds_lesson.GetItemString(ll_row, 'subject_description') + '/' + &
							lds_lesson.GetItemString(ll_row, 'chapter_description') + "/" 								
	ll_content_id = lds_lesson.GetItemNumber(ll_row, "lesson_content_content_id")
	ls_tmp = trim(lower(lds_lesson.GetItemString(ll_row, 'content_bitmap_file')))
	if isnull(ls_tmp) then ls_tmp = ""
	if ls_tmp <> "" then
		if pos(ls_tmp, "dictionary") > 0 then 
			ls_resource_path = as_remote_site_path + "/LH_resources/static table/bitmap/dictionary/"
			ls_word = lds_lesson.GetItemString(ll_row, 'content_details')
			ls_1st_letter = lower(left(ls_word, 1))
//			ls_remote_resource_path = as_remote_site_path + ls_resource_path + ls_1st_letter + "/" + ls_word + ".wav"	
			ls_remote_resource_path = ls_resource_path + ls_1st_letter + "/" + ls_word + ".jpg"	
			wf_add_to_dict_list( ls_remote_resource_path )
//			MessageBox("dictionary", ls_remote_resource_path)
		else
			ls_bmp_name = as_remote_site_path + "/LH_resources/materials/bitmap/" + &
										lower(ls_resource_path) + string(ll_content_id, "0000000000") + ls_tmp
			ls_remote_resource_path = ls_bmp_name							
			wf_add_to_resource_list( ls_remote_resource_path )
		end if
	end if
	ls_tmp = trim(lower(lds_lesson.GetItemString(ll_row, 'content_wave_file')))
	if isnull(ls_tmp) then ls_tmp = ""
	if ls_tmp <> "" then
		if pos(ls_tmp, "dictionary") > 0 then 
			ls_resource_path = as_remote_site_path + "/LH_resources/static table/wave/dictionary/"
			ls_word = lds_lesson.GetItemString(ll_row, 'content_details')
			ls_1st_letter = lower(left(ls_word, 1))
			ls_remote_resource_path = ls_resource_path + ls_1st_letter + "/" + ls_word + ".wav"	
//			MessageBox("dictionary", ls_remote_resource_path)
			wf_add_to_dict_list( ls_remote_resource_path )
		else
			ls_wave_name = as_remote_site_path + "/LH_resources/materials/wave/" + &
										lower(ls_resource_path) + string(ll_content_id, "0000000000") + lower(lds_lesson.GetItemString(ll_row, 'content_wave_file'))			
			ls_remote_resource_path = ls_wave_name							
			wf_add_to_resource_list( ls_remote_resource_path )
		end if
	end if
	if lds_lesson.GetItemNumber(ll_row, "lesson_method_id")  = 22 then // sentence composing, functional word - construction dictionary
		ls_mask = trim(lds_lesson.GetItemString(ll_row, 'lesson_content_mask'))
		if isnull(ls_mask) then ls_mask = ""
		if ls_mask <> "" then	
			ls_details = lds_lesson.GetItemString(ll_row, 'content_details')
			ls_distraction = lds_lesson.GetItemString(ll_row, 'lesson_content_distraction')
			wf_make_world_list( ls_details, ls_mask, ls_distraction, ls_word_list)
			for ll_i = 1 to upperbound(ls_word_list)
				ls_word = ls_word_list[ll_i]
				if right(ls_word, 1) = "," or right(ls_word, 1) = "." then
					ls_word = left(ls_word, len(ls_word) - 1)
				end if
				if len(ls_word) > 0 then
					ls_1st_letter = lower(left(ls_word, 1))
					ls_resource_path = as_remote_site_path + "/LH_resources/static table/bitmap/dictionary/"
					ls_remote_resource_path = ls_resource_path + ls_1st_letter + "/" + ls_word + ".jpg"	
					wf_add_to_dict_list( ls_remote_resource_path )
					ls_resource_path = as_remote_site_path + "/LH_resources/static table/wave/dictionary/"				
					ls_remote_resource_path = ls_resource_path + ls_1st_letter + "/" + ls_word + ".wav"	
					wf_add_to_dict_list( ls_remote_resource_path )
				end if
			next
		end if
	end if	
next

ls_resource_path = as_remote_site_path + "/LH_resources/static table/wave/"

ls_wave_name = ""
if lds_lesson.RowCount() > 0 then
	ls_wave_name = trim(lower(lds_lesson.GetItemString(1, 'instruction_wave_file')))
end if
if isnull(ls_wave_name) then ls_wave_name = ""
if ls_wave_name <> "" then
	ls_remote_resource_path = ls_resource_path + "instruction/" + string(ids_lesson_list.GetItemNumber(as_row, 'instruction_id'), "00000000") +	ls_wave_name
	wf_add_to_resource_list( ls_remote_resource_path)
end if
ls_wave_name = ""
if lds_lesson.RowCount() > 0 then
	ls_wave_name = trim(lower(lds_lesson.GetItemString(1, 'instruction2_wave_file')))
end if
if isnull(ls_wave_name) then ls_wave_name = ""
if ls_wave_name <> "" then
	ls_remote_resource_path = ls_resource_path + "instruction/" + string(ids_lesson_list.GetItemNumber(as_row, 'instruction_id2'), "00000000") +	ls_wave_name
	wf_add_to_resource_list( ls_remote_resource_path)
end if
ls_wave_name = ""
if lds_lesson.RowCount() > 0 then
	ls_wave_name = trim(lower(lds_lesson.GetItemString(1, 'prompt_prompt_inst')))
end if
if isnull(ls_wave_name) then ls_wave_name = ""
if ls_wave_name <> "" then
	ls_remote_resource_path = ls_resource_path + "prompt/" + string(ids_lesson_list.GetItemNumber(as_row, 'prompt_inst'), "00000000") +	ls_wave_name
	wf_add_to_resource_list( ls_remote_resource_path)
end if
ls_wave_name = ""
if lds_lesson.RowCount() > 0 then
	ls_wave_name = trim(lower(lds_lesson.GetItemString(1, 'preposition_1')))
end if
if isnull(ls_wave_name) then ls_wave_name = ""
if ls_wave_name <> "" then
	ls_remote_resource_path = ls_resource_path + "preposition/" + "pre" + string(ids_lesson_list.GetItemNumber(as_row, 'preposition1'), "0000") +	ls_wave_name
	wf_add_to_resource_list( ls_remote_resource_path)
end if
ls_wave_name = ""
if lds_lesson.RowCount() > 0 then
	ls_wave_name = trim(lower(lds_lesson.GetItemString(1, 'preposition_2')))
end if
if isnull(ls_wave_name) then ls_wave_name = ""
if ls_wave_name <> "" then
	ls_remote_resource_path = ls_resource_path + "preposition/" + "pre" + string(ids_lesson_list.GetItemNumber(as_row, 'preposition2'), "0000") +	ls_wave_name
	wf_add_to_resource_list( ls_remote_resource_path)
end if
//ls_wave_name = trim(lower(lds_lesson.GetItemString(1, 'prompt_prompt_inst')))
//if isnull(ls_wave_name) then ls_wave_name = ""
//if ls_wave_name <> "" then
//	ls_remote_resource_path = ls_resource_path + "prompt/" + string(ids_lesson_list.GetItemNumber(as_row, 'prompt_inst'), "00000000") +	ls_wave_name
//	wf_add_to_resource_list( ls_remote_resource_path)
//end if

ll_method_id = long(left(ls_FileName, 2))
if ll_method_id = 15 or ll_method_id = 16 then
	if upperbound(gn_appman.ids_lesson) > 1 then
		if isvalid(gn_appman.ids_lesson[2]) then
			destroy gn_appman.ids_lesson[2]
		end if
	end if
	RemoetFileName = left(as_remote_file_path, len(as_remote_file_path) - 4) + "_con.txt"
	LocalFileName = "C:\" + left(ls_FileName, len(ls_FileName) - 4) + "_con.txt"
//	extGetBinaryFile(LocalFileName, RemoetFileName) 
	f_getcachelessonfile(RemoetFileName, LocalFileName)
	gn_appman.ids_lesson[2] = create nvo_datastore
	gn_appman.ids_lesson[2].dataobject = 'd_lesson_container'
	ll_count = gn_appman.ids_lesson[2].ImportFile(LocalFileName)
	if ll_count < 1 then
		la_parm = gn_appman.ids_lesson[2]
		f_importfile_to_dd(la_parm, LocalFileName, "~t")
	end if	
//	FileDelete(LocalFileName)
	lds_lesson_container = gn_appman.ids_lesson[2]
	for ll_row = 1 to lds_lesson_container.RowCount()
		ls_wave_name = lds_lesson_container.GetItemString(ll_row, 'wave_file')
		if isnull(ls_wave_name) then ls_wave_name = ""
		if ls_wave_name <> "" then
			ls_remote_resource_path = ls_resource_path + "container/" + lower(ls_wave_name)
			wf_add_to_resource_list( ls_remote_resource_path)
		end if
		ls_wave_name = lds_lesson_container.GetItemString(ll_row, 'bean_wave_file')
		if isnull(ls_wave_name) then ls_wave_name = ""
		if ls_wave_name <> "" then
			ls_remote_resource_path = ls_resource_path + "bean/" + lower(ls_wave_name)
			wf_add_to_resource_list( ls_remote_resource_path)
		end if
		ls_resource_path = as_remote_site_path + "/LH_resources/static table/bitmap/"
		ls_bmp_name = lds_lesson_container.GetItemString(ll_row, 'bitmap_file')
		if isnull(ls_bmp_name) then ls_bmp_name = ""
		if ls_bmp_name <> "" then
			ls_remote_resource_path = ls_resource_path + "container/" + lower(ls_bmp_name)
			wf_add_to_resource_list( ls_remote_resource_path)
		end if
		ls_bmp_name = lds_lesson_container.GetItemString(ll_row, 'bean_bitmap_file')
		if isnull(ls_bmp_name) then ls_bmp_name = ""
		if ls_bmp_name <> "" then
			ls_remote_resource_path = ls_resource_path + "bean/" + lower(ls_bmp_name)
			wf_add_to_resource_list( ls_remote_resource_path)
		end if
	next
end if

return 1
end function

public function integer wf_resource_validate ();long ll_r_row, ll_l_row, ll_ret = 1
boolean lb_found

if upperbound(is_resource_file_list) <> upperbound(is_r_path) then 
	ll_ret = 0
end if
for ll_r_row = 1 to upperbound(is_resource_file_list)
	lb_found = false
	for ll_l_row = 1 to upperbound(is_r_path)		
		if is_resource_file_list[ll_r_row] = is_r_path[ll_l_row] and is_timestamp_list[ll_r_row] = is_r_tstamp[ll_l_row] then
			lb_found = true
			exit
		end if
	next
	if not lb_found then
		ll_ret = 0
		il_total_res_update_fsize = il_total_res_update_fsize + long(is_file_size_list[ll_r_row])
//		return 0
	end if
	ib_resource_update[ll_r_row] = not lb_found
next

return ll_ret
end function

public function integer wf_add_to_dict_list (string as_file_name);integer li_i
long ll_filelength
boolean lb_file_in_the_list
string ls_remote_file_time_stamp
lb_file_in_the_list = false
for li_i = 1 to upperbound(is_dict_file_list)
	if as_file_name = is_dict_file_list[li_i] then
		lb_file_in_the_list = true
		exit
	end if
next
if not lb_file_in_the_list then
	is_dict_file_list[upperbound(is_dict_file_list) + 1] = as_file_name
	is_dict_timestamp_list[upperbound(is_dict_timestamp_list) + 1] = space(14)
	is_dict_file_size_list[upperbound(is_dict_file_size_list) + 1] = space(9)
//	FileWrite(ii_file_no2, as_file_name)
end if

return 1

end function

public function integer wf_add_to_lesson_list (string as_file_name);integer li_i
long ll_filelength
boolean lb_file_in_the_list
string ls_remote_file_time_stamp
lb_file_in_the_list = false
for li_i = 1 to upperbound(is_lesson_file_list)
	if as_file_name = is_lesson_file_list[li_i] then
		lb_file_in_the_list = true
		exit
	end if
next
if not lb_file_in_the_list then
	is_lesson_file_list[upperbound(is_lesson_file_list) + 1] = as_file_name
	is_lesson_timestamp_list[upperbound(is_lesson_timestamp_list) + 1] = space(14)
	is_lesson_file_size_list[upperbound(is_lesson_file_size_list) + 1] = space(9)
//	FileWrite(ii_file_no2, as_file_name)
end if

return 1

end function

public function integer wf_update_dictionary ();long ll_r_row, ll_l_row, ll_file_size, ll_i, ll_count
string ls_remote_dict_path, ls_dict_path, ls_local_filename, ls_dict_tmp_i, ls_dict_tmp_m
boolean lb_found, lb_valid_file_exist = false

MessageBox("wf_update_dictionary", "START")
//ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
ls_local_filename = "ttttmmmppp.bin"

if FileExists(gn_appman.is_dict_index_file) and FileExists(gn_appman.is_dict_image_file) then // update
	ls_dict_tmp_i = gn_appman.is_app_path + "\resourece_tmp.lhi"
	ls_dict_tmp_m = gn_appman.is_app_path + "\resourece_tmp.lhm"
	extCreateResourceFile(ls_dict_tmp_i, ls_dict_tmp_m)
	for ll_r_row = 1 to upperbound(is_dict_file_list)
		if is_dict_timestamp_list[ll_r_row] = "00000000000000" or is_dict_timestamp_list[ll_r_row] = "19700101000000" then continue
		lb_valid_file_exist = true
		ls_remote_dict_path = is_dict_file_list[ll_r_row]
		lb_found = false
		for ll_l_row = 1 to upperbound(is_r_path)
			if is_dict_file_list[ll_r_row] = is_local_dict_path[ll_l_row] and is_dict_timestamp_list[ll_r_row] = is_local_dict_tstamp[ll_l_row] then
				lb_found = true
				ls_remote_dict_path = is_dict_file_list[ll_r_row]
				extGetImageFile(gn_appman.is_dict_index_file, gn_appman.is_dict_image_file, is_dict_file_list[ll_r_row], ls_local_filename)
//			MessageBox("wf_update_dict found", ls_remote_dict_path)
				ll_file_size = FileLength(ls_local_filename)
				extPutImageFile(ls_dict_tmp_i, ls_dict_tmp_m, ls_local_filename, is_dict_file_list[ll_r_row], is_local_dict_tstamp[ll_r_row], ll_file_size)			
				exit
			end if
		next
		if not lb_found then
			extGetBinaryFile(ls_local_filename, ls_remote_dict_path)
//			MessageBox("wf_update_dict new", ls_remote_dict_path)
			ll_file_size = FileLength(ls_local_filename)
			if isvalid(gn_appman.iw_progress_bar) then
				Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)
			end if
			extPutImageFile(ls_dict_tmp_i, ls_dict_tmp_m, ls_local_filename, is_dict_file_list[ll_r_row], is_dict_timestamp_list[ll_r_row], ll_file_size)					
		end if
	next	
	if lb_valid_file_exist then
		FileDelete(gn_appman.is_dict_index_file)
		FileDelete(gn_appman.is_dict_image_file)
		FileMove(ls_dict_tmp_i, gn_appman.is_dict_index_file)
		FileMove(ls_dict_tmp_m, gn_appman.is_dict_image_file)
	else //???
		FileMove(ls_dict_tmp_i, gn_appman.is_dict_index_file)
		FileMove(ls_dict_tmp_m, gn_appman.is_dict_image_file)
	end if
else // Create New Resource File
	extCreateResourceFile(gn_appman.is_dict_index_file, gn_appman.is_dict_image_file)
	ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
	lb_valid_file_exist = false
	for ll_r_row = 1 to upperbound(is_dict_file_list)
		if is_dict_timestamp_list[ll_r_row] = "00000000000000" or is_dict_timestamp_list[ll_r_row] = "19700101000000" then continue
		lb_valid_file_exist = true
		ls_remote_dict_path = is_dict_file_list[ll_r_row]
		extGetBinaryFile(ls_local_filename, ls_remote_dict_path)
		ll_file_size = FileLength(ls_local_filename)
		if isvalid(gn_appman.iw_progress_bar) then
			Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)
		end if
		extPutImageFile(gn_appman.is_dict_index_file, gn_appman.is_dict_image_file, ls_local_filename, is_dict_file_list[ll_r_row], is_dict_timestamp_list[ll_r_row], ll_file_size)					
	Next
	if not lb_valid_file_exist then
		FileDelete(gn_appman.is_dict_index_file)
		FileDelete(gn_appman.is_dict_image_file)
	end if
end if
FileDelete(ls_local_filename)
return 1
end function

public function integer wf_update_lesson ();long ll_r_row, ll_l_row, ll_file_size, ll_i, ll_count
string ls_remote_lesson_path, ls_lesson_path, ls_local_filename, ls_lesson_tmp_i, ls_lesson_tmp_m
boolean lb_found, lb_valid_file_exist = false

MessageBox("wf_update_lesson", "START")
//ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
ls_local_filename = "ttttmmmppp.bin"

if FileExists(gn_appman.is_lesson_index_file) and FileExists(gn_appman.is_lesson_image_file) then // update
	ls_lesson_tmp_i = gn_appman.is_app_path + "\resourece_tmp.lhi"
	ls_lesson_tmp_m = gn_appman.is_app_path + "\resourece_tmp.lhm"
	extCreateResourceFile(ls_lesson_tmp_i, ls_lesson_tmp_m)
	for ll_r_row = 1 to upperbound(is_lesson_file_list)
		if is_lesson_timestamp_list[ll_r_row] = "00000000000000" or is_lesson_timestamp_list[ll_r_row] = "19700101000000" then continue
		lb_valid_file_exist = true
		ls_remote_lesson_path = is_lesson_file_list[ll_r_row]
		lb_found = false
		for ll_l_row = 1 to upperbound(is_r_path)
			if is_lesson_file_list[ll_r_row] = is_local_lesson_path[ll_l_row] and is_lesson_timestamp_list[ll_r_row] = is_local_lesson_tstamp[ll_l_row] then
				lb_found = true
				ls_remote_lesson_path = is_lesson_file_list[ll_r_row]
				extGetImageFile(gn_appman.is_lesson_index_file, gn_appman.is_lesson_image_file, is_lesson_file_list[ll_r_row], ls_local_filename)
				ll_file_size = FileLength(ls_local_filename)
				extPutImageFile(ls_lesson_tmp_i, ls_lesson_tmp_m, ls_local_filename, is_lesson_file_list[ll_r_row], is_local_lesson_tstamp[ll_r_row], ll_file_size)			
				exit
			end if
		next
		if not lb_found then
//			MessageBox("wf_update_dict", ls_remote_lesson_path)
			extGetBinaryFile(ls_local_filename, ls_remote_lesson_path)
			ll_file_size = FileLength(ls_local_filename)
//			if isvalid(gn_appman.iw_progress_bar) then
//				Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)
//			end if
			extPutImageFile(ls_lesson_tmp_i, ls_lesson_tmp_m, ls_local_filename, is_lesson_file_list[ll_r_row], is_lesson_timestamp_list[ll_r_row], ll_file_size)					
		end if
	next
	if lb_valid_file_exist then
		FileDelete(gn_appman.is_lesson_index_file)
		FileDelete(gn_appman.is_lesson_image_file)
		FileMove(ls_lesson_tmp_i, gn_appman.is_lesson_index_file)
		FileMove(ls_lesson_tmp_m, gn_appman.is_lesson_image_file)
	else //???
		FileDelete(ls_lesson_tmp_i)
		FileDelete(ls_lesson_tmp_m)
	end if
else // Create New Resource File
	extCreateResourceFile(gn_appman.is_lesson_index_file, gn_appman.is_lesson_image_file)
	ls_local_filename = gn_appman.is_app_path + "\ttttmmmppp.bin"
	lb_valid_file_exist = false
	for ll_r_row = 1 to upperbound(is_lesson_file_list)
		if is_lesson_timestamp_list[ll_r_row] = "00000000000000" or is_lesson_timestamp_list[ll_r_row] = "19700101000000" then continue
		lb_valid_file_exist = true
		ls_remote_lesson_path = is_lesson_file_list[ll_r_row]
		extGetBinaryFile(ls_local_filename, ls_remote_lesson_path)
		ll_file_size = FileLength(ls_local_filename)
//		if isvalid(gn_appman.iw_progress_bar) then
//			Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)
//		end if
		extPutImageFile(gn_appman.is_lesson_index_file, gn_appman.is_lesson_image_file, ls_local_filename, is_lesson_file_list[ll_r_row], is_lesson_timestamp_list[ll_r_row], ll_file_size)					
	Next
	if not lb_valid_file_exist then
		FileDelete(gn_appman.is_lesson_index_file)
		FileDelete(gn_appman.is_lesson_image_file)
	end if
end if
FileDelete(ls_local_filename)
return 1
end function

public function integer wf_dictionary_validate ();long ll_dictrow, ll_l_row, ll_ret = 1
boolean lb_found

if upperbound(is_dict_file_list) <> upperbound(is_dict_path) then 
	ll_ret = 0
end if
for ll_dictrow = 1 to upperbound(is_dict_file_list)
	lb_found = false
	for ll_l_row = 1 to upperbound(is_local_dict_path)		
		if is_dict_file_list[ll_dictrow] = is_local_dict_path[ll_l_row] and is_dict_timestamp_list[ll_dictrow] = is_local_dict_tstamp[ll_l_row] then
			lb_found = true
			exit
		end if
	next
	if not lb_found then
		ll_ret = 0
		il_total_dict_update_fsize = il_total_dict_update_fsize + long(is_dict_file_size_list[ll_dictrow])
	end if
next

return ll_ret
end function

public function integer wf_lesson_validate ();long ll_r_row, ll_l_row, ll_ret = 1
boolean lb_found

if upperbound(is_lesson_file_list) <> upperbound(is_lesson_path) then 
	ll_ret = 0
end if
for ll_r_row = 1 to upperbound(is_lesson_file_list)
	lb_found = false
	for ll_l_row = 1 to upperbound(is_local_lesson_path)		
		if is_lesson_file_list[ll_r_row] = is_local_lesson_path[ll_l_row] and is_lesson_timestamp_list[ll_r_row] = is_local_lesson_tstamp[ll_l_row] then
			lb_found = true
			exit
		end if
	next
	if not lb_found then
		ll_ret = 0
		il_total_lesson_update_fsize = il_total_lesson_update_fsize + long(is_lesson_file_size_list[ll_r_row])
	end if
next

return ll_ret
end function

public function integer wf_make_world_list (string as_input_words, string as_mask, string as_distraction, ref string as_output_word_list[]);integer li_i,li_j=0, li_count, li_pos
string ls_tmp_word_list[], ls_tmp_words, ls_tmp_mask, ls_empty[], ls_mask
ls_tmp_words = trim(as_input_words)
if len(as_mask) = 0 then 
	ls_mask = space(len(as_input_words))
else
	ls_mask = as_mask
end if
if len(ls_mask) > len(as_input_words) then 
	ls_mask = left(ls_mask, len(as_input_words))
end if
if len(ls_mask) < len(as_input_words) then 
	ls_mask = ls_mask + space(len(as_input_words) - len(ls_mask))
end if
li_count = len(as_input_words)
ls_tmp_mask = ls_mask
li_i = 1
do
	li_pos = pos(ls_tmp_words, ' ')
	if li_pos > 0 then
		if trim(left(ls_tmp_mask, li_pos - 1)) = "" then
			as_output_word_list[upperbound(as_output_word_list) + 1] = left(ls_tmp_words, li_pos - 1)
		end if		
		ls_tmp_words = right(ls_tmp_words, len(ls_tmp_words) - li_pos)
		ls_tmp_mask = right(ls_tmp_mask, len(ls_tmp_mask) - li_pos)
		li_i++
	end if	
loop while li_pos > 0
if trim(ls_tmp_mask) = "" then
	as_output_word_list[upperbound(as_output_word_list) + 1] = ls_tmp_words
end if		

// add distraction list
if len(trim(as_distraction)) > 0 then
	ls_tmp_words = as_distraction
	do
		li_pos = pos(ls_tmp_words, ' ')
		if li_pos > 0 then
			as_output_word_list[upperbound(as_output_word_list) + 1] = left(ls_tmp_words, li_pos - 1)
			ls_tmp_words = right(ls_tmp_words, len(ls_tmp_words) - li_pos)
		end if	
	loop while li_pos > 0
	as_output_word_list[upperbound(as_output_word_list) + 1] = ls_tmp_words
end if

return 1
end function

public function integer wf_reward_synch ();// check if resource synchronization is needed
long ll_return, ll_i, ll_file_size
string ls_sql_statement
string ls_list, ls_col_name[], ls_result_set[], ls_local_file_name

// validate reward
ls_sql_statement = &
"select resource_id,full_path,file_name from RewardSource where media_type = 'FV' and account_id = " + string(gn_appman.il_account_id) + " union " + &
"select rs.resource_id as resource_id,rs.full_path as full_path,rs.file_name as file_name from RewardSource as rs, RewardSourceAcquired as ra " + &
" where rs.media_type = 'FV' and rs.account_id = ra.orig_acct_id and ra.account_id = " + string(gn_appman.il_account_id) + " order by resource_id"

ids_reward = create nvo_datastore
ids_reward.dataobject = "d_student_reward_source"
ids_reward.is_select_sql = ls_sql_statement
ids_reward.Data_retrieve( )
if ids_reward.rowcount( ) > 0 then
	for ll_i = 1 to ids_reward.rowcount( )		
		is_reward_path[ll_i] = ids_reward.GetItemString(ll_i, "full_path")
		is_reward_fname[ll_i] = ids_reward.GetItemString(ll_i, "file_name")
		is_reward_timestamp_list[ll_i] = space(14)
		is_reward_fsize[ll_i] = space(9)
	next
else
	return 0
end if
if extGetValidFileList(is_reward_path, is_reward_timestamp_list, is_reward_fsize, upperbound(is_reward_path)) = 0 then
	return 0	
end if
 
CreateDirectory(gn_appman.is_app_path + "\vidoes")
for ll_i = 1 to upperbound(is_reward_path)
	ls_local_file_name = gn_appman.is_app_path + "\vidoes\" + is_reward_fname[ll_i]	
//	MessageBox(is_reward_fname[ll_i] + ":" + is_reward_fsize[ll_i], FileLength(ls_local_file_name))
	if not FileExists(ls_local_file_name) or (FileExists(ls_local_file_name) and &
		FileLength(ls_local_file_name) <> long(is_reward_fsize[ll_i])) then
		il_total_reward_update_fsize = il_total_reward_update_fsize + long(is_reward_fsize[ll_i])
	end if
next

if il_total_reward_update_fsize = 0 then return 0
OpenWithParm(w_progress_bar, string(il_total_reward_update_fsize) + "Title:Download Reward Files Please Wait...")
for ll_i = 1 to upperbound(is_reward_path)
	ls_local_file_name = gn_appman.is_app_path + "\vidoes\" + is_reward_fname[ll_i]
	if not FileExists(ls_local_file_name) or (FileExists(ls_local_file_name) and &
		FileLength(ls_local_file_name) <> long(is_reward_fsize[ll_i])) then
		if isvalid(gn_appman.iw_progress_bar) then
			extSetWinHandle(long(Handle(gn_appman.iw_progress_bar)))
		end if		
//		MessageBox(is_reward_path[ll_i], is_reward_fsize[ll_i])

		extGetBinaryFile(ls_local_file_name, is_reward_path[ll_i])
		ll_file_size = FileLength(ls_local_file_name)
//		if isvalid(gn_appman.iw_progress_bar) then
//			Send(Handle(gn_appman.iw_progress_bar), 1024, 0, ll_file_size)
//		end if
	end if
next
if isvalid(gn_appman.iw_progress_bar) then
	Send(Handle(gn_appman.iw_progress_bar), 1025, 0, 0)
end if	
	
return 1

end function

public function integer wf_lesson_list ();long ll_row, ll_orig_acct_id, ll_lesson_id, ll_method_id
string ls_lesson_name, ls_lesson_subpath, ls_remote_site_path, ls_remote_lesson_path
string ls_res_datetime, ls_remote_res_datetime, ls_remote_sys_datetime, ls_date, ls_time, ls_sql_statement
string ls_list, ls_col_name[], ls_result_set[], ls_local_file_name
DateTime ldt_res_datetime, ldt_dict_datetime, ldt_remote_sys_datetime, ldt_remote_res_datetime
boolean lb_not_update_for_lesson=false, lb_not_update_for_dict=false
long ll_return, ll_i

ls_res_datetime = space(20)
ls_remote_sys_datetime = space(20)
ls_remote_res_datetime = space(20)

ls_sql_statement = &
"select Max(LastResourceDT) From Account Where id = " + string(gn_appman.il_account_id) 
ll_return = gn_appman.invo_sqlite.of_execute_retrieve_sql2(ls_sql_statement, ls_col_name, ls_result_set)
if ll_return > 0 then
	ls_remote_res_datetime = ls_result_set[1]
//	MessageBox("ls_remote_res_datetime", ls_remote_res_datetime)
	ls_date = left( ls_remote_res_datetime, 10)
	ls_time = mid(ls_remote_res_datetime, 12, 8)
	ldt_remote_res_datetime = DateTime(Date(ls_date), Time(ls_time))
	extGetSysDate(ls_remote_sys_datetime)
	ls_date = left(ls_res_datetime, 10)
	ls_time = mid(ls_res_datetime, 12, 8)
	ldt_remote_sys_datetime = DateTime(Date(ls_date), Time(ls_time))
	if ldt_remote_res_datetime > ldt_remote_sys_datetime then	
		ldt_remote_sys_datetime = ldt_remote_res_datetime
		ls_remote_sys_datetime = ls_remote_res_datetime
	end if
else
//	MessageBox("wf_lesson_list", "0")
	return 0
end if
//MessageBox("wf_lesson_list", "1")
if FileExists(gn_appman.is_lesson_index_file) then
	il_lesson_entry_count = extResIndexCount(gn_appman.is_lesson_index_file, ls_res_datetime)
	ls_date = left(ls_res_datetime, 10)
	ls_time = mid(ls_res_datetime, 12, 8)
	ldt_res_datetime = DateTime(Date(ls_date), Time(ls_time))
//MessageBox("FileExists", "1")
	if ldt_remote_res_datetime <= ldt_res_datetime and il_lesson_entry_count > 0 then // earlier 		
		return 0
	end if
	for ll_i = 1 to il_lesson_entry_count
		is_local_lesson_path[ll_i] = space(500)
		is_local_lesson_tstamp[ll_i] = space(14)
	next
	extRetrieveResIndex(gn_appman.is_lesson_index_file, is_local_lesson_path, is_local_lesson_tstamp)
	for ll_i = 1 to il_lesson_entry_count
		is_local_lesson_tstamp[ll_i] = left(is_local_lesson_tstamp[ll_i], 14)
	next	
end if

// Lesson Retrieving
ids_lesson_list = create nvo_datastore
ids_lesson_list.dataobject = "d_lesson_list"
ids_lesson_list.is_select_sql = &
	"select la.account_id as account_id,la.orig_acct_id as orig_acct_id,instruction_id,instruction_id2," + &
	" prompt_inst,l.lesson_id as lesson_id,m.method_id as method_id," + &
	" l.lesson_name as lesson_name,m.Lesson_subpath as Lesson_subpath,a.Site_path as Site_path" + &
	" From LessonAcquired As la,Lesson As l,Method as m,Account as a " + &
	" Where la.orig_acct_id = l.account_id and la.lesson_id = l.lesson_id and l.method_id = m.method_id " + &
	" and l.account_id = a.id and la.account_id = " + string(gn_appman.il_account_id) + &
	" union " + &
   " Select l.account_id as account_id,l.account_id as orig_acct_id,instruction_id,instruction_id2," + &
	" prompt_inst,l.lesson_id as lesson_id,m.method_id as method_id," + &
	" l.lesson_name as lesson_name,m.Lesson_subpath as Lesson_subpath,a.Site_path as Site_path" + &
	" From Lesson As l,Method as m,Account as a" + &
	" Where l.method_id = m.method_id and l.account_id = a.id and l.account_id = " + string(gn_appman.il_account_id)	
//MessageBox("ids_lesson_list", ids_lesson_list.is_select_sql)
ids_lesson_list.Data_retrieve( )
//MessageBox("ids_lesson_list.RowCount()", ids_lesson_list.RowCount())
// Lesson Loading
For ll_row = 1 to ids_lesson_list.RowCount()
	ll_orig_acct_id = ids_lesson_list.GetItemNumber(ll_row, "orig_acct_id")
	ll_method_id = ids_lesson_list.GetItemNumber(ll_row, "method_id")
	ll_lesson_id = ids_lesson_list.GetItemNumber(ll_row, "lesson_id")	
	ls_lesson_name = lower(ids_lesson_list.GetItemString(ll_row, "lesson_name"))
	ls_lesson_subpath = ids_lesson_list.GetItemString(ll_row, "Lesson_subpath")
	ls_remote_site_path = ids_lesson_list.GetItemString(ll_row, "site_path") + "/Account" + string(ll_orig_acct_id, "000000")
	ls_remote_lesson_path = ls_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + string(ll_method_id, "00") + ls_lesson_name + string(ll_lesson_id, "0000000000") + ".xml"	
//	ls_remote_lesson_path = ls_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + string(ll_method_id, "00") + ls_lesson_name + string(ll_lesson_id, "0000000000") + ".txt"	
//	MessageBox(ls_remote_lesson_path, ls_remote_lesson_path)
	wf_add_to_lesson_list(ls_remote_lesson_path)
	if ll_method_id = 15 or ll_method_id = 16 then
		ls_remote_lesson_path = left(ls_remote_lesson_path, len(ls_remote_lesson_path) - 4) + "_con.txt"
//		ls_remote_lesson_path = left(ls_remote_lesson_path, len(ls_remote_lesson_path) - 4) + "_con.xml"
		wf_add_to_lesson_list(ls_remote_lesson_path)
	end if
Next

//	MessageBox("upperbound(is_dict_file_list)", upperbound(is_dict_file_list))
if upperbound(is_lesson_file_list) > 0 then
	if extGetValidFileList(is_lesson_file_list, is_lesson_timestamp_list, is_lesson_file_size_list, upperbound(is_lesson_file_list)) = 0 then
		Messagebox("Error", "Cannot Get Remote File Timestamps For Dictionary!")
	end if
end if

return 1

end function

public function integer wf_cache_datastores ();long ll_orig_acct_id, ll_student_id, ll_lesson_id, ll_method_id, ll_row
string ls_index_id
nvo_datastore lds_sys_treeview, lds_account, lds_student, lds_lesson_type, lds_lesson_list
nvo_datastore lds_lesson_student, lds_lesson_parm, lds_student_RTR, lds_student_RTW, lds_reward
nvo_datastore lds_student_abbls_task_letter,lds_student_abbls_task_sequence,lds_student_abbls_lesson_list

lds_sys_treeview = create nvo_datastore
lds_account = create nvo_datastore
lds_student = create nvo_datastore
lds_lesson_type = create nvo_datastore
lds_lesson_list = create nvo_datastore
lds_lesson_student = create nvo_datastore
lds_lesson_parm = create nvo_datastore
lds_student_RTR = create nvo_datastore
lds_student_RTW = create nvo_datastore
lds_reward = create nvo_datastore

lds_student_abbls_task_letter = create nvo_datastore
lds_student_abbls_task_sequence = create nvo_datastore
lds_student_abbls_lesson_list = create nvo_datastore


lds_sys_treeview.dataobject = "d_treeview_sys_table"
lds_account.dataobject = "d_account"
lds_student.dataobject = "d_student"
lds_lesson_type.dataobject = "d_student_lesson_type"
lds_lesson_list.dataobject = "d_student_lesson"
lds_lesson_student.dataobject = "d_student"
lds_lesson_parm.dataobject = "d_lesson_parm"
lds_student_RTR.dataobject = "d_student_rtr"
lds_student_RTW.dataobject = "d_student_rtw"
lds_reward.dataobject = "d_student_reward_source"
lds_student_abbls_task_letter.dataobject = "d_student_abbls_list"
lds_student_abbls_task_sequence.dataobject = "d_student_abbls_detail"
lds_student_abbls_lesson_list.dataobject = "d_abbls_student_lesson"

lds_sys_treeview.is_select_sql = "Select * From Treeview where tv_group_id = 9 And Status = 'A'"
lds_sys_treeview.data_retrieve()

lds_account.is_select_sql = "select Name, ID as account_id From Account Where ID = " + string(gn_appman.il_account_id)
lds_account.data_retrieve()

lds_student.is_database_table = "Student"
lds_student.is_select_col = {"account_id", "student_id", "last_name", "first_name"}
lds_student.is_where_col[1] = "account_id"
lds_student.ia_where_value[1] = gn_appman.il_account_id
lds_student.data_retrieve()
lds_lesson_type.is_select_sql = "Select l.account_id as account_id, sl.student_id as student_id, m.method_cat_id as method_cat_id, m.method_cat_desc as method_name " + &
						" From Method as m, Lesson as l,StudentLesson sl Where m.method_id = l.method_id and " + &
						" sl.account_id = l.account_id and sl.lesson_id = l.lesson_id and sl.active_ind = 'A' and " + &
						" l.account_id = " + string(gn_appman.il_account_id) + " Group By l.account_id, sl.student_id, m.method_cat_id " + &
						" union " + &
						"Select la.account_id as account_id, sl.student_id as student_id, m.method_cat_id as method_cat_id, m.method_cat_desc as method_name " + &
						" From Method as m, LessonAcquired As la, Lesson As l,StudentLesson as sl Where la.orig_acct_id = l.account_id and " + &
						" sl.account_id = la.account_id and sl.lesson_id = la.lesson_id and sl.active_ind = 'A' and " + &					
						" la.lesson_id = l.lesson_id and l.method_id = m.method_id and la.account_id = " + string(gn_appman.il_account_id) + &
						" Group By la.account_id, sl.student_id, m.method_cat_id "

lds_lesson_type.data_retrieve()

lds_lesson_list.is_select_sql = "Select sl.account_id as account_id, sl.orig_acct_id as orig_acct_id, sl.student_id as student_id, l.lesson_id as lesson_id, " + &
											"l.lesson_name as lesson_name, l.method_cat_id as method_cat_id, l.method_id as method_id from StudentLesson As sl, Lesson As l " + &
											"where sl.orig_acct_id = l.account_id and sl.active_ind = 'A' and " + &
											"sl.lesson_id = l.lesson_id and sl.account_id = "  + string(gn_appman.il_account_id)
lds_lesson_list.data_retrieve()

lds_lesson_student.is_database_table = "Student"
lds_lesson_student.is_where_col[1] = "account_id"
lds_lesson_student.ia_where_value[1] = gn_appman.il_account_id
lds_lesson_student.is_where_col[2] = "student_id"

lds_student_RTR.dataobject = "d_student_rtr"
lds_student_RTW.dataobject = "d_student_rtw"
lds_reward.dataobject = "d_student_reward_source"

for ll_row = 1 to lds_student.RowCount()
	ll_student_id = lds_student.GetItemNumber(ll_row, "student_id")
	lds_lesson_student.ia_where_value[2] = ll_student_id
	ls_index_id = string(ll_student_id, "0000000000")
	lds_lesson_student.Reset()
	lds_lesson_student.data_retrieve(ls_index_id)
	lds_student_RTR.is_select_sql =  "Select srtr.orig_acct_id as orig_acct_id,rtr.response_id as response_id, rtr.wave_file as wave_file, a.site_path as site_path " + &
												"from StudentRTR As srtr, ResponseTR as rtr, Account as a " + &
												"where srtr.orig_acct_id = rtr.account_id and " + &
												"      srtr.response_id = rtr.response_id and "+ &
												"      srtr.orig_acct_id = a.id and "+ &
												"      srtr.account_id = " + string(gn_appman.il_account_id) + " and "+ &
												"      srtr.student_id = " + string(ll_student_id)
	lds_student_RTR.data_retrieve(ls_index_id)	
	lds_student_RTW.is_select_sql =  "Select srtw.orig_acct_id as orig_acct_id,rtw.response_id as response_id, rtw.wave_file as wave_file, a.site_path as site_path " + &
												"from StudentRTW As srtw, ResponseTW as rtw, Account as a " + &
												"where srtw.orig_acct_id = rtw.account_id and " + &
												"      srtw.response_id = rtw.response_id and "+ &
												"      srtw.orig_acct_id = a.id and "+ &
												"      srtw.account_id = " + string(gn_appman.il_account_id) + " and "+ &
												"      srtw.student_id = " + string(ll_student_id)	
	lds_student_RTW.data_retrieve(ls_index_id)
	lds_reward.is_select_sql =  "Select media_type, rs.site_path as site_path, rs.file_name as file_name, rs.full_path as full_path," + &
												" sr.duration as duration,sr.repeat as repeat,sr.sort_order as sort_order " + &
												"from StudentReward As sr, RewardSource As rs " + &
												"where sr.orig_acct_id = rs.account_id and " + &
												"      sr.resource_id = rs.resource_id and "+ &
												"      sr.account_id = " + string(gn_appman.il_account_id) + " and "+ &
												"      sr.student_id = " + string(ll_student_id) + " " + &
												"order by sr.sort_order "
	lds_reward.data_retrieve(ls_index_id)
next

lds_lesson_parm.dataobject = "d_lesson_parm"
for ll_row = 1 to lds_lesson_list.RowCount()
	ll_student_id = lds_lesson_list.GetItemNumber(ll_row, "student_id")
	ll_orig_acct_id = lds_lesson_list.GetItemNumber(ll_row, "orig_acct_id")
	ll_lesson_id = lds_lesson_list.GetItemNumber(ll_row, "lesson_id")
	ls_index_id = string(ll_student_id, "0000000") + string(ll_orig_acct_id, "0000000") + string(ll_lesson_id, "0000000000")
	lds_lesson_parm.is_select_sql =  "Select sl.account_id as account_id, sl.orig_acct_id as orig_acct_id, sl.student_id as student_id,sl.lesson_id as lesson_id,sl.degree as degree,sl.tries as tries,sl.prompt_inst as prompt_inst,sl.prompt_ind as prompt_ind,l.instruction_id as instruction_id," + &
										"sl.picture_ind as picture_ind,sl.text_ind as text_ind, repeat,a.site_path as site_path, l.lesson_name as lesson_name, lesson_subpath " + &
										"from StudentLesson as sl, Account as a, Lesson as l, Method as m " + &
										"where sl.orig_acct_id = a.id and sl.lesson_id = l.lesson_id and sl.orig_acct_id = l.account_id and l.method_id = m.method_id and "+ &
										"		 sl.account_id = " + string(gn_appman.il_account_id) + " and "+ &
										"      sl.student_id = " + string(ll_student_id) + " and "+ &
										"      sl.lesson_id = " + string(ll_lesson_id) + " and "+ &
										"      sl.orig_acct_id = " + string(ll_orig_acct_id)
	lds_lesson_parm.data_retrieve(ls_index_id)
next

lds_student_abbls_task_letter.is_select_sql = &
	" Select sl.account_id as account_id, alist.task_letter_id task_letter_id,alist.task_letter task_letter, alist.description description, student_id " + &
	" From AbblsList as alist, AbblsLesson al,Lesson as l, StudentLesson sl " + &
	" Where alist.task_letter_id = al.task_letter_id and al.lesson_id = l.lesson_id and l.account_id and l.account_id = sl.account_id and l.lesson_id = sl.lesson_id " + &
	" and l.account_id = " + string(gn_appman.il_account_id) + & 
	" Group By l.account_id, alist.task_letter_id, sl.student_id " + &
	" union " + &
	" Select sl.account_id as account_id, alist.task_letter_id task_letter_id,alist.task_letter task_letter, alist.description description, student_id " + &
	" From AbblsList as alist, AbblsLesson al,Lesson as l,StudentLesson sl " + &
	" Where alist.task_letter_id = al.task_letter_id and al.lesson_id = l.lesson_id and al.account_id = l.account_id and l.account_id = sl.orig_acct_id and l.lesson_id = sl.lesson_id " + &
	" and sl.account_id = " + string(gn_appman.il_account_id) + &
	" Group By l.account_id, alist.task_letter_id, sl.student_id "
lds_student_abbls_task_letter.data_retrieve()
//MessageBox("ids_student_abbls_task_sequence", ids_student_abbls_task_letter.is_select_sql)
	
lds_student_abbls_task_sequence.is_select_sql = &
	" Select l.account_id as account_id, alist.task_letter_id task_letter_id,alist.task_letter task_letter, student_id," + &
	"  ad.task_name task_name, ad.task_sequence task_sequence " + &
	" From AbblsDetail ad,AbblsList alist,AbblsLesson al,Lesson as l, StudentLesson sl " + &
	" Where alist.task_letter_id = ad.task_letter_id and ad.task_letter_id = al.task_letter_id and l.account_id = sl.account_id and l.lesson_id = sl.lesson_id " + &
	" and ad.task_sequence = al.task_sequence and al.lesson_id = l.lesson_id and l.account_id = "	+ string(gn_appman.il_account_id) + &
	" Group By l.account_id, alist.task_letter_id, ad.task_sequence, sl.student_id " + &
	" union " + &
	" Select sl.account_id account_id, alist.task_letter_id task_letter_id,alist.task_letter task_letter, student_id, " + &
	"  ad.task_name task_name, ad.task_sequence task_sequence " + &
	" From AbblsDetail ad,AbblsList alist,AbblsLesson al,Lesson l,StudentLesson sl " + &
	" Where alist.task_letter_id = ad.task_letter_id and ad.task_letter_id = al.task_letter_id and al.lesson_id = sl.lesson_id and " + &
	" al.account_id = l.account_id and ad.task_sequence = al.task_sequence and sl.orig_acct_id = al.account_id and al.lesson_id = l.lesson_id and sl.account_id = "	+ string(gn_appman.il_account_id) + &
	" Group By l.account_id, alist.task_letter_id, ad.task_sequence, sl.student_id"
lds_student_abbls_task_sequence.data_retrieve()
//MessageBox("ids_student_abbls_task_sequence", ids_student_abbls_task_sequence.is_select_sql)

lds_student_abbls_lesson_list.is_select_sql = "Select al.account_id account_id, l.account_id orig_acct_id, m.method_cat_desc method_name, l.lesson_id lesson_id, lesson_name,task_letter_id,task_sequence, student_id, l.method_id method_id " + &
					" From Lesson As l, AbblsLesson al, Method m, StudentLesson sl " + &
					" Where l.method_id = m.method_id and  l.lesson_id = al.lesson_id and l.account_id = sl.account_id and l.lesson_id = sl.lesson_id and l.account_id = " + string(gn_appman.il_account_id) + &
					" union " + &
					"Select la.account_id account_id, la.orig_acct_id orig_acct_id, m.method_cat_desc method_name,l.lesson_id as lesson_id, lesson_name,task_letter_id,task_sequence, student_id, l.method_id method_id " + &
					" From LessonAcquired As la, Lesson As l, Method as m, AbblsLesson al, StudentLesson sl " + &
					" Where la.orig_acct_id = l.account_id and la.lesson_id = l.lesson_id and l.method_id = m.method_id and l.lesson_id = al.lesson_id and l.account_id = sl.orig_acct_id and l.lesson_id = sl.lesson_id " + &
					" and la.account_id = " + string(gn_appman.il_account_id)
//MessageBox("lds_student_abbls_lesson_list", lds_student_abbls_lesson_list.is_select_sql)
lds_student_abbls_lesson_list.data_retrieve()
//Messagebox("wf_cache", "a")
destroy lds_sys_treeview
destroy lds_account
destroy lds_student
destroy lds_lesson_type
destroy lds_lesson_list
destroy lds_lesson_student
destroy lds_lesson_parm
destroy lds_student_RTR
destroy lds_student_RTW
destroy lds_reward

destroy lds_student_abbls_task_letter
destroy lds_student_abbls_task_sequence
destroy lds_student_abbls_lesson_list
	
return 1
end function

public function integer wf_upload_report ();long ll_column_count, ll_col
string ls_sql_statement, ls_Host, ls_Key, ls_ReturnStatus
integer li_FileNum
ls_Host = space(30)
ls_Key = "dummy"
ls_ReturnStatus = space(600)

if not FileExists(gn_appman.is_sql_cache) then return 0
li_FileNum = FileOpen(gn_appman.is_sql_cache)

do while FileRead(li_FileNum, ls_sql_statement) <> -100
	if len(ls_sql_statement) < 10 then continue
	if LHOA_SQL_dml2(ls_Host, ls_Key, ls_sql_statement, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
		continue
	end if		
loop

FileClose(li_FileNum)

FileDelete(gn_appman.is_sql_cache)
return 1

end function

on w_login.create
int iCurrent
call super::create
this.cbx_local=create cbx_local
this.cbx_save_password=create cbx_save_password
this.rb_account_maintenance=create rb_account_maintenance
this.rb_lesson_playing=create rb_lesson_playing
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_login=create dw_login
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_local
this.Control[iCurrent+2]=this.cbx_save_password
this.Control[iCurrent+3]=this.rb_account_maintenance
this.Control[iCurrent+4]=this.rb_lesson_playing
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.dw_login
end on

on w_login.destroy
call super::destroy
destroy(this.cbx_local)
destroy(this.cbx_save_password)
destroy(this.rb_account_maintenance)
destroy(this.rb_lesson_playing)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_login)
end on

event open;call super::open;string ls_Name, ls_Password, ls_fwName, ls_fwPassword, ls_SavePassword
string ls_lesson_playing, ls_local
dw_login.InsertRow(0)
move(1, 1)

if FileExists(is_startupfile) then
	ls_SavePassword = ProfileString(is_startupfile, "LOGIN", "SavePassword", "NO")
	ls_Name = ProfileString(is_startupfile, "LOGIN", "Name", "")
	ls_lesson_playing = ProfileString(is_startupfile, "LOGIN", "LesssonPlaying", "NO") // as to set the default checkbox
	ls_local = ProfileString(is_startupfile, "LOGIN", "Local", "NO")	// as to set the default checkbox
	dw_login.object.data[1, 1] = ls_Name // as to set the default checkbox
	if ls_SavePassword = "YES" then
		cbx_save_password.checked = true
		ls_Password = ProfileString(is_startupfile, "LOGIN", "Password", "")
		dw_login.object.data[1, 2] = ls_Password	
	else
		cbx_save_password.checked = false
	end if
	if ls_lesson_playing = "YES" then
		rb_lesson_playing.checked = true
		rb_account_maintenance.checked = false
	else
		rb_lesson_playing.checked = false
		rb_account_maintenance.checked = true
	end if
	if ls_local = "YES" then
		rb_lesson_playing.checked = true
		cbx_local.checked = true
	else
		cbx_local.checked = false
	end if
	if pos(gn_appman.is_commandline, "STUDENT") > 0 then
		cb_ok.event clicked() 
	end if
	if pos(gn_appman.is_commandline, "REFRESH_LOCAL") > 0 then
		cbx_local.checked = false
		rb_lesson_playing.checked = true
		cb_ok.event clicked() 
	end if
	
end if




end event

event close;call super::close;if isvalid(ids_lesson_list) then
	destroy ids_lesson_list
end if
if isvalid(ids_response_to_right) then
	destroy ids_response_to_right
end if
if isvalid(ids_response_to_wrong) then
	destroy ids_response_to_wrong
end if
if isvalid(ids_reward) then
	destroy ids_reward
end if



end event

event key;call super::key;//call super::key;integer li_row
long ll_count
string ls_comment_type, ls_win_title
if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
//		enable_ctrl_alt_del()
//		wf_set_lesson_mode(false)
	end if
end if
end event

type cbx_local from checkbox within w_login
integer x = 704
integer y = 460
integer width = 270
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Local"
end type

event clicked;if checked then rb_lesson_playing.checked = true
end event

type cbx_save_password from checkbox within w_login
integer x = 14
integer y = 460
integer width = 571
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Save Password"
boolean checked = true
end type

type rb_account_maintenance from radiobutton within w_login
integer x = 14
integer y = 392
integer width = 608
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Account Maintenance"
end type

event clicked;cbx_local.checked = false
end event

type rb_lesson_playing from radiobutton within w_login
integer x = 14
integer y = 336
integer width = 489
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lesson Playing"
boolean checked = true
end type

type cb_ok from commandbutton within w_login
integer x = 695
integer y = 352
integer width = 306
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
boolean default = true
end type

event clicked;string ls_Host, ls_Key, ls_Name, ls_Password, ls_fwName, ls_fwPassword, ls_ReturnStatus, ls_returns
string ls_sql, ls_col_name[], ls_result_set[], ls_command, ls_sql_statement, ls_restart

integer li_i, li_FileNum, li_ret, li_pin_from_user;
long ll_login_id, ll_trans_code, li_pin = 0, ll_return
w_internet_lh_mdi lw_frame
lw_frame = gn_appman.iw_frame

if pos(gn_appman.is_commandline, "STUDENT") > 0 then
	cbx_local.checked = true
end if

dw_login.AcceptText()
ls_Name = dw_login.object.data[1, 1]
ls_Password = dw_login.object.data[1, 2]
ls_ReturnStatus = space(200)
gn_appman.is_host_name = space(200)

if pos(gn_appman.is_commandline, "STUDENT") > 0 then cbx_local.checked = true

if cbx_local.checked then 
	gn_appman.il_local_login_ind = 1
	li_ret = LHOA_Login(gn_appman.il_local_login_ind, gn_appman.is_host_name, ls_Key, ls_Name, ls_Password, il_login_id, il_trans_code, li_pin, ls_ReturnStatus)
	if li_ret = 0 then return 0	
else
	if ping("www.yahoo.com") = 0 and ping("www.google.com") = 0 then
		if pos(gn_appman.is_commandline, "REFRESH_LOCAL") = 0 then // the refresh_local run in background, so if no internet just halt the application
			MessageBox("Error", "Your Internet Connection Is Not Avaible, Please Verify It Before Re-try!")
		else
			halt
		end if
		return 0
	end if
//	if ping("www.learninghelper.com") = 0 then
	gn_appman.il_local_login_ind = 0	
end if

gn_appman.is_user_name = ls_Name

if gn_appman.il_local_login_ind = 0 then // internet account
	li_ret = NativeInternetLogin()
	if li_ret = 0 then
		if pos(gn_appman.is_commandline, "REFRESH_LOCAL") > 0 then halt // the refresh_local run in background, so if no internet just halt the application
		MessageBox("Error", "Internet Is Not Available!")
	elseif li_ret = -1 then // Firewall or Proxy
		if pos(gn_appman.is_commandline, "REFRESH_LOCAL") > 0 then halt
		if open(w_proxy_login) = 0 then
			return
		end if
	end if
	li_ret = NativeInternetLogin()
	SetPointer(HourGlass!)
	gn_appman.is_remote_home_path = space(200)
	GetHostName(gn_appman.is_host_name)
	GetHomePath(gn_appman.is_remote_home_path)
	li_ret = LHOA_Login(gn_appman.il_local_login_ind, gn_appman.is_host_name, ls_Key, ls_Name, ls_Password, il_login_id, il_trans_code, li_pin, ls_ReturnStatus)
	if li_ret = -1 then // expired
		open(w_pin)
		li_pin_from_user = integer(Message.StringParm)
		if li_pin_from_user = 0 then
			return
		end if
		if li_pin_from_user = li_pin then // PIN matched, update accout status 
			ls_sql_statement = "Update Account Set Status eq 'A' Where Name eq '" + ls_Name + "'"
			if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql_statement, 0, 88888888, ls_ReturnStatus) = 0 then
				MessageBox("ReturnStatus", ls_ReturnStatus)
				return 0
			end if			
			li_ret = LHOA_Login(gn_appman.il_local_login_ind, gn_appman.is_host_name, ls_Key, ls_Name, ls_Password, il_login_id, il_trans_code, li_pin, ls_ReturnStatus)
		else
			MessageBox("Error", "Incorrect Pin Number!")
			return
		end if
	elseif li_ret = 0 then
		MessageBox("ReturnStatus", ls_ReturnStatus)
		return
	end if
//	MessageBox("il_login_id", il_login_id)
	li_ret = LHOA_SQL_version_validate("ilearninghelper", gn_appman.il_version_num, gn_appman.il_build_num, il_login_id)
	if li_ret = 1 then // need update 
		if pos(gn_appman.is_commandline, "REFRESH_LOCAL") = 0 then // only it's not refresh_local, then upgrade the software
			if MessageBox("Warning", "The Software Needs Upgrading, Do You Want To Proceed The Upgrading Now?", Question!, YesNO!) = 1 then
				LHOA_download_installer()
		//		ls_command = "install_ilearninghelper.exe restart" 
				ls_restart = "restart" + string(il_login_id, "000000")
				SwapProgram("install_ilearninghelper.exe", ls_restart)
			end if
		end if
	end if
	li_ret = NativeInternetLogin()
	gn_appman.il_login_id = il_login_id
	gn_appman.il_account_id = il_login_id
	gn_appman.il_transaction_code = il_trans_code

	SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_LOGIN_ID", string(il_login_id))
	SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_TRANS_CODE", string(il_trans_code))

//is_bitmap_path = ProfileString(is_startupfile, "resources", "bitmapfile", "")

	ls_sql = "Select Student_count, site_path, tv_group_id, AccountType " + &
			" from account where " + &
			" id eq " + string(gn_appman.il_account_id)	
	ll_return = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
	for li_i = 1 to upperbound(ls_result_set)
		if lower(ls_col_name[li_i]) = "student_count" then
			gn_appman.ii_student_count = integer(ls_result_set[li_i])
			SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_STUDENT_COUNT", string(gn_appman.ii_student_count))			
		end if
		if lower(ls_col_name[li_i]) = "site_path" then
			gn_appman.is_remote_site_path = ls_result_set[li_i]
			SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_SITE_PATH", gn_appman.is_remote_site_path)
		end if
		if lower(ls_col_name[li_i]) = "tv_group_id" then
			gn_appman.il_tv_group_id = long(ls_result_set[li_i])
			SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_TV_GROUP_ID", string(gn_appman.il_tv_group_id))
		end if
		if lower(ls_col_name[li_i]) = "accounttype" then
			gn_appman.is_account_type = ls_result_set[li_i]
			SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_ACCOUNT_TYPE", gn_appman.is_account_type)
		end if
	next
else // local login
	gn_appman.il_login_id = long(ProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_LOGIN_ID", "0"))
	gn_appman.il_account_id = il_login_id
	gn_appman.il_transaction_code = long(ProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_TRANS_CODE", "0"))
	gn_appman.ii_student_count = integer(ProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_STUDENT_COUNT", "0"))
	gn_appman.is_remote_site_path = ProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_SITE_PATH", "")
	gn_appman.il_tv_group_id = long(ProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_TV_GROUP_ID", "0"))
	gn_appman.is_account_type = ProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_ACCOUNT_TYPE", "")
	SetProfileString(is_startupfile, "LOGIN_BACKUP", ls_name + "_ACCOUNT_TYPE", gn_appman.is_account_type)
end if
gn_appman.is_resource_index_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_resource.lhi"
gn_appman.is_resource_image_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_resource.lhm"
gn_appman.is_dict_index_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_resource_d.lhi"
gn_appman.is_dict_image_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_resource_d.lhm"
gn_appman.is_lesson_index_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_lesson.lhi"
gn_appman.is_lesson_image_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_lesson.lhm"
gn_appman.is_datawindow_index_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_datawindow.lhi"
gn_appman.is_datawindow_image_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_datawindow.lhm"
gn_appman.is_report_index_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_report.lhi"
gn_appman.is_report_image_file = gn_appman.is_app_path + "\" + trim(ls_Name) + "_report.lhm"
gn_appman.is_sql_cache = gn_appman.is_app_path + "\reports\sql_statements.txt"

if gn_appman.ii_student_count = 1 then
	gn_appman.il_student_id = 1
end if
gn_appman.ib_lesson_training_only = rb_lesson_playing.checked
if not FileExists(is_startupfile) then
	li_FileNum = FileOpen(is_startupfile, LineMode!, Write!)
	FileClose(li_FileNum)
end if
SetProfileString(is_startupfile, "LOGIN", "Name", ls_Name)
SetProfileString(is_startupfile, "LOGIN", "FWName", ls_fwName)
SetProfileString(is_startupfile, "LOGIN", "FWPassword", ls_fwPassword)
if cbx_save_password.checked then
	SetProfileString(is_startupfile, "LOGIN", "SavePassword", "YES")
	SetProfileString(is_startupfile, "LOGIN", "Password", ls_Password)
else
	SetProfileString(is_startupfile, "LOGIN", "SavePassword", "NO")
end if

if rb_lesson_playing.checked then
	SetProfileString(is_startupfile, "LOGIN", "LesssonPlaying", "YES")
else
	SetProfileString(is_startupfile, "LOGIN", "LessonPlaying", "NO")
end if
if cbx_local.checked then
	SetProfileString(is_startupfile, "LOGIN", "Local", "YES")
else
	SetProfileString(is_startupfile, "LOGIN", "Local", "NO")
end if

lw_frame.im_mdi.m_applications.m_debugexplorer.visible = false
lw_frame.im_mdi.m_login.enabled = false
lw_frame.im_mdi.m_logoff.enabled = true
lw_frame.im_mdi.m_tools.visible = false	
choose case gn_appman.is_account_type
	case "T", "I" // T=Trial, I=Individual Account (Subscriber)
		lw_frame.im_mdi.m_applications.m_systreeview.visible = false
		lw_frame.im_mdi.m_applications.m_lhexplorer.enabled = true
		lw_frame.im_mdi.m_online.m_createaccount.visible = false
		lw_frame.im_mdi.m_online.m_lessonshoppingcart.visible = false
		if gn_appman.il_local_login_ind = 0 then // internet account
			ls_sql = "select CharValue from SysParm where Name = 'Shopping_Cart_ind'"
			ls_returns = gn_appman.invo_sqlite.of_retrieve_one_value(ls_sql)
			if ls_returns = "Y" then // shopping cart is turned on
				lw_frame.im_mdi.m_online.m_lessonshoppingcart.visible = true
			end if
		end if
	case "G" // Group account (school, institution)
		lw_frame.im_mdi.m_applications.m_systreeview.visible = false
		lw_frame.im_mdi.m_applications.m_lhexplorer.enabled = true
		lw_frame.im_mdi.m_online.m_createaccount.visible = false
		lw_frame.im_mdi.m_online.m_lessonshoppingcart.visible = false
		lw_frame.im_mdi.m_online.m_lessonshoppingcart.text = "Lesson Library"
	case "A", "S" // Admin, Systgem
		lw_frame.im_mdi.m_applications.m_systreeview.visible = true
		lw_frame.im_mdi.m_applications.m_debugexplorer.visible = true
		lw_frame.im_mdi.m_applications.m_lhexplorer.enabled = true
		lw_frame.im_mdi.m_online.m_createaccount.visible = false
		lw_frame.im_mdi.m_tools.visible = true
		lw_frame.im_mdi.m_tools.m_softwaremanager.visible = true
	case else
		lw_frame.im_mdi.m_applications.m_systreeview.visible = false
		lw_frame.im_mdi.m_applications.m_lhexplorer.enabled = false
		lw_frame.im_mdi.m_online.m_createaccount.visible = false
end choose
if gn_appman.il_local_login_ind = 0 and gn_appman.ib_lesson_training_only then // login to internet account
	extCreateResourceFile(gn_appman.is_datawindow_index_file, gn_appman.is_datawindow_image_file)
//	wf_lesson_synch()
//	wf_resource_synch( )
//	wf_reward_synch()
	wf_cache_datastores()
	wf_upload_report()
	if pos(gn_appman.is_commandline, "REFRESH_LOCAL") > 0 then // upgrade the software now
		li_ret = LHOA_SQL_version_validate("ilearninghelper", gn_appman.il_version_num, gn_appman.il_build_num, il_login_id)
		if li_ret = 1 then // need update
			LHOA_download_installer()
			ls_restart = "nostart" + string(il_login_id, "000000") // since this is run in background, no need to restart the program after upgrade
			SwapProgram("install_ilearninghelper.exe", ls_restart)
		end if
		SetProfileString(is_startupfile, "LOGIN", "Local", "YES")
		halt
	end if
end if
if pos(gn_appman.is_commandline, "STUDENT") > 0 then // if this is student batch run
	post Open(gn_appman.iw_student_login)
else
	if gn_appman.il_local_login_ind = 0 then // login to internet account
		open(w_announcement)
	end if
	if gn_appman.ib_lesson_training_only then
		OpenSheetWithParm(w_explorer, "", gn_appman.iw_frame, 0, original!)
	else
		OpenSheetWithParm(w_explorer_account_manager, "", gn_appman.iw_frame, 0, original!)	
	end if
end if

post close(parent)

SetPointer(Arrow!)

end event

type cb_cancel from commandbutton within w_login
integer x = 1102
integer y = 352
integer width = 306
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type dw_login from datawindow within w_login
event dwnkey pbm_dwnkey
integer x = 18
integer y = 16
integer width = 1390
integer height = 304
integer taborder = 10
string title = "none"
string dataobject = "d_login"
boolean minbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dwnkey;if KeyDown(KeyControl!) and KeyDown(KeyAlt!) and KeyDown(KeyShift!) and KeyDown(KeyZ!) then
//and KeyDown(KeyA!) and KeyDown(KeyN!) and KeyDown(KeyZ!) then
	
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
//		enable_ctrl_alt_del()
//		wf_set_lesson_mode(false)
	end if
end if
end event

