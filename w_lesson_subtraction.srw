$PBExportHeader$w_lesson_subtraction.srw
forward
global type w_lesson_subtraction from w_lesson
end type
type st_2 from statictext within w_lesson_subtraction
end type
type st_3 from statictext within w_lesson_subtraction
end type
type st_4 from statictext within w_lesson_subtraction
end type
type st_5 from statictext within w_lesson_subtraction
end type
end forward

global type w_lesson_subtraction from w_lesson
string tag = "1505000"
boolean titlebar = true
string title = "Subtraction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
event paint pbm_paint
event ue_agent_ready pbm_custom01
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
end type
global w_lesson_subtraction w_lesson_subtraction

type variables
integer ii_bean_drop_style
boolean ib_alternation_switch = false, ib_file_loaded = false
long il_handle, il_asciisize, il_binsize
ulong il_thread
string is_bitmap, is_data, is_empty

end variables

forward prototypes
public subroutine wf_question_announcer ()
public function boolean wf_check_number (integer ai_count)
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_set_flash (integer ai_index_begin, integer ai_index_end, integer ar_interval, ref w_container aw_container)
public subroutine wf_set_flash_for_prompt ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_response (boolean ab_correct)
public subroutine wf_get_new_item ()
public subroutine wf_init_container ()
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

public subroutine wf_question_announcer ();if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if

end subroutine

public function boolean wf_check_number (integer ai_count);if ai_count = integer(st_3.text) - integer(st_5.text) then
	return true
else
	return false
end if
end function

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	st_1.x = xpos
	st_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public subroutine wf_set_flash (integer ai_index_begin, integer ai_index_end, integer ar_interval, ref w_container aw_container);aw_container.ii_flash_index_begin = ai_index_begin
aw_container.ii_flash_index_end = ai_index_end
timer(0.25, aw_container)



end subroutine

public subroutine wf_set_flash_for_prompt ();integer li_i
w_container_number_match lw_tmp
if not ib_prompt then return
lw_tmp = iw_dest[1]
for li_i = 1 to upperbound(lw_tmp.ioval)
	if integer(st_3.text) - integer(st_5.text) = integer(lw_tmp.ioval[li_i].st_number.text) then
		lw_tmp.iuo_count = lw_tmp.ioval[li_i]
		lw_tmp.ii_flash_index_begin = li_i
		lw_tmp.ii_flash_index_end = li_i		
		timer(0.25, lw_tmp)
		return
	end if
next

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
	dw_prompt.visible = false
else
	if dw_prompt.RowCount() > 0 then
		dw_prompt.visible = true
	end if	
	st_1.visible = false
	st_2.visible = false
	st_3.visible = false
	st_4.visible = false
	st_5.visible = false

	for li_row = 1 to upperbound(iw_source)
		if isvalid(iw_source[li_row]) then iw_source[li_row].event close()
	next 
	for li_row = 1 to upperbound(iw_dest)
		if isvalid(iw_dest[li_row]) then iw_dest[li_row].event close()
	next 
end if

end subroutine

public subroutine wf_response (boolean ab_correct);w_container_number_match lw_tmp
string ls_answer
ii_current_try++
SetPointer(HourGlass!)
if ab_correct then
	timer(0, iw_dest[1])
	iw_dest[1].wf_reset_backcolor()
	il_total_correct_answers[ii_current_question_id] = il_total_correct_answers[ii_current_question_id] + 1
	ls_answer = string(integer(st_3.text) - integer(st_5.text)) + ".wav"
	inv_sound_play.play_number_sound(ls_answer)
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

public subroutine wf_get_new_item ();integer li_row 
long ll_x, ll_y, ll_i, ll_j, ll_item, ll_items[2]
integer li_dummy[]
string ls_selected_item
uo_count_number iuo_tmp
li_dummy = {0, 13}	
ii_current_try = 0
//if isvalid(gw_money_board) then
//	gw_money_board.BringToTop = true
//end if

ii_current_try = 0
if ii_trial_target > 0 then // pair up
	ii_current_question_id = ii_current_list_offset + ii_trial_target - 1
else
	ii_current_question_id++
end if
il_total_tries[ii_current_question_id]++
if ii_current_question_id > ii_total_items then
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
//	wf_update_statistic()
	post wf_set_lesson_mode(false) // close container window
//	wf_check_batch()
	return
end if
SetRedraw(false)
integer li_count
statictext lst[2]
lst = {st_3, st_5}

for ll_i = 1 to 2	
	ll_item = ll_i + ii_current_question_id - 1
	if ll_item > ii_total_items then ll_item = 1
	ll_items[ll_i] = ll_item
