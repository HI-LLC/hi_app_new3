$PBExportHeader$w_lesson_unscramble_word.srw
forward
global type w_lesson_unscramble_word from w_lesson
end type
type st_2 from statictext within w_lesson_unscramble_word
end type
type sle_1 from singlelineedit within w_lesson_unscramble_word
end type
end forward

global type w_lesson_unscramble_word from w_lesson
string tag = "1508000"
integer height = 2320
string title = "Lesson - Unscramble Words"
st_2 st_2
sle_1 sle_1
end type
global w_lesson_unscramble_word w_lesson_unscramble_word

type variables
integer ii_bean_drop_style, ii_char_index =  1
boolean ib_alternation_switch = false
boolean ib_keyboard_only = false
integer ii_current_state = 0
constant integer ici_init_state = 0
constant integer ici_query_state = 1
constant integer ici_answer_expecting_state = 2
constant integer ici_lesson_end_state = 3
uo_count_alpha iuo_count_alpha
end variables

forward prototypes
public subroutine wf_init_container ()
public subroutine wf_letter_scanning (character key)
public subroutine wf_make_word_list (integer ai_window_width, integer ai_char_width, string as_input_words, ref string as_output_word_list[])
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_next_dest ()
public subroutine wf_question_announcer ()
public subroutine wf_set_flash_for_prompt ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public function boolean wf_check_alpha ()
public subroutine wf_response (boolean ab_correct)
public subroutine wf_get_new_item ()
end prototypes

public subroutine wf_init_container ();ii_current_state = ici_init_state 

end subroutine

public subroutine wf_letter_scanning (character key);integer li_i
string ls_input_letter
dragobject ldrgo_letter
w_container_unscramble_word lw_container
uo_count_alpha luo_count_alpha
ls_input_letter = key
if ls_input_letter = "" then return
lw_container = iw_source[1]
for li_i = 1 to upperbound(lw_container.ioval)
	luo_count_alpha = lw_container.ioval[li_i]
	if is_text_ind = '0' then //case in-sensitive		
		if upper(ls_input_letter) = upper(luo_count_alpha.st_number.text) and luo_count_alpha.visible then
			ldrgo_letter = luo_count_alpha
			lw_container.event dragdrop(ldrgo_letter)
			sle_1.text = ""
			return
		end if
	elseif is_text_ind = '2' then // case ensitive
		if ls_input_letter = luo_count_alpha.st_number.text and luo_count_alpha.visible then
			ldrgo_letter = luo_count_alpha
			lw_container.event dragdrop(ldrgo_letter)
			sle_1.text = ""
			return
		end if
	else // dictation
		luo_count_alpha.st_number.text = ls_input_letter 
		ldrgo_letter = luo_count_alpha
		lw_container.event dragdrop(ldrgo_letter)
		sle_1.text = ""
		return
//		if ls_input_letter = luo_count_alpha.st_number.text then
//			ldrgo_letter = luo_count_alpha
//			lw_container.event dragdrop(ldrgo_letter)
//			sle_1.text = ""
//			return
//		end if
	end if
next
//if is_text_ind = '3'then // dictation
//	ib_misspelled = true
//end if
sle_1.text = ""
	
end subroutine

public subroutine wf_make_word_list (integer ai_window_width, integer ai_char_width, string as_input_words, ref string as_output_word_list[]);integer li_row = 1, li_i, li_count, li_width = 0, li_pos, li_last_space_pos, li_over_pass_chars
string ls_tmp_word_list[], ls_tmp_words
ls_tmp_words = trim(as_input_words)
li_count = len(as_input_words)
li_width = ai_char_width
li_i = 1
do
	li_pos = pos(ls_tmp_words, ' ')
	if li_pos > 0 then
//		ls_tmp_word_list[li_i] = left(ls_tmp_words, li_pos - 1)		
		ls_tmp_word_list[li_i] = left(ls_tmp_words, li_pos)		
		ls_tmp_words = trim(right(ls_tmp_words, len(ls_tmp_words) - li_pos))
		li_i++
	end if	
loop while li_pos > 0
ls_tmp_word_list[li_i] = ls_tmp_words
li_row = 1
as_output_word_list[1] =  ls_tmp_word_list[1]
//MessageBox("ai_window_width", string(ai_window_width))
//MessageBox("li_width", string(li_width))
for li_i = 2 to upperbound(ls_tmp_word_list)
//	MessageBox("ls_tmp_word_list", ls_tmp_word_list[li_i])
//	MessageBox("len(as_output_word_list[li_row]) + len(ls_tmp_word_list[li_i]) + 1)", &
//		string((len(as_output_word_list[li_row]) + len(ls_tmp_word_list[li_i]) + 1) * li_width))
	if (len(as_output_word_list[li_row]) + len(ls_tmp_word_list[li_i]) + 1) * li_width < ai_window_width then
		as_output_word_list[li_row] = as_output_word_list[li_row] + ls_tmp_word_list[li_i]
	else
		li_row = li_row + 1
		as_output_word_list[li_row] = ls_tmp_word_list[li_i]
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

