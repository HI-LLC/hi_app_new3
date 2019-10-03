$PBExportHeader$w_lesson.srw
forward
global type w_lesson from window
end type
type dw_reward from datawindow within w_lesson
end type
type cb_close from commandbutton within w_lesson
end type
type cb_start from commandbutton within w_lesson
end type
type dw_2 from datawindow within w_lesson
end type
type p_1 from picture within w_lesson
end type
type st_1 from statictext within w_lesson
end type
type dw_1 from datawindow within w_lesson
end type
type dw_prompt from datawindow within w_lesson
end type
type point from structure within w_lesson
end type
type msg from structure within w_lesson
end type
end forward

type POINT from structure
	integer		x
	integer		y
end type

type MSG from structure
	long		hwnd
	integer		message
	integer		wParam
	long		lParam
	long		time
	POINT		pt
end type

global type w_lesson from window
string tag = "1500000"
integer x = 823
integer y = 360
integer width = 3557
integer height = 2248
string title = "Lesson"
windowstate windowstate = maximized!
long backcolor = 15780518
dw_reward dw_reward
cb_close cb_close
cb_start cb_start
dw_2 dw_2
p_1 p_1
st_1 st_1
dw_1 dw_1
dw_prompt dw_prompt
end type
global w_lesson w_lesson

