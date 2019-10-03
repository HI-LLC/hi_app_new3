$PBExportHeader$w_lesson_unscramble_sentence.srw
forward
global type w_lesson_unscramble_sentence from w_lesson
end type
type st_2 from statictext within w_lesson_unscramble_sentence
end type
end forward

global type w_lesson_unscramble_sentence from w_lesson
string tag = "1508000"
string title = "Lesson - Unscramble Sentences"
st_2 st_2
end type
global w_lesson_unscramble_sentence w_lesson_unscramble_sentence

type variables
integer ii_bean_drop_style, ii_char_index =  1
boolean ib_alternation_switch = false
integer ii_current_state = 0
constant integer ici_init_state = 0
constant integer ici_query_state = 1
constant integer ici_answer_expecting_state = 2
constant integer ici_lesson_end_state = 3
end variables

forward prototypes
public subroutine wf_get_new_item ()
public subroutine wf_init_container ()
public subroutine wf_make_word_list (integer ai_window_width, integer ai_char_height, string as_input_words, ref string as_output_word_list[], ref str_string_array as_output_layout_list[])
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_next_dest ()
public subroutine wf_question_announcer ()
public subroutine wf_set_flash_for_prompt ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public function boolean wf_check_alpha ()
public subroutine wf_response (boolean ab_correct)
end prototypes

public subroutine wf_get_new_item ();integer li_row,li_col, li_row_count, li_i, li_count, li_x, li_y, li_width, li_height, li_allowed_height, li_char_ind = 0
integer li_adjusted_height = 0
string ls_process_words, ls_scrambled_word[], ls_word_list[]
string ls_selected_item, ls_tmp
str_string_array ls_layout_list[]
long ll_x, ll_y, ll_i, ll_width
integer li_dummy[], li_j, li_lpDx
ulong li_dc
real lr_height_ratio, lr_xy_ratio
str_size lstr_str_size
str_rect lstr_rect
li_dummy = {0, 13}	
w_container lw_empty[]
w_container_unscramble_word lw_tmp


li_dc = GetDC(handle(this))

ii_current_state = ici_query_state 
timer(30, this)
ii_char_index = 1
ib_misspelled = false
ii_current_try = 0
ii_current_question_id++
il_total_tries[ii_current_question_id]++
//return
if ii_current_question_id > ii_total_items then
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	st_2.visible = false
//	wf_update_statistic()
	post wf_set_lesson_mode(false) // close container window
//	wf_check_batch()
	ii_current_state = ici_lesson_end_state  
	timer(0, this)
	return
end if
SetRedraw(false)	
// close previous destination window
li_count = upperbound(iw_dest)
for li_i = 1 to li_count
	if isvalid(iw_dest[li_i]) then
		close(iw_dest[li_i])
	end if
next
iw_dest = lw_empty
// close previous source window
li_count = upperbound(iw_source)
for li_i = 1 to li_count
	if isvalid(iw_source[li_i]) then
		close(iw_source[li_i])
	end if
next
iw_source = lw_empty
li_count = len(is_text_list[ii_current_question_id])
if li_count = 0 then 
	MessageBox("Lesson", "Invalid word.")
	wf_get_new_item()
   return
end if

if ii_prompt_ind = 1 then // Hint
	st_2.visible = true
	st_2.width = this.width
	st_2.x = 0
	st_2.y = 0
//	if isvalid(gw_money_board) then // adjust the hint text that they would not be blocked by money board
//		st_2.y = 20
//	end if
	st_2.text = is_text_list[ii_current_question_id]
	st_2.BringToTop = true
	li_adjusted_height = st_2.y + st_2.height
else
	st_2.visible = false
end if

// open destination windows
li_width = 200
li_height = 140

// Since we use none-fixed height font, all string's widths need to be measured
wf_make_word_list((this.width*3/4), li_height, is_text_list[ii_current_question_id], ls_word_list, ls_layout_list)
ls_process_words = ""
for li_row = 1 to upperbound(ls_word_list)
	ls_process_words = ls_process_words + ls_word_list[li_row]
next

li_allowed_height = (this.height - li_adjusted_height - this.height/20 )*4/9  // height for blocks on which to be dropped
li_y = li_adjusted_height + li_allowed_height/(upperbound(ls_word_list) + 1) - (li_height/2)
li_row_count =  upperbound(ls_layout_list) 
lr_xy_ratio = PixelsToUnits(1000, XPixelsToUnits!)/PixelsToUnits(1000, YPixelsToUnits!)

