$PBExportHeader$w_lesson_dragdrop_count.srw
forward
global type w_lesson_dragdrop_count from w_lesson
end type
type ln_1 from line within w_lesson_dragdrop_count
end type
type ln_2 from line within w_lesson_dragdrop_count
end type
end forward

global type w_lesson_dragdrop_count from w_lesson
string tag = "1504000"
string title = "Lesson - Drag-drop Counting"
ln_1 ln_1
ln_2 ln_2
end type
global w_lesson_dragdrop_count w_lesson_dragdrop_count

type variables
integer ii_bean_drop_style, ii_step = 0
boolean ib_alternation_switch = false
boolean ib_clicked = false
boolean ib_moving = false
end variables

forward prototypes
public function boolean wf_check_number (integer ai_count)
public subroutine wf_get_new_item ()
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_question_announcer ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_response ()
public subroutine wf_init_container ()
end prototypes

public function boolean wf_check_number (integer ai_count);if ai_count = ii_number_list[ii_current_question_id] then
	return true
else
	return false
end if
end function

public subroutine wf_get_new_item ();integer li_row
long ll_x, ll_y, ll_i
integer li_dummy[]
li_dummy = {0, 13}	

ii_current_question_id++
if ii_current_question_id > ii_total_items then
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	wf_set_lesson_mode(false)
	return
end if
wf_random_list()
for li_row = 1 to upperbound(iw_dest)
	if isvalid(iw_dest[li_row]) then
		iw_dest[li_row].wf_init_draw_bean(ii_number_list[ii_current_question_id], 0)
	end if
next 
integer li_prev_dest
if ib_alternation_switch then
	li_prev_dest = ii_selected_dest
	ii_selected_dest = ii_selected_dest + 1
	if ii_selected_dest = 3 then
		ii_selected_dest = 1
	end if
	iw_dest[ii_selected_dest].ib_target = true
	iw_dest[li_prev_dest].ib_target = false
end if
SetPointer(HourGlass!)
wf_question_announcer()


end subroutine

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	p_1.x = xpos
	p_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public subroutine wf_question_announcer ();inv_sound_play.play_st_sound(is_instruction)
inv_sound_play.play_st_sound(is_wave_list[ii_current_question_id])
inv_sound_play.play_st_sound(is_source_bean_wave_list[ii_selected_source])

//if (not isnull(is_preposition_1) and (len(trim(is_preposition_1)) > 0) then
//	inv_sound_play.play_st_sound(is_preposition_1)
//	inv_sound_play.play_st_sound(is_source_wave_list[ii_selected_source])
//end if
//if (not isnull(is_preposition_2)) and (len(trim(is_preposition_2)) > 0) then
//	inv_sound_play.play_st_sound(is_preposition_2)
//	inv_sound_play.play_st_sound(is_dest_wave_list[ii_selected_dest])
//end if


if pos(lower(is_preposition_1), ".wav") > 0 then
	inv_sound_play.play_st_sound(is_preposition_1)
	inv_sound_play.play_st_sound(is_source_wave_list[ii_selected_source])
end if
if pos(lower(is_preposition_2), ".wav") > 0 then
	inv_sound_play.play_st_sound(is_preposition_2)
	inv_sound_play.play_st_sound(is_dest_wave_list[ii_selected_dest])
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
		iw_source[li_row].event close()
	next 
	for li_row = 1 to upperbound(iw_dest)
		iw_dest[li_row].event close()
	next 
	ii_selected_dest = 0
	ib_alternation_switch = false
end if
end subroutine

public subroutine wf_response ();string ls_1st_letter, ls_word, ls_dict_sound_file
ls_word = is_text_list[ii_current_question_id]
if pos(is_response_to_right, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_response_to_right)
else
	wf_play_video(is_response_to_right)
end if
if pos(is_wave_list[ii_current_question_id], ".wav") > 0 then
	inv_sound_play.play_st_sound(is_wave_list[ii_current_question_id])
