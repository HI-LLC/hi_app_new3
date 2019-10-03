$PBExportHeader$w_lesson_mw_cmmnd.srw
forward
global type w_lesson_mw_cmmnd from w_lesson
end type
type ln_1 from line within w_lesson_mw_cmmnd
end type
type ln_2 from line within w_lesson_mw_cmmnd
end type
end forward

global type w_lesson_mw_cmmnd from w_lesson
string tag = "1506000"
string title = "Lesson - Grouping"
ln_1 ln_1
ln_2 ln_2
end type
global w_lesson_mw_cmmnd w_lesson_mw_cmmnd

type variables
integer ii_bean_drop_style
boolean ib_alternation_switch = false
long il_source_container_id[], il_dest_container_id[]

end variables

forward prototypes
public function boolean wf_check_number (integer ai_count)
public subroutine wf_get_new_item ()
public subroutine wf_mousemove (integer xpos, integer ypos)
public subroutine wf_set_new_item (integer ai_drag_item)
public subroutine wf_question_announcer ()
public subroutine wf_init_container ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_response (boolean ab_correct)
end prototypes

public function boolean wf_check_number (integer ai_count);if ii_trial_target = 1 then // sequential
	if ai_count = ii_random_list[ii_current_question_id] then
		return true
	else
		return false
	end if
else
	return true
end if
end function

public subroutine wf_get_new_item ();integer li_row
long ll_x, ll_y, ll_i
integer li_dummy[]
string ls_selected_item
li_dummy = {0, 13}	
//if isvalid(gw_money_board) then
//	gw_money_board.BringToTop = true
//end if
ii_current_question_id++
il_total_tries[ii_current_question_id]++
if ii_current_question_id > ii_total_items then
	MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
	wf_set_lesson_mode(false)
//	wf_check_batch()
//	wf_update_statistic()
	return
end if
integer li_prev_dest
li_prev_dest = ii_selected_dest
ii_selected_dest = il_lesson_content_pair_ind[ii_current_question_id]
if ii_selected_dest > upperbound(iw_dest) then ii_selected_dest = upperbound(iw_dest)
iw_dest[li_prev_dest].ib_target = false
iw_dest[ii_selected_dest].ib_target = true

wf_question_announcer()
integer ii_id
ii_id = ii_random_list[ii_current_question_id]


end subroutine

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	p_1.x = xpos
	p_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public subroutine wf_set_new_item (integer ai_drag_item);long ll_x, ll_y, ll_i
ii_current_question_id = ai_drag_item
for ll_i = 1 to upperbound(iw_dest)
//	if il_lesson_content_pair_ind[ai_drag_item] = il_dest_container_id[ll_i] then
	if il_lesson_content_pair_ind[ai_drag_item] = iw_dest[ll_i].ii_id then
		iw_dest[ll_i].ib_target = true
	else
		iw_dest[ll_i].ib_target = false		
	end if
next
end subroutine

public subroutine wf_question_announcer ();//Instructon
if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if
if pos(is_wave_list[ii_random_list[ii_current_question_id]], ".wav") > 0 then
	inv_sound_play.play_st_sound(is_wave_list[ii_random_list[ii_current_question_id]])
else
	wf_play_video(is_wave_list[ii_random_list[ii_current_question_id]])
end if
//first preposition
if pos(is_preposition_1, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_preposition_1)
end if
if pos(is_source_wave_list[ii_selected_source], ".wav") > 0 then
	inv_sound_play.play_st_sound(is_source_wave_list[ii_selected_source])
end if	
// secod preposition
if pos(is_preposition_2, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_preposition_2)
end if
if pos(is_dest_wave_list[ii_selected_dest], ".wav") > 0 then
	inv_sound_play.play_st_sound(is_dest_wave_list[ii_selected_dest])
end if	
end subroutine

