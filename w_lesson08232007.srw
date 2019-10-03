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
boolean clientedge = true
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
nvo_datastore ids_lesson, ids_lesson_container
string is_wave_list[]
string is_picture_list[]
string is_text_list[]
string is_mask_list[]
string is_distract_list[]
string is_instruction
string is_instruction2
string is_response_to_right
string is_response_to_wrong
string is_response_to_right_list[]
string is_response_to_wrong_list[]
string is_reward_list[]
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
string is_remote_site_path
string is_remote_lesson_path
integer ii_degree
integer ii_tries
integer ii_item_presented[]
integer ii_correct_item
integer ii_answer_item
integer ii_total_items
integer ii_random_list[]
integer ii_current_i = 0
integer ii_current_try
integer ii_current_question_id = 1
integer ii_current_answer_id = 1
integer ii_selected_source = 0
integer ii_selected_dest = 0
integer ii_type
integer ii_current_list_offset = 1
integer ii_first_QA = 1

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
long il_account_id, il_orig_acct_id, il_student_id, il_method_id
long il_response_time[]
long il_begin
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
time it_begin
nvo_sound_play inv_sound_play
nvo_datastore ids_student_RTR, ids_student_RTW, ids_reward, ids_lesson_parm, ids_progress_data, ids_progress_data_content
nvo_datastore ids_progress_report
w_dummy iw_dummy
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
public subroutine wf_init_local_report ()
public subroutine wf_update_progress_report ()
public subroutine wf_retrieve_report (long al_progress_data_id)
public subroutine wf_new_progress_report (long al_progress_data_id)
public function integer wf_init_parameters ()
public function integer wf_load_lesson_content (string as_remote_file_path)
end prototypes

public subroutine wf_random_list (ref integer ai_list[], integer ai_count);integer li_i, li_list[], li_index, li_list_tmp[]

Randomize ( 0 )
for li_i = 1 to ai_count
	do
		li_index = rand(ai_count)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i] = li_index	
next
if upperbound(ai_list) > 0 then
	for li_i = 1 to ai_count
		li_list_tmp[li_i] = ai_list[li_list[li_i]]
	next
	for li_i = 1 to ai_count
		ai_list[li_i] = li_list_tmp[li_i]
	next
else
	for li_i = 1 to ai_count
		ai_list[li_i] = li_list[li_i]
	next	
end if

end subroutine

public subroutine wf_random_list (ref string as_list[]);integer li_i, li_list[], li_index, li_count
string ls_list_tmp[]
li_count = upperbound(as_list)
Randomize ( 0 )
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

public subroutine wf_question_announcer ();if il_begin = 0 then
	il_begin = cpu()
end if
end subroutine

public subroutine wf_response (boolean ab_correct);
end subroutine

public subroutine wf_response ();long ll_count, ll_current, ll_time_duration
ll_count = upperbound(gn_appman.is_response_to_right_list)
if ii_current_try = 0 then
	ll_time_duration = (cpu() - il_begin)
	il_response_time[ii_current_question_id] = il_response_time[ii_current_question_id] + ll_time_duration
end if
if ll_count > 0 then
	Randomize ( 0 )
	ll_current = rand(ll_count)
	is_response_to_right = gn_appman.is_response_to_right_list[ll_current]
//	MessageBox("super:wf_resposne", is_response_to_right)
end if
ll_count = upperbound(gn_appman.is_response_to_wrong_list)
if ll_count > 0 then
	Randomize ( 0 )
	ll_current = rand(ll_count)
	is_response_to_wrong = gn_appman.is_response_to_wrong_list[ll_current]
//	MessageBox("super:wf_resposne", is_response_to_wrong)
end if

end subroutine

public subroutine wf_random_list (ref string as_list);integer li_i, li_list[], li_index, li_count
string ls_list_tmp[]
string ls_tmp = ""
li_count = len(as_list)
Randomize ( 0 )
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
Randomize ( 0 )
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
		if dw_prompt.RowCount() = 0 then
			dw_prompt.InsertRow(0)
		end if
	end if
end if

end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);if ab_lesson_on then
	cb_close.visible = false
	cb_start.visible = false
//	dw_reward.visible = false
//	dw_1.visible = false
//	dw_2.visible = false
//	controlmenu = false
else	
	cb_close.visible = true
	cb_start.visible = true
//	dw_reward.visible = true
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
long ll_method_id, ll_content_id
any la_parm
gn_appman.of_get_parm("Method ID", la_parm)
ll_method_id = la_parm
ib_prompt = false					
ib_error_correction = false
li_rowcount = ids_lesson.rowcount()
//dw_prompt.InsertRow(0)
//wf_init_parameters()
wf_set_prompt_list(il_method_id)
//ls_prompt_ind = ProfileString(is_startupfile, "prompt", "method_" + string(ll_method_id), "")
ls_prompt_ind = string(dw_prompt.GetItemNumber(1, "prompt_ind"))
if isnull(ls_prompt_ind) then
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
//ls_degree = ProfileString(is_startupfile, "degree", "method_" + string(ll_method_id), "")
ii_degree = dw_prompt.GetItemNumber(1, "degree")

if isnull(ii_degree) then
	if not isnull(ids_lesson.GetItemNumber(1, 'lesson_degree')) then 
		ii_degree = ids_lesson.GetItemNumber(1, 'lesson_degree')
	else
		ii_degree = 2
	end if
end if
//is_picture_ind = ProfileString(is_startupfile, "picture_ind", "method_" + string(ll_method_id), "")
is_picture_ind = dw_prompt.GetItemString(1, "picture_ind")
if isnull(is_picture_ind) then
	if not isnull(ids_lesson.GetItemString(1, 'lesson_picture_ind')) then 
		is_picture_ind = ids_lesson.GetItemString(1, 'lesson_picture_ind')
	else
		is_picture_ind = "1"
	end if
end if
is_text_ind = dw_prompt.GetItemString(1, "text_ind")
if isnull(is_text_ind) then
	if not isnull(ids_lesson.GetItemString(1, 'lesson_text_ind')) then 
		is_text_ind = ids_lesson.GetItemString(1, 'lesson_text_ind')
	else
		is_text_ind = "0"
	end if
end if

//dw_prompt.SetItem(1, 'picture_ind', is_picture_ind)
//dw_prompt.SetItem(1, 'text_ind', is_text_ind)

//if dw_prompt.RowCount() > 0 then
//	dw_prompt.SetItem(1, "prompt_ind", ii_prompt_ind)
//	dw_prompt.SetItem(1, "degree", ii_degree)
//end if
if not isnull(ids_lesson.GetItemString(1, 'lesson_pair_ind')) then
	ii_trial_target = integer(ids_lesson.GetItemString(1, 'lesson_pair_ind'))
end if
//if ii_trial_target > ii_degree then ii_trial_target = ii_degree
ii_total_items = ids_lesson.RowCount()
for il_row = 1 to ii_total_items
	ll_content_id = ids_lesson.GetItemNumber(il_row, "lesson_content_content_id")
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if (not isnull(ls_tmp)) and isnumber(ls_tmp) then
		ii_number_list[il_row] = integer(ls_tmp)
	else
		ii_number_list[il_row] = 0
	end if
	is_picture_list[il_row] = ""
	is_text_list[il_row] = ""	
	is_mask_list[il_row] = ""	
	is_distract_list[il_row] = ""	
	ls_resource_path = ids_lesson.GetItemString(il_row, 'subject_description') + '/' + &
								ids_lesson.GetItemString(il_row, 'chapter_description') + "/" 								
	ls_tmp = lower(ids_lesson.GetItemString(il_row, 'content_bitmap_file'))
	if not isnull(ls_tmp) /* and is_picture_ind = '1' */ then
		if gn_appman.ib_online_data then
			is_picture_list[il_row] = is_remote_site_path + "/LH_resources/materials/bitmap/" + &
												lower(ls_resource_path) + string(ll_content_id, "0000000000") + ls_tmp				
		else
			is_picture_list[il_row] = string(ll_content_id, "0000000000") + "/" + ls_tmp
		end if
	end if
	if gn_appman.ib_online_data then
		is_wave_list[il_row] = is_remote_site_path + "/LH_resources/materials/wave/" + &
											lower(ls_resource_path) + string(ll_content_id, "0000000000") + lower(ids_lesson.GetItemString(il_row, 'content_wave_file'))			
	else
		is_wave_list[il_row] = string(ll_content_id, "0000000000") + lower(ids_lesson.GetItemString(il_row, 'content_wave_file'))		
	end if
	
