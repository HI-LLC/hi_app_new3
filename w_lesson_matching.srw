$PBExportHeader$w_lesson_matching.srw
forward
global type w_lesson_matching from w_lesson
end type
end forward

shared variables

end variables

global type w_lesson_matching from w_lesson
string tag = "1502000"
string title = "Lesson - Matching"
end type
global w_lesson_matching w_lesson_matching

type variables
long il_orig_color, li_drag_pic_height = 0, li_drag_pic_width = 0
integer ii_current_state = 0
constant integer ici_init_state = 0
constant integer ici_query_state = 1
constant integer ici_answer_expecting_state = 2
constant integer ici_lesson_end_state = 3
boolean ib_session_done = true

end variables

forward prototypes
public subroutine wf_container_clicked (integer ai_id)
public subroutine wf_question_announcer ()
public subroutine wf_reset_select ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_response ()
public subroutine wf_get_new_item ()
public subroutine wf_init_container ()
end prototypes

public subroutine wf_container_clicked (integer ai_id);ii_current_answer_id = ii_item_presented[ai_id]
str_msg msg
long ll_hwn, li_i
wf_response()
for li_i = 1 to upperbound(iw_source)
	ll_hwn = handle(iw_source[li_i])
	do while remove_message(msg, ll_hwn, 513, 513) > 0 
	loop
next
end subroutine

public subroutine wf_question_announcer ();if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if

ii_current_state = ici_answer_expecting_state  
post timer(10, this)

end subroutine

public subroutine wf_reset_select ();long ll_x, ll_y
real lr_x_ratio, lr_y_ratio
environment env
GetEnvironment (env)

lr_x_ratio = 65535/env.ScreenWidth
lr_y_ratio = 65535/env.ScreenHeight

p_1.x = (this.width - p_1.width)/2
p_1.y = p_1.height/2 + 50
ll_x = p_1.x + p_1.width/2 + WorkspaceX()
ll_y = p_1.y + p_1.height/2 + WorkspaceY()
//MessageBox(string(ll_x), string(ll_y))
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
//mouse_event(dwFlags, ll_x, ll_y, 0, 0)
//MessageBox(string(ll_x), string(ll_y))
mouse_event(32769, ll_x*lr_x_ratio, ll_y*lr_y_ratio, 0, 0)




end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);super::wf_set_lesson_mode(ab_lesson_on)
if ab_lesson_on then 
	dw_prompt.visible = false
else
	if dw_prompt.RowCount() > 0 then
		dw_prompt.visible = true
	end if	
	integer li_row
	for li_row = 1 to ii_degree
		iw_source[li_row].event close()
	next 
end if
end subroutine

public subroutine wf_response ();integer li_row, li_i, li_correct_row
long ll_orig_color, ll_hwn, ll_i
ii_current_try++
SetPointer(HourGlass!)
if ii_current_answer_id = ii_current_question_id then
	il_total_correct_answers[ii_current_answer_id] = il_total_correct_answers[ii_current_answer_id] + 1
	if pos(is_response_to_right, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_right)
	else
		wf_play_video(is_response_to_right)
	end if
	if isvalid(gw_money_board) then
		gw_money_board.wf_add_credit()
	end if
	wf_get_new_item()	
elseif ii_current_try >= ii_tries then
	if ii_prompt_ind = 2 then // Error Correction
		for li_row = 1 to ii_degree
			if ii_item_presented[li_row] = ii_current_question_id then
				li_correct_row = li_row			
			end if
		next
		ll_orig_color = iw_source[li_correct_row].BackColor
		if isvalid(iw_source[li_correct_row]) then 
			timer(0.25, iw_source[li_correct_row])
		end if
		for ll_i = 1 to 1000 
			if ib_session_done then return
			yield()
			sleeping(1)
		next