public subroutine wf_init_container ();string ls_tmp, ls_picture_ind, ls_text_ind, ls_source_ind, ls_selected_ind
integer li_row, li_source_row = 0, li_dest_row = 0, li_i, li_dest_count, li_dest_width, li_dest_height, li_valid_height
integer li_dest_layout_row, li_dest_layout_col, li_dest_layout_rowcount, li_dest_layout_colcount
integer li_height_interval, li_width_interval, li_remain
double ldb_layout_test
string ls_bitmap_path, ls_wavefile_path
if ids_lesson_container.RowCount() = 0 then
	MessageBox("wf_init_container", "no container")
	return
end if

//il_source_pair_ind[], il_dest_pair_ind[]
for li_row = 1 to ids_lesson_container.RowCount()
	ls_source_ind = ids_lesson_container.GetItemString(li_row, 'source_ind')
	if ls_source_ind = '1' then // source container
		li_source_row++
		is_source_picture_list[li_source_row] = ls_bitmap_path + ".\bitmap\" + ids_lesson_container.GetItemString(li_row, 'bitmap_file')
		is_source_wave_list[li_source_row] = ".\wave\" + ids_lesson_container.GetItemString(li_row, 'wave_file')
		is_source_bean_picture_list[li_source_row] = ".\bitmap\" + ids_lesson_container.GetItemString(li_row, 'bean_bitmap_file')
		is_source_bean_wave_list[li_source_row] = ".\wave\" + ids_lesson_container.GetItemString(li_row, 'bean_wave_file')
	else	// destination container
		li_dest_row++
		is_dest_picture_list[li_dest_row] = ".\bitmap\" + ids_lesson_container.GetItemString(li_row, 'bitmap_file')
		is_dest_wave_list[li_dest_row] = ".\wave\" + ids_lesson_container.GetItemString(li_row, 'wave_file')
		is_dest_selected_ind_list[li_dest_row] = ids_lesson_container.GetItemString(li_row, 'selected_ind')
		il_dest_container_id[li_dest_row] = ids_lesson_container.GetItemNumber(li_row, 'container_container_id')
		ls_tmp = ids_lesson_container.GetItemString(li_row, 'bean_drop_style')
//		ii_bean_drop_style = 0
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
for li_source_row = 1 to upperbound(is_source_picture_list)
	open(iw_source[li_source_row], 'w_container_twc', this)
	iw_source[li_source_row].ii_id = il_dest_container_id[li_dest_row]
	iw_source[li_source_row].hide()
	iw_source[li_source_row].x = this.x + (li_source_row - 1)*2*ll_interval + ll_interval - iw_source[li_source_row].width/2
	iw_source[li_source_row].y = ln_1.BeginY - 50//this.y + (this.width/2 - iw_source[li_source_row].width)/2
	iw_source[li_source_row].p_1.PictureName = is_source_picture_list[li_source_row]
	ii_selected_source = li_source_row
	iw_source[li_source_row].wf_set_count(upperbound(is_picture_list), 0, 0)
	iw_source[li_source_row].ib_source = true
	for li_i = 1 to upperbound(is_picture_list)
		iw_source[li_source_row].ioval[li_i].p_1.picturename = is_picture_list[li_i]
		iw_source[li_source_row].ioval[li_i].wf_object_zoom(1.5)
		iw_source[li_source_row].ioval[li_i].p_1.BringToTop = true			
	next
	iw_source[li_source_row].show()
next 
ii_degree = upperbound(is_picture_list)
wf_random_list()

ii_selected_dest = 1

//dest container layout
li_dest_count = upperbound(is_dest_picture_list)
li_valid_height = this.height - ln_2.BeginY
ldb_layout_test = li_dest_count
ldb_layout_test = sqrt(ldb_layout_test) 
li_dest_layout_rowcount = integer(truncate(ldb_layout_test, 0))

if ldb_layout_test > truncate(ldb_layout_test, 0) then
	li_dest_layout_colcount = integer(truncate(ldb_layout_test, 0)) + 1
	if li_dest_layout_colcount*li_dest_layout_rowcount < li_dest_count then 
		li_dest_layout_rowcount++
	end if
else
	li_dest_layout_colcount = integer(truncate(ldb_layout_test, 0))