//	is_remote_site_path
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if not isnull(ls_tmp) then 
		is_text_list[il_row] = ls_tmp
	end if
	if not isnull(ids_lesson.GetItemString(il_row, 'lesson_content_mask')) then 
		is_mask_list[il_row] = ids_lesson.GetItemString(il_row, 'lesson_content_mask')
	end if
	if not isnull(ids_lesson.GetItemString(il_row, 'lesson_content_distraction')) then 
		is_distract_list[il_row] = ids_lesson.GetItemString(il_row, 'lesson_content_distraction')
	end if
	il_lesson_content_pair_ind[il_row] = ids_lesson.GetItemNumber(il_row, 'content_pair_ind')
next
//ls_data_col_ind = ids_lesson.GetItemString(1, 'data_collection_ind')
ib_data_collection = gn_appman.ib_lesson_training_only
//if not isnull(ls_data_col_ind) then
//	if ls_data_col_ind = '1' then
//		ib_data_collection = true
//	end if
//end if
if gn_appman.ib_online_data then
	ls_resource_path = gn_appman.is_remote_site_path + "/LH_resources/static table/wave/" 
else
	ls_resource_path = ""
end if

is_instruction = ls_resource_path + "instruction/" +  string(ids_lesson_parm.GetItemNumber(1, 'instruction_id'), "00000000") + &
								lower(ids_lesson.GetItemString(1, 'instruction_wave_file'))
ii_type = ids_lesson.GetItemNumber(1, 'lesson_method_id')
if ii_degree > ii_total_items then
	ii_degree = ii_total_items
end if
if ii_degree > 4 then
	ii_degree = 4
end if

ii_current_question_id = 0
ii_current_try = 0
ii_current_list_offset = 1 
end subroutine

public subroutine wf_dragdrop (dragobject source);w_lesson lw_tmp
integer li_count
integer li_y
integer li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
boolean lb_found = false, lb_misspelled = false
string ls_dragobject_name, ls_dragicon
uo_count_alpha luo_count_alpha
uo_count_number luo_count_number
w_container_unscramble_word lw_container_unscramble_word
w_container_number_match lw_container_number_match
if not isvalid(source) then return
if source.classname() = 'uo_count_alpha' then
	for li_i = 1 to upperbound(iw_dest)
		lw_container_unscramble_word = iw_dest[li_i]
		if lw_container_unscramble_word.st_1.visible = false then
//			MessageBox("lw_container_unscramble_word.st_1.text", lw_container_unscramble_word.st_1.text)
			lb_found = true
			exit
		end if
		if lw_container_unscramble_word.st_1.text <> lw_container_unscramble_word.is_char then
			lb_misspelled = true
		end if
	next
	luo_count_alpha = source
	lx = source.x 
	ly = source.y 
//	MessageBox("luo_count_alpha.st_number.text", luo_count_alpha.st_number.text)
	if is_text_ind = "4" then // dictation without error prevention
		if not lb_found and (not lb_misspelled or asc(luo_count_alpha.st_number.text) <> 8) then return
		if asc(luo_count_alpha.st_number.text) = 8 then // backspace
			if li_i > 1 then
				lw_container_unscramble_word = iw_dest[li_i - 1]
				lw_container_unscramble_word.st_1.visible = false
				lw_container_unscramble_word.st_1.text = lw_container_unscramble_word.is_char
			end if
			return
		end if
		// if the entered char is a space or at the end of the phrase or sentence  
		// and the word is misspelled, stop from entering
		if lw_container_unscramble_word.is_char = ' ' and lb_misspelled then return
		if lb_misspelled then 
			lw_container_unscramble_word.st_1.backcolor = 65535
		else
			lw_container_unscramble_word.st_1.backcolor = 16711680
		end if
		lw_container_unscramble_word.st_1.text = luo_count_alpha.st_number.text
		lw_container_unscramble_word.visible = true				
		lw_container_unscramble_word.st_1.visible = true
		lw_container_unscramble_word.BringToTop = true								
		lw_container_unscramble_word.st_1.BringToTop = true	
//		MessageBox("wf_dragdrop", "A")
		luo_count_alpha.enabled = false
		luo_count_alpha.visible = false
		if luo_count_alpha.st_number.text = lw_container_unscramble_word.is_char then
//		MessageBox("wf_dragdrop", "B")
			if dynamic wf_check_alpha() then
				wf_response(true)
				timer(0, this)
			else
				dynamic wf_next_dest()
			end if
		else			
//		MessageBox("wf_dragdrop", "C")
			lw_container_unscramble_word.st_1.backcolor = 65535
			ib_misspelled = true
		end if		
	else // others
		if not lb_found then return	
//		MessageBox("wf_dragdrop", "A")
		if luo_count_alpha.iw_parent <> lw_container_unscramble_word then // from other bucket
//			MessageBox("wf_dragdrop", "B")
			if lw_container_unscramble_word.ib_target then
//				MessageBox("wf_dragdrop", "C")
				if luo_count_alpha.st_number.text = lw_container_unscramble_word.st_1.text then
//					MessageBox("wf_dragdrop", "D")
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

for ll_i = 1 to ids_lesson.RowCount()
	il_response_time[ll_i] = 0
	il_total_correct_answers[ll_i] = 0
next

ids_progress_report =  create nvo_datastore
ids_progress_report.dataobject = "d_ilh_pg_data_content"
ids_progress_data = create nvo_datastore
ids_progress_data.dataobject = "d_ilh_pg_data_content"

ids_progress_report.is_database_table = "ProgressDataContent"
ids_progress_report.is_update_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id", &
					"content_id","content_name","distraction","total_tries","total_correct_answers","total_response_time"}
ids_progress_report.is_key_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id","content_id"}

ids_progress_data.is_database_table = "ProgressData"					
ids_progress_data.is_update_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id", &
					"lesson_name","begin_date","end_date"}
ids_progress_data.is_key_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id"}

ls_sql = "Select count(*) as a_count from ProgressData where " + &
			"account_id eq " + string(il_account_id) + " and " + &
			"student_id eq " + string(il_student_id) + " and " + &
			"orig_acct_id eq " + string(il_orig_acct_id) + " and " + &
			"lesson_id eq " + string(il_lesson_id)
li_count = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
if li_count > 0 then
	if integer(ls_result_set[1]) > 0 then // report exist for the lesson
		ls_sql = "Select max(progress_data_id) as progress_data_id from progressdata where " + &
					"account_id eq " + string(il_account_id) + " and " + &
					"student_id eq " + string(il_student_id) + " and " + &
					"orig_acct_id eq " + string(il_orig_acct_id) + " and " + &
					"lesson_id eq " + string(il_lesson_id) 
		li_count = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
		if li_count > 0 then
			ll_progress_data_id = long(ls_result_set[1])
			ls_sql = "Select max(total_tries) as total_tries from ProgressDataContent where " + &
						"account_id eq " + string(il_account_id) + " and " + &
						"student_id eq " + string(il_student_id) + " and " + &
						"orig_acct_id eq " + string(il_orig_acct_id) + " and " + &
						"lesson_id eq " + string(il_lesson_id) + " and " + &
						"progress_data_id eq " + string(ll_progress_data_id) 
			li_count = gn_appman.invo_sqlite.of_execute_retrieve_sql(ls_sql, ls_col_name, ls_result_set)
			if li_count > 0 then
				if integer(ls_result_set[1]) = 0 or integer(ls_result_set[1]) >= gn_appman.il_data_threshold then // report reaches threshold, need new report
					ll_progress_data_id = ll_progress_data_id + 1
					wf_new_progress_report(ll_progress_data_id)
				end if
			end if
		end if
	else
		ll_progress_data_id = 1
		wf_new_progress_report(ll_progress_data_id)
	end if
	wf_retrieve_report(ll_progress_data_id)