type prototypes
FUNCTION long get_message ( ref MSG lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "bcdll.dll"
FUNCTION long peek_message ( ref MSG lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "bcdll.dll"
FUNCTION long remove_message ( ref MSG lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "bcdll.dll"   
FUNCTION long show_cursor ( int cursor_ind ) LIBRARY "bcdll.dll"   
end prototypes

type variables
protected:
datastore ids_lesson, ids_lesson_container
string is_wave_list[]
string is_picture_list[]
string is_text_list[]
string is_instruction
string is_instruction2
string is_response_to_right
string is_response_to_wrong
string is_response_to_right_list[]
string is_response_to_wrong_list[]
string is_preposition_1
string is_preposition_2
string is_prompt_instruction

string is_source_wave_list[]
string is_source_picture_list[]
string is_source_bean_wave_list[]
string is_source_bean_picture_list[]
string is_source_selected_ind_list[]
string is_dest_wave_list[]
string is_dest_picture_list[]
string is_dest_bean_wave_list[]
string is_dest_bean_picture_list[]
string is_dest_selected_ind_list[]
string is_picture_ind, is_text_ind

integer ii_degree
integer ii_tries
integer ii_item_presented[]
integer ii_correct_item
integer ii_answer_item
integer ii_total_items
integer ii_random_list[]
integer ii_current_try
integer ii_current_question_id = 1
integer ii_current_answer_id = 1
integer ii_selected_source = 0
integer ii_selected_dest = 0
integer ii_type
integer ii_current_list_offset = 1

boolean ib_data_collection = false
boolean ib_batch_run = false
boolean ib_prompt = false
boolean ib_error_correction = false

//str_lesson_program istr_lp
integer ii_number_list[]

long il_total_tries[]
long il_total_correct_answers[]
long il_progress_data_id
long il_lesson_id
long il_lesson_content_pair_ind[]
integer ii_count[]
integer ii_answer_list[]
integer ii_prompt_ind = 0
Pointer ip_orig_pointer
w_container iw_source[], iw_dest[]
public:
integer ii_trial_target = 0
boolean ib_drag = false
boolean ib_misspelled = false
boolean ib_done_prompt = false
integer ii_x0, ii_y0
nv_sound_play inv_sound_play
nvo_datastore ids_student_RTR, ids_student_RTW

datastore ids_progress_report

end variables

forward prototypes
public subroutine wf_random_list (ref integer ai_list[], integer ai_count)
public subroutine wf_random_list (ref string as_list[])
public subroutine wf_get_new_item ()
public subroutine wf_init_container ()
public subroutine wf_question_announcer ()
public subroutine wf_response (boolean ab_correct)
public subroutine wf_response ()
public subroutine wf_random_list (ref string as_list)
public subroutine wf_sort_list (ref integer ai_list[])
public subroutine wf_random_list (ref integer ai_list[])
public subroutine wf_check_batch ()
public function boolean wf_is_in_list (integer ai_item, ref integer ai_list[])
public subroutine wf_lesson_filter (string as_filter_expresson)
public subroutine wf_random_list ()
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_set_prompt_list (integer al_method_id)
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_play_video (string as_video_file)
public subroutine wf_init_lesson ()
public subroutine wf_dragdrop (dragobject source)
public subroutine wf_init_report ()
public subroutine wf_update_progress_report ()
public subroutine wf_retrieve_report (long al_progress_data_id)
public subroutine wf_new_progress_report (long al_progress_data_id)
public function integer wf_init_parameters ()
end prototypes

public subroutine wf_random_list (ref integer ai_list[], integer ai_count);integer li_i, li_list[], li_index
Randomize ( 0 )
for li_i = 1 to ai_count
	do
		li_index = rand(ai_count)
	loop while wf_is_in_list(li_index, li_list)
	ai_list[li_i] = li_index
next


end subroutine

public subroutine wf_random_list (ref string as_list[]);integer li_i, li_list[], li_index, li_count
string ls_list_tmp[]
li_count = upperbound(as_list)
for li_i = 1 to li_count
	do
		li_index = rand(li_count)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i]= li_index
	ls_list_tmp[li_i] = as_list[li_index]
next
for li_i = 1 to li_count
	as_list[li_i] = ls_list_tmp[li_i]
next

end subroutine

public subroutine wf_get_new_item ();
end subroutine

public subroutine wf_init_container ();
end subroutine

public subroutine wf_question_announcer ();
end subroutine

public subroutine wf_response (boolean ab_correct);
end subroutine

public subroutine wf_response ();long ll_count, ll_current
ll_count = upperbound(is_response_to_right_list)
if ll_count > 0 then
//	Randomize ( 0 )
	ll_current = rand(ll_count)
	is_response_to_right = is_response_to_right_list[ll_current]
end if
ll_count = upperbound(is_response_to_wrong_list)
if ll_count > 0 then
//	Randomize ( 0 )
	ll_current = rand(ll_count)
	is_response_to_wrong = is_response_to_wrong_list[ll_current]
end if

end subroutine

public subroutine wf_random_list (ref string as_list);integer li_i, li_list[], li_index, li_count
string ls_list_tmp[]
string ls_tmp = ""
li_count = len(as_list)
for li_i = 1 to li_count
	ls_list_tmp[li_i] = mid(as_list, li_i, 1)
next
wf_random_list(ls_list_tmp)
for li_i = 1 to li_count
	ls_tmp = ls_tmp + ls_list_tmp[li_i]
next
as_list = ls_tmp

end subroutine

public subroutine wf_sort_list (ref integer ai_list[]);integer li_tmp_list[], li_tmp_list2[], li_i, li_j, li_k = 1, li_min = 1000, li_tmp_i, li_max = -1
boolean lb_found

for li_i = 1 to upperbound(ai_list)
	if ai_list[li_i] > li_max then li_max = ai_list[li_i] 
next
for li_i = 1 to li_max 
	li_tmp_list[li_i] = -1
next
for li_i = 1 to upperbound(ai_list)
	li_tmp_list[ai_list[li_i]] = ai_list[li_i]
next
for li_i = 1 to upperbound(li_tmp_list)
	if li_tmp_list[li_i] <> -1 then
		li_tmp_list2[upperbound(li_tmp_list2) + 1] = li_tmp_list[li_i]
	end if
next
ai_list = li_tmp_list2

end subroutine

public subroutine wf_random_list (ref integer ai_list[]);integer li_i, li_list[], li_index, li_count
integer li_list_tmp[]
li_count = upperbound(ai_list)
for li_i = 1 to li_count
	do
		li_index = rand(li_count)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i]= li_index
	li_list_tmp[li_i] = ai_list[li_index]
next
for li_i = 1 to li_count
	ai_list[li_i] = li_list_tmp[li_i]
next

end subroutine

public subroutine wf_check_batch ();
end subroutine

public function boolean wf_is_in_list (integer ai_item, ref integer ai_list[]);integer i
for i = 1 to upperbound(ai_list)
	if ai_item = ai_list[i] then

		return true
	end if
next
return false
end function

public subroutine wf_lesson_filter (string as_filter_expresson);//datawindowchild ldwc_lesson
//if dw_2.GetChild('lesson', ldwc_lesson) = 1 then
//	ldwc_lesson.SetFilter(as_filter_expresson)
//	ldwc_lesson.Filter()
//else
//	MessageBox("Error", "Lesson Selection Fails")
//end if
end subroutine

public subroutine wf_random_list ();integer li_i, li_list[], li_index
for li_i = 1 to ii_degree
	do
		li_index = rand(ii_degree)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i]= li_index
	ii_random_list[li_i] = li_index
next
end subroutine

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	st_1.x = xpos
	st_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public subroutine wf_set_prompt_list (integer al_method_id);long ll_prompt_list[], ll_i, ll_row
string ls_prompt_list[]
datawindowchild ldwc
choose case al_method_id
	case 2, 3 to 13, 17 to 19, 25 //
		ll_prompt_list = {0, 1, 2}
		ls_prompt_list = {"None", "Prompt", "Error Correction"}
	case 14
		ll_prompt_list = {0, 2, 3}
		ls_prompt_list = {"Counts", "Hint", "Prompt"}
	case 21, 22
		ll_prompt_list = {0, 1, 2}
		ls_prompt_list = {"None", "Hint", "Prompt"}
	case 23, 24
		ll_prompt_list = {0, 1, 2, 3}
		ls_prompt_list = {"None", "Counts", "Hint", "Prompt"}		
