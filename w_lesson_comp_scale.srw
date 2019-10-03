$PBExportHeader$w_lesson_comp_scale.srw
forward
global type w_lesson_comp_scale from w_lesson
end type
end forward

global type w_lesson_comp_scale from w_lesson
string tag = "1503000"
string title = "Lesson - Comparison (scale)"
end type
global w_lesson_comp_scale w_lesson_comp_scale

type variables
boolean ib_comparison_switch = true
integer ii_max_number = 0
integer ii_min_number = 9999

long il_orig_color
integer ii_current_state = 0
constant integer ici_init_state = 0
constant integer ici_query_state = 1
constant integer ici_answer_expecting_state = 2
constant integer ici_lesson_end_state = 3
end variables

forward prototypes
public subroutine wf_init_lesson ()
public function integer wf_get_correct_id ()
public subroutine wf_container_clicked (integer ai_id)
public subroutine wf_init_container ()
public subroutine wf_movemouse (long dx, long dy)
public subroutine wf_question_announcer ()
public subroutine wf_get_new_item ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_response ()
end prototypes

public subroutine wf_init_lesson ();super::wf_init_lesson()

integer il_row
ii_total_items = ids_lesson.RowCount()
for il_row = 1 to ii_total_items
	if ii_number_list[il_row] > ii_max_number then
		ii_max_number = ii_number_list[il_row]
	end if
	if ii_number_list[il_row] < ii_min_number then
		ii_min_number = ii_number_list[il_row]
	end if
next

end subroutine

public function integer wf_get_correct_id ();integer li_i, li_extreme, li_correct_id
li_extreme = ii_number_list[ii_item_presented[1]]
li_correct_id = ii_item_presented[1]
if ii_type = 3 or ii_type = 5 or ii_type = 7 or ii_type = 9 or &
	(ii_type > 10 and ib_comparison_switch ) then // many
	for li_i = 2 to ii_degree
		if li_extreme <  ii_number_list[ii_item_presented[li_i]] then
			li_extreme = ii_number_list[ii_item_presented[li_i]]
			li_correct_id = ii_item_presented[li_i]
		end if
	next
else // few
	for li_i = 2 to ii_degree
		if li_extreme >  ii_number_list[ii_item_presented[li_i]] then
			li_extreme = ii_number_list[ii_item_presented[li_i]]
			li_correct_id = ii_item_presented[li_i]
		end if
	next
end if
return li_correct_id

end function

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

public subroutine wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
string ls_bean
integer li_layout_row, li_layout_col, li_layout_rowcount, li_layout_colcount
integer li_height_interval, li_width_interval, li_remain, li_valid_height, li_width, li_height
double ldb_layout_test
integer li_row, li_source_row = 0, li_count
long ll_interval, ll_len
w_container_discrete_trial lw_container
ll_interval = this.width/(ii_degree*2)
//if ii_trial_target = 0 then ii_trial_target = 1
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


end subroutine

public subroutine wf_movemouse (long dx, long dy);long ll_x, ll_y
str_mousepos i_mousepos
GetCursorPos(i_mousepos)
//ll_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
//ll_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
ll_x = UnitsToPixels(dx, XUnitsToPixels!)
constant ulong dwFlags = 32769
mouse_event(dwFlags, ll_x*82, i_mousepos.ypos*110, 0, 0)
end subroutine

public subroutine wf_question_announcer ();
if not ib_comparison_switch and ii_type > 10 then //if it is alternation comparison and it is negative term
	if pos(is_instruction, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_instruction2)
	else
		wf_play_video(is_instruction2)
	end if
else
//	inv_sound_play.play_st_sound(is_instruction)
	if pos(is_instruction, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_instruction)
	else
		wf_play_video(is_instruction)
	end if
end if
ii_current_state = ici_answer_expecting_state  
post timer(10, this)

end subroutine

public subroutine wf_get_new_item ();integer il_row, li_correct_row
real lr_ratio
long ll_x, ll_y, ll_i
string ls_selected_item, ls_selected_qua
string ls_quantity_type[] = {"","","More","Less","","","Bigger","Smaller","Taller", "Shorter"}
integer li_dummy[]

