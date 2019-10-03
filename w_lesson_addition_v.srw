$PBExportHeader$w_lesson_addition.srw
forward
global type w_lesson_addition from w_lesson
end type
type st_2 from statictext within w_lesson_addition
end type
type st_3 from statictext within w_lesson_addition
end type
type st_4 from statictext within w_lesson_addition
end type
type st_5 from statictext within w_lesson_addition
end type
end forward

global type w_lesson_addition from w_lesson
string tag = "1505000"
string title = "Lesson - Addition"
event paint pbm_paint
event ue_agent_ready pbm_custom01
event syskeydown pbm_syskeydown
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
end type
global w_lesson_addition w_lesson_addition

type variables
integer ii_bean_drop_style
boolean ib_alternation_switch = false, ib_file_loaded = false
long il_handle, il_asciisize, il_binsize
ulong il_thread
string is_bitmap, is_data, is_empty

end variables

forward prototypes
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_set_flash_for_prompt ()
public subroutine wf_load_graph (string as_filename)
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_get_new_item ()
public function integer wf_init_container ()
public subroutine wf_question_announcer ()
public function boolean wf_check_number (integer ai_count)
public subroutine wf_response (boolean ab_correct)
end prototypes

event paint;//long ll_i
//do while PostThreadMessageExt(il_thread,273,32778,0) = 0 and ll_i < 100
//	sleeping(10)
//	ll_i++
//loop

end event

event ue_agent_ready;//if wparam = 0 then
//	il_handle = lparam
//	MessageBox("ue_agent_ready: il_handle", string(il_handle))
//else
//	il_thread = lparam
//	MessageBox("ue_agent_ready: il_thread", string(il_thread))
//end if
//MessageBox("ue_agent_ready: il_thread", string(il_thread))

end event

event syskeydown;integer li_row
long ll_count
string ls_comment_type, ls_win_title
if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
		enable_ctrl_alt_del()
		wf_set_lesson_mode(false)
	end if
end if
if KeyDown(KeyControl!) and KeyDown(KeyZ!) then
	select count(progress_data_id) into :ll_count
	from progress_data
	where lesson_id = :il_lesson_id;
	if ll_count = 0 then
		MessageBox('Error', 'No report is created for this lesson cannot add comment!')
		return
	end if
	select max(progress_data_id) into :il_progress_data_id
	from progress_data
	where lesson_id = :il_lesson_id;
	ls_win_title = "Report Comment Maintenance"
	ls_comment_type = "PROGRESS REPORT"
	gn_appman.of_set_parm("Win Title", ls_win_title)
	gn_appman.of_set_parm("Comment Type",  ls_comment_type)
	gn_appman.of_set_parm("Table Key ID",  il_progress_data_id)
	gn_appman.of_set_parm("Second Key ID",  il_lesson_id)
	Open(w_comment_update)
end if

end event

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	st_1.x = xpos
	st_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public subroutine wf_set_flash_for_prompt ();integer li_i
w_container_number_match lw_tmp
if ii_prompt_ind < 3 then return
lw_tmp = iw_dest[1]
for li_i = 1 to upperbound(lw_tmp.ioval)
	if integer(st_3.text) + integer(st_5.text) = integer(lw_tmp.ioval[li_i].st_number.text) then
		lw_tmp.iuo_count = lw_tmp.ioval[li_i]
		lw_tmp.ii_flash_index_begin = li_i
		lw_tmp.ii_flash_index_end = li_i		
		timer(0.25, lw_tmp)
		return
	end if
next

end subroutine

public subroutine wf_load_graph (string as_filename);//long ll_handle
//ll_handle = handle(this)
//StartThread(ll_handle, as_filename, il_thread)
//ib_file_loaded = true
end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);super::wf_set_lesson_mode(ab_lesson_on)
integer li_row
	p_1.visible = false

if ab_lesson_on then 
	st_1.visible = true
	st_2.visible = true
	st_3.visible = true
	st_4.visible = true
	st_5.visible = true	
else
	st_1.visible = false
	st_2.visible = false
	st_3.visible = false
	st_4.visible = false
	st_5.visible = false
	for li_row = 1 to upperbound(iw_source)
		if isvalid(iw_source[li_row]) then
//			iw_source[li_row].post event close()
			destroy iw_source[li_row]
		end if
	next 
	for li_row = 1 to upperbound(iw_dest)
		if isvalid(iw_dest[li_row]) then		
//			iw_dest[li_row].post event close()
			destroy iw_dest[li_row]
		end if
	next 
end if

end subroutine