end choose
if upperbound(ll_prompt_list) =  0 then
	dw_prompt.visible = false
else
	if dw_prompt.GetChild("prompt_ind", ldwc) = -1 then
		MessageBox("prompt_ind", "GetChild Error")
		dw_prompt.visible = false
	else
		for ll_i = 1 to upperbound(ll_prompt_list)
			ll_row = ldwc.InsertRow(0)
			ldwc.SetItem(ll_row, "description", ls_prompt_list[ll_i])
			ldwc.SetItem(ll_row, "id", ll_prompt_list[ll_i])
		next
		dw_prompt.InsertRow(0)
	end if
end if

end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);if ab_lesson_on then
	cb_close.visible = false
	cb_start.visible = false
	dw_reward.visible = false
//	dw_1.visible = false
//	dw_2.visible = false
//	controlmenu = false
else	
	cb_close.visible = true
	cb_start.visible = true
	dw_reward.visible = true
	if isvalid(gw_money_board) then gw_money_board.visible = false
//	dw_1.visible = true
//	dw_2.visible = true
//	controlmenu = true
end if
end subroutine

public subroutine wf_play_video (string as_video_file);OpenWithParm(w_play_avi, as_video_file, this)
end subroutine

public subroutine wf_init_lesson ();integer il_row, li_rowcount
string ls_tmp, ls_resource_path, ls_data_col_ind, ls_prompt_ind, ls_degree
long ll_method_id
any la_parm
gn_appman.of_get_parm("Method ID", la_parm)
ll_method_id = la_parm
ib_prompt = false					
ib_error_correction = false
li_rowcount = ids_lesson.rowcount()
//dw_prompt.InsertRow(0)
wf_set_prompt_list(ll_method_id)
ls_prompt_ind = ProfileString(is_startupfile, "prompt", "method_" + string(ll_method_id), "")
if ls_prompt_ind = "" then
	if not isnull(ids_lesson.GetItemString(1, 'lesson_prompt_ind')) then 
		ii_prompt_ind = integer(ids_lesson.GetItemString(1, 'lesson_prompt_ind'))
		choose case ii_prompt_ind
			case 1
				ib_prompt = true
			case 2
				ib_error_correction = true
		end choose
	else
		ii_prompt_ind = 0
	end if
else
	ii_prompt_ind = integer(ls_prompt_ind)
	choose case ii_prompt_ind
		case 1
			ib_prompt = true
		case 2
			ib_error_correction = true
	end choose
end if
ls_degree = ProfileString(is_startupfile, "degree", "method_" + string(ll_method_id), "")
if ls_degree = "" then
	if not isnull(ids_lesson.GetItemNumber(1, 'lesson_degree')) then 
		ii_degree = ids_lesson.GetItemNumber(1, 'lesson_degree')
	else
		ii_degree = 2
	end if
else
	ii_degree = integer(ls_degree)
end if
is_picture_ind = ProfileString(is_startupfile, "picture_ind", "method_" + string(ll_method_id), "")
if is_picture_ind = "" then
	if not isnull(ids_lesson.GetItemString(1, 'lesson_picture_ind')) then 
		is_picture_ind = ids_lesson.GetItemString(1, 'lesson_picture_ind')
	else
		is_picture_ind = "1"
	end if
end if
is_text_ind = ProfileString(is_startupfile, "text_ind", "method_" + string(ll_method_id), "")
//MessageBox("is_startupfile", is_startupfile)
//MessageBox("is_picture_ind: " + is_picture_ind, "is_text_ind: " + is_text_ind)
if is_text_ind = "" then
	if not isnull(ids_lesson.GetItemString(1, 'lesson_text_ind')) then 
		is_text_ind = ids_lesson.GetItemString(1, 'lesson_text_ind')
	else
		is_text_ind = "0"
	end if
end if

dw_prompt.SetItem(1, 'picture_ind', is_picture_ind)
dw_prompt.SetItem(1, 'text_ind', is_text_ind)

if dw_prompt.RowCount() > 0 then
	dw_prompt.SetItem(1, "prompt_ind", ii_prompt_ind)
	dw_prompt.SetItem(1, "degree", ii_degree)
end if
if not isnull(ids_lesson.GetItemString(1, 'lesson_pair_ind')) then
	ii_trial_target = integer(ids_lesson.GetItemString(1, 'lesson_pair_ind'))