li_dummy = {0, 13}	
//if isvalid(gw_money_board) then
//	gw_money_board.BringToTop = true
//end if
ib_done_prompt = false
ii_current_try = 1
if ii_trial_target > 0 then // pair up
	ii_current_question_id = ii_current_list_offset + ii_trial_target - 1
else
	ii_current_question_id++
end if
il_total_tries[ii_current_question_id]++
if (ii_trial_target = 0 and ii_current_question_id > ii_total_items) or &
	(ii_current_list_offset + ii_degree - 1  > ii_total_items) then
	ii_current_list_offset = 1
	for il_row = 1 to ii_degree
		iw_source[il_row].visible = false
		iw_source[il_row].event close()
	next 
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	wf_set_lesson_mode(false)
	return
end if
wf_random_list()
integer li_count
string ls_bean
ib_comparison_switch = not ib_comparison_switch
for il_row = 1 to ii_degree
	iw_source[il_row].BackColor = il_orig_color
	timer(0, iw_source[il_row])
	iw_source[il_row].visible = false
	ii_item_presented[il_row] = mod(ii_random_list[il_row] + ii_current_question_id - 1, ii_total_items)
	if ii_item_presented[il_row] = 0 then
		ii_item_presented[il_row] = ii_total_items
	end if
	li_count = ii_number_list[ii_item_presented[il_row]]
	ls_bean = is_picture_list[ii_item_presented[il_row]]
	iw_source[il_row].is_bean_picturename = ls_bean
	lr_ratio = li_count/ii_max_number
	if ii_type = 3 or ii_type = 4 then // many vs. few
		iw_source[il_row].wf_set_count(li_count, 1, 0)
	elseif ii_type = 7 or ii_type = 8 then // big vs. small
		iw_source[il_row].wf_set_size(lr_ratio, 0)
	elseif ii_type = 9 or ii_type = 10 then // tall vs. short
		iw_source[il_row].wf_set_height(lr_ratio, 0)
	end if
next
for il_row = 1 to ii_degree
	iw_source[il_row].visible = true
next

wf_question_announcer()
if ii_trial_target > 0 then
	ii_current_list_offset = ii_current_list_offset + ii_degree
end if
str_msg msg
long ll_hwn, li_i, li_msg_count = 0
for li_i = 1 to upperbound(iw_source)
	ll_hwn = handle(iw_source[li_i])
	do while remove_message(msg, ll_hwn, 513, 513) > 0 
	loop
next

for il_row = 1 to ii_degree
	if ii_item_presented[iw_source[il_row].ii_id] = wf_get_correct_id() then
		li_correct_row = il_row
		exit
	end if
next
end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);super::wf_set_lesson_mode(ab_lesson_on)
if ab_lesson_on then
	dw_prompt.visible = false
else
	if dw_prompt.RowCount() > 0 then
		dw_prompt.visible = true
	end if	
end if

end subroutine

public subroutine wf_response ();integer li_row, li_correct_row, li_i
long ll_orig_color, ll_hwn
integer li_tmp
long ll_x, ll_y
//li_tmp = wf_get_correct_id()
ll_x = (iw_source[1].x + iw_source[1].width) + &
		(iw_source[2].x - (iw_source[1].x + iw_source[1].width))/2
ll_x = ll_x + this.x + this.workspacex()	
wf_movemouse(ll_x, 0)
SetPointer(HourGlass!)
if ii_current_answer_id = wf_get_correct_id() then
	il_total_correct_answers[ii_current_answer_id]++
	if pos(is_response_to_right, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_right)
	else
		wf_play_video(is_response_to_right)
	end if
	if isvalid(gw_money_board) then
		gw_money_board.wf_add_credit()
	end if
	wf_get_new_item()