//		MessageBox("Info", "Continue...")
		timer(0, iw_source[li_correct_row])
		iw_source[li_correct_row].BackColor = ll_orig_color
		wf_get_new_item()
	elseif ii_prompt_ind = 1 and not ib_done_prompt then
		ib_done_prompt = true
		string ls_bean
		w_container_discrete_trial lw_tmp
		for li_row = 1 to ii_degree
			iw_source[li_row].visible = false
		next
		for li_row = 1 to ii_degree
			if ii_item_presented[li_row] = ii_current_question_id then
				li_correct_row = li_row			
			end if
		next
		ll_orig_color = iw_source[li_correct_row].BackColor
		timer(0.25, iw_source[li_correct_row])
		for li_row = 1 to ii_degree
			lw_tmp = iw_source[li_row]	
			lw_tmp.visible = true
			lw_tmp.pb_1.BringToTop = true
		next
		
		wf_question_announcer()
		str_msg msg
		for li_i = 1 to upperbound(iw_source)
			ll_hwn = handle(iw_source[li_i])
			do while remove_message(msg, ll_hwn, 513, 513) > 0 
			loop
		next	
	else
		wf_get_new_item()
	end if	
else
	if pos(is_response_to_wrong, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_wrong)
	else
		wf_play_video(is_response_to_wrong)
	end if
end if		

end subroutine

public subroutine wf_get_new_item ();integer il_row, li_random_num, li_correct_row, li_delayed_time = 0
long ll_x, ll_y, ll_i
integer li_dummy[]
string ls_selected_item
w_container_discrete_trial lw_tmp
li_dummy = {0, 13}	
ib_session_done = false
ib_done_prompt = false
ib_drag = false
p_1.visible = false
//MessageBox("ii_current_question_id", ii_current_question_id)
// set current question_id
if ii_trial_target > 0 then // pair up
	ii_current_question_id = ii_current_list_offset + ii_trial_target
else
	ii_current_question_id++
end if
ii_current_state =  ici_answer_expecting_state
ii_current_try = 0
il_total_tries[ii_current_question_id]++
if (ii_trial_target = 0 and ii_current_question_id > ii_total_items) or &
	(ii_current_list_offset + ii_degree > ii_total_items) then
	for il_row = 1 to ii_degree
//		iw_source[il_row].ib_to_stop_movie = true
		lw_tmp = iw_source[il_row]	
		if not lw_tmp.ib_stopped then
			lw_tmp.ib_stopped = true
			iw_source[il_row].ib_to_stop_movie = true
			if isvalid(lw_tmp.ole_1) then lw_tmp.ole_1.object.Stop()
		end if
		lw_tmp.visible = false
	next 	
	ib_session_done = true
	ii_current_state =  ici_lesson_end_state
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	post wf_set_lesson_mode(false)
//	wf_update_statistic()	
//	wf_check_batch()
	return
end if

wf_random_list()
string ls_bean
for il_row = 1 to ii_degree
	iw_source[il_row].BackColor = il_orig_color
	timer(0, iw_source[il_row])
	iw_source[il_row].visible = false
	if ii_trial_target > 0 then // pair up
		ii_item_presented[il_row] = ii_random_list[il_row] + ii_current_list_offset + 1
	else
		ii_item_presented[il_row] = mod(ii_random_list[il_row] + ii_current_question_id - 1, ii_total_items)
	end if
	if ii_item_presented[il_row] = 0 then
		ii_item_presented[il_row] = ii_total_items
	end if
	ls_bean = lower(is_picture_list[ii_item_presented[il_row]])
	lw_tmp = iw_source[il_row]
	if is_text_ind = "1" then
		lw_tmp.pb_1.Text = is_text_list[ii_item_presented[il_row]]
	end if
	if pos(ls_bean, ".bmp") > 0 or pos(ls_bean, ".jpg") > 0 or pos(ls_bean, ".gif") > 0 or pos(ls_bean, ".wmf") > 0 then
		lw_tmp.width = lw_tmp.ii_width
		lw_tmp.height = lw_tmp.ii_height
		if is_text_ind = "1" then
			lw_tmp.pb_1.Text = is_text_list[ii_item_presented[il_row]]	
		end if
		if is_picture_ind = "1" then
			lw_tmp.pb_1.PictureName = is_picture_list[ii_item_presented[il_row]]
		end if
		lw_tmp.pb_1.BringToTop = true
		lw_tmp.pb_1.visible = true
		if isvalid(lw_tmp.ole_1) then lw_tmp.ole_1.visible = false
		lw_tmp.visible = true
	elseif pos(ls_bean, ".avi") > 0 or pos(ls_bean, ".mpg") > 0 or pos(ls_bean, ".mov") > 0 then
		lw_tmp.ib_to_stop_movie =  false
		if isvalid(lw_tmp.ole_1) then
			lw_tmp.ole_1.BringToTop = true
			lw_tmp.ole_1.visible = true
			lw_tmp.ole_1.object.FileName = is_picture_list[ii_item_presented[il_row]]		
		end if
		lw_tmp.pb_1.visible = false		
	end if