SetPointer(ip_orig_pointer)
if is_text_ind <> '3' then // Dictate
	post timer(10, this)
else
	post timer(5, this)
end if
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
	st_2.visible = true
	dw_prompt.visible = false
else
	st_2.visible = false
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
	timer(0, this)
	if isvalid(gw_money_board) then
		gw_money_board.BringToTop = true
		gw_money_board.wf_add_credit()
	end if
	st_2.visible = false
	ib_keyboard_only = false
	sle_1.visible = false
	wf_get_new_item()	
elseif ii_current_try = ii_tries then
	st_2.visible = false
	ib_keyboard_only = false
	sle_1.visible = false
	wf_get_new_item()
else
	if pos(is_response_to_wrong, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_wrong)
	else
		wf_play_video(is_response_to_wrong)
	end if
end if
end subroutine

public subroutine wf_get_new_item ();integer li_row, li_row_count, li_i, li_count, li_x, li_y, li_width, li_height, li_allowed_height, li_char_ind = 0
integer li_adjusted_height = 0
string ls_process_words, ls_word_list[]
string ls_selected_item
long ll_x, ll_y, ll_i,ll_hwn
integer li_dummy[], li_j

li_dummy = {0, 13}	
w_container lw_empty[]
w_container_unscramble_word lw_tmp
ii_current_state = ici_query_state 
ii_char_index = 1
ib_misspelled = false
ii_current_try = 0
ii_current_question_id++
il_total_tries[ii_current_question_id]++
//return
SetFocus()
if ii_current_question_id > ii_total_items then
	ib_keyboard_only = false
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	st_2.visible = false
//	wf_update_statistic()
	post wf_set_lesson_mode(false) // close container window
//	wf_check_batch()
	ii_current_state = ici_lesson_end_state  
	timer(0, this)
	return
end if
ip_orig_pointer = SetPointer(HourGlass!)
if is_text_ind <> '1' then // mouse input
	ib_keyboard_only = true
	mouse_event(32769, 1, 1, 0, 0)
else
	ib_keyboard_only = false
	sle_1.visible = false
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
	SetRedraw(true)	
   return
end if

if ii_prompt_ind = 1 then // Hint
	st_2.visible = true
	st_2.width = this.width
	st_2.x = 0
	st_2.y = 0
	if isvalid(gw_money_board) then
		st_2.y = 80
	end if
	st_2.text = is_text_list[ii_current_question_id]
	st_2.BringToTop = true
	li_adjusted_height = st_2.y + st_2.height
else
	st_2.visible = false
end if

// open destination windows
li_width = 250
li_height = 230

wf_make_word_list(this.width, li_width + 5, is_text_list[ii_current_question_id], ls_word_list)

ls_process_words = ""
for li_row = 1 to upperbound(ls_word_list)
	ls_process_words = ls_process_words + ls_word_list[li_row]
next
li_allowed_height = (this.height - li_adjusted_height - this.height/20 )*5/9 
li_y = li_adjusted_height + li_allowed_height/(upperbound(ls_word_list) + 1) - (li_height/2)
li_row_count =  upperbound(ls_word_list)
for li_row = 1 to li_row_count
	li_count = len(ls_word_list[li_row])
	li_x = (this.width - (li_width + 5) * li_count - 5)/2 //- li_width/2
	for li_i = 1 to li_count
//		if mid(ls_word_list[li_row], li_i, 1) <> ' ' then
			li_char_ind++
			open(iw_dest[li_char_ind], 'w_container_unscramble_word', this)
			lw_tmp = iw_dest[li_char_ind]
			lw_tmp.p_1.visible = false
//			lw_tmp.border = false
//			lw_tmp.BackColor = f_getcolor(11)
			lw_tmp.visible = true
			lw_tmp.ib_target = false	
			lw_tmp.width = li_width
			lw_tmp.height = li_height
			lw_tmp.x = li_x
			lw_tmp.y = li_y
			lw_tmp.st_1.text = mid(ls_word_list[li_row], li_i, 1)	
			lw_tmp.st_1.visible = false
			lw_tmp.st_1.BringToTop = true	
//		end if
		li_x =  li_x + li_width //+ 5		
	next
	li_y = li_y + (li_allowed_height/(upperbound(ls_word_list) + 1))