end if

end subroutine

public subroutine wf_init_local_report ();//long li_count, ll_progress_data_id, ll_i
//string ls_sql, ls_col_name[], ls_result_set[]
//
//for ll_i = 1 to ids_lesson.RowCount()
//	il_response_time[ll_i] = 0
//	il_total_correct_answers[ll_i] = 0
//next
//
//ids_progress_report =  create nvo_datastore
//ids_progress_report.dataobject = "d_ilh_pg_data_content"
//ids_progress_data = create nvo_datastore
//ids_progress_data.dataobject = "d_ilh_pg_data_content"
//
//ll_progress_data_id = 1
//wf_new_progress_report(ll_progress_data_id)

///////////////////////////////////////
long li_count, ll_progress_data_id, ll_i, ll_row, ll_col
string ls_sql, ls_result_set[]
string ls_filter, ls_progress_data_file, ls_progress_report_file
string ls_col_name[] = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id","lesson_name","begin_date","end_date"}
boolean lb_new_report = false

for ll_i = 1 to ids_lesson.RowCount()
	il_response_time[ll_i] = 0
	il_total_correct_answers[ll_i] = 0
next

ids_progress_report =  create nvo_datastore
ids_progress_report.dataobject = "d_ilh_pg_data_content"
ids_progress_data = create nvo_datastore
ids_progress_data.dataobject = "d_ilh_pg_data_content"

ids_progress_report.is_database_table = "ProgressDataContent"
ids_progress_report.is_update_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id", &
					"content_id","content_name","distraction","total_tries","total_correct_answers","total_response_time"}
ids_progress_report.is_key_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id","content_id"}

ids_progress_data.is_database_table = "ProgressData"					
ids_progress_data.is_update_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id", &
					"lesson_name","begin_date","end_date"}
ids_progress_data.is_key_col = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id"}


// if report directory does not exist, create directory

//ls_progress_data_file = gn_appman.is_app_path + "\reports\" + gn_appman.is_user_name + "_progress_data.csv"
ls_progress_data_file = "reports\" + gn_appman.is_user_name + "_progress_data.csv"
//			ls_progress_report_file = "reports\" + gn_appman.is_user_name + "_progress_report" + string(student_id, "000") + string(lesson_id, "000000") + string(ll_progress_data_id, "000") + ".csv"


if Not FileExists(ls_progress_data_file) then
	lb_new_report = true
	ll_progress_data_id = 1
else
	ids_progress_data.ImportFile(ls_progress_data_file)
//			MessageBox("ids_progress_data.RowCount()", ids_progress_data.RowCount())
	if ids_progress_data.RowCount() < 1 then
		lb_new_report = true
		ll_progress_data_id = 1
	else
		for ll_row = 1 to ids_progress_data.RowCount()
			for ll_col = 1 to upperbound(ls_col_name)
				ids_progress_data.SetItemStatus(ll_row, trim(ls_col_name[ll_col]), Primary!, NotModified!)
			next
			if ids_progress_data.SetItemStatus(ll_row, 0, Primary!, DataModified!) <> 1 then
				MessageBox("ids_progress_data.SetItemStatus", "DataModified Failed")
			end if
			if ids_progress_data.SetItemStatus(ll_row, 0, Primary!, NotModified!) <> 1 then
				MessageBox("ids_progress_data.SetItemStatus", "NotModified Failed")
			end if
			ids_progress_data.ResetUpdate()
		next	
//		ids_progress_data.ResetUpdate()
		ids_progress_data.SetSort("progress_data_id D")
		ll_progress_data_id = ids_progress_data.GetItemNumber(1, "progress_data_id")
		ls_filter = "account_id = " + string(il_account_id) + " and " + &
					"student_id = " + string(il_student_id) + " and " + &
					"orig_acct_id = " + string(il_orig_acct_id) + " and " + &
					"lesson_id = " + string(il_lesson_id)
		ids_progress_data.SetFilter(ls_filter)
		ids_progress_data.Filter()
		if ids_progress_data.RowCount() = 0 then
			lb_new_report = true
			ll_progress_data_id = ll_progress_data_id + 1
		else // existing report
			ls_progress_report_file = "reports\" + gn_appman.is_user_name + "_progress_report" + string(il_student_id, "000") + string(il_lesson_id, "000000") + string(ll_progress_data_id, "000") + ".csv"
//			MessageBox("ls_progress_report_file", ls_progress_report_file)
			if FileExists(ls_progress_report_file) then
				wf_retrieve_report(ll_progress_data_id)
//				MessageBox(ls_progress_report_file, ids_progress_report.RowCount())
				if ids_progress_report.RowCount() > 0 then
					if ids_progress_report.GetItemNumber(1, "total_tries") >= gn_appman.il_data_threshold then // new report
						lb_new_report = true
						ll_progress_data_id = ll_progress_data_id + 1
					end if
				else // file not good, delete it, and create new one
					FileDelete(ls_progress_report_file)
					lb_new_report = true
				end if
			else // Not file exist
				lb_new_report = true
			end if
		end if
	end if
end if
il_progress_data_id = ll_progress_data_id
if lb_new_report then
	wf_new_progress_report(ll_progress_data_id)
else
	wf_retrieve_report(ll_progress_data_id)	
end if
for ll_row = 1 to ids_progress_data.RowCount()
	il_total_tries[ll_row] = 0
	il_total_correct_answers[ll_row] = 0
	il_response_time[ll_row] = 0
next

end subroutine

public subroutine wf_update_progress_report ();long ll_row, ll_i, ll_total_tries, ll_total_correct_answers, ll_total_response_time, ll_report_row = 0
string ls_timestamp
DateTime ldt_timestamp

//if gn_appman.il_local_login_ind = 1 then return // local account 