next
if ii_number_list[ll_items[1]] < ii_number_list[ll_items[2]] then 
	ll_item = ll_items[1]
	ll_items[1] = ll_items[2]
	ll_items[2] = ll_item
end if	
for ll_i = 1 to 2	
	li_count = ii_number_list[ll_items[ll_i]]
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
iw_source[2].wf_reset_count_size(iw_source[1].ioval[1].width, iw_source[1].ioval[1].height) 

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
	for ll_i = 1 to integer(st_3.text)
		iw_source[1].ioval[ll_i].backcolor = f_getcolor(3)
	next
	ls_number_wave = st_3.text + ".wav"
	inv_sound_play.play_number_sound(ls_number_wave)
//	wf_set_flash(1, integer(st_3.text), 0.25, iw_source[1])
	for ll_i = 1 to integer(st_5.text)
		iw_source[2].ioval[ll_i].backcolor = f_getcolor(6)
		iw_source[1].ioval[integer(st_3.text) - ll_i  + 1].backcolor = f_getcolor(4)
		ls_number_wave = string(integer(st_3.text) - ll_i) + ".wav"
		inv_sound_play.play_number_sound(ls_number_wave)
//		wf_set_flash(1, integer(st_3.text) - ll_i, 0.25, iw_source[1])
	next
end if
if ii_prompt_ind = 3 then
	wf_set_flash_for_prompt()
end if

end subroutine

public subroutine wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
integer li_row, li_source_row = 0, li_dest_row = 0, li_x_interval, li_y_interval, li_i

long ll_interval, ll_len
li_x_interval = width/7
li_y_interval = height/25 + 180
st_3.x = li_x_interval + st_3.width/2
st_4.x = li_x_interval*2 + st_3.width/2
st_5.x = li_x_interval*3 + st_3.width/2
st_2.x = li_x_interval*4 + st_3.width/2
st_3.y = li_y_interval
st_4.y = li_y_interval
st_5.y = li_y_interval
st_2.y = li_y_interval

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
//iw_source[2].Show()

open(iw_source[3], 'w_container_number_match', this)				
iw_source[3].ib_target = true
iw_source[3].width = 480
iw_source[3].height = 420
iw_source[3].x = li_x_interval*5 + st_3.width/2
iw_source[3].y = li_y_interval
w_container_number_match lw_tmp
lw_tmp = iw_source[3]
lw_tmp.st_1.text = '?'		
lw_tmp.p_1.visible = false
lw_tmp.st_1.visible = true
lw_tmp.st_1.BringToTop = true

//iw_source[3].Show()
for li_i = 1 to upperbound(ii_number_list)
	if li_i < upperbound(ii_number_list) then
		ii_answer_list[li_i] = abs(ii_number_list[li_i + 1] - ii_number_list[li_i])
	else
		ii_answer_list[li_i] = abs(ii_number_list[li_i] - ii_number_list[1])
	end if
//	MessageBox(string(li_i), "ii_number_list: " + string(ii_number_list[li_i]) + "ii_answer_list: " + string(ii_answer_list[li_i]))
next
wf_sort_list(ii_answer_list)
//MessageBox(string(upperbound(ii_answer_list)), string(ii_answer_list[upperbound(ii_answer_list)]))

open(iw_dest[1], 'w_container_number_match', this)
iw_dest[1].x = (this.width - iw_dest[1].width)/2
iw_dest[1].y = (li_y_interval - 180)*14
iw_dest[1].wf_draw_number(ii_answer_list, 1, 0)
iw_dest[1].Show()

end subroutine

on w_lesson_subtraction.create
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

on w_lesson_subtraction.destroy
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

event close;call super::close;long ll_i
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

type dw_reward from w_lesson`dw_reward within w_lesson_subtraction
end type

type cb_close from w_lesson`cb_close within w_lesson_subtraction
string tag = "1505030"
end type

type cb_start from w_lesson`cb_start within w_lesson_subtraction
string tag = "1505030"
end type

event cb_start::clicked;Setredraw(false)
super::event clicked()
p_1.visible = false
Setredraw(true)
end event

type dw_2 from w_lesson`dw_2 within w_lesson_subtraction
string tag = "1505020"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_subtraction
boolean visible = false
end type

type st_1 from w_lesson`st_1 within w_lesson_subtraction
end type

type dw_1 from w_lesson`dw_1 within w_lesson_subtraction
string tag = "1505010"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 24')
end if

end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_subtraction
integer width = 978
end type

type st_2 from statictext within w_lesson_subtraction
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

type st_3 from statictext within w_lesson_subtraction
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

type st_4 from statictext within w_lesson_subtraction
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
string text = "-"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_lesson_subtraction
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