for li_row = 1 to li_row_count
//	MessageBox("ls_word_list " + string(li_row), ls_word_list[li_row])
	GetTextExtentPoint32A(li_dc, ls_word_list[li_row], len(ls_word_list[li_row]), lstr_str_size)
	ll_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
	lr_height_ratio = li_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)
	li_x = (this.width - ll_width*lr_height_ratio*lr_xy_ratio)/2
	for li_col = 1 to upperbound(ls_layout_list[li_row].array)
		li_char_ind++
		ls_scrambled_word[li_char_ind] = ls_layout_list[li_row].array[li_col]
		open(iw_dest[li_char_ind], 'w_container_unscramble_word', this)
		lw_tmp = iw_dest[li_char_ind]
		lw_tmp.border = false
		lw_tmp.BackColor = f_getcolor(11)
		lw_tmp.p_1.visible = false
		lw_tmp.visible = true
		lw_tmp.ib_target = false	
		lw_tmp.st_1.x = 1
		lw_tmp.st_1.y = 1
		lw_tmp.st_1.textsize = 35
		ls_tmp = ls_layout_list[li_row].array[li_col] + ' '
		li_dc = GetDC(handle(this))
		GetTextExtentPoint32A(li_dc, ls_tmp, len(ls_tmp), lstr_str_size)
		lr_height_ratio = li_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)		
		ll_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
		ll_width =  ll_width*lr_xy_ratio*lr_height_ratio
		lw_tmp.width = ll_width + 10
		lw_tmp.height = li_height
		lw_tmp.x = li_x
		lw_tmp.y = li_y
		lw_tmp.st_1.width = ll_width 
		lw_tmp.st_1.text = ls_layout_list[li_row].array[li_col]	
		lw_tmp.st_1.visible = false
		lw_tmp.st_1.BringToTop = true	
		li_x =  li_x + ll_width/*len(ls_layout_list[li_row].array[li_col])*/		
	next
	li_y = li_y + (li_allowed_height/(upperbound(ls_word_list) + 1))
next

lw_tmp = iw_dest[1]
lw_tmp.ib_target = true	

//ls_scrambled_word = ls_process_words
wf_random_list(ls_scrambled_word)
open(iw_source[1], 'w_container_unscramble_word', this)
lw_tmp = iw_source[1]
lw_tmp.height = (this.height - li_adjusted_height - this.height/20)*5/9
lw_tmp.width = (lw_tmp.height * 6)/4
lw_tmp.y = li_adjusted_height + (this.height - li_adjusted_height - this.height/20)*4/9
lw_tmp.x = (this.width - lw_tmp.width)/2
lw_tmp.p_1.height = lw_tmp.height
lw_tmp.p_1.width = lw_tmp.width
//lw_tmp.ii_height = lw_tmp.height
//lw_tmp.ii_width = lw_tmp.width
lw_tmp.st_1.visible = false
lw_tmp.ib_target = false	
if is_picture_ind = '1' and FileExists(is_picture_list[ii_current_question_id]) then
	lw_tmp.p_1.PictureName = is_picture_list[ii_current_question_id]
else
	lw_tmp.BackColor = f_getcolor(7)
	lw_tmp.p_1.visible = false
end if
lw_tmp.wf_draw_alpha(ls_scrambled_word, 1, 0)
lw_tmp.visible = true
SetRedraw(true)	
wf_question_announcer()
if ii_prompt_ind = 2 then // Prompt
	wf_set_flash_for_prompt()
end if
string ls_msg

//for li_j = 1 to upperbound(ls_scrambled_word)
//	ls_msg = iw_source[1].ioval[li_j].st_number.text
//	MessageBox(string(li_j), ls_msg)
//next

end subroutine

public subroutine wf_init_container ();ii_current_state = ici_init_state 

end subroutine