ldt_timestamp = DateTime(today(), now())
ids_progress_data.SetItem(1, "end_date", ldt_timestamp)
ids_progress_report.SetItem(1, "end_date", ldt_timestamp)
for ll_i = 1 to upperbound(il_total_tries)
	choose case il_method_id
		case 1 // Reading
			if ll_i > ii_first_QA and mod(ll_i - ii_first_QA + 1, ii_degree + 2) = 3 then
				ll_report_row++
				if ll_report_row > ids_progress_report.RowCount() then return
				ll_total_tries = ids_progress_report.GetItemNumber(ll_report_row,"total_tries") + il_total_tries[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_tries",il_total_tries[ll_i])
				ids_progress_report.SetItem(ll_report_row, "total_tries", ll_total_tries)
				ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_report_row,"total_correct_answers") + il_total_correct_answers[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_correct_answers",il_total_correct_answers[ll_i])
				ids_progress_report.SetItem(ll_report_row, "total_correct_answers", ll_total_correct_answers)
				ll_total_response_time = ids_progress_report.GetItemNumber(ll_report_row,"total_response_time") + il_response_time[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_response_time",il_response_time[ll_i])
				ids_progress_report.SetItem(ll_report_row, "total_response_time", ll_total_response_time)
			end if
		case 2 // OI
			if ii_trial_target > 0 then // pair up
				if mod(ll_i, ii_degree) = 1 then
					ll_report_row++
					ll_total_tries = ids_progress_report.GetItemNumber(ll_report_row,"total_tries") + il_total_tries[ll_i]
					ids_progress_report.SetItem(ll_report_row,"cur_tries",il_total_tries[ll_i])
					ids_progress_report.SetItem(ll_report_row, "total_tries", ll_total_tries)
					ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_report_row,"total_correct_answers") + il_total_correct_answers[ll_i]
					ids_progress_report.SetItem(ll_report_row,"cur_correct_answers",il_total_correct_answers[ll_i])
					ids_progress_report.SetItem(ll_report_row, "total_correct_answers", ll_total_correct_answers)
					ll_total_response_time = ids_progress_report.GetItemNumber(ll_report_row,"total_response_time") + il_response_time[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_response_time",il_response_time[ll_i])
					ids_progress_report.SetItem(ll_report_row, "total_response_time", ll_total_response_time)
					end if
			else //sequential
				ll_report_row = ll_i
				ll_total_tries = ids_progress_report.GetItemNumber(ll_report_row,"total_tries") + il_total_tries[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_tries",il_total_tries[ll_i])
				ids_progress_report.SetItem(ll_report_row, "total_tries", ll_total_tries)
				ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_report_row,"total_correct_answers") + il_total_correct_answers[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_correct_answers",il_total_correct_answers[ll_i])
				ids_progress_report.SetItem(ll_report_row, "total_correct_answers", ll_total_correct_answers)
				ll_total_response_time = ids_progress_report.GetItemNumber(ll_report_row,"total_response_time") + il_response_time[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_response_time",il_response_time[ll_i])
				ids_progress_report.SetItem(ll_report_row, "total_response_time", ll_total_response_time)
			end if
		case 14 //Counting - Number (Symbol) Match
		case 15 //Counting - Drag-drop
		case 16 //Grouping
		case 20 //Speech
		case 21, 22 //Spelling-Unscramble Word, Sentence Composing-Unscramble Sentence
			ll_report_row = ll_i
			if ll_report_row > ids_progress_report.RowCount() then return
			ll_total_tries = ids_progress_report.GetItemNumber(ll_report_row,"total_tries") + il_total_tries[ll_i]
			ids_progress_report.SetItem(ll_report_row,"cur_tries",il_total_tries[ll_i])
			ids_progress_report.SetItem(ll_report_row, "total_tries", ll_total_tries)
			ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_report_row,"total_correct_answers") + il_total_correct_answers[ll_i]
			ids_progress_report.SetItem(ll_report_row,"cur_correct_answers",il_total_correct_answers[ll_i])
			ids_progress_report.SetItem(ll_report_row, "total_correct_answers", ll_total_correct_answers)
			ll_total_response_time = ids_progress_report.GetItemNumber(ll_report_row,"total_response_time") + il_response_time[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_response_time",il_response_time[ll_i])
			ids_progress_report.SetItem(ll_report_row, "total_response_time", ll_total_response_time)
		case 23 //Addition
		case 24 //Subtraction
		case 25 //Object Matching
					ll_report_row++
			if ll_report_row > ids_progress_report.RowCount() then return
			ll_total_tries = ids_progress_report.GetItemNumber(ll_report_row,"total_tries") + il_total_tries[ll_i]
			ids_progress_report.SetItem(ll_report_row,"cur_tries",il_total_tries[ll_i])
			ids_progress_report.SetItem(ll_report_row, "total_tries", ll_total_tries)
			ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_report_row,"total_correct_answers") + il_total_correct_answers[ll_i]
			ids_progress_report.SetItem(ll_report_row,"cur_correct_answers",il_total_correct_answers[ll_i])
			ids_progress_report.SetItem(ll_report_row, "total_correct_answers", ll_total_correct_answers)
			ll_total_response_time = ids_progress_report.GetItemNumber(ll_report_row,"total_response_time") + il_response_time[ll_i]
				ids_progress_report.SetItem(ll_report_row,"cur_response_time",il_response_time[ll_i])
			ids_progress_report.SetItem(ll_report_row, "total_response_time", ll_total_response_time)
		case 27 //Speech-Read Loud
		case 28 //Speech-Verbal Labeling
		case 29 //Speech - Conversation
	end choose
//	MessageBox("total_tries: " + string(ll_total_tries), "cur_tries: " + string(il_total_tries[ll_row]))
//	MessageBox("total_correct_answers: " + string(ll_total_correct_answers), "cur_correct_answers: " + string(il_total_correct_answers[ll_row]))
//	MessageBox("total_response_time: " + string(ll_total_response_time), "cur_response_time: " + string(il_response_time[ll_row]))
next  

/*
for ll_row = 1 to ids_progress_report.RowCount()
	if ll_row > upperbound(il_total_tries) then
		ll_total_tries = ids_progress_report.GetItemNumber(ll_row,"total_tries")
	else
		ll_total_tries = ids_progress_report.GetItemNumber(ll_row,"total_tries") + il_total_tries[ll_row]
	end if
	if ll_row > upperbound(il_total_correct_answers) then
		ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_row,"total_correct_answers")
	else
		ll_total_correct_answers = ids_progress_report.GetItemNumber(ll_row,"total_correct_answers") + il_total_correct_answers[ll_row]
	end if
	if ll_row > upperbound(il_response_time) then
		ll_total_response_time = ids_progress_report.GetItemNumber(ll_row,"total_response_time")
	else
		ll_total_response_time = ids_progress_report.GetItemNumber(ll_row,"total_response_time") + il_response_time[ll_row]
	end if
	ids_progress_report.SetItem(ll_row,"total_tries",ll_total_tries)
	ids_progress_report.SetItem(ll_row,"total_correct_answers",ll_total_correct_answers)
	ids_progress_report.SetItem(ll_row,"total_response_time",ll_total_response_time)	
	if ll_row <= upperbound(il_total_tries) then
		ids_progress_report.SetItem(ll_row,"cur_tries",il_total_tries[ll_row])
	end if
	if ll_row <= upperbound(il_total_correct_answers) then
		ids_progress_report.SetItem(ll_row,"cur_correct_answers",il_total_correct_answers[ll_row])
	end if
	if ll_row <= upperbound(il_response_time) then
		ids_progress_report.SetItem(ll_row,"cur_response_time",il_response_time[ll_row])
	end if
	ids_progress_report.SetItem(1, "end_date", ldt_timestamp)
//	MessageBox("total_tries: " + string(ll_total_tries), "cur_tries: " + string(il_total_tries[ll_row]))
//	MessageBox("total_correct_answers: " + string(ll_total_correct_answers), "cur_correct_answers: " + string(il_total_correct_answers[ll_row]))
//	MessageBox("total_response_time: " + string(ll_total_response_time), "cur_response_time: " + string(il_response_time[ll_row]))
next  
*/
//ls_timestamp = string(today(), "YYYY-MM-DD") + " " + string(now(), "HH:MM:SS") 
//ids_progress_data.SetItem(1, "begin_date", ldt_timestamp)
//ids_progress_data.SetItem(1, "end_date", ldt_timestamp)


end subroutine

public subroutine wf_retrieve_report (long al_progress_data_id);long li_count, ll_return, ll_lesson_id, ll_row, ll_row_count, ll_col
string ls_sql, ls_result_set[], ls_progress_report_file
string ls_col_name[] = {"account_id","student_id","orig_acct_id","lesson_id","progress_data_id","begin_date","end_date",&
				"lesson_name","content_name","distraction","content_id", "total_tries","total_correct_answers","total_response_time"}

if gn_appman.il_local_login_ind = 1 then
//	ls_progress_report_file = "reports\" + gn_appman.is_user_name + "_progress_report" + string(il_progress_data_id, "00000") + ".csv"
	ls_progress_report_file = "reports\" + gn_appman.is_user_name + "_progress_report" + string(il_student_id, "000") + string(il_lesson_id, "000000") + string(al_progress_data_id, "000") + ".csv"
	ids_progress_report.Reset()
	ids_progress_report.ImportFile(ls_progress_report_file)
	for ll_row = 1 to ids_progress_report.RowCount()
		for ll_col = 1 to upperbound(ls_col_name)
			ids_progress_report.SetItemStatus(ll_row, trim(ls_col_name[ll_col]), Primary!, NotModified!)
		next
		if ids_progress_report.SetItemStatus(ll_row, 0, Primary!, DataModified!) <> 1 then
			MessageBox("ids_progress_report.SetItemStatus", "DataModified Failed")
		end if
		if ids_progress_report.SetItemStatus(ll_row, 0, Primary!, NotModified!) <> 1 then
			MessageBox("ids_progress_report.SetItemStatus", "NotModified Failed")
		end if
		ids_progress_report.ResetUpdate()
	next
//	ids_progress_report.Resetupdate()
else
	ids_progress_report.is_select_sql = &
	"Select pc.account_id as account_id, pc.student_id as student_id, pc.orig_acct_id as orig_acct_id, " + &
				" pc.lesson_id as lesson_id, pc.progress_data_id as progress_data_id, " + &
				" begin_date, end_date, lesson_name, content_name, distraction, content_id, " + &
				" total_tries, total_correct_answers, total_response_time " + & 
				" from ProgressDataContent pc, ProgressData p where " + &
				" pc.progress_data_id eq p.progress_data_id and " + &
				" pc.account_id eq p.account_id and " + &
				" pc.student_id eq p.student_id and " + &
				" pc.orig_acct_id eq p.orig_acct_id and " + &
				" pc.lesson_id eq p.lesson_id and " + &
				" pc.account_id eq " + string(il_account_id) + " and " + &
				" pc.student_id eq " + string(il_student_id) + " and " + &
				" pc.orig_acct_id eq " + string(il_orig_acct_id) + " and " + &
				" pc.progress_data_id eq " + string(al_progress_data_id) + " and " + &
				" pc.lesson_id eq " + string(il_lesson_id) 
				
	ll_return = ids_progress_report.data_retrieve()
	
	ids_progress_data.is_select_sql = &
				" Select account_id, student_id, orig_acct_id,lesson_id,progress_data_id,lesson_name,begin_date,end_date " + &
				" From ProgressData " + &
				" Where account_id eq " + string(il_account_id) + " and " + &
				" student_id eq " + string(il_student_id) + " and " + &
				" orig_acct_id eq " + string(il_orig_acct_id) + " and " + &
				" progress_data_id eq " + string(al_progress_data_id) + " and " + &
				" lesson_id eq " + string(il_lesson_id) 
	ll_row_count = ids_progress_data.data_retrieve()
	for ll_row = 1 to ids_progress_data.RowCount()
		il_total_tries[ll_row] = 0
		il_total_correct_answers[ll_row] = 0
		il_response_time[ll_row] = 0
	next
end if
//if ll_row_count < 



end subroutine

public subroutine wf_new_progress_report (long al_progress_data_id);//insert progress_data
long ll_lesson_id, ll_lesson_content_id, li_return, ll_row, ll_mod, ll_insert_row, ll_i, ll_j, ll_row_offset
long ll_span_begin, ll_span_end, ll_dist_row, ll_rowcount
string ls_sql, ls_Host, ls_key, ls_content_name, ls_col_name[], ls_result_set[]
string ls_returnstatus, ls_lesson_name, ls_timestamp, ls_distraction, ls_mask
datetime ldt_timestamp
ls_lesson_name = ids_lesson_parm.GetItemString(1,"lesson_name")
ls_timestamp = string(today(), "YYYY-MM-DD") + " " + string(now(), "HH:MM:SS") 

ldt_timestamp = DateTime(today(), now())
ids_progress_data.Reset()
ll_row = ids_progress_data.InsertRow(0)
ids_progress_data.SetItem(ll_row, "account_id", il_account_id)
ids_progress_data.SetItem(ll_row, "student_id", il_student_id)
ids_progress_data.SetItem(ll_row, "orig_acct_id", il_orig_acct_id)
ids_progress_data.SetItem(ll_row, "lesson_id", il_lesson_id)
ids_progress_data.SetItem(ll_row, "progress_data_id", al_progress_data_id)
ids_progress_data.SetItem(ll_row, "lesson_name", ls_lesson_name)
ids_progress_data.SetItem(ll_row, "begin_date", ldt_timestamp)
ids_progress_data.SetItem(ll_row, "end_date", ldt_timestamp)

ids_progress_report.Reset()
ll_rowcount = ids_lesson.RowCount()
ls_distraction = ""

choose case il_method_id
	case 1 // Reading
		ll_row = ii_first_QA
		do while ll_row > 0 and ll_row<= ids_lesson.RowCount() 
			ls_distraction = ""
			ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
			ls_content_name = ids_lesson.GetItemString(ll_row, "content_description") + ":" + ids_lesson.GetItemString(ll_row + 2, "content_details")			
			for ll_dist_row = ll_row + 3 to (ll_row + ii_degree + 1 ) // distraction rows
				if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
				ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row, "content_details")
			next
			ll_insert_row = ids_progress_report.InsertRow(0)
			ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
			if ls_distraction <> "" then
				ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
			end if
			ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
			ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
			ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
			ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
			ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
			ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
			ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)	
			ll_row = ll_row + (ii_degree + 2)
		loop
	case 2 // OI
		if ii_trial_target > 0 then // pair up
			ll_row = 1
			do while ll_row <= ids_lesson.RowCount()
				ls_distraction = ""
				ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
				ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
				for ll_dist_row = ll_row + 1 to (ll_row + ii_degree - 1)
					if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
					ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row, "content_details")
				next
				ll_insert_row = ids_progress_report.InsertRow(0)
				ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
				if ls_distraction <> "" then
					ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
				end if
				ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
				ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
				ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
				ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
				ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
				ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
				ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)		
				ll_row = ll_row + ii_degree
			loop
		else // sequential discrete trial
			for ll_row = 1 to ids_lesson.RowCount()
				ls_distraction = ""
				ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
				ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
				for ll_dist_row = ll_row + 1 to (ll_row + ii_degree - 1)
					if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
					if ll_dist_row > ids_lesson.RowCount() then
						ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row - ids_lesson.RowCount(), "content_description")
					else
						ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row, "content_description")
					end if
				next
				ll_insert_row = ids_progress_report.InsertRow(0)
				ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
				if ls_distraction <> "" then
					ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
				end if
				ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
				ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
				ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
				ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
				ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
				ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
				ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)						
			next
		end if
	case 14 //Counting - Number (Symbol) Match
	case 15 //Counting - Drag-drop
	case 16 //Grouping
	case 20 //Speech
	case 21, 22 //Spelling-Unscramble Word
		for ll_row = 1 to ids_lesson.RowCount()
			ls_mask =  ids_lesson.GetItemString(ll_row, "lesson_content_mask")
			if isnull(ls_mask) then ls_mask = ""
			if len(ls_mask) > 0 then
				ls_content_name = ids_lesson.GetItemString(ll_row, "content_details")
				ls_content_name = ls_content_name + ":"
				for ll_j = 1 to len(ls_mask)
					if mid(ls_mask, ll_j, 1) <> mid(ls_content_name, ll_j, 1) then
						ls_content_name = ls_content_name + mid(ls_content_name, ll_j, 1) + " "
					end if
				next
			else
				ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
			end if		
			ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
			ls_distraction =  ids_lesson.GetItemString(ll_row, "lesson_content_distraction")
			ll_insert_row = ids_progress_report.InsertRow(0)
			ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
			if isnull(ls_distraction) then ls_distraction = ""
			if ls_distraction <> "" then
				ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
			end if
			ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
			ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
			ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
			ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
			ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
			ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
			ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)						
		next
	case 22 //Sentence Composing-Unscramble Sentence
	case 23 //Addition
	case 24 //Subtraction
	case 25 //Object Matching
		if ii_trial_target > 0 then // pair up
			ll_row = 1
			do while ll_row <= ll_rowcount
				ls_distraction = ""
				ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
				ls_content_name = ids_lesson.GetItemString(ll_row, "content_description") + " : " + ids_lesson.GetItemString(ll_row + 1, "content_details")		
				for ll_dist_row = ll_row + 2 to (ll_row + ii_degree)
					if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
					ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row, "content_details")
				next
				ll_insert_row = ids_progress_report.InsertRow(0)
				ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
				if ls_distraction <> "" then
					ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
				end if
				ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
				ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
				ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
				ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
				ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
				ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
				ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)		
				ll_row = ll_row + (ii_degree + 1)
			loop
		else // sequential discrete trial
			for ll_row = 1 to ids_lesson.RowCount()
				ls_distraction = ""
				ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
				ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
				for ll_dist_row = ll_row + 1 to (ll_row + ii_degree - 1)
					if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
					if ll_dist_row > ids_lesson.RowCount() then
						ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row - ids_lesson.RowCount(), "content_details")
					else
						ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_dist_row, "content_details")
					end if
				next
				ll_insert_row = ids_progress_report.InsertRow(0)
				ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
				if ls_distraction <> "" then
					ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
				end if
				ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
				ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
				ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
				ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
				ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
				ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
				ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)						
			next
		end if
	case 27 //Speech-Read Loud
	case 28 //Speech-Verbal Labeling
	case 29 //Speech - Conversation