end if
//if ii_trial_target > ii_degree then ii_trial_target = ii_degree
ii_total_items = ids_lesson.RowCount()
for il_row = 1 to ii_total_items
	il_total_tries[il_row] = 0
	il_total_correct_answers[il_row] = 0
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if (not isnull(ls_tmp)) and isnumber(ls_tmp) then
		ii_number_list[il_row] = integer(ls_tmp)
	else
		ii_number_list[il_row] = 0
	end if
	is_picture_list[il_row] = ""
	is_text_list[il_row] = ""	
	ls_resource_path = ids_lesson.GetItemString(il_row, 'subject_description') + '/' + &
								ids_lesson.GetItemString(il_row, 'chapter_description') + "/"								
	ls_tmp = lower(ids_lesson.GetItemString(il_row, 'content_bitmap_file'))
	if not isnull(ls_tmp) and is_picture_ind = '1' then 
		if gn_appman.ib_online_data then
			is_picture_list[il_row] = gn_appman.is_remote_site_path + "/LH_resources/materials/bitmap/" + &
												lower(ls_resource_path) + ls_tmp				
		else
			is_picture_list[il_row] = ls_tmp
		end if
	end if
	if gn_appman.ib_online_data then
		is_wave_list[il_row] = gn_appman.is_remote_site_path + "/LH_resources/materials/wave/" + &
											lower(ls_resource_path) + lower(ids_lesson.GetItemString(il_row, 'content_wave_file'))			
	else
		is_wave_list[il_row] = lower(ids_lesson.GetItemString(il_row, 'content_wave_file'))		
	end if
	
//	is_remote_site_path
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if not isnull(ls_tmp) then 
		is_text_list[il_row] = ls_tmp
	end if
	il_lesson_content_pair_ind[il_row] = ids_lesson.GetItemNumber(il_row, 'content_pair_ind')
next
ls_data_col_ind = ids_lesson.GetItemString(1, 'data_collection_ind')
if not isnull(ls_data_col_ind) then
	if ls_data_col_ind = '1' then
		ib_data_collection = true
	end if
end if
if gn_appman.ib_online_data then
	ls_resource_path = gn_appman.is_remote_site_path + "/LH_resources/static table/wave/" 
else
	ls_resource_path = ""
end if
is_response_to_right = ls_resource_path + "response to right/" + lower(ids_lesson.GetItemString(1, 'response_to_right_wave_file'))
is_response_to_wrong = ls_resource_path + "response to wrong/" + lower(ids_lesson.GetItemString(1, 'response_to_wrong_wave_file'))
is_instruction = ls_resource_path + "instruction/" + lower(ids_lesson.GetItemString(1, 'instruction_wave_file'))
is_instruction2 = ls_resource_path + "instruction/" + lower(ids_lesson.GetItemString(1, 'instruction2_wave_file'))
is_prompt_instruction = ls_resource_path + "prompt/" + lower(ids_lesson.GetItemString(1, 'prompt_prompt_inst'))	
is_preposition_1 = ls_resource_path + "preposition/" + lower(ids_lesson.GetItemString(1, 'preposition_1'))
is_preposition_2 =ls_resource_path +  "preposition/" + lower(ids_lesson.GetItemString(1, 'preposition_2'))
il_lesson_id = ids_lesson.GetItemNumber(1, 'lesson_id') 
ii_degree = integer(ids_lesson.GetItemNumber(1, 'lesson_degree'))
ii_tries = ids_lesson.GetItemNumber(1, 'lesson_tries')
ii_type = ids_lesson.GetItemNumber(1, 'lesson_method_id')
if ii_degree > ii_total_items then
	ii_degree = ii_total_items
end if
if ii_degree > 4 then
	ii_degree = 4
end if

wf_init_parameters()

ii_current_question_id = 0
ii_current_try = 0
ii_current_list_offset = 1 
end subroutine

public subroutine wf_dragdrop (dragobject source);w_lesson lw_tmp
integer li_count
integer li_y
integer li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
boolean lb_found = false
string ls_dragobject_name, ls_dragicon
uo_count_alpha luo_count_alpha
uo_count_number luo_count_number
w_container_unscramble_word lw_container_unscramble_word
w_container_number_match lw_container_number_match

if source.classname() = 'uo_count_alpha' then
	for li_i = 1 to upperbound(iw_dest)
		lw_container_unscramble_word = iw_dest[li_i]
		if lw_container_unscramble_word.st_1.visible = false then
			lb_found = true

			exit
		end if
	next
	luo_count_alpha = source
	lx = source.x 
	ly = source.y 
	if not lb_found then return			
	if luo_count_alpha.iw_parent <> lw_container_unscramble_word then // from other bucket
		if lw_container_unscramble_word.ib_target then
			if luo_count_alpha.st_number.text = lw_container_unscramble_word.st_1.text then
				lw_container_unscramble_word.visible = true				
				lw_container_unscramble_word.st_1.visible = true
				lw_container_unscramble_word.BringToTop = true								
				lw_container_unscramble_word.st_1.BringToTop = true	
				luo_count_alpha.enabled = false
				luo_count_alpha.visible = false
				if dynamic wf_check_alpha() then
					wf_response(true)
					timer(0, this)
				else
					dynamic wf_next_dest()
				end if
			else
				ib_misspelled = true
			end if
		end if
	end if