public subroutine wf_get_new_item ();integer li_row
long ll_x, ll_y, ll_i, ll_j, ll_item, ll_hwn
integer li_dummy[], li_i
string ls_selected_item
w_lesson_addition lw_dummy
uo_count_number iuo_tmp
li_dummy = {0, 13}	

if isvalid(gw_money_board) then
	gw_money_board.BringToTop = true
end if
ii_current_state =  ici_answer_expecting_state
ii_current_try = 0
if ii_trial_target > 0 then // pair up
	ii_current_question_id = ii_current_list_offset + ii_trial_target - 1
else
	ii_current_question_id++
end if
il_total_tries[ii_current_question_id]++
if ii_current_question_id > ii_total_items then
	if gnvo_is.ib_demo_is_going then
		if gnvo_is.iw_demo_selection.classname() = "w_demo_selection" then
			ll_x = cb_close.x + cb_close.width/2 + WorkspaceX()
			ll_y = cb_close.y + cb_close.height/2 + WorkSpaceY()
			ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
			ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
			gnvo_is.of_reset_parms()
			gnvo_is.of_set_parms(0, 0, 0,  0, 10, 50, false, false, false, false, false, false, false, false, "", 1.0, 'Enter', true, li_dummy,0,0)
			gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To Close Button', false, li_dummy,0,0)
			gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, "Click Close Button", false, li_dummy,handle(gnvo_is.iw_status),1024)
			gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, '', false, li_dummy,handle(gnvo_is.iw_status),1027) 
			gnvo_is.ib_demo_selection_on = true
			gnvo_is.of_set_index(1)
			gnvo_is.start(2)
		else
			gnvo_is.of_reset_parms()
			gnvo_is.of_set_parms(0, 0, 0,  0, 10, 50, false, false, false, false, false, false, false, false, "", 1.0, 'Enter', true, li_dummy,0,0)
			gnvo_is.of_set_index(1)
			gnvo_is.start(2)					
		end if
	elseif isvalid(gnvo_is.iw_demo_selection) then
		if gnvo_is.iw_demo_selection.classname() = "w_demo_trial_selection" then
			gnvo_is.of_reset_parms()
			gnvo_is.of_set_parms(0, 0, 0,  0, 10, 50, false, false, false, false, false, false, false, false, "", 1.0, 'Enter', true, li_dummy,0,0)
			gnvo_is.of_set_index(1)
			gnvo_is.start(2)		
		end if
	end if
	ii_current_state =  ici_lesson_end_state
	timer(0.5, this)
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	wf_update_statistic()
	post wf_set_lesson_mode(false) // close container window
	wf_check_batch()
	return
end if
SetRedraw(false)
integer li_count
statictext lst[2]
lst = {st_3,st_5}
for ll_i = 1 to 2	
	ll_item = ll_i + ii_current_question_id - 1
	if ll_item > ii_total_items then ll_item = 1
	li_count = ii_number_list[ll_item]
	lst[ll_i].text = string(li_count)
	iw_source[ll_i].is_bean_PictureName = is_picture_list[ll_item]
	iw_source[ll_i].wf_set_count(li_count, 1, 0)
	for ll_j = 1 to upperbound(iw_source[ll_i].ioval)
		iw_source[ll_i].ioval[ll_j].p_1.visible = false
		iw_source[ll_i].ioval[ll_j].p_1.BringToTop = false
		iw_source[ll_i].ioval[ll_j].BringToTop = true
		iw_source[ll_i].ioval[ll_j].backcolor = f_getcolor(4)
	next	
	if ii_prompt_ind > 0 then	iw_source[ll_i].Show()
next
if integer(st_3.text) = integer(st_5.text) and integer(st_5.text) = 1 then
	iw_source[1].wf_reset_count_size(iw_source[1].ioval[1].width/2, iw_source[1].ioval[1].height/2) 
	iw_source[2].wf_reset_count_size(iw_source[2].ioval[1].width/2, iw_source[2].ioval[1].height/2)
elseif integer(st_3.text) >=  integer(st_5.text) then // left addant is bigger then right addant
	iw_source[2].wf_reset_count_size(iw_source[1].ioval[1].width, iw_source[1].ioval[1].height) 
else
	iw_source[1].wf_reset_count_size(iw_source[2].ioval[1].width, iw_source[2].ioval[1].height) 
end if

w_container_number_match lw_tmp
lw_tmp = iw_source[3]
iw_source[3].Show()
lw_tmp.st_1.text = '?'		
SetRedraw(true)
//MessageBox('wf_get_new_item', 'C')
wf_question_announcer()
if ii_trial_target > 0 then
	ii_current_list_offset = ii_current_list_offset + ii_degree