end if
li_remain = (li_dest_layout_rowcount*li_dest_layout_colcount) - li_dest_count
//estimate width and height
// set the width and height based on width
li_width_interval = this.width/(li_dest_layout_colcount*4 + 1)
li_dest_width = li_width_interval*3
li_dest_height = (li_dest_width*4)/7
if li_dest_height > (li_valid_height/li_dest_layout_rowcount) then // set the width and height based on height
	li_height_interval = li_valid_height/(li_dest_layout_rowcount*6 + 1)
	li_dest_height = li_height_interval*5
	li_dest_width = (li_dest_height*7)/4
	li_width_interval = (this.width - (li_dest_width*li_dest_layout_colcount))/(li_dest_layout_colcount + 1)
else
	li_height_interval = (li_valid_height - (li_dest_height*li_dest_layout_rowcount))/(li_dest_layout_rowcount + 1)
end if
li_dest_layout_row = 0
for li_dest_row = 1 to upperbound(is_dest_picture_list)
	open(iw_dest[li_dest_row], 'w_container_twc', this)
	if mod(li_dest_row, li_dest_layout_colcount) = 1 then li_dest_layout_row++
	if mod(li_dest_row, li_dest_layout_colcount) = 0 then
		li_dest_layout_col = li_dest_layout_colcount
	else
		li_dest_layout_col = mod(li_dest_row, li_dest_layout_colcount)
	end if
	iw_dest[li_dest_row].hide()
	iw_dest[li_dest_row].ii_id = il_dest_container_id[li_dest_row]
	iw_dest[li_dest_row].width = li_dest_width
	iw_dest[li_dest_row].height = li_dest_height
	iw_dest[li_dest_row].ii_width = li_dest_width
	iw_dest[li_dest_row].ii_height = li_dest_height
	iw_dest[li_dest_row].p_1.width = li_dest_width
	iw_dest[li_dest_row].p_1.height = li_dest_height
	iw_dest[li_dest_row].p_1.PictureName = is_dest_picture_list[li_dest_row]
	iw_dest[li_dest_row].y = ln_2.BeginY + li_height_interval*li_dest_layout_row + (li_dest_layout_row - 1)*li_dest_height
	if li_dest_layout_row < li_dest_layout_rowcount then	
		iw_dest[li_dest_row].x = li_width_interval*li_dest_layout_col + (li_dest_layout_col - 1)*li_dest_width
	else
		li_width_interval = (this.width - (li_dest_layout_colcount - li_remain)*li_dest_width)/(li_dest_layout_colcount - li_remain + 1)
		iw_dest[li_dest_row].x = li_width_interval*li_dest_layout_col + (li_dest_layout_col - 1)*li_dest_width
	end if
	iw_dest[li_dest_row].wf_init_draw_bean(upperbound(is_picture_list), 0)
	iw_dest[li_dest_row].show()
next 




end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);super::wf_set_lesson_mode(ab_lesson_on)
if ab_lesson_on then	
	dw_prompt.visible = false
else
//	if dw_prompt.RowCount() > 0 then
//		dw_prompt.visible = true
//	end if	

	integer li_row
	for li_row = 1 to upperbound(iw_source)
		if isvalid(iw_source[li_row]) then iw_source[li_row].event close()
	next 
	for li_row = 1 to upperbound(iw_dest)
		if isvalid(iw_dest[li_row]) then iw_dest[li_row].event close()
	next 
	ii_selected_dest = 0
	ib_alternation_switch = false
end if
end subroutine