public subroutine wf_make_word_list (integer ai_window_width, integer ai_char_height, string as_input_words, ref string as_output_word_list[], ref str_string_array as_output_layout_list[]);integer li_row = 1, li_i,li_j=0, li_count, li_width = 0, li_pos, li_last_space_pos, li_over_pass_chars
integer li_dc, li_sum_width = 0
string ls_tmp_word_list[], ls_tmp_words
real lr_xy_ratio, lr_height_ratio
str_size lstr_str_size
ls_tmp_words = trim(as_input_words)
li_count = len(as_input_words)
//li_width = ai_char_height
li_i = 1
do
	li_pos = pos(ls_tmp_words, ' ')
	if li_pos > 0 then
		ls_tmp_word_list[li_i] = left(ls_tmp_words, li_pos - 1)		
		ls_tmp_words = trim(right(ls_tmp_words, len(ls_tmp_words) - li_pos))
		li_i++
	end if	
loop while li_pos > 0
ls_tmp_word_list[li_i] = ls_tmp_words
li_row = 1
as_output_word_list[1] =  ls_tmp_word_list[1]
li_j = 1
li_dc = GetDc(handle(this))
lr_xy_ratio = PixelsToUnits(1000, XPixelsToUnits!)/PixelsToUnits(1000, YPixelsToUnits!)
as_output_layout_list[1].array[1] =  ls_tmp_word_list[1]
for li_i = 2 to upperbound(ls_tmp_word_list)
	GetTextExtentPoint32A(li_dc, ls_tmp_word_list[li_i], len(ls_tmp_word_list[li_i]), lstr_str_size)
	lr_height_ratio = ai_char_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)
	li_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
	li_width =  li_width*lr_xy_ratio*lr_height_ratio
	li_sum_width = li_sum_width + li_width
	if li_sum_width < ai_window_width then
		as_output_word_list[li_row] = as_output_word_list[li_row] + ' ' + ls_tmp_word_list[li_i]
		li_j++
		as_output_layout_list[li_row].array[li_j] = ls_tmp_word_list[li_i]
	else
		li_sum_width = 0
		li_row = li_row + 1
		as_output_word_list[li_row] = ls_tmp_word_list[li_i]
		li_j = 1
		as_output_layout_list[li_row].array[li_j] = ls_tmp_word_list[li_i]
	end if
next


end subroutine

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	st_1.x = xpos
	st_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public subroutine wf_next_dest ();w_container_unscramble_word lw_tmp
lw_tmp = iw_dest[ii_char_index]
lw_tmp.ib_target = false
ii_char_index = ii_char_index + 1
lw_tmp = iw_dest[ii_char_index]
lw_tmp.ib_target = true
if ii_prompt_ind = 2 then // Prompt
	wf_set_flash_for_prompt()
end if

end subroutine

public subroutine wf_question_announcer ();string ls_1st_letter, ls_word, ls_dict_sound_file

ls_word = is_text_list[ii_current_question_id]
ls_1st_letter = upper(left(ls_word, 1))
if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if
if pos(is_wave_list[ii_current_question_id], ".wav") > 0 then
	inv_sound_play.play_st_sound(is_wave_list[ii_current_question_id])
elseif pos(is_wave_list[ii_current_question_id], "DICTIONARY") > 0 then
	ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
	if FileExists(ls_dict_sound_file) then
		sndPlaySoundA(ls_dict_sound_file, 0)
	else
		MessageBox("Error", "Sound file - " + ls_dict_sound_file + " does not exist!")
	end if
else
	wf_play_video(is_wave_list[ii_current_question_id])
end if

ii_current_state = ici_answer_expecting_state  
post timer(30, this)

end subroutine

public subroutine wf_set_flash_for_prompt ();integer li_i
w_container_unscramble_word lw_dest, lw_source
lw_dest = iw_dest[ii_char_index]
lw_source = iw_source[1]
for li_i = 1 to upperbound(lw_source.ioval)
	if lw_dest.st_1.text = lw_source.ioval[li_i].st_number.text and lw_source.ioval[li_i].visible then
		lw_source.iuo_count = lw_source.ioval[li_i]
		timer(0.25, lw_source)
		return
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
	integer li_row
	for li_row = 1 to upperbound(iw_source)
		if isvalid(iw_source[li_row]) then iw_source[li_row].event close()
	next 
	for li_row = 1 to upperbound(iw_dest)
		if isvalid(iw_dest[li_row]) then iw_dest[li_row].event close()
	next 
	ii_selected_dest = 0
	ii_selected_source = 0
end if
end subroutine

public function boolean wf_check_alpha ();integer li_i
w_container_unscramble_word lw_tmp

for li_i = 1 to upperbound(iw_dest)
	lw_tmp = iw_dest[li_i]
	if lw_tmp.st_1.visible = false then
		return false
	end if