elseif pos(is_wave_list[ii_current_question_id], "DICTIONARY") > 0 then
	ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "numbers\" + ls_word + ".wav"
	if FileExists(ls_dict_sound_file) then
		sndPlaySoundA(ls_dict_sound_file, 0)
	else
		MessageBox("Error", "Sound file - " + ls_dict_sound_file + " does not exist!")
	end if
end if
inv_sound_play.play_st_sound(is_source_bean_wave_list[ii_selected_source])
if isvalid(gw_money_board) then
	gw_money_board.wf_add_credit()
end if
integer li_source_list[], li_dest_list[], li_i, li_j = 0
//MessageBox("Good Job!", "Next Number")
for li_i = 1 to upperbound(iw_source[ii_selected_source].ioval)
	if iw_source[ii_selected_source].ioval[li_i].visible = false then	
		li_j++
		li_source_list[li_j] = li_i
	end if
next
li_j = 0
for li_i = 1 to upperbound(iw_dest[ii_selected_dest].ioval)
	if isvalid(iw_dest[ii_selected_dest].ioval[li_i]) then		
		li_j++
		li_dest_list[li_j] = li_i
	end if
next
integer li_width, li_height
for li_i = 1 to upperbound(li_dest_list)
	iw_dest[ii_selected_dest].ioval[li_dest_list[li_i]].BringToTop = false
	iw_dest[ii_selected_dest].ioval[li_dest_list[li_i]].visible = false
	destroy iw_dest[ii_selected_dest].ioval[li_dest_list[li_i]]
	iw_source[ii_selected_source].ioval[li_source_list[li_i]].visible = true
	li_width = iw_source[ii_selected_source].ioval[li_source_list[li_i]].ii_width
	li_height = iw_source[ii_selected_source].ioval[li_source_list[li_i]].ii_height
	iw_source[ii_selected_source].ioval[li_source_list[li_i]].width = li_width
	iw_source[ii_selected_source].ioval[li_source_list[li_i]].height = li_height
	sndPlaySoundA(gn_appman.is_app_path + ".\wave\" + string(li_i)+".wav", 0)
next
st_1.visible = false
iw_dest[ii_selected_dest].ii_bean_count = 0
//ii_number_list[ii_current_question_id]
wf_get_new_item()

end subroutine

public subroutine wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
integer li_row, li_source_row = 0, li_dest_row = 0
string ls_bitmap_path, ls_wavefile_path
if ids_lesson_container.RowCount() = 0 then
	MessageBox("wf_init_container", "no container")
	return
end if
for li_row = 1 to ids_lesson_container.RowCount()
	ls_source_ind = ids_lesson_container.GetItemString(li_row, 'source_ind')
	if ls_source_ind = '1' then // source container
		li_source_row++
		is_source_picture_list[li_source_row] = ".\bitmap\" + ids_lesson_container.GetItemString(li_row, 'bitmap_file')
		is_source_wave_list[li_source_row] = ".\wave\" + ids_lesson_container.GetItemString(li_row, 'wave_file')
		is_source_bean_picture_list[li_source_row] = ".\bitmap\" + ids_lesson_container.GetItemString(li_row, 'bean_bitmap_file')
		is_source_bean_wave_list[li_source_row] = ".\wave\" + ids_lesson_container.GetItemString(li_row, 'bean_wave_file')
	else	// destination container
		li_dest_row++
		is_dest_picture_list[li_dest_row] = ".\bitmap\" + ids_lesson_container.GetItemString(li_row, 'bitmap_file')
		is_dest_wave_list[li_dest_row] = ".\wave\" + ids_lesson_container.GetItemString(li_row, 'wave_file')
		is_dest_selected_ind_list[li_dest_row] = ids_lesson_container.GetItemString(li_row, 'selected_ind')
		ls_tmp = ids_lesson_container.GetItemString(li_row, 'bean_drop_style')
		if not isnull(ls_tmp) then
			ii_bean_drop_style = integer(ls_tmp)
		else
			ii_bean_drop_style = 0
		end if
	end if
next

long ll_interval, ll_len
ll_interval = this.width/(upperbound(is_source_picture_list)*2)
ln_1.visible = false
ln_2.visible = false

ln_1.BeginY = ln_1.BeginY + 180
ln_2.BeginY = ln_2.BeginY + 180
for li_source_row = 1 to upperbound(is_source_picture_list)
	open(iw_source[li_source_row], 'w_container_dragdrop', this)
	iw_source[li_source_row].hide()
	iw_source[li_source_row].x = this.x + (li_source_row - 1)*2*ll_interval + ll_interval - iw_source[li_source_row].width/2
	iw_source[li_source_row].y = ln_1.BeginY - 50//this.y + (this.width/2 - iw_source[li_source_row].width)/2
	iw_source[li_source_row].p_1.PictureName = is_source_picture_list[li_source_row]
	if (not isnull(is_source_bean_picture_list[li_source_row])) and len(is_source_bean_picture_list[li_source_row]) > 0 then
//		MessageBox("Bean", is_source_bean_picture_list[li_source_row])
		ii_selected_source = li_source_row
		ll_len = len(is_source_bean_picture_list[li_source_row])
		iw_source[li_source_row].is_bean_PictureName = is_source_bean_picture_list[li_source_row]
//		iw_source[li_source_row].is_bean_DragIcon = gn_appman.is_bitmap_path + left(is_source_bean_picture_list[li_source_row], ll_len - 3) + 'ico'
		iw_source[li_source_row].wf_set_count(20, 1, 0)
		iw_source[li_source_row].ib_source = true
	end if
	iw_source[li_source_row].show()
next 
ii_selected_dest = 0
ll_interval = this.width/(upperbound(is_dest_picture_list)*2)
for li_dest_row = 1 to upperbound(is_dest_picture_list)
	open(iw_dest[li_dest_row], 'w_container_dragdrop', this)
//	iw_dest[li_dest_row].hide()
	iw_dest[li_dest_row].x = this.x + (li_dest_row - 1)*2*ll_interval + ll_interval - iw_dest[li_dest_row].width/2
	iw_dest[li_dest_row].y = ln_2.BeginY //this.y + (this.width/2 - iw_dest[li_source_row].width)/2 + this.width/2
	iw_dest[li_dest_row].p_1.PictureName = is_dest_picture_list[li_dest_row]
	if (not isnull(is_dest_selected_ind_list[li_dest_row])) and is_dest_selected_ind_list[li_dest_row] = '1' then
		ii_selected_dest = li_dest_row
		iw_dest[li_dest_row].ib_target = true
	end if
	iw_dest[li_dest_row].show()
next 
if ii_selected_dest = 0 then
	ib_alternation_switch = true
	ii_selected_dest = 1
end if
end subroutine

on w_lesson_dragdrop_count.create
int iCurrent
call super::create
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
this.Control[iCurrent+2]=this.ln_2
end on

on w_lesson_dragdrop_count.destroy
call super::destroy
destroy(this.ln_1)
destroy(this.ln_2)
end on

event dragdrop;call super::dragdrop;uo_count iuo_tmp

if source.classname() = 'uo_count_dragdrop' then
	p_1.visible = false
	ib_drag = false
	iuo_tmp = source
	iuo_tmp.visible = true
	iuo_tmp.width = iuo_tmp.ii_width
	iuo_tmp.height = iuo_tmp.ii_height		
end if
end event

event dragwithin;call super::dragwithin;w_lesson_dragdrop_count lw_tmp
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

event mousemove;call super::mousemove;if ib_drag then
	p_1.x = xpos
	p_1.y = ypos
//	if ib_moving then
//		MessageBox("mousemove x", string(xpos))
//	end if
end if

end event

event open;call super::open;//ids_lesson_container = create datastore
//ids_lesson_container.dataobject = 'd_lesson_container'
//ids_lesson_container.SetTransObject(SQLCA)

p_1.visible = false
st_1.visible = false

long ll_x, ll_y, ll_i, ll_cur_x, ll_cur_y, ll_tmp_y
//
//ll_x = dw_1.x + (dw_1.width) + WorkspaceX() - 80
//ll_y = dw_1.y + WorkSpaceY() - 70 // + (dw_1.height) - 20
//ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
//ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
//MessageBox("ll_x " + string(ll_x), "ll_y " + string(ll_y))
//gnvo_is.post of_move_cursor(ll_x, ll_y, 10, 2, false, false)
//gnvo_is.post of_lb_down()
//gnvo_is.post of_lb_up()


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

type dw_reward from w_lesson`dw_reward within w_lesson_dragdrop_count
end type

type cb_close from w_lesson`cb_close within w_lesson_dragdrop_count
string tag = "1504030"
end type

type cb_start from w_lesson`cb_start within w_lesson_dragdrop_count
string tag = "1504030"
end type

type dw_2 from w_lesson`dw_2 within w_lesson_dragdrop_count
event dwndropdown pbm_dwndropdown
string tag = "1504020"
boolean minbox = true
end type

event dw_2::dwndropdown;//gnvo_is.of_move_cursor(0, 30, 50, 2, false, true)
//timer(3)

end event

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) and (ids_lesson_container.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if

long ll_x, ll_y, ll_i, ll_cur_x, ll_cur_y, ll_tmp_y

ll_x = cb_start.x + (cb_start.width)/2 + parent.WorkspaceX() 
ll_y = cb_start.y + parent.WorkSpaceY()  + (cb_start.height)/2 - 20
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)

