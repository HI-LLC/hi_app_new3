$PBExportHeader$w_lesson_numbermatch_count.srw
forward
global type w_lesson_numbermatch_count from w_lesson
end type
type st_2 from statictext within w_lesson_numbermatch_count
end type
end forward

global type w_lesson_numbermatch_count from w_lesson
string tag = "1505000"
integer width = 3607
integer height = 2436
string title = "Lesson - Number Matching Counting"
event paint pbm_paint
st_2 st_2
end type
global w_lesson_numbermatch_count w_lesson_numbermatch_count

type variables
integer ii_bean_drop_style
boolean ib_alternation_switch = false, ib_file_loaded = false
long il_handle, il_asciisize, il_binsize
ulong il_thread
string is_bitmap, is_data, is_empty

w_container iw_container_number_match
end variables

forward prototypes
public subroutine wf_set_flash_for_prompt ()
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_question_announcer ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_response (boolean ab_correct)
public function boolean wf_check_number (integer ai_count)
public subroutine wf_get_new_item ()
public subroutine wf_init_container ()
end prototypes

event paint;//long ll_i
//do while PostThreadMessageExt(il_thread,273,32778,0) = 0 and ll_i < 100
//	sleeping(10)
//	ll_i++
//loop
//
//
end event

public subroutine wf_set_flash_for_prompt ();integer li_i
w_container_dragdrop lw_source
w_container_number_match lw_dest
lw_source = iw_source[1]
lw_dest = iw_dest[1]
for li_i = 1 to upperbound(lw_dest.ioval)
	if lw_source.ii_bean_count = integer(lw_dest.ioval[li_i].st_number.text) then
		lw_dest.iuo_count = lw_dest.ioval[li_i]
		timer(0.25, lw_dest)
		return
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

public subroutine wf_question_announcer ();if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if

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
	st_2.visible = false
	ii_selected_dest = 0
	ii_selected_source = 0
end if

end subroutine

public subroutine wf_response (boolean ab_correct);w_container_number_match lw_tmp
ii_current_try++
SetPointer(HourGlass!)
if ab_correct then
	timer(0, iw_dest[1])
	iw_dest[1].wf_reset_backcolor()
	il_total_correct_answers[ii_current_question_id] = il_total_correct_answers[ii_current_question_id] + 1
	inv_sound_play.play_st_sound(is_wave_list[ii_current_question_id])
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

public function boolean wf_check_number (integer ai_count);if ai_count = ii_number_list[ii_current_question_id] then
	return true
else
	return false
end if
end function

public subroutine wf_get_new_item ();integer li_row
long ll_x, ll_y, ll_i, ll_hwn
integer li_dummy[], li_i
string ls_selected_item
uo_count_number iuo_tmp
li_dummy = {0, 13}	
w_lesson_numbermatch_count lw_dummy

ii_current_try = 0
ii_current_question_id++
il_total_tries[ii_current_question_id]++
//return
if ii_current_question_id > ii_total_items then

	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
//	wf_update_statistic()
	post wf_set_lesson_mode(false) // close container window
//	wf_check_batch()
	return
end if
integer li_count

iw_source[1].is_bean_PictureName = is_picture_list[ii_current_question_id]

w_container_number_match lw_tmp
li_count = ii_number_list[ii_current_question_id]
lw_tmp = iw_source[2]
lw_tmp.st_1.text = '?'		
iw_source[1].wf_set_count(li_count, 1, 0)

for ll_i = 1 to upperbound(iw_source[1].ioval)
	iw_source[1].ioval[ll_i].p_1.visible = false
	iw_source[1].ioval[ll_i].p_1.BringToTop = false
	iw_source[1].ioval[ll_i].BringToTop = true
	iw_source[1].ioval[ll_i].backcolor = f_getcolor(4)
next	
iw_source[1].Show()

wf_question_announcer()
w_container_dragdrop lw_tmp2
string ls_number_wave
if ii_prompt_ind > 1 then // hint or prompt
	for ll_i = 1 to iw_source[1].ii_bean_count
		iw_source[1].ioval[ll_i].backcolor = f_getcolor(6)
		ls_number_wave = string(ll_i) + ".wav"
		inv_sound_play.play_number_sound(ls_number_wave)
	next
end if
if ii_prompt_ind = 3 then // prompt
	wf_set_flash_for_prompt()
end if

end subroutine

public subroutine wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
integer li_row, li_source_row = 0, li_dest_row = 0, li_x_interval, li_y_interval, li_i
long ll_interval, ll_len

li_x_interval = width/10
li_y_interval = height/15
st_2.x = li_x_interval*3
st_2.y = li_y_interval + 180

open(iw_source[1], 'w_container_dragdrop', this)
iw_source[1].p_1.visible = false
ii_selected_source = 1
iw_source[1].x = li_x_interval
iw_source[1].y = li_y_interval
open(iw_source[2], 'w_container_number_match', this)				
iw_source[2].ib_target = true
iw_source[2].width = 480
iw_source[2].height = 420
iw_source[2].x = width - li_x_interval - iw_source[2].width
iw_source[2].y = iw_source[1].y + (iw_source[1].height - iw_source[2].height)/2
w_container_number_match lw_tmp
lw_tmp = iw_source[2]
lw_tmp.st_1.text = '?'		
lw_tmp.p_1.visible = false
lw_tmp.st_1.visible = true
lw_tmp.st_1.BringToTop = true

st_2.x = iw_source[1].x +  iw_source[1].width + (iw_source[2].x - iw_source[1].width - iw_source[1].x - st_2.width)/2
st_2.y = iw_source[1].y + (iw_source[1].height - st_2.height)/2

// make answer list
for li_i = 1 to upperbound(ii_number_list)
	ii_answer_list[li_i] = ii_number_list[li_i]
next
wf_sort_list(ii_answer_list)

open(iw_dest[1], 'w_container_number_match', this)
iw_dest[1].x = (this.width - iw_dest[1].width)/2
iw_dest[1].y = li_y_interval*8
iw_dest[1].wf_draw_number(ii_answer_list, 1, 0)
iw_source[1].Show()
iw_source[2].Show()
iw_dest[1].Show()
st_2.visible = true

end subroutine

on w_lesson_numbermatch_count.create
int iCurrent
call super::create
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
end on

on w_lesson_numbermatch_count.destroy
call super::destroy
destroy(this.st_2)
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

event dragwithin;call super::dragwithin;w_lesson_numbermatch_count lw_tmp
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
//	p_1.x = xpos
//	p_1.y = ypos
//end if
end event

event open;call super::open;st_1.visible = false
st_2.visible = false
p_1.visible = false
//post setredraw(false)

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
//	ib_file_loaded = false
//end if
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

type dw_reward from w_lesson`dw_reward within w_lesson_numbermatch_count
end type

type cb_close from w_lesson`cb_close within w_lesson_numbermatch_count
string tag = "1505030"
end type

type cb_start from w_lesson`cb_start within w_lesson_numbermatch_count
string tag = "1505030"
end type

event cb_start::clicked;call super::clicked;st_2.visible = true
end event

type dw_2 from w_lesson`dw_2 within w_lesson_numbermatch_count
string tag = "1505020"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_numbermatch_count
end type

type st_1 from w_lesson`st_1 within w_lesson_numbermatch_count
end type

type dw_1 from w_lesson`dw_1 within w_lesson_numbermatch_count
string tag = "1505010"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 14')
end if

end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_numbermatch_count
integer width = 987
end type

type st_2 from statictext within w_lesson_numbermatch_count
integer x = 2016
integer y = 392
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