elseif source.classname() = 'uo_count_number' then
	if this.classname() = "w_lesson_numbermatch_count" then
		lw_container_number_match = iw_source[2]
	else
		lw_container_number_match = iw_source[3]
	end if
	luo_count_number = source
	lx = source.x 
	ly = source.y 
	if luo_count_number.iw_parent <> lw_container_number_match then // from other bucket
		if lw_container_number_match.ib_target then
			li_count = long(luo_count_number.st_number.text)
			if this.dynamic wf_check_number(li_count) then
				lw_container_number_match.st_1.text = string(li_count)
				lw_container_number_match.st_1.visible = true
				wf_response(true)
			else
				wf_response(false)
			end if
		end if
	end if
end if
end subroutine

public subroutine wf_init_report ();long li_count, ll_progress_data_id, ll_i
string ls_sql, ls_col_name[], ls_result_set[]
ids_progress_report =  create datastore
ids_progress_report.dataobject = "d_ilh_pg_data_content"

ls_sql = "Select count(*) as a_count from ProgressData where " + &
			"account_id eq " + string(gn_appman.il_account_id) + " and " + &
			"student_id eq " + string(gn_appman.il_student_id) + " and " + &
			"lesson_id eq " + string(gn_appman.il_lesson_id)
li_count = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
if li_count > 0 then
	if integer(ls_result_set[1]) > 0 then // report exist for the lesson
		ls_sql = "Select max(progress_data_id) as progress_data_id from progressdata where " + &
					"account_id eq " + string(gn_appman.il_account_id) + " and " + &
					"student_id eq " + string(gn_appman.il_student_id) + " and " + &
					"lesson_id eq " + string(gn_appman.il_lesson_id) 
		li_count = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
		if li_count > 0 then
			ll_progress_data_id = long(ls_result_set[1])
			ls_sql = "Select max(total_tries) from ProgressDataContent where " + &
						"account_id eq " + string(gn_appman.il_account_id) + " and " + &
						"student_id eq " + string(gn_appman.il_student_id) + " and " + &
						"lesson_id eq " + string(gn_appman.il_lesson_id) + " and " + &
						"progress_data_id eq " + string(ll_progress_data_id) 
			li_count = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
			if li_count > 0 then
			end if
			if integer(ls_result_set[1]) >= gn_appman.il_data_threshold then // report exist for the lesson
				ll_progress_data_id = ll_progress_data_id + 1
				wf_new_progress_report(ll_progress_data_id)
			end if
		end if
	else
		ll_progress_data_id = 1
		wf_new_progress_report(ll_progress_data_id)
	end if
	wf_retrieve_report(ll_progress_data_id)
end if

end subroutine

public subroutine wf_update_progress_report ();long ll_row, ll_total_tries, ll_total_correct_answers
string ls_sql, ls_Host, ls_Key, ls_ReturnStatus
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(600)

ls_sql = "Update ProgressData set end_date eq '" &
			+ string(today(), "YYYY-MM-DD") + " " + string(now(), "HH:MM:SS") + "' " &
				+ " where progress_data_id eq " + string(ids_progress_report.GetItemNumber(1,"progress_data_id")) &
				+ " and student_id eq " + string(gn_appman.il_student_id) &
				+ " and lesson_id eq " + string(ids_lesson.GetItemNumber(1,"lesson_id")) &
				+ " and account_id eq " + string(gn_appman.il_account_id)
ls_sql = lower(ls_sql)
if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
	MessageBox("ReturnStatus", ls_ReturnStatus)
	return
end if
				
for ll_row = 1 to ids_progress_report.RowCount()
	ll_total_tries = ids_progress_report.GetItemNumber(ll_row,"total_tries") + il_total_tries[ll_row]
	ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_row,"total_correct_answers") + il_total_correct_answers[ll_row]
	ids_progress_report.SetItem(ll_row,"total_tries",ll_total_tries)
	ids_progress_report.SetItem(ll_row,"total_correct_answers",ll_total_correct_answers)
	ls_sql = "Update ProgressDataContent set " &
				+ " total_correct_answers eq " + string(ll_total_correct_answers) &
				+ ", total_tries eq " + string(ll_total_tries) &
				+ " where progress_data_id eq " + string(ids_progress_report.GetItemNumber(ll_row,"progress_data_id")) &
				+ " and content_id eq " + string(ids_progress_report.GetItemNumber(ll_row,"content_id")) &
				+ " and student_id eq " + string(gn_appman.il_student_id) &
				+ " and lesson_id eq " + string(ids_lesson.GetItemNumber(1,"lesson_id")) &
				+ " and account_id eq " + string(gn_appman.il_account_id) 
	ls_sql = lower(ls_sql)
	if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
		MessageBox("ReturnStatus", ls_ReturnStatus)
		return
	end if
	ll_total_tries = il_total_tries[ll_row]
	ll_total_correct_answers = il_total_correct_answers[ll_row]
	ids_progress_report.SetItem(ll_row,"cur_tries",ll_total_tries)
	ids_progress_report.SetItem(ll_row,"cur_correct_answers",ll_total_correct_answers)