elseif ii_current_try = ii_tries then
	if ii_prompt_ind = 2 then // Error Correction
		for li_row = 1 to ii_degree
			if ii_item_presented[li_row] = wf_get_correct_id() then
				li_correct_row = li_row			
			end if
		next
		ll_orig_color = iw_source[li_correct_row].BackColor
		timer(0.25, iw_source[li_correct_row])
		if pos(is_prompt_instruction, ".wav") > 0 then
			inv_sound_play.play_st_sound(is_prompt_instruction)
		elseif trim(is_prompt_instruction) <> "" then
			wf_play_video(is_prompt_instruction)
		end if
		MessageBox("Info", "Continue...")
		timer(0, iw_source[li_correct_row])
		iw_source[li_correct_row].BackColor = ll_orig_color
		wf_get_new_item()
	elseif ii_prompt_ind = 1 and not ib_done_prompt then
		
		ib_done_prompt = true
		string ls_bean
		for li_row = 1 to ii_degree
			iw_source[li_row].visible = false
		next
		for li_row = 1 to ii_degree
			if ii_item_presented[li_row] = wf_get_correct_id() then
				li_correct_row = li_row			
			end if
		next
		ll_orig_color = iw_source[li_correct_row].BackColor
		timer(0.25, iw_source[li_correct_row])
		for li_row = 1 to ii_degree
			iw_source[li_row].visible = true
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
	ii_current_try++
end if		

end subroutine

on w_lesson_comp_scale.create
call super::create
end on

on w_lesson_comp_scale.destroy
call super::destroy
end on

event clicked;call super::clicked;//str_mousepos i_mousepos
//GetCursorPos(i_mousepos)
//long ll_x, ll_y, ll_sheet_x, ll_sheet_y
//ll_x = i_mousepos.xpos
//ll_y = i_mousepos.ypos
////MessageBox("x Y", string(i_mousepos.xpos) + '  ' + string(i_mousepos.ypos))
////ll_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) //+ ParentWindow().x + this.workspaceX() //+ this.x
////ll_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) //+ ParentWindow().y + this.workspaceY() //+ this.y
////
////ll_sheet_x = UnitsToPixels(xpos + this.workspaceX(), XUnitsToPixels!)
////ll_sheet_y = UnitsToPixels(ypos + this.workspaceY(), YUnitsToPixels!)
////ll_x = UnitsToPixels(dx, XUnitsToPixels!)
//constant ulong dwFlags = 32769
//
//mouse_event(dwFlags, i_mousepos.xpos*82, i_mousepos.ypos*110, 0, 0)
//GetCursorPos(i_mousepos)
////MessageBox("x Y", string(i_mousepos.xpos) + '  ' + string(i_mousepos.ypos))
//MessageBox("x ratio Y ratio", string(ll_x/i_mousepos.xpos) + '  ' + string(ll_y/i_mousepos.ypos))
//
end event

event open;call super::open;//OpenWithParm(w_play_avi3, "")
//wf_dummy()
end event

event key;call super::key;integer il_row
long ll_count
string ls_comment_type, ls_win_title

if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
//		for il_row = 1 to upperbound(iw_source)
//			close(iw_source[il_row])
//		next 		
//		for il_row = 1 to upperbound(iw_dest)
//			close(iw_dest[il_row])
//		next 		
		enable_ctrl_alt_del()
		wf_set_lesson_mode(false)
	end if
end if

end event

type dw_reward from w_lesson`dw_reward within w_lesson_comp_scale
end type

type cb_close from w_lesson`cb_close within w_lesson_comp_scale
string tag = "1503030"
end type

type cb_start from w_lesson`cb_start within w_lesson_comp_scale
string tag = "1503030"
end type

type dw_2 from w_lesson`dw_2 within w_lesson_comp_scale
string tag = "1503020"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)

if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then	
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_comp_scale
end type

type st_1 from w_lesson`st_1 within w_lesson_comp_scale
end type

type dw_1 from w_lesson`dw_1 within w_lesson_comp_scale
string tag = "1503010"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id > 2 and method_id < 14')
end if

end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_comp_scale
integer width = 1477
end type