end choose


/*
for ll_row = 1 to ids_lesson.RowCount()
	ls_distraction = ""
	choose case il_method_id
		case 2 // OI
			if ii_trial_target > 0 then // pair up
				ll_mod = mod(ll_row, ii_degree)
				if ll_mod = 0 then ll_mod = ii_degree
				if ll_mod = ii_trial_target then
					ll_span_begin = ll_row + 1 - ii_trial_target
					ll_span_end = ll_row + 1 - ii_trial_target + (ii_degree - 1)
				else
					continue
				end if
			else
				ll_span_begin = ll_row 
				ll_span_end = ll_row + (ii_degree - 1)
			end if	
			for ll_i = ll_span_begin to ll_span_end
				if ll_i > ids_lesson.RowCount() then
					ll_row_offset = ll_i - ids_lesson.RowCount()
				else
					ll_row_offset = ll_i
				end if
				if ll_row_offset <> ll_row and ll_row_offset <> ll_span_begin then 
					if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
					ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_row_offset, "content_description")
				end if
			next			
			ls_content_name = ids_lesson.GetItemString(ll_span_begin, "content_description")	
		case 25  //OM Object Matching
			if ii_trial_target > 0 then // pair up
				ll_mod = mod(ll_row, ii_degree + 1)
				if ll_mod = 0 then ll_mod = ii_degree + 1
				if ll_mod = ii_trial_target then
					ll_span_begin = ll_row + 1 - ii_trial_target
					ll_span_end = ll_row + 1 - ii_trial_target + ii_degree
				else
					continue
				end if
			else
				ll_span_begin = ll_row 
				ll_span_end = ll_row + (ii_degree - 1)
			end if	
//			MessageBox("ll_row", ll_row)
//			MessageBox(string(ll_span_begin), ll_span_end)
			for ll_i = ll_span_begin to ll_span_end
				if ll_i > ids_lesson.RowCount() then
					ll_row_offset = ll_i - ids_lesson.RowCount()
				else
					ll_row_offset = ll_i
				end if
//			MessageBox("ll_row_offset", ll_row_offset)
				if ll_row_offset <> ll_row and ll_row_offset <> ll_span_begin then 
					if ls_distraction <> "" then ls_distraction = ls_distraction + "/"
					ls_distraction = ls_distraction + ids_lesson.GetItemString(ll_row_offset, "content_description")
//					MessageBox("ls_distraction", ls_distraction)
				end if
			next	
			ls_content_name = ids_lesson.GetItemString(ll_span_begin, "content_description") + " match " + ids_lesson.GetItemString(ll_row, "content_description")		
		case 21 // Spelling
			ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
	end choose
	ll_lesson_content_id = ids_lesson.GetItemNumber(ll_row, "lesson_content_id")
//	ls_content_name = ids_lesson.GetItemString(ll_row, "content_description")
	ll_insert_row = ids_progress_report.InsertRow(0)
	ids_progress_report.object.data[ll_insert_row] = ids_progress_data.object.data[1]
	if ls_distraction <> "" then
		ids_progress_report.SetItem(ll_insert_row, "distraction", ls_distraction)
	end if
	ids_progress_report.SetItem(ll_insert_row, "account_id", il_account_id)
	ids_progress_report.SetItem(ll_insert_row, "student_id", il_student_id)
	ids_progress_report.SetItem(ll_insert_row, "orig_acct_id", il_orig_acct_id)
	ids_progress_report.SetItem(ll_insert_row, "lesson_id", il_lesson_id)
	ids_progress_report.SetItem(ll_insert_row, "progress_data_id", al_progress_data_id)
	ids_progress_report.SetItem(ll_insert_row, "content_id", ll_lesson_content_id)
	ids_progress_report.SetItem(ll_insert_row, "content_name", ls_content_name)
next
*/
end subroutine