next  

end subroutine

public subroutine wf_retrieve_report (long al_progress_data_id);long li_count, ll_return, ll_lesson_id
string ls_sql, ls_col_name[], ls_result_set[]
ll_lesson_id = ids_lesson.GetItemNumber(1,"lesson_id")

ls_sql = "Select pc.progress_data_id as progress_data_id, begin_date, end_date, lesson_name, content_name, content_id, " + &
			" total_tries, total_correct_answers " + & 
			" from ProgressDataContent pc, ProgressData p where " + &
			" pc.progress_data_id eq p.progress_data_id and " + &
			" pc.account_id eq p.account_id and " + &
			" pc.student_id eq p.student_id and " + &
			" pc.lesson_id eq p.lesson_id and " + &
			" pc.account_id eq " + string(gn_appman.il_account_id) + " and " + &
			" pc.student_id eq " + string(gn_appman.il_student_id) + " and " + &
			" pc.progress_data_id eq " + string(al_progress_data_id) + " and " + &
			" pc.lesson_id eq " + string(ll_lesson_id) 
ll_return = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)

if ll_return > 0 then
	gn_appman.invo_sqlite.of_load_to_datastore(ids_progress_report, ls_col_name, ls_result_set)
end if
end subroutine

public subroutine wf_new_progress_report (long al_progress_data_id);
//insert progress_data
long ll_lesson_id, ll_lesson_content_id, li_return, ll_row
string ls_sql, ls_Host, ls_key, ls_content_name, ls_col_name[], ls_result_set[]
string ls_returnstatus, ls_lesson_name, ls_timestamp
ll_lesson_id = ids_lesson.GetItemNumber(1,"lesson_id")
ls_lesson_name = ids_lesson.GetItemString(1,"lesson_description")
ls_timestamp = string(today(), "YYYY-MM-DD") + " " + string(now(), "HH:MM:SS") 
ls_sql = "Insert Into ProgressData(account_id,student_id,lesson_id,progress_data_id,lesson_name,begin_date," &
	+ "end_date) values(" + string(gn_appman.il_account_id) + "," + string(gn_appman.il_student_id) + "," &
	+ string(ll_lesson_id)  + "," + string(al_progress_data_id) + ",'" + ls_lesson_name + "','" &
	+ ls_timestamp + "','" + ls_timestamp + "')"
ls_Host = space(30)
ls_Key = "luxiluyiluke"
ls_ReturnStatus = space(600)
if LHOA_SQL_dml(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus) = 0 then
	MessageBox("ReturnStatus", ls_ReturnStatus)
	return
end if

for ll_row = 1 to ids_lesson.RowCount()
	ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
	ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
	ls_sql = "Insert Into ProgressDataContent(account_id,student_id,lesson_id," + &
				"progress_data_id,content_id,content_name,total_correct_answers,total_tries) " + &
				"values(" + string(gn_appman.il_account_id) + "," + string(gn_appman.il_student_id) + "," + &
				string(ll_lesson_id) + "," + string(al_progress_data_id) +"," + string(ll_lesson_content_id) + ",'" + ls_content_name + "',0,0)"
	li_return = LHOA_SQL_dml(ls_Host, ls_Key, ls_sql, gn_appman.il_login_id, gn_appman.il_transaction_code, ls_ReturnStatus)	
next

end subroutine

public function integer wf_init_parameters ();long ll_row
string ls_resource_path, ls_remote_path
if gn_appman.ib_online_data then
	ids_student_RTR.is_database_table = "StudentRTR"
	ids_student_RTR.is_select_sql =  "Select rtr.wave_file as wave_file " + &
												"from StudentRTR As srtr, ResponseTR as rtr " + &
												"where srtr.account_id eq rtr.account_id and " + &
												"      srtr.response_id eq rtr.response_id and "+ &
												"      srtr.account_id eq " + string(gn_appman.il_account_id) + " and "+ &
												"      srtr.student_id eq " + string(gn_appman.il_student_id)
	ids_student_RTR.data_retrieve()	
	ids_student_RTW.is_database_table = "StudentRTW"
	ids_student_RTW.is_select_sql =  "Select rtw.wave_file as wave_file " + &
												"from StudentRTW As srtw, ResponseTW as rtw " + &
												"where srtw.account_id eq rtw.account_id and " + &
												"      srtw.response_id eq rtw.response_id and "+ &
												"      srtw.account_id eq " + string(gn_appman.il_account_id) + " and "+ &
												"      srtw.student_id eq " + string(gn_appman.il_student_id)
	ids_student_RTW.data_retrieve()										
	ls_resource_path = gn_appman.is_remote_site_path + "/LH_resources/static table/wave/" 
	for ll_row = 1 to ids_student_RTR.RowCount()
		is_response_to_right_list[ll_row] = ls_resource_path + "response to right/" + ids_student_RTR.GetItemString(ll_row, "wave_file")
	next
	for ll_row = 1 to ids_student_RTW.RowCount()
		is_response_to_wrong_list[ll_row] = ls_resource_path + "response to wrong/" + ids_student_RTW.GetItemString(ll_row, "wave_file")
	next
	return 1