next
return true

end function

public subroutine wf_response (boolean ab_correct);string ls_1st_letter, ls_word, ls_dict_sound_file

ls_word = is_text_list[ii_current_question_id]
ls_1st_letter = upper(left(ls_word, 1))
ii_current_try++
SetPointer(HourGlass!)
ii_current_state = ici_query_state 
if ab_correct then
	if not ib_misspelled then // consider as correct spelling only not wrong letters were dragged
		il_total_correct_answers[ii_current_question_id] = il_total_correct_answers[ii_current_question_id] + 1
	end if
	
	if pos(is_wave_list[ii_current_question_id], ".wav") > 0 then
		inv_sound_play.play_st_sound(is_wave_list[ii_current_question_id])
	elseif pos(is_wave_list[ii_current_question_id], "DICTIONARY") > 0 then
		ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
		if FileExists(ls_dict_sound_file) then
			sndPlaySoundA(ls_dict_sound_file, 0)
		else
			MessageBox("Error", "Sound file - " + ls_dict_sound_file + " does not exist!")
		end if
	end if
	if pos(is_response_to_right, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_right)
	else
		wf_play_video(is_response_to_right)
	end if
	if ii_current_question_id > ii_total_items then return
//	MessageBox("Good Job!", "Next Number")
	if isvalid(gw_money_board) then
		gw_money_board.BringToTop = true
		gw_money_board.wf_add_credit()
	end if
	st_2.visible = false
	wf_get_new_item()
elseif ii_current_try = ii_tries then
	st_2.visible = false
	wf_get_new_item()
else
	if pos(is_response_to_wrong, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_wrong)
	else
		wf_play_video(is_response_to_wrong)
	end if
end if



end subroutine

on w_lesson_unscramble_sentence.create
int iCurrent
call super::create
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
end on

on w_lesson_unscramble_sentence.destroy
call super::destroy
destroy(this.st_2)
end on

event dragdrop;call super::dragdrop;uo_count_alpha iuo_tmp
if source.classname() = 'uo_count_alpha' then
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

event dragwithin;call super::dragwithin;w_lesson_unscramble_word lw_tmp
long li_x, li_y
str_mousepos i_mousepos
GetCursorPos(i_mousepos)
lw_tmp = ParentWindow()
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_x = li_x - WorkSpaceX()
li_y = li_y - WorkSpaceY()
wf_mousemove(li_x, li_y)

end event

event mousemove;call super::mousemove;//if ib_drag then
//	st_1.x = xpos
//	st_1.y = ypos
//end if
end event

event open;call super::open;st_1.visible = false
st_1.enabled = false
st_2.visible = false
p_1.visible = false

//mouse_event (long dwFlags, long dx, long dy, long dwData, long dwExtraInfo)

end event

event timer;string ls_wave_file
string ls_1st_letter, ls_word, ls_dict_sound_file
ls_word = is_text_list[ii_current_question_id]
ls_1st_letter = upper(left(ls_word, 1))
/*
if ii_current_state = ici_answer_expecting_state then
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

*/
end event

event key;call super::key;if cb_start.visible then
	st_2.visible = false
	timer(0, this)
end if

integer il_row
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

type dw_reward from w_lesson`dw_reward within w_lesson_unscramble_sentence
end type

type cb_close from w_lesson`cb_close within w_lesson_unscramble_sentence
string tag = "1508040"
end type

type cb_start from w_lesson`cb_start within w_lesson_unscramble_sentence
string tag = "1508040"
end type

type dw_2 from w_lesson`dw_2 within w_lesson_unscramble_sentence
string tag = "1508030"
string title = "Lesson - Unscramble Words"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_unscramble_sentence
integer x = 46
integer y = 568
end type

type st_1 from w_lesson`st_1 within w_lesson_unscramble_sentence
integer x = 23
integer y = 616
integer width = 338
integer height = 184
integer textsize = -18
fontpitch fontpitch = fixed!
end type

type dw_1 from w_lesson`dw_1 within w_lesson_unscramble_sentence
string tag = "1508020"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 22')
end if

end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_unscramble_sentence
integer width = 2011
end type

type st_2 from statictext within w_lesson_unscramble_sentence
integer x = 9
integer y = 208
integer width = 3525
integer height = 104
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "0123456789012345678901234567890123456789012345678901234"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