next
//if ii_prompt_ind = 1 then // prompt
//	for il_row = 1 to ii_degree
//		if ii_item_presented[il_row] = ii_current_question_id then
//			li_correct_row = il_row			
//		end if
//	next
//	lw_tmp = iw_source[li_correct_row]
//	lw_tmp.visible = true
//	lw_tmp.pb_1.PictureName = is_picture_list[ii_current_question_id]
//	if pos(is_prompt_instruction, ".wav") > 0 then
//		inv_sound_play.play_st_sound(is_prompt_instruction)
//	else
//		wf_play_video(is_prompt_instruction)
//	end if
//	MessageBox("Info", "Continue..")
//end if
for il_row = 1 to ii_degree
	lw_tmp = iw_source[il_row]	
	lw_tmp.visible = true
	lw_tmp.pb_1.BringToTop = true
next

wf_question_announcer()
str_msg msg
long ll_hwn, li_i, li_msg_count = 0

for li_i = 1 to upperbound(iw_source)
	ll_hwn = handle(iw_source[li_i])
	do while remove_message(msg, ll_hwn, 513, 513) > 0 
	loop
next

for il_row = 1 to ii_degree
	if ii_item_presented[il_row] = ii_current_question_id then
		li_correct_row = il_row			
	end if
next
ib_drag = true
if ii_trial_target > 0 then // pair up
	p_1.PictureName = is_picture_list[ii_current_list_offset + 1]
else
	p_1.PictureName = is_picture_list[ii_current_question_id]
end if
p_1.visible = true
wf_reset_select()
if ii_trial_target > 0 then
	ii_current_list_offset = ii_current_list_offset + ii_degree + 1
end if

end subroutine

public subroutine wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
string ls_bean
integer li_layout_row, li_layout_col, li_layout_rowcount, li_layout_colcount
integer li_height_interval, li_width_interval, li_remain, li_valid_height, li_width, li_height
double ldb_layout_test
integer li_row, li_source_row = 0, li_count
long ll_interval, ll_len
w_container_discrete_trial lw_container
ll_interval = this.width/(ii_degree*2)
//container layout
li_valid_height = this.height - cb_start.height - cb_start.y
ldb_layout_test = ii_degree
ldb_layout_test = sqrt(ldb_layout_test) 
li_layout_rowcount = integer(truncate(ldb_layout_test, 0))

if ldb_layout_test > truncate(ldb_layout_test, 0) then
	li_layout_colcount = integer(truncate(ldb_layout_test, 0)) + 1
	if li_layout_colcount*li_layout_rowcount < ii_degree then 
		li_layout_rowcount++
	end if
else
	li_layout_colcount = integer(truncate(ldb_layout_test, 0))
end if
li_remain = (li_layout_rowcount*li_layout_colcount) - ii_degree
//estimate width and height
// set the width and height based on width
li_width_interval = this.width/(li_layout_colcount*4 + 1)
li_width = li_width_interval*3
li_height = (li_width*5)/8
if li_height > (li_valid_height/li_layout_rowcount) then // set the width and height based on height
	li_height_interval = li_valid_height/(li_layout_rowcount*6 + 1)
	li_height = li_height_interval*5
	li_width = (li_height*8)/5
	li_width_interval = (this.width - (li_width*li_layout_colcount))/(li_layout_colcount + 1)
else
	li_height_interval = (li_valid_height - (li_height*li_layout_rowcount))/(li_layout_rowcount + 1)