public function integer wf_init_parameters ();long ll_row, li_prompt_ind
string ls_resource_path, ls_remote_path, ls_coltype
string ls_lesson_name, ls_lesson_subpath, ls_index_id

ls_index_id = string(il_student_id, "0000000000")

if gn_appman.ib_online_data then
	if not isvalid(gn_appman.ids_student) then 
		gn_appman.ids_student = create nvo_datastore
		gn_appman.ids_student.dataobject = "d_student"
	end if
	if	gn_appman.il_training_account_id <> il_account_id or &
		gn_appman.il_training_student_id <> il_student_id then
		gn_appman.ids_student.Reset()
		gn_appman.ids_student.is_database_table = "Student"
		gn_appman.ids_student.is_where_col[1] = "account_id"
		gn_appman.ids_student.ia_where_value[1] = il_account_id
		gn_appman.ids_student.is_where_col[2] = "student_id"
		gn_appman.ids_student.ia_where_value[2] = il_student_id
		gn_appman.ids_student.data_restore(ls_index_id)
	end if
	if gn_appman.ids_student.RowCount() > 0 then
		if gn_appman.ids_student.GetItemNumber(1, "reward_token_num") = 0 then
			gb_money_board_on = false
		end if
	end if
	gn_appman.il_data_threshold = gn_appman.ids_student.GetItemNumber(1, "data_count_threshold")
	if not isvalid(gn_appman.ids_lesson_parm) then
		gn_appman.ids_lesson_parm = create nvo_datastore
		gn_appman.ids_lesson_parm.dataobject = "d_lesson_parm"
	end if
	ids_lesson_parm = gn_appman.ids_lesson_parm 
	ids_lesson_parm.is_database_table = "StudentLesson"
	ids_lesson_parm.is_select_sql =  "Select sl.account_id as account_id, sl.orig_acct_id as orig_acct_id, sl.student_id as student_id,sl.lesson_id as lesson_id,sl.degree as degree,sl.tries as tries,sl.prompt_inst as prompt_inst,sl.prompt_ind as prompt_ind,l.instruction_id as instruction_id," + &
												"sl.picture_ind as picture_ind,sl.text_ind as text_ind, repeat,a.site_path as site_path, l.lesson_name as lesson_name, lesson_subpath " + &
												"from StudentLesson as sl, Account as a, Lesson as l, Method as m " + &
												"where sl.orig_acct_id eq a.id and sl.lesson_id eq l.lesson_id and sl.orig_acct_id eq l.account_id and l.method_id eq m.method_id and "+ &
												"		 sl.account_id eq " + string(il_account_id) + " and "+ &
												"      sl.student_id eq " + string(il_student_id) + " and "+ &
												"      sl.lesson_id eq " + string(il_lesson_id) + " and "+ &
												"      sl.orig_acct_id eq " + string(il_orig_acct_id)
	ids_lesson_parm.is_database_table = "StudentLesson"											
	ids_lesson_parm.is_update_col[] = {"degree","tries","prompt_ind","picture_ind","text_ind"}
	ids_lesson_parm.is_key_col[] = {"account_id", "student_id", "orig_acct_id", "lesson_id"}
	ls_index_id = string(il_student_id, "0000000") + string(il_orig_acct_id, "0000000") + string(il_lesson_id, "0000000000")
	ids_lesson_parm.data_restore(ls_index_id)	
	if ids_lesson_parm.RowCount() > 0 then
		ls_lesson_name = lower(ids_lesson_parm.GetItemString(1, "lesson_name"))
		ls_lesson_subpath = lower(ids_lesson_parm.GetItemString(1, "lesson_subpath"))
		if isnull(ls_lesson_name) then ls_lesson_name = "lesson_name Is NULL"
		if isnull(ls_lesson_subpath) then ls_lesson_subpath = "Lesson_Subpath Is NULL"
		is_remote_site_path = ids_lesson_parm.GetItemString(1, "site_path") + "/Account" + string(il_orig_acct_id, "000000")
		gn_appman.is_remote_site_path = is_remote_site_path
		is_remote_lesson_path = is_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + string(il_method_id, "00") + ls_lesson_name + string(il_lesson_id, "0000000000") + ".txt"	
		gn_appman.is_dictionary_wave = is_remote_site_path + "/LH_resources/static table/wave/dictionary"
		gn_appman.is_dictionary_bitmap = is_remote_site_path + "/LH_resources/static table/bitmap/dictionary"
		choose case il_method_id
			case 14,15,16,21,22,23,24
				ids_lesson_parm.is_update_col[] = {"prompt_ind","picture_ind","text_ind"}
			case else
				ii_degree = ids_lesson_parm.GetItemNumber(1, "degree")
				ii_tries = ids_lesson_parm.GetItemNumber(1, "tries")
				ids_lesson_parm.is_update_col[] = {"degree","tries","prompt_ind","picture_ind","text_ind"}
				dw_prompt.SetItem(1, "degree", ii_degree)
				dw_prompt.SetItem(1, "tries", ii_tries)
		end choose
		li_prompt_ind = long(ids_lesson_parm.GetItemString(1, "prompt_ind"))
		dw_prompt.SetItem(1, "prompt_ind", li_prompt_ind)
		li_prompt_ind = dw_prompt.GetItemNumber(1, "prompt_ind")
		dw_prompt.SetItem(1, "picture_ind", ids_lesson_parm.GetItemString(1, "picture_ind"))
		dw_prompt.SetItem(1, "text_ind", ids_lesson_parm.GetItemString(1, "text_ind"))
		dw_prompt.ResetUpdate()
	end if
	if upperbound(gn_appman.is_response_to_right_list) = 0 or &
		gn_appman.il_training_account_id <> il_account_id or &
		gn_appman.il_training_student_id <> il_student_id then
		gn_appman.is_response_to_right_list = gn_appman.is_empty_list
		if not isvalid(gn_appman.ids_student_RTR) then
			gn_appman.ids_student_RTR = create nvo_datastore
			gn_appman.ids_student_RTR.dataobject = "d_student_rtr"
		end if
		ids_student_RTR = gn_appman.ids_student_RTR
		ids_student_RTR.is_database_table = "StudentRTR"
		ids_student_RTR.is_select_sql =  "Select srtr.orig_acct_id as orig_acct_id,rtr.response_id as response_id, rtr.wave_file as wave_file, a.site_path as site_path " + &
													"from StudentRTR As srtr, ResponseTR as rtr, Account as a " + &
													"where srtr.orig_acct_id eq rtr.account_id and " + &
													"      srtr.response_id eq rtr.response_id and "+ &
													"      srtr.orig_acct_id eq a.id and "+ &
													"      srtr.account_id eq " + string(il_account_id) + " and "+ &
													"      srtr.student_id eq " + string(il_student_id)
		ids_student_RTR.data_restore(string(il_student_id, "0000000000"))	
		for ll_row = 1 to ids_student_RTR.RowCount()
			ls_resource_path = ids_student_RTR.GetItemString(ll_row, "site_path") + "/Account" + string(ids_student_RTR.GetItemNumber(ll_row, "orig_acct_id"), "000000") + "/LH_resources/static table/wave/"
			gn_appman.is_response_to_right_list[ll_row] = ls_resource_path + "response to right/" + string(ids_student_RTR.GetItemNumber(ll_row, "response_id"), "00000000") + lower(ids_student_RTR.GetItemString(ll_row, "wave_file"))