next

lw_tmp = iw_dest[1]
lw_tmp.ib_target = true	
string ls_scrambled_word = ''
for li_i = 1 to len(ls_process_words)
//	if mid(ls_process_words, li_i, 1) <> ' ' then
		ls_scrambled_word = ls_scrambled_word + mid(ls_process_words, li_i, 1)
//	end if
next
ls_scrambled_word = ls_process_words
wf_random_list(ls_scrambled_word)
open(iw_source[1], 'w_container_unscramble_word', this)
lw_tmp = iw_source[1]
lw_tmp.visible = false
if is_text_ind <> '3' then // NOT Dictate
	ls_scrambled_word = ls_process_words
	wf_random_list(ls_scrambled_word)
	open(iw_source[1], 'w_container_unscramble_word', this)
	lw_tmp = iw_source[1]
	lw_tmp.visible = false
	//if is_text_ind = '3' then // Dictate
	//	for li_i = 1 to upperbound(lw_tmp.ioval)
	//		lw_tmp.ioval[li_i].visible = false
	//	next
	//end if
	lw_tmp.height = (this.height - li_adjusted_height - this.height/20)*4/9
	lw_tmp.width = (lw_tmp.height * 7)/4
	lw_tmp.y = li_adjusted_height + (this.height - li_adjusted_height - this.height/20)*5/9
	lw_tmp.x = (this.width - lw_tmp.width)/2
	lw_tmp.p_1.height = lw_tmp.height
	lw_tmp.p_1.width = lw_tmp.width
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
else
	ls_scrambled_word =  'A'
	lw_tmp.wf_draw_alpha(ls_scrambled_word, 1, 0)
end if
//if is_text_ind <> '3' then // Dictate
//	lw_tmp.visible = true
//end if
SetRedraw(true)	
wf_question_announcer()
if ib_keyboard_only then 
	sle_1.visible = true
	sle_1.SetFocus()
end if	

if ii_prompt_ind = 2 then // Prompt
	wf_set_flash_for_prompt()
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
//Sleeping(4000)
//
//post MessageBox("wf_get_new_item", "END")
end subroutine

on w_lesson_unscramble_word.create
int iCurrent
call super::create
this.st_2=create st_2
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.sle_1
end on

on w_lesson_unscramble_word.destroy
call super::destroy
destroy(this.st_2)
destroy(this.sle_1)
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

if ib_keyboard_only and cb_start.visible = false then
	mouse_event(32769, 1, 1, 0, 0)
end if
end event

event open;call super::open;st_1.visible = false
st_1.enabled = false
st_2.visible = false
p_1.visible = false
iuo_count_alpha = create uo_count_alpha
//mouse_event (long dwFlags, long dx, long dy, long dwData, long dwExtraInfo)

end event

event timer;string ls_wave_file
string ls_1st_letter, ls_word, ls_dict_sound_file
ls_word = is_text_list[ii_current_question_id]
ls_1st_letter = upper(left(ls_word, 1))

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
end event

event key;call super::key;if cb_start.visible then
	st_2.visible = false
	timer(0, this)
end if
if sle_1.visible then
	sle_1.SetFocus()
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

event close;call super::close;if isvalid(iuo_count_alpha) then
	destroy iuo_count_alpha
end if
end event

event clicked;call super::clicked;if sle_1.visible then
	sle_1.SetFocus()
end if

end event

type dw_reward from w_lesson`dw_reward within w_lesson_unscramble_word
end type

type cb_close from w_lesson`cb_close within w_lesson_unscramble_word
string tag = "1508040"
end type

type cb_start from w_lesson`cb_start within w_lesson_unscramble_word
string tag = "1508040"
end type

type dw_2 from w_lesson`dw_2 within w_lesson_unscramble_word
string tag = "1508030"
string title = "Lesson - Unscramble Words"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_unscramble_word
end type

type st_1 from w_lesson`st_1 within w_lesson_unscramble_word
end type

type dw_1 from w_lesson`dw_1 within w_lesson_unscramble_word
string tag = "1508020"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 21')
end if

end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_unscramble_word
integer width = 2496
string dataobject = "d_prompt_spelling"
end type

type st_2 from statictext within w_lesson_unscramble_word
integer x = 841
integer y = 216
integer width = 2327
integer height = 104
boolean bringtotop = true
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_lesson_unscramble_word
event dwnkey pbm_char
integer x = 5
integer y = 1884
integer taborder = 60
boolean bringtotop = true
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

event dwnkey;if len(key) > 0 then
	wf_letter_scanning(key)
end if
end event