//MessageBox("ll_x " + string(ll_x), "ll_y " + string(ll_y))
//gnvo_is.of_move_cursor(ll_x, ll_y, 10, 2, false, false)
////time(2)
//gnvo_is.of_lb_down()
//gnvo_is.of_lb_up()
end event

type p_1 from w_lesson`p_1 within w_lesson_dragdrop_count
end type

type st_1 from w_lesson`st_1 within w_lesson_dragdrop_count
integer width = 645
integer height = 428
integer textsize = -48
end type

type dw_1 from w_lesson`dw_1 within w_lesson_dragdrop_count
event dwndropdown pbm_dwndropdown
string tag = "1504010"
end type

event dw_1::dwndropdown;//gnvo_is.of_move_cursor(0, 30, 50, 2, false, true)
//
//
////gnvo_is.of_lb_up()
////GetChild("student", ldwc)
////post SetItem(1, "student", ll_student_id)
//
////gnvo_is.post of_lb_down()
////gnvo_is.post of_lb_up()
////
//
//timer(2)
//
end event

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 15')
end if

//long ll_x, ll_y, ll_i, ll_cur_x, ll_cur_y, ll_tmp_y
//
//ll_x = dw_2.x + (dw_2.width) + parent.WorkspaceX() - 80
//ll_y = dw_2.y + parent.WorkSpaceY()  + (dw_2.height) - 20
//ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
//ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
//
//gnvo_is.of_move_cursor(ll_x, ll_y, 10, 2, false, false)
//gnvo_is.of_lb_down()
//gnvo_is.of_lb_up()
end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_dragdrop_count
integer width = 992
end type

type ln_1 from line within w_lesson_dragdrop_count
boolean visible = false
integer linethickness = 1
integer beginx = 91
integer beginy = 112
integer endx = 2450
integer endy = 112
end type

type ln_2 from line within w_lesson_dragdrop_count
boolean visible = false
integer linethickness = 1
integer beginx = 110
integer beginy = 1120
integer endx = 2469
integer endy = 1120
end type