end if
w_container_dragdrop lw_tmp2
string ls_number_wave
if ii_prompt_ind > 1 then // hint or prompt
	if integer(st_3.text) >=  integer(st_5.text) then // left addant is bigger then right addant
		for ll_i = 1 to integer(st_3.text)
			iw_source[1].ioval[ll_i].backcolor = f_getcolor(6)
		next
		ls_number_wave = st_3.text + ".wav"
		inv_sound_play.play_number_sound(ls_number_wave)
		for ll_i = 1 to integer(st_5.text)
			iw_source[2].ioval[ll_i].backcolor = f_getcolor(6)
			ls_number_wave = string(integer(st_3.text) + ll_i) + ".wav"
			inv_sound_play.play_number_sound(ls_number_wave)
		next
	else
		for ll_i = 1 to integer(st_5.text)
			iw_source[2].ioval[ll_i].backcolor = f_getcolor(6)
		next
		ls_number_wave = st_5.text + ".wav"
		inv_sound_play.play_number_sound(ls_number_wave)
		for ll_i = 1 to integer(st_3.text)
			iw_source[1].ioval[ll_i].backcolor = f_getcolor(6)
			ls_number_wave = string(integer(st_5.text) + ll_i) + ".wav"
			inv_sound_play.play_number_sound(ls_number_wave)
		next
	end if
end if
if ii_prompt_ind = 3 then // prompt
	wf_set_flash_for_prompt()
end if
if gnvo_is.ib_demo_is_going then
	for ll_i = 1 to upperbound(iw_dest[1].ioval)
		iuo_tmp = iw_dest[1].ioval[ll_i]
		if integer(iuo_tmp.st_number.text) = integer(st_5.text) + integer(st_3.text) then exit 
	next
	li_dummy = {0, 13}	
	gnvo_is.of_reset_parms()
	ll_x = iw_dest[1].x + iw_dest[1].ioval[ll_i].x + iw_dest[1].ioval[ll_i].width/2 + WorkspaceX()
	ll_y = iw_dest[1].y + iw_dest[1].ioval[ll_i].y + iw_dest[1].ioval[ll_i].height/2 + WorkSpaceY()
	ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
	ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
	ls_selected_item = 'Move Mouse Pointer To Number "' + iuo_tmp.st_number.text + '"'
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 20, true, false, false, false, false, false, true, false, "", 1.0, ls_selected_item, false, li_dummy,0,0)
	ls_selected_item = 'Drag Number "' + iuo_tmp.st_number.text + '"'
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, false, false, false, false, false, "", 2.0, ls_selected_item, false, li_dummy,0,0)
	ll_x = iw_source[3].x + iw_source[3].width/2 + WorkspaceX()
	ll_y = iw_source[3].y + iw_source[3].height/2 + WorkSpaceY()
	ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
	ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
	ls_selected_item = 'Drop Number "' + iuo_tmp.st_number.text + '"'
	gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, ls_selected_item, false, li_dummy,0,0)
	gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, false, true, false, false, false, false, "", 2.0, "", false, li_dummy,0,0)
	gnvo_is.of_set_index(1)
	gnvo_is.start(3)
elseif isvalid(gnvo_is.iw_demo_selection) then
	if gnvo_is.iw_demo_selection.classname() = "w_demo_trial_selection" then
		gnvo_is.of_reset_parms()
		gnvo_is.of_set_parms(0, 0, 0,  0, 10, 50, false, false, false, false, false, false, false, false, "", 1.0, 'Enter', true, li_dummy,0,0)
		gnvo_is.of_set_index(1)
		gnvo_is.start(2)		
	end if
end if

str_msg msg
for li_i = 1 to upperbound(iw_source)
	ll_hwn = handle(iw_source[li_i])
	do while remove_message(msg, ll_hwn, 0, 0) > 0 
	loop
next
for li_i = 1 to upperbound(iw_dest)
	ll_hwn = handle(iw_dest[li_i])
	do while remove_message(msg, ll_hwn, 0, 0) > 0 
	loop
next
ll_hwn = handle(this)
do while remove_message(msg, ll_hwn, 	0, 0) > 0 
loop
lw_dummy = this
lw_dummy.post SetFocus()
end subroutine

public function integer wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
integer li_row, li_source_row = 0, li_dest_row = 0, li_x_interval, li_y_interval, li_i