public subroutine wf_response (boolean ab_correct);boolean lb_all_moved = true
integer li_i
if ii_trial_target <> 1 then il_total_tries[ii_current_question_id]++
if ab_correct then
	if ii_trial_target = 1 then
		inv_sound_play.play_st_sound(is_response_to_right)
	END IF
	il_total_correct_answers[ii_current_question_id] = il_total_correct_answers[ii_current_question_id] + 1
	if ii_current_question_id > ii_total_items then return
	if isvalid(gw_money_board) then
		gw_money_board.wf_add_credit()
	end if
	if ii_trial_target = 1 then
		wf_get_new_item()
	else
		for li_i = 1 to upperbound(iw_source[1].ioval)
			if isvalid(iw_source[1].ioval[li_i]) then
				if iw_source[1].ioval[li_i].visible then
					lb_all_moved = false
					exit
				end if
			end if
		next		
		if lb_all_moved then				
			inv_sound_play.play_st_sound(is_response_to_right)
			timer(0, this)
			MessageBox("Lesson", "End of the lesson, click Start button to restart the lesson!")
			wf_set_lesson_mode(false)
//			wf_check_batch()
//			wf_update_statistic()
			return
		end if
	end if
else
	if pos(is_response_to_wrong, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_response_to_wrong)
	else
		wf_play_video(is_response_to_wrong)
	end if
end if


end subroutine

on w_lesson_mw_cmmnd.create
int iCurrent
call super::create
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
this.Control[iCurrent+2]=this.ln_2
end on

on w_lesson_mw_cmmnd.destroy
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

event dragwithin;call super::dragwithin;w_lesson_mw_cmmnd lw_tmp
long li_x, li_y
str_mousepos i_mousepos
GetCursorPos(i_mousepos)
//MessageBox("w_lesson_mw_cmmnd", "dragwithin")
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
end if
end event

event open;call super::open;
p_1.visible = false
st_1.visible = false
end event

event timer;call super::timer;//Instructon
if pos(is_instruction, ".wav") > 0 then
	inv_sound_play.play_st_sound(is_instruction)
else
	wf_play_video(is_instruction)
end if

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

type dw_reward from w_lesson`dw_reward within w_lesson_mw_cmmnd
end type

type cb_close from w_lesson`cb_close within w_lesson_mw_cmmnd
string tag = "1506030"
end type

type cb_start from w_lesson`cb_start within w_lesson_mw_cmmnd
string tag = "1506030"
end type

event cb_start::clicked;Constant Long WindowPosFlags = 83 // = SWP_NOACTIVATE + SWP_SHOWWINDOW + SWP_NOMOVE + SWP_NOSIZE
Constant Long HWND_TOPMOST = -1
Constant Long HWND_NOTOPMOST = -2
long ll_student_id
integer li_width, li_height
wf_set_lesson_mode(true)
ii_current_question_id = 0
wf_init_lesson()
wf_init_container()
if ii_trial_target = 1 then // SEQUENTIAL
	wf_get_new_item()
else
//Instructon
	if pos(is_instruction, ".wav") > 0 then
		inv_sound_play.play_st_sound(is_instruction)
	else
		wf_play_video(is_instruction)
	end if
	timer(10, parent)
end if

end event

type dw_2 from w_lesson`dw_2 within w_lesson_mw_cmmnd
string tag = "1506020"
end type

event dw_2::itemchanged;call super::itemchanged;long ll_lesson_id
ll_lesson_id = long(data)
if (ids_lesson.Retrieve(ll_lesson_id) > 0 ) and (ids_lesson_container.Retrieve(ll_lesson_id) > 0 ) then
	cb_start.enabled = true
end if
end event

type p_1 from w_lesson`p_1 within w_lesson_mw_cmmnd
end type

type st_1 from w_lesson`st_1 within w_lesson_mw_cmmnd
end type

type dw_1 from w_lesson`dw_1 within w_lesson_mw_cmmnd
string tag = "1506010"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name = 'student' then
	wf_lesson_filter('method_id = 16')
end if
end event

type dw_prompt from w_lesson`dw_prompt within w_lesson_mw_cmmnd
integer width = 997
end type

type ln_1 from line within w_lesson_mw_cmmnd
boolean visible = false
integer linethickness = 1
integer beginx = 91
integer beginy = 112
integer endx = 2450
integer endy = 112
end type

type ln_2 from line within w_lesson_mw_cmmnd
boolean visible = false
integer linethickness = 1
integer beginx = 110
integer beginy = 1120
integer endx = 2469
integer endy = 1120
end type