else
	return 0
end if

end function

on w_lesson.create
this.dw_reward=create dw_reward
this.cb_close=create cb_close
this.cb_start=create cb_start
this.dw_2=create dw_2
this.p_1=create p_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_prompt=create dw_prompt
this.Control[]={this.dw_reward,&
this.cb_close,&
this.cb_start,&
this.dw_2,&
this.p_1,&
this.st_1,&
this.dw_1,&
this.dw_prompt}
end on

on w_lesson.destroy
destroy(this.dw_reward)
destroy(this.cb_close)
destroy(this.cb_start)
destroy(this.dw_2)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_prompt)
end on

event open;integer li_num
long ll_student_id, ll_count, ll_method_id
string ls_expression, ls_filename, ls_uncompressed_file, ls_filename_con
ls_filename = Message.StringParm
ll_method_id = long(left(ls_filename, 2))
if not FileExists(is_startupfile) then
	li_num = FileOpen(is_startupfile, LineMode! , Write!)
	FileWrite(li_num, " ")
	FileClose(li_num)
end if
Randomize(0)
ids_student_RTR = create nvo_datastore
ids_student_RTR.dataobject = "d_student_rtr"
ids_student_RTW = create nvo_datastore
ids_student_RTW.dataobject = "d_student_rtw"

dw_reward.InsertRow(0)
ids_lesson = gn_appman.ids_lesson[1]
gn_appman.il_lesson_id = ids_lesson.GetItemNumber(1, "lesson_id")
ll_count = ids_lesson.RowCount()
if ll_method_id = 15 or ll_method_id = 16 then
	ids_lesson_container = gn_appman.ids_lesson[2]
end if
if isvalid(p_1) then p_1.visible = false
if isvalid(st_1) then st_1.visible = false

integer li_width, li_height
Constant Long WindowPosFlags = 83 // = SWP_NOACTIVATE + SWP_SHOWWINDOW + SWP_NOMOVE + SWP_NOSIZE
Constant Long HWND_TOPMOST = -1
Constant Long HWND_NOTOPMOST = -2

if gs_vedio_file = "" then
	gs_vedio_file = dw_reward.GetItemString(1, "file_name")
else
	dw_reward.SetItem(1, "file_name", gs_vedio_file)	
end if

if gi_token_num = 0 then
	gi_token_num = dw_reward.GetItemNumber(1, "token_num")
else
	dw_reward.SetItem(1, "token_num", gi_token_num)		
end if

if gs_vedio_file <> "NO" then
	if Isvalid(gw_money_board) then
//		gw_money_board.invo_reward_program.of_init()
		gw_money_board.visible = true
//		gw_money_board.BringToTop = true
	else
		open(gw_money_board)
		gw_money_board.x = this.x
		gw_money_board.y = this.y
	end if
	move(gw_money_board, 1, 1)
	gw_money_board.height = gw_money_board.p_1.height + 2*gw_money_board.p_1.x
	li_width = UnitsToPixels(gw_money_board.width, XUnitsToPixels!)
	li_height = UnitsToPixels(gw_money_board.height, YUnitsToPixels!)
	SetWindowPos (Handle (gw_money_board), HWND_TOPMOST, 1, 1, li_width, li_height, WindowPosFlags)	
	gw_money_board.iw_lesson = this
else
	if isvalid(gw_money_board) then gw_money_board.visible = false
end if

ii_current_question_id = 0
wf_init_report()
if this.classname() = "w_lesson_mw_cmmnd" then
	ii_trial_target = integer(ids_lesson.GetItemString(1, "lesson_pair_ind"))
	if ii_trial_target > 1 then // GROUPING
		cb_start.post event clicked()
	else
		post wf_init_lesson()
		post wf_init_container()
		post wf_set_lesson_mode(true)
		post wf_get_new_item()
	end if
else
	wf_set_lesson_mode(true)
	post wf_init_lesson()
	post wf_init_container()
	post wf_set_lesson_mode(true)
	post wf_get_new_item()
end if



end event

event key;call super::key;integer li_row
long ll_count
string ls_comment_type, ls_win_title
if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
		enable_ctrl_alt_del()
		wf_set_lesson_mode(false)
	end if
end if
end event

event close;window lw_window
long ll_handle
lw_window = this