long ll_interval, ll_len
li_x_interval = width/7
li_y_interval = height/25
st_3.x = li_x_interval + st_3.width/2
st_4.x = li_x_interval*2 + st_3.width/2
st_5.x = li_x_interval*3 + st_3.width/2
st_2.x = li_x_interval*4 + st_3.width/2
st_3.y = li_y_interval
st_4.y = li_y_interval
st_5.y = li_y_interval
st_2.y = li_y_interval

if upperbound(ii_number_list) < 2 then
	MessageBox("Error", "Not Enough Number of Lesson Contents Existing For The Lesson")
	return -1
end if

open(iw_source[1], 'w_container_dragdrop', this)
iw_source[1].p_1.visible = false
ii_selected_source = 1
iw_source[1].x = st_3.x
iw_source[1].y = st_3.y + st_3.height + 100
iw_source[1].width = st_3.width + 200
iw_source[1].height = st_3.height + 200
//iw_source[1].Show()

open(iw_source[2], 'w_container_dragdrop', this)
iw_source[2].p_1.visible = false
ii_selected_source = 1
iw_source[2].x = st_5.x
iw_source[2].y = st_5.y + st_5.height + 100
iw_source[2].width = st_5.width + 200
iw_source[2].height = st_5.height + 200
//iw_source[2].p_1.visible = false
//iw_source[2].Show()

open(iw_source[3], 'w_container_number_match', this)				
iw_source[3].ib_target = true
iw_source[3].width = 420
iw_source[3].height = 390
iw_source[3].x = li_x_interval*5 + st_3.width/2
iw_source[3].y = li_y_interval
w_container_number_match lw_tmp
lw_tmp = iw_source[3]
lw_tmp.st_1.text = '?'		
lw_tmp.st_1.visible = true
lw_tmp.st_1.BringToTop = true
lw_tmp.p_1.visible = false

// make answer list
for li_i = 1 to upperbound(ii_number_list)
	if li_i < upperbound(ii_number_list) then
		ii_answer_list[li_i] = ii_number_list[li_i + 1] + ii_number_list[li_i]
	else
		ii_answer_list[li_i] = ii_number_list[li_i] + ii_number_list[1]
	end if
next
wf_sort_list(ii_answer_list)
open(iw_dest[1], 'w_container_number_match', this)
//iw_dest[1].p_1.picturename = "color_grey.bmp"
iw_dest[1].x = (this.width - iw_dest[1].width)/2
iw_dest[1].y = li_y_interval*14
//iw_dest[1].Show()
iw_dest[1].wf_draw_number(ii_answer_list, 1, 0)
iw_dest[1].Show()

ii_current_state = ici_init_state 
return 1
end function

public subroutine wf_question_announcer ();ii_current_state = ici_answer_expecting_state 

if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if
end subroutine

public function boolean wf_check_number (integer ai_count);if ai_count = integer(st_3.text) + integer(st_5.text) then
	return true
else
	return false
end if
end function

public subroutine wf_response (boolean ab_correct);boolean lb_dummy_opened = false
w_container_number_match lw_tmp
string ls_answer
long ll_orig_color, ll_hwn, ll_hwn_this
ii_current_try++
SetPointer(HourGlass!)
if ab_correct then
	timer(0, iw_dest[1])
	iw_dest[1].wf_reset_backcolor()
	il_total_correct_answers[ii_current_question_id] = il_total_correct_answers[ii_current_question_id] + 1
	ls_answer = string(integer(st_3.text) + integer(st_5.text)) + ".wav"
	inv_sound_play.play_number_sound(ls_answer)
	if pos(is_response_to_right, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_right)
	else
		wf_play_video(is_response_to_right)
	end if
	if ii_current_question_id > ii_total_items then return
//	if isvalid(gw_money_board) then
//		if gw_money_board.ii_current_index + 1 = gw_money_board.ii_total_tokens then
//			gn_appman.of_set_parm("Lesson Window Handle", ll_hwn_this)
//			if not isvalid(iw_dummy) then
//				open(iw_dummy)
//			else
//				iw_dummy.visible = true
//			end if
//			gn_appman.ib_movie_playing = true
//		end if
//		gw_money_board.wf_add_credit()
//		do while gn_appman.ib_movie_playing 
//			Yield()
//		loop
//		if isvalid(iw_dummy) then iw_dummy.visible = false
//	end if
	if isvalid(gw_money_board) then
		if gw_money_board.ii_current_index + 1 = gw_money_board.ii_total_tokens then
				gn_appman.of_set_parm("Lesson Window Handle", ll_hwn_this)
				lb_dummy_opened = true
				open(iw_dummy)
			ib_waiting = true
			gn_appman.ib_movie_playing = true
		end if
		gw_money_board.wf_add_credit()
		do while gn_appman.ib_movie_playing 
			Yield()
		loop
		if lb_dummy_opened then
			close(iw_dummy)
		end if
	end if

	wf_get_new_item()