//			MessageBox("gn_appman.is_response_to_right_list[" + string(ll_row) + "]", gn_appman.is_response_to_right_list[ll_row])
		next
//		destroy ids_student_RTR		
	end if
	if upperbound(gn_appman.is_response_to_wrong_list) = 0 or &
		gn_appman.il_training_account_id <> il_account_id or &
		gn_appman.il_training_student_id <> il_student_id then
		gn_appman.is_response_to_wrong_list = gn_appman.is_empty_list
		if not isvalid(gn_appman.ids_student_RTW) then
			gn_appman.ids_student_RTW = create nvo_datastore
			gn_appman.ids_student_RTW.dataobject = "d_student_rtw"
		end if
		ids_student_RTW = gn_appman.ids_student_RTW
		ids_student_RTW.is_database_table = "StudentRTW"
		ids_student_RTW.is_select_sql =  "Select srtw.orig_acct_id as orig_acct_id,rtw.response_id as response_id, rtw.wave_file as wave_file, a.site_path as site_path " + &
													"from StudentRTW As srtw, ResponseTW as rtw, Account as a " + &
													"where srtw.orig_acct_id eq rtw.account_id and " + &
													"      srtw.response_id eq rtw.response_id and "+ &
													"      srtw.orig_acct_id eq a.id and "+ &
													"      srtw.account_id eq " + string(il_account_id) + " and "+ &
													"      srtw.student_id eq " + string(il_student_id)
		ids_student_RTW.data_restore(string(il_student_id, "0000000000"))
		for ll_row = 1 to ids_student_RTW.RowCount()
			ls_resource_path = ids_student_RTW.GetItemString(ll_row, "site_path") + "/Account" + string(ids_student_RTW.GetItemNumber(ll_row, "orig_acct_id"), "000000") + "/LH_resources/static table/wave/"
			gn_appman.is_response_to_wrong_list[ll_row] = ls_resource_path + "response to wrong/" + string(ids_student_RTW.GetItemNumber(ll_row, "response_id"), "00000000") + lower(ids_student_RTW.GetItemString(ll_row, "wave_file"))
//			MessageBox("gn_appman.is_response_to_wrong_list[" + string(ll_row) + "]", gn_appman.is_response_to_wrong_list[ll_row])
		next
//		destroy ids_student_RTW
	end if	
	if upperbound(gn_appman.is_reward_list) = 0 or &
		gn_appman.il_training_account_id <> il_account_id or &
		gn_appman.il_training_student_id <> il_student_id then
		gn_appman.is_reward_list = gn_appman.is_empty_list
		if not isvalid(gn_appman.ids_reward) then			
			gn_appman.ids_reward = create nvo_datastore
			gn_appman.ids_reward.dataobject = "d_student_reward_source"
		end if
		gn_appman.ids_reward.Reset()
		gn_appman.ids_reward.is_database_table = "StudentReward"
		gn_appman.ids_reward.is_select_sql =  "Select media_type, rs.site_path as site_path, rs.file_name as file_name, rs.full_path as full_path," + &
													" sr.duration as duration,sr.repeat as repeat,sr.sort_order as sort_order " + &
													"from StudentReward As sr, RewardSource As rs " + &
													"where sr.orig_acct_id eq rs.account_id and " + &
													"      sr.resource_id eq rs.resource_id and "+ &
													"      sr.account_id eq " + string(il_account_id) + " and "+ &
													"      sr.student_id eq " + string(il_student_id) + " " + &
													"order by sr.sort_order "
		gn_appman.ids_reward.data_restore(string(il_student_id, "0000000000"))