long ll_method_id, ll_i
any la_parm

if gn_appman.ib_show_report then
	OpenWithParm(w_progress_report, ids_progress_report)
end if
	
if isvalid(ids_lesson) then destroy ids_lesson
if isvalid(ids_lesson_container) then destroy ids_lesson_container
if isvalid(ids_student_RTW) then destroy ids_student_RTW
if isvalid(ids_student_RTR) then destroy ids_student_RTR

if upperbound(iw_dest) > 0 then
	for ll_i = 1 to upperbound(iw_dest)
		if isvalid(iw_dest[ll_i]) then destroy iw_dest[ll_i]
	next
	for ll_i = 1 to upperbound(iw_source)
		if isvalid(iw_source[ll_i]) then destroy iw_source[ll_i]
	next
end if
gn_appman.of_get_parm("Method ID", la_parm)
ll_method_id = la_parm

SetProfileString(is_startupfile, "prompt", "method_" + string(ll_method_id), string(ii_prompt_ind))
SetProfileString(is_startupfile, "degree", "method_" + string(ll_method_id), string(ii_degree))
SetProfileString(is_startupfile, "picture_ind", "method_" + string(ll_method_id), string(is_picture_ind))
SetProfileString(is_startupfile, "text_ind", "method_" + string(ll_method_id), string(is_text_ind))
gb_lesson_is_playing = false
if isvalid(gw_money_board) then
	gw_money_board.visible = false
end if
end event

type dw_reward from datawindow within w_lesson
integer y = 128
integer width = 2606
integer height = 116
integer taborder = 60
string title = "none"
string dataobject = "d_reward"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if dwo.name = "token_num" then
	gi_token_num = integer(data)
else
	gs_vedio_file = data
end if

if isvalid(gw_money_board) then gw_money_board.wf_refresh()

end event

type cb_close from commandbutton within w_lesson
integer x = 3282
integer y = 12
integer width = 247
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_start from commandbutton within w_lesson
integer x = 2743
integer y = 12
integer width = 530
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Start Lesson"
end type

event clicked;Constant Long WindowPosFlags = 83 // = SWP_NOACTIVATE + SWP_SHOWWINDOW + SWP_NOMOVE + SWP_NOSIZE
Constant Long HWND_TOPMOST = -1
Constant Long HWND_NOTOPMOST = -2
long ll_student_id
integer li_width, li_height
wf_set_lesson_mode(true)
ii_current_question_id = 0
//wf_init_lesson()
wf_init_container()
//MessageBox("gs_vedio_file", gs_vedio_file)
if gs_vedio_file <> "NO" then
	if Isvalid(gw_money_board) then
//		gw_money_board.invo_reward_program.of_init()
		gw_money_board.visible = true
	else
		open(gw_money_board)
		gw_money_board.x = parent.x
		gw_money_board.y = parent.y
		li_width = UnitsToPixels(gw_money_board.width, XUnitsToPixels!)
		li_height = UnitsToPixels(gw_money_board.height, YUnitsToPixels!)
		SetWindowPos (Handle (gw_money_board), HWND_TOPMOST, 1, 1, li_width, li_height, WindowPosFlags)	
		gw_money_board.iw_lesson = parent
	end if
else
	gw_money_board.visible = false
end if
wf_get_new_item()

end event

type dw_2 from datawindow within w_lesson
event key pbm_dwnkey
event keydown pbm_keydown
boolean visible = false
integer x = 946
integer y = 12
integer width = 1376
integer height = 36
integer taborder = 40
boolean bringtotop = true
string title = "Lesson - Comparison"
string dataobject = "d_lesson_comparison"
boolean border = false
boolean livescroll = true
end type

event key;parent.event key(key, keyflags)
end event

event keydown;parent.event key(key, keyflags)
end event

type p_1 from picture within w_lesson
integer x = 23
integer y = 412
integer width = 325
integer height = 228
boolean bringtotop = true
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_lesson
boolean visible = false
integer y = 256
integer width = 448
integer height = 248
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 65535
boolean enabled = false
string text = "88"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_lesson
event key pbm_dwnkey
boolean visible = false
integer x = 5
integer y = 12
integer width = 933
integer height = 36
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_student_l"
boolean border = false
boolean livescroll = true
end type

event key;parent.event key(key, keyflags)
end event

event itemchanged;datawindowchild ldwc_tmp
end event

type dw_prompt from datawindow within w_lesson
integer x = 142
integer width = 2441
integer height = 132
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_prompt"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
choose case dwo.name 
	case "prompt_ind"
		ii_prompt_ind = integer(data)
		choose case ii_prompt_ind
			case 1
				ib_prompt = true
			case 2
				ib_error_correction = true
		end choose
	case "degree"
		ii_degree = integer(data)
	case "picture_ind"
		is_picture_ind = data
	case "text_ind"
		is_text_ind = data
end choose
end event