elseif ii_current_try = ii_tries then
	timer(0, iw_dest[1])
	iw_dest[1].wf_reset_backcolor()
	wf_get_new_item()
else
	if pos(is_response_to_wrong, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_wrong)
	else
		wf_play_video(is_response_to_wrong)
	end if
end if	
end subroutine

on w_lesson_addition.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_5
end on

on w_lesson_addition.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
end on

event dragdrop;call super::dragdrop;uo_count_number iuo_tmp
if source.classname() = 'uo_count_number' then
	st_1.visible = false
	ib_drag = false
	iuo_tmp = source
	iuo_tmp.visible = true
	iuo_tmp.width = iuo_tmp.ii_width
	iuo_tmp.height = iuo_tmp.ii_height		
	iuo_tmp.x = iuo_tmp.ii_x		
	iuo_tmp.y = iuo_tmp.ii_y		
end if
end event

event mousemove;call super::mousemove;//if ib_drag then
//	p_1.x = xpos
//	p_1.y = ypos
//end if
end event

event open;call super::open;//wf_set_lesson_mode(false)
p_1.visible = false
st_1.visible = false
st_1.text = ' '
st_1.height = 0
st_1.width = 0
st_2.visible = false
st_3.visible = false
st_4.visible = false
st_5.visible = false

dw_1.visible = true
dw_2.visible = true
dw_1.InsertRow(0)

//is_bitmap = "c:\above2.bmp"
//wf_load_graph(is_bitmap)
end event

event close;call super::close;//long ll_i
//if ib_file_loaded then
//	do while PostThreadMessageExt(il_thread,273,32779,0) = 0 and ll_i < 100
//		sleeping(10)
//		ll_i++
//	loop
//	if ll_i > 90 then
//		MessageBox("PostThreadMessage", "failed")
//	end if
//end if
end event

event systemkey;call super::systemkey;integer li_row
long ll_count
string ls_comment_type, ls_win_title
if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
		enable_ctrl_alt_del()
		wf_set_lesson_mode(false)
	end if
end if
if KeyDown(KeyControl!) and KeyDown(KeyZ!) then
	select count(progress_data_id) into :ll_count
	from progress_data
	where lesson_id = :il_lesson_id;
	if ll_count = 0 then
		MessageBox('Error', 'No report is created for this lesson cannot add comment!')
		return
	end if
	select max(progress_data_id) into :il_progress_data_id
	from progress_data
	where lesson_id = :il_lesson_id;
	ls_win_title = "Report Comment Maintenance"
	ls_comment_type = "PROGRESS REPORT"
	gn_appman.of_set_parm("Win Title", ls_win_title)
	gn_appman.of_set_parm("Comment Type",  ls_comment_type)
	gn_appman.of_set_parm("Table Key ID",  il_progress_data_id)
	gn_appman.of_set_parm("Second Key ID",  il_lesson_id)
	Open(w_comment_update)
end if

end event

type cb_close from w_lesson`cb_close within w_lesson_addition
string tag = "1505030"
end type

type cb_start from w_lesson`cb_start within w_lesson_addition
string tag = "1505030"
end type

event cb_start::clicked;Setredraw(false)
super::event clicked()
p_1.visible = false
Setredraw(true)
end event

type dw_1 from w_lesson`dw_1 within w_lesson_addition
string tag = "1505010"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 23')
end if

end event

type dw_2 from w_lesson`dw_2 within w_lesson_addition
string tag = "1505020"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_addition
boolean visible = false
end type

type st_1 from w_lesson`st_1 within w_lesson_addition
end type

type st_2 from statictext within w_lesson_addition
integer x = 2235
integer y = 236
integer width = 297
integer height = 364
boolean bringtotop = true
integer textsize = -70
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "="
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_lesson_addition
integer x = 297
integer y = 236
integer width = 512
integer height = 364
boolean bringtotop = true
integer textsize = -70
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 15780518
boolean enabled = false
string text = "00"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_lesson_addition
integer x = 992
integer y = 236
integer width = 347
integer height = 364
boolean bringtotop = true
integer textsize = -70
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "+"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_lesson_addition
integer x = 1646
integer y = 236
integer width = 512
integer height = 364
boolean bringtotop = true
integer textsize = -70
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 15780518
boolean enabled = false
string text = "00"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