//		MessageBox("gn_appman.ids_reward.is_select_sql", gn_appman.ids_reward.is_select_sql)
//		MessageBox("gn_appman.ids_reward.RowCount()", gn_appman.ids_reward.RowCount())
		for ll_row = 1 to gn_appman.ids_reward.RowCount()
			if left(gn_appman.ids_reward.GetItemString(ll_row, "media_type"), 1) = 'I'  or &
					pos(gn_appman.ids_reward.GetItemString(ll_row, "media_type"), "http:") > 0 then
				gn_appman.is_reward_list[ll_row] = gn_appman.ids_reward.GetItemString(ll_row, "full_path")
			else
				gn_appman.is_reward_list[ll_row] = gn_appman.is_app_path + "\vidoes\" + gn_appman.ids_reward.GetItemString(ll_row, "file_name")
			end if
//			MessageBox(ls_resource_path, gn_appman.ids_reward.GetItemString(ll_row, "file_name"))
		next
	end if
	return 1
else
	return 0
end if
gn_appman.il_training_account_id = il_account_id
gn_appman.il_training_student_id = il_student_id
gn_appman.il_training_method_id = il_method_id
gn_appman.il_training_lesson_id = il_lesson_id

end function

public function integer wf_load_lesson_content (string as_remote_file_path);string RemoetFileName, LocalFileName, ls_tmp_list[], ls_FileName, ls_tmp
long ll_i, ll_count, ll_method_id
any la_parm

integer li_FileNum, li_return = 10, li_char_pos, li_tab_pos, li_row, li_col_count, li_col
string ls_buffer, ls_coltype, ls_value, ls_colname
date ld_tmp
time lt_tmp

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
f_getcachelessonfile(RemoetFileName, LocalFileName)

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
		la_parm = gn_appman.ids_lesson[1]
		f_importfile_to_dd(la_parm, LocalFileName, "~t")
	end if
end if
return 1
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
long ll_count
string ls_expression, ls_filename, ls_uncompressed_file, ls_filename_con
any la_tmp, la_null

gn_appman.iw_frame.visible = true

dw_reward.visible = false

gn_appman.of_get_parm("Account ID", la_tmp)
il_account_id = la_tmp
la_tmp = la_null
gn_appman.of_get_parm("Student Id", la_tmp)
il_student_id = la_tmp
la_tmp = la_null
gn_appman.of_get_parm("Orig Account ID", la_tmp)
il_orig_acct_id = la_tmp
la_tmp = la_null
gn_appman.of_get_parm("Method ID", la_tmp)
il_method_id = la_tmp
la_tmp = la_null
gn_appman.of_get_parm("Lesson ID", la_tmp)
il_lesson_id = la_tmp

//MessageBox("il_method_id: " + string(il_method_id), il_lesson_id)

if not FileExists(is_startupfile) then
	li_num = FileOpen(is_startupfile, LineMode! , Write!)
	FileWrite(li_num, " ")
	FileClose(li_num)
end if
Randomize(0)
dw_reward.InsertRow(0)
if dw_prompt.RowCount() = 0 then
	dw_prompt.InsertRow(0)
end if
wf_init_parameters()
wf_load_lesson_content(is_remote_lesson_path)
ids_lesson = gn_appman.ids_lesson[1]
gn_appman.il_lesson_id = ids_lesson.GetItemNumber(1, "lesson_id")
ll_count = ids_lesson.RowCount()
if il_method_id = 15 or il_method_id = 16 then
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

if gb_money_board_on then
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
if this.classname() = "w_lesson_mw_cmmnd" then
	ii_trial_target = integer(ids_lesson.GetItemString(1, "lesson_pair_ind"))
	if ii_trial_target > 1 then // GROUPING
		cb_start.post event clicked()
	else
		post wf_init_lesson()
		post wf_init_container()
		if gn_appman.il_local_login_ind = 0 then // login to internet
			post wf_init_report()
		else
			post wf_init_local_report()
		end if
		post wf_set_lesson_mode(true)
		post wf_get_new_item()
	end if
else
	post wf_init_lesson()
	post wf_init_container()
	if gn_appman.il_local_login_ind = 0 then // login to internet
		post wf_init_report()
	else
		post wf_init_local_report()
	end if
	post wf_set_lesson_mode(true)
	post wf_get_new_item()
end if
this.Windowstate = maximized!


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
long ll_handle, ll_status
string ls_progress_data_file, ls_progress_report_file
lw_window = this

long ll_method_id, ll_i
any la_parm

if gn_appman.is_commandline = "STUDENT" then
	gn_appman.iw_frame.visible = false
end if

if gn_appman.il_local_login_ind = 0 then // login to internet
	if gn_appman.ib_lesson_training_only then
		ids_progress_data.Save()
		ids_progress_report.Save()
	end if
	if gn_appman.ib_show_report then
		OpenWithParm(w_progress_report, ids_progress_report)
	end if
	if dw_prompt.ModifiedCount() > 0 then
		if MessageBox("Warning", "You Have Changed The Lesson Parameters, Do You Want To Save The Change?", Information!, YesNo!) = 1 then
			choose case il_method_id
				case 14,15,16,21,22,23,24
				case else
					ids_lesson_parm.SetItem(1, "degree", dw_prompt.GetItemNumber(1, "degree"))
					ids_lesson_parm.SetItem(1, "tries", dw_prompt.GetItemNumber(1, "tries"))
			end choose
			ids_lesson_parm.SetItem(1, "prompt_ind", string(dw_prompt.GetItemNumber(1, "prompt_ind")))
			MessageBox("prompt_ind", dw_prompt.GetItemNumber(1, "prompt_ind"))
			ids_lesson_parm.SetItem(1, "picture_ind", dw_prompt.GetItemString(1, "picture_ind"))
			ids_lesson_parm.SetItem(1, "text_ind", dw_prompt.GetItemString(1, "text_ind"))
			ids_lesson_parm.Save()	
		end if
	end if
else
	CreateDirectory("reports")
	ids_progress_data.Save()
	ids_progress_report.Save()
	ls_progress_data_file = "reports\" + gn_appman.is_user_name + "_progress_data.csv"
	ids_progress_data.SaveAs(ls_progress_data_file, CSV!, false)
	ls_progress_report_file = "reports\" + gn_appman.is_user_name + "_progress_report" + string(il_student_id, "000") + string(il_lesson_id, "000000") + string(il_progress_data_id, "000") + ".csv"
	ids_progress_report.SaveAs(ls_progress_report_file, CSV!, false)
//	MessageBox(ls_progress_data_file, ids_progress_data.RowCount())
//	MessageBox(ls_progress_report_file, ids_progress_report.RowCount())
	OpenWithParm(w_progress_report, ids_progress_report)	
end if
	
if isvalid(ids_lesson) then destroy ids_lesson
if isvalid(ids_lesson_container) then destroy ids_lesson_container
if isvalid(ids_student_RTW) then destroy ids_student_RTW
if isvalid(ids_student_RTR) then destroy ids_student_RTR
if isvalid(ids_lesson_parm) then destroy ids_lesson_parm

for ll_i = 1 to upperbound(iw_dest)
	if isvalid(iw_dest[ll_i]) then destroy iw_dest[ll_i]
next
for ll_i = 1 to upperbound(iw_source)
	if isvalid(iw_source[ll_i]) then destroy iw_source[ll_i]
next
//gn_appman.of_get_parm("Method ID", la_parm)
//ll_method_id = la_parm

//SetProfileString(is_startupfile, "prompt", "method_" + string(ll_method_id), string(ii_prompt_ind))
//SetProfileString(is_startupfile, "degree", "method_" + string(ll_method_id), string(ii_degree))
//SetProfileString(is_startupfile, "picture_ind", "method_" + string(ll_method_id), string(is_picture_ind))
//SetProfileString(is_startupfile, "text_ind", "method_" + string(ll_method_id), string(is_text_ind))
gb_lesson_is_playing = false
if isvalid(gw_money_board) then
	gw_money_board.visible = false
end if

if isvalid(gn_appman.iw_student_login) then
	Send(handle(gn_appman.iw_student_login), 1024, 0, 0)
end if
end event

event activate;this.Windowstate = maximized!
end event

type dw_reward from datawindow within w_lesson
boolean visible = false
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
boolean visible = false
integer x = 9
integer width = 2720
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