end if
li_layout_row = 0
for li_source_row = 1 to ii_degree
	open(iw_source[li_source_row], 'w_container_discrete_trial', this)
	lw_container = iw_source[li_source_row]
	if mod(li_source_row, li_layout_colcount) = 1 then li_layout_row++
	if mod(li_source_row, li_layout_colcount) = 0 then
		li_layout_col = li_layout_colcount
	else
		li_layout_col = mod(li_source_row, li_layout_colcount)
	end if
	lw_container.ii_id = li_source_row
	lw_container.hide()
	lw_container.x = this.x + (li_source_row - 1)*2*ll_interval + ll_interval - iw_source[li_source_row].width/2
	lw_container.y = (this.height - iw_source[li_source_row].height)/2
	lw_container.show()
	lw_container.hide()
	lw_container.ii_id = li_source_row
	lw_container.width = li_width
	lw_container.height = li_height
	lw_container.ii_width = li_width
	lw_container.ii_height = li_height
	lw_container.p_1.width = li_width - 35
	lw_container.p_1.height = li_height - 35
	lw_container.pb_1.width = li_width - 35
	lw_container.pb_1.height = li_height - 35
	if isvalid(lw_container.ole_1) then
		lw_container.ole_1.width = li_width - 35
		lw_container.ole_1.height = li_height - 35
	end if
	lw_container.y = cb_start.height + cb_start.y + li_height_interval*li_layout_row + &
		(li_layout_row - 1)*li_height
	if li_layout_row = li_layout_rowcount then	
		li_width_interval = (this.width - (li_layout_colcount - li_remain)*li_width)/(li_layout_colcount - li_remain + 1)
	end if
	lw_container.x = li_width_interval*li_layout_col + (li_layout_col - 1)*li_width
	lw_container.show()
next 

il_orig_color = iw_source[1].BackColor
ii_current_state = ici_init_state 
ii_current_list_offset = 0
ib_drag = false
if li_drag_pic_height = 0 then
	li_drag_pic_height = p_1.height
end if
if li_drag_pic_width = 0 then
	li_drag_pic_width = p_1.width
end if

p_1.width = li_drag_pic_width*7/4
p_1.height = li_drag_pic_height*7/4

end subroutine

on w_lesson_matching.create
call super::create
end on

on w_lesson_matching.destroy
call super::destroy
end on

event key;integer il_row
long ll_count
string ls_comment_type, ls_win_title

w_container_discrete_trial lw_tmp
if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
		for il_row = 1 to ii_degree
			lw_tmp = iw_source[il_row]	
			if not lw_tmp.ib_stopped then
				lw_tmp.ib_stopped = true
				lw_tmp.ib_to_stop_movie = true
				lw_tmp.ole_1.object.Stop()
			end if
		next 		
		enable_ctrl_alt_del()
		wf_set_lesson_mode(false)
	end if
end if

end event

event timer;call super::timer;string ls_wave_file
string ls_1st_letter, ls_word, ls_dict_sound_file

if ii_current_state = ici_answer_expecting_state then
	ls_word = is_text_list[ii_current_question_id]
	ls_1st_letter = upper(left(ls_word, 1))
	ls_wave_file = is_wave_list[ii_current_question_id]	
	if isnull(ls_wave_file) then
		MessageBox("Error", "Sound file is selected.")
		return
	end if
	if pos(ls_wave_file, ".wav") > 0 then
//		MessageBox("ls_wave_file", ls_wave_file)
		if FileExists(ls_wave_file) then
			sndPlaySoundA(ls_wave_file, 1)
		else
			MessageBox("Error", "Sound file - " + ls_wave_file + " does not exist!")
		end if
	elseif pos(is_wave_list[ii_current_question_id], "DICTIONARY") > 0 then
		ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
		if FileExists(ls_dict_sound_file) then
			sndPlaySoundA(ls_dict_sound_file, 1)
		else
			MessageBox("Error", "Sound file - " + ls_dict_sound_file + " does not exist!")
		end if
	end if			
end if
//timer(10)


end event

event mousemove;call super::mousemove;if ib_drag then
	p_1.x = xpos - p_1.width/2
	p_1.y = ypos - p_1.height/2
end if
end event

type dw_reward from w_lesson`dw_reward within w_lesson_matching
end type

type cb_close from w_lesson`cb_close within w_lesson_matching
string tag = "1502040"
end type

type cb_start from w_lesson`cb_start within w_lesson_matching
string tag = "1502030"
end type

type dw_2 from w_lesson`dw_2 within w_lesson_matching
string tag = "1502020"
string title = ""
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id, ll_row
ll_lesson_id = long(data)

//wf_update_statistic()
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if

for ll_row = 1 to ids_lesson.rowcount()
	il_total_tries[ll_row] = 0
	il_total_correct_answers[ll_row] = 0
next


end event

type p_1 from w_lesson`p_1 within w_lesson_matching
end type

type st_1 from w_lesson`st_1 within w_lesson_matching
end type

type dw_1 from w_lesson`dw_1 within w_lesson_matching
string tag = "1502000"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id >= 25 and method_id <= 25')
end if
end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_matching
integer width = 2487
end type

