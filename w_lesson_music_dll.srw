$PBExportHeader$w_lesson_music_dll.srw
forward
global type w_lesson_music_dll from w_lesson
end type
type st_2 from statictext within w_lesson_music_dll
end type
type st_3 from statictext within w_lesson_music_dll
end type
type st_4 from statictext within w_lesson_music_dll
end type
type st_11 from statictext within w_lesson_music_dll
end type
type cb_start_record from commandbutton within w_lesson_music_dll
end type
type cb_play_demo from commandbutton within w_lesson_music_dll
end type
type cb_save from commandbutton within w_lesson_music_dll
end type
type cb_playback from commandbutton within w_lesson_music_dll
end type
type cbx_note_sound from checkbox within w_lesson_music_dll
end type
type pb_1 from picturebutton within w_lesson_music_dll
end type
type pb_2 from picturebutton within w_lesson_music_dll
end type
type cb_3 from commandbutton within w_lesson_music_dll
end type
type st_start from st_1 within w_lesson_music_dll
end type
type st_end from st_1 within w_lesson_music_dll
end type
type cbx_keyboard from checkbox within w_lesson_music_dll
end type
type sle_beat_rate from singlelineedit within w_lesson_music_dll
end type
type st_5 from statictext within w_lesson_music_dll
end type
type sle_1 from singlelineedit within w_lesson_music_dll
end type
type cb_1 from commandbutton within w_lesson_music_dll
end type
type pb_3 from picturebutton within w_lesson_music_dll
end type
type uo_1 from uo_music_sheet within w_lesson_music_dll
end type
type sle_2 from singlelineedit within w_lesson_music_dll
end type
type cbx_finger_hint from checkbox within w_lesson_music_dll
end type
type cb_2 from commandbutton within w_lesson_music_dll
end type
type cb_4 from commandbutton within w_lesson_music_dll
end type
end forward

global type w_lesson_music_dll from w_lesson
string tag = "1508000"
integer width = 4768
integer height = 2284
string title = ""
boolean border = false
integer ii_current_i = 1
event ue_get_player_handle pbm_custom01
event ue_key_played pbm_custom02
event ue_record_msg pbm_custom03
event ue_get_player_bound pbm_custom04
st_2 st_2
st_3 st_3
st_4 st_4
st_11 st_11
cb_start_record cb_start_record
cb_play_demo cb_play_demo
cb_save cb_save
cb_playback cb_playback
cbx_note_sound cbx_note_sound
pb_1 pb_1
pb_2 pb_2
cb_3 cb_3
st_start st_start
st_end st_end
cbx_keyboard cbx_keyboard
sle_beat_rate sle_beat_rate
st_5 st_5
sle_1 sle_1
cb_1 cb_1
pb_3 pb_3
uo_1 uo_1
sle_2 sle_2
cbx_finger_hint cbx_finger_hint
cb_2 cb_2
cb_4 cb_4
end type
global w_lesson_music_dll w_lesson_music_dll

type variables
integer ii_bean_drop_style, ii_char_index =  1, ii_high_note, ii_low_note
boolean ib_alternation_switch = false
boolean ib_missing_list[]
boolean ib_note_clicked = false
boolean ib_play_demo = false

string is_finger_prompt = "00"
string is_current_mask, is_current_distraction, is_the_missing_word
integer ii_current_state = 0
long il_reading_question_id
integer ii_current_scroll = 0

integer ii_current_note = 1
integer ii_begin_note = 2, ii_end_note
integer ii_BeginX, ii_BeginY, ii_EndX, ii_EndY, ii_orig_width, ii_orig_height,ii_p_1_y_orig = -2000
integer ii_midi_input = 0, ii_midi_output = 0
double idb_width_ratio,idb_height_ratio
long il_player_handle = 0, il_player_handle_lh = 0

// midi recording and playing back
long il_midi_data[], il_midi_time[], il_data_count = 0
double idb_beat_rate, idb_beat_duration, idb_note_per_beat
double idb_right_note_duration[5], idb_left_note_duration[5]
long il_beat_rate, il_note_beat_denomitor
boolean ib_busy_token = false // to control code flow
boolean ib_playing_token = true // to control code flow
boolean ib_playing_demo = false
boolean ib_sound_seperation = false
boolean ib_left_hand_exists=false,ib_right_exists=false,ib_both_exists=false
boolean ib_data_process = false

string is_empty_note = ""
string is_current_note = ""

string is_rh_text_list[], is_lh_text_list[], is_bh_text_list[]
integer ii_rh_text_count = 0, ii_lh_text_count = 0, ii_bh_text_count = 0
string is_rh_wave_list[], is_lh_wave_list[], is_bh_wave_list[]
string is_rh_picture_list[], is_lh_picture_list[], is_bh_picture_list[]

string is_cur_wave_list[], is_cur_picture_list[], is_cur_text_list[]
string is_cur_mid_lesson = "dummy.mid"

string is_left_dev_name = "", is_right_dev_name = ""
string is_midi_input_dev_name = "", is_midi_output_dev_name = ""

integer ii_cur_text_count, ii_cur_piece

integer ii_rh_list_demo[],ii_lh_list_demo[],ii_bh_list_demo[],ii_empty_list[],ii_rh_count_demo,ii_lh_count_demo,ii_bh_count_demo
str_rect win_rect // music player window position


//beat_rate = beats/minute or beats/second
//example:
//beat_rate = 100 beats/minute = 100 beats/60 second = 1.667 beats/second
//beat_duration = 1/beat_rate = 60 second /100 beats = 0.6 second/beat
//beat_note = note/beat
//example:
//beat_note = 1/4 means quater note gets one beat
//          = 1/8 means one eighth note gets one beat
//note_duration = (note / beat_note) * beat_duration
//
//Full Example:
//beat_rate = 100 beats/minute = 100 beats/60 seconds
//beat_note = 1/4 (note/beat)
//
//for an half note (1/2, 2/4), find the time duration
//note = 1/2 note
//note_duration 
//= (note / idb_note_per_beat) * idb_beat_duration
//= (1/2 note / (1/4 note/beat) *  0.6 second/beat
//= 2 beats * 0.6 second/beat = 1.2 seconds

// 0 - "None", 
// 1 - "RH Note Prompt", 
// 2 - "RH Key Prompt", 
// 3 - "RH Note and Key Prompt", 
// 4 - "RH Prompt With Demo", &								
// 5 - "LH Note Prompt", 
// 6 - "LH Key Prompt", 
// 7 - "LH Note and Key Prompt", 
// 8 - "LH Prompt With Demo", &
// 9 - "Both Note Prompt", 
//10 - "Both Key Prompt", 
//11 - "Both Note and Key Prompt", 
//12 - "Both Prompt With Demo"}		

//integer il_current_repeat
//integer il_repeat

str_music_repeat istr_empty,istr_cur_repeat[],istr_bh_repeat[],istr_both_repeat[],istr_lh_repeat[],istr_rh_repeat[]
ulong iul_dll_handle

end variables

forward prototypes
public subroutine wf_init_container ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_get_new_item ()
public function integer wf_rec_move (string as_note)
public function string wf_seq_to_note (integer ai_seq)
public subroutine wf_reset_pos ()
public function integer wf_note_to_seq (string as_note)
public function boolean wf_note_clicked (integer ai_x, integer ai_y)
public subroutine wf_get_high_low_notes ()
public function integer wf_get_note_num (integer ai_bar, integer ai_x, integer ai_y)
public function integer wf_set_measure_range (integer ai_bar, integer ai_x, integer ai_y)
public subroutine wf_set_bar (integer ai_bar, integer ai_note)
public subroutine wf_set_token (boolean ab_value)
public function integer wf_get_rh_lh_note_list ()
public function integer wf_set_current_data_array ()
public function integer wf_save_mdi ()
public function integer wf_play_demo ()
public function integer wf_play_back ()
public function integer wf_build_demo_note_entry (string as_current_note)
public function boolean wf_validate_demo_note (integer ai_note)
public subroutine wf_fresh_bring_to_top ()
public function integer wf_check_repeat (integer ai_i)
public subroutine wf_set_prompt_list (integer al_method_id)
public subroutine wf_adjust_bars (integer ai_bar, integer ai_x_delta, integer ai_y_delta)
public subroutine wf_scroll_sheet (integer ai_delta)
public subroutine wf_reset_pic_coord ()
end prototypes

event ue_get_player_handle;long ll_pb_win_handle
string ls_shmem_buf
string ls_device1 = "SoundMAX Digital Audio"
string ls_device2 = "SSS USB Headphone Set"

//MessageBox("1024", ib_sound_seperation)
//return

if wparam = 1 then
	il_player_handle = lparam
	if ib_sound_seperation then // launch another piano for left hand sound
		Sleep(5)
		ll_pb_win_handle = handle(this)
		ls_shmem_buf = string(ll_pb_win_handle, "00000000") + string(ii_prompt_ind, "00") + string(ii_low_note, "000")  + string(ii_high_note,"000")
		ls_shmem_buf = ls_shmem_buf + "02"  + is_finger_prompt + is_left_dev_name// + space(82 - len(ls_device2))
		extSetMusicNoteToSharedMemory(ls_shmem_buf) // set variable in share memory for MusicLesson.exe to pick up
		run("MusicLesson.exe " + is_startupfile)
	else // if it's not sound seperation, start the lesson rightaway
//		MessageBox("ue_get_player_handle", "a")
		Sleep(2)
		cb_start.enabled = true
		cb_start.post event clicked()
//		ii_begin_note = 2
//		ii_end_note = upperbound(is_cur_text_list)
		post wf_set_bar(1, ii_begin_note)
		post wf_set_bar(2, ii_end_note)
	end if
end if
ShowWindow(il_keyboard_handle, 5)
if ib_sound_seperation and wparam = 2 then
	il_player_handle_lh = lparam
	Send(il_player_handle, 1051, 0, il_player_handle_lh) // send the primary piano module the handle for secondary module
	cb_start.enabled = true
	cb_start.post event clicked()
	ii_begin_note = 2
	ii_end_note = upperbound(is_cur_text_list)
//	post wf_set_bar(1, ii_begin_note)
//	post wf_set_bar(2, ii_end_note)
end if
return 1
end event

event ue_key_played;string ls_note_to_keyboard, ls_local_filename, ls_text, ls_shmem_buf
double ldb_note_duration
long ll_note_duration = 0
long ll_i, ll_pb_win_handle, il_thread_id
integer li_check_repeat

if ib_playing_demo then return 0
if ib_busy_token then return 0

li_check_repeat = wf_check_repeat(ii_current_note)
if li_check_repeat = 0 then
	ii_current_note++
else
	ii_current_note = li_check_repeat
end if

//for ll_i = 1 to 10
//	Yield()
//	Sleep(0.01)
//next
//timer(1, this)
//MessageBox("ue_key_played", "1")
//	sle_2.text = string(ii_current_note) + " " + string(ii_end_note)

if ii_current_note <= ii_end_note then
	if pos(lower(is_cur_picture_list[ii_current_note]),".jpg") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".bmp") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".gif") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".png") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".tif") > 0 then
		ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + string(ii_current_note, "000") + right(is_cur_picture_list[ii_current_note], 4)
		f_GetCacheResourceFile(is_cur_picture_list[ii_current_note], ls_local_filename)
		uo_1.p_1.PictureName = ls_local_filename
		wf_reset_pic_coord()
//		uo_1.p_1.y = 1
	end if
	yield()
	if idb_right_note_duration[1] > 0.0 then
		ll_note_duration = idb_right_note_duration[1]*1000
	end if
	if idb_left_note_duration[1] > 0.0 then
		ll_note_duration = idb_left_note_duration[1]*1000
	end if
	BringWindowToTop(il_player_handle)
	extSetMusicNoteToSharedMemory(is_empty_note)
	Send(il_player_handle, 1025, 0, 0)

	if ii_prompt_ind <> 0 and  mod(ii_prompt_ind, 2) <> 2 then // not 0 and not 2
		wf_rec_move(is_cur_text_list[ii_current_note])
	end if
	ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note], 17, len(is_cur_text_list[ii_current_note]) - 16)
//	sle_2.text = ls_note_to_keyboard
	extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
	send(il_player_handle, 1025, 0, 0)
else
//	MessageBox("ii_prompt_ind", ii_prompt_ind)
	Sleep(2)
//	extSetMusicNoteToSharedMemory(is_empty_note)
//	Send(il_player_handle, 1025, 0, 0)
	ii_current_note = ii_begin_note
	ls_note_to_keyboard = right(is_cur_text_list[ii_current_note], len(is_cur_text_list[ii_current_note]) - 16)
	extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
	Send(il_player_handle, 1025, 0, 0)
	Send(il_player_handle, 1027, ii_prompt_ind, 0)
	cb_start.enabled = true
	cb_start.visible = true
	cb_close.visible = true
	if mod(ii_prompt_ind, 4) = 0 and ii_prompt_ind > 0 then
		sleep(1)
		cb_play_demo.post event clicked()
	else
		ii_current_note = ii_begin_note
//		Send(handle(uo_1),277,6,0) // 6=TOP, 2=UP 3 DOWN
		ls_text = trim(is_cur_text_list[ii_current_note])
		if ii_prompt_ind > 1 then
			wf_rec_move(ls_text)	
		end if
		if ii_begin_note = 2 then
			cb_3.event clicked()
		end if
//		wf_set_bar(1, ii_begin_note)
//		wf_set_bar(2, ii_end_note)

//		Send(il_player_handle, 1026, 0, 0)

		ll_pb_win_handle = handle(this)
		//ii_prompt_ind = 0
		//ib_sound_seperation = true
		ls_shmem_buf = string(ll_pb_win_handle, "00000000") + string(ii_prompt_ind, "00") + string(ii_low_note, "000")  + string(ii_high_note,"000")
		ls_shmem_buf = ls_shmem_buf + "01"  + is_finger_prompt + is_right_dev_name// + space(82 - len(ls_device1))
		
		extSetMusicNoteToSharedMemory(ls_shmem_buf) // set variable in share memory for MusicLesson.exe to pick up
//		run("MusicLesson.exe " + is_startupfile)
		if not IsWindow(il_player_handle) then
			extStartPianoThread(ll_pb_win_handle,is_startupfile,il_thread_id)
		else
			Send(il_player_handle, 1032, 0, 0)
			ShowWindow(il_player_handle, 5)
		end if
//		SetDlgSignal()

	end if
end if
return 1
end event

event ue_record_msg;if ib_playing_demo then return 
il_midi_data[upperbound(il_midi_data) + 1] = lparam
il_midi_time[upperbound(il_midi_time) + 1] = cpu()
il_data_count++

end event

event ue_get_player_bound;integer li_win_pixel_height
if wparam = 1 then win_rect.left = lparam 
if wparam = 2 then win_rect.right = lparam 
if wparam = 3 then win_rect.top = lparam 
if wparam = 4 then 
	win_rect.bottom = lparam 
//	li_win_pixel_height = UnitsToPixels(height + WorkSpaceY(), YUnitsToPixels!)
//	Post(il_player_handle, 1031,li_win_pixel_height,0)
//	MessageBox("win_rect", "l:" + string(win_rect.left) + " r:" + string(win_rect.right) + "t:" + string(win_rect.top) + " b:" + string(win_rect.bottom))
end if
	
end event

public subroutine wf_init_container ();long il_row
string ls_local_filename
gs_vedio_file = "NO"

if upperbound(is_picture_list) > 0 then // obtain original picture demension
	ii_orig_width = integer(left(is_text_list[1], 4))
	ii_orig_height = integer(mid(is_text_list[1], 5, 4))
	idb_width_ratio = double(uo_1.p_1.width/ii_orig_width)
	idb_height_ratio = double(uo_1.p_1.height/ii_orig_height)
//	uo_1.p_1.y = uo_1.y + 20
end if
//if pos(is_text_list[1], "F") > 0 then 
//	is_finger_prompt = "01"
//	cbx_finger_hint.visible = true
//else
//	is_finger_prompt = "00"
//	cbx_finger_hint.visible = false
//end if
if len(is_text_list[1]) >= 12 then
	il_note_beat_denomitor = long(mid(is_text_list[1], 9, 2))
else
	il_note_beat_denomitor = 0
end if

//post wf_reset_pos()

end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);super::wf_set_lesson_mode(ab_lesson_on)
cb_close.visible = true
//if ab_lesson_on then return
//integer li_row
//for li_row = 1 to upperbound(iw_source)
//	if isvalid(iw_source[li_row]) then
//		iw_source[li_row].event close()
////		if isvalid(iw_source[li_row]) then destroy iw_source[li_row]
//	end if
//next 
//for li_row = 1 to upperbound(iw_dest)
//	if isvalid(iw_dest[li_row]) then		
//		iw_dest[li_row].event close()
////		if isvalid(iw_dest[li_row]) then destroy iw_dest[li_row]
//	end if
//next 
//ii_selected_dest = 0
//ii_selected_source = 0
end subroutine

public subroutine wf_get_new_item ();integer li_row,li_col, li_row_count, li_i, li_j, li_count, li_x, li_y, li_width, li_height, li_allowed_height, li_char_ind = 0
integer li_adjusted_height = 0
string ls_process_words, ls_scrambled_word[], ls_word_list[], ls_wave_list[], ls_bitmap_list[]
string ls_selected_item, ls_tmp, ls_hint
long ll_x, ll_y, ll_i, ll_width
integer li_choice_list[]
w_container lw_empty[]

end subroutine

public function integer wf_rec_move (string as_note);string ls_note_to_keyboard 
integer i,total_note_count=0,right_hand_note_count=0,left_hand_note_count=0;
integer right_hand_notes[5],left_hand_notes[5]
integer right_note_fraction[5], right_note_denomitor[5],left_note_fraction[5], left_note_denomitor[5]
integer li_y_adjust

ls_note_to_keyboard = right(as_note, len(as_note) - 16)

SetRedraw(false)

total_note_count = len(ls_note_to_keyboard)/8
right_hand_note_count = total_note_count/2
left_hand_note_count = total_note_count/2

if mod(total_note_count, 2) =1 then
	right_hand_note_count++
end if

il_beat_rate = long(sle_beat_rate.text)
if il_beat_rate > 0 then
	idb_beat_duration = 60.0/double(il_beat_rate)
else
	idb_beat_duration = 0.0
end if
if il_note_beat_denomitor > 0 then
	idb_note_per_beat = 1.0/double(il_note_beat_denomitor)
end if

for i= 1 to 5
	idb_right_note_duration[i] = 0.0
	idb_left_note_duration[i] = 0.0
next 
for i=1 to right_hand_note_count
	right_hand_notes[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 5, 2))
	right_note_denomitor[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 1, 2))
	right_note_fraction[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 3, 2))
	if il_beat_rate > 0 and il_note_beat_denomitor > 0 and right_note_denomitor[i] > 0 then
		idb_right_note_duration[i] = ((double(right_note_fraction[i])/double(right_note_denomitor[i]))/idb_note_per_beat)*idb_beat_duration		
	end if
	sle_1.text = string(idb_right_note_duration[i])
//	sle_1.text = string(right_note_fraction[i]) + " | " + string(right_note_denomitor[i]) 
next

for i=1 to left_hand_note_count
	left_hand_notes[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 13, 2))
	left_note_denomitor[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 9, 2))
	left_note_fraction[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 11, 2))
	if il_beat_rate > 0 and il_note_beat_denomitor > 0 and left_note_denomitor[i] > 0 then
		idb_left_note_duration[i] = ((double(left_note_fraction[i])/double(left_note_denomitor[i]))/idb_note_per_beat)*idb_beat_duration		
	end if
	sle_1.text = string(idb_left_note_duration[i])
//	sle_1.text = string(left_note_fraction[i]) + " | " + string(left_note_denomitor[i]) 
//	sle_1.text = ls_note_to_keyboard 
next


uo_1.st_11.text = ""
uo_1.st_4.text = ""

if right_hand_note_count > 0 then
	if right_hand_notes[1] > 0 then
		uo_1.st_11.text = wf_seq_to_note(right_hand_notes[1])	
	end if
end if

if left_hand_note_count > 0 then
	if left_hand_notes[1] > 0 then
		uo_1.st_4.text = wf_seq_to_note(left_hand_notes[1])	
	end if
end if

//MessageBox("p_1.y wf_rec_move", p_1.y)

ii_BeginX = integer(mid(as_note, 1, 4))*idb_width_ratio + uo_1.p_1.x
ii_EndX = integer(mid(as_note, 9, 4))*idb_width_ratio + uo_1.p_1.x

integer ii_BeginY_prev,ii_EndY_prev
ii_BeginY_prev = ii_BeginY
ii_EndY_prev = ii_EndY
ii_BeginY = integer(mid(as_note, 5, 4))*idb_height_ratio + uo_1.p_1.y
ii_EndY = integer(mid(as_note, 13, 4))*idb_height_ratio + uo_1.p_1.y	

// re-adjust Y
// 

li_y_adjust = (ii_EndY - ii_BeginY)*3/7

if ib_both_exists then
	if ii_cur_piece = 1 then // right hand music adjust bottom
		ii_EndY = ii_EndY - li_y_adjust
	end if
	if ii_cur_piece = 2 then // left hand music adjust top
		ii_BeginY = ii_BeginY + li_y_adjust
	end if	
end if

uo_1.st_11.x = ii_BeginX
uo_1.st_11.y = ii_BeginY
uo_1.st_11.width = ii_EndX + 10 - ii_BeginX
uo_1.st_11.height = 80

uo_1.st_2.x = ii_BeginX
uo_1.st_2.y = ii_BeginY
uo_1.st_2.width = 10
uo_1.st_2.height = ii_EndY - ii_BeginY

uo_1.st_3.x = ii_EndX
uo_1.st_3.y = ii_BeginY
uo_1.st_3.width = 10
uo_1.st_3.height = ii_EndY - ii_BeginY

uo_1.st_4.x = ii_BeginX
uo_1.st_4.y = ii_EndY
uo_1.st_4.width = ii_EndX + 10 - ii_BeginX
uo_1.st_4.height = 80

if ii_current_note > 2 and ii_EndY_prev <> ii_EndY and &
	ii_EndY + WorkSpaceY() > PixelsToUnits(win_rect.top,YPixelsToUnits!) then // move picture up
	wf_scroll_sheet(ii_EndY - ii_EndY_prev)
end if


post wf_fresh_bring_to_top()

uo_1.st_11.BringToTop = true
uo_1.st_2.BringToTop = true
uo_1.st_3.BringToTop = true
uo_1.st_4.BringToTop = true
uo_1.visible = true
SetRedraw(true)
//MessageBox("1","1")
return 1
end function

public function string wf_seq_to_note (integer ai_seq);integer li_i
string ls_level
string ls_note_list[] = {"C","C","D","D","E","F","F","G","G","A","A","B"}
string ls_sharp_list[] = {"","#","","#","","","#","","#","","#",""}

if ai_seq >= 12 and ai_seq <= 23 then
	ls_level = ""
elseif ai_seq >= 24 and ai_seq <= 35 then
	ls_level = "0"
elseif ai_seq >= 36 and ai_seq <= 47 then
	ls_level = "1"
elseif ai_seq >= 48 and ai_seq <= 59 then
	ls_level = "2"
elseif ai_seq >= 60 and ai_seq <= 71 then
	ls_level = "3"
elseif ai_seq >= 72 and ai_seq <= 83 then
	ls_level = "4"
elseif ai_seq >= 84 and ai_seq <= 95 then
	ls_level = "5"
end if

li_i = mod(ai_seq, 12) + 1
ls_level = ""
return ls_note_list[li_i] + ls_level + ls_sharp_list[li_i]

end function

public subroutine wf_reset_pos ();long ll_pb_win_handle, il_thread_id
string ls_shmem_buf
string ls_title = "Piano"
string ls_dll_name, ls_dll_func_name
ls_dll_name = "MusicLesson.dll"
ll_pb_win_handle = handle(this)
ulong lul_startPlayer, llextStartPianoThread

ii_prompt_ind = dw_prompt.GetItemNumber(1, "prompt_ind")
dw_prompt.Modify("prompt_ind.dddw.Lines=13")
//MessageBox("wf_reset_post",ii_prompt_ind)
if not ib_data_process then // First time call to process left-right note
	ib_data_process = true	

	if pos(is_text_list[1], "F") > 0 then // finger prompt
		is_finger_prompt = "01"
		cbx_finger_hint.visible = true
	else
		is_finger_prompt = "00"
		cbx_finger_hint.visible = false
	end if	
	wf_get_rh_lh_note_list()
//MessageBox("wf_reset_post","4")
	if ib_both_exists then
		if ii_prompt_ind < 0 or ii_prompt_ind > 12 then
			ii_prompt_ind = 11
		end if
	elseif ib_right_exists then
		if ii_prompt_ind < 0 or ii_prompt_ind > 5 then
			ii_prompt_ind = 4
		end if
	else // Left Hand
		if ii_prompt_ind <> 0 and (ii_prompt_ind < 5 or ii_prompt_ind > 8) then
			ii_prompt_ind = 7
		end if
	end if 
	
	sle_2.text = sle_2.text + " ii_prompt_ind:" + string(ii_prompt_ind)
	
	if dw_prompt.RowCount() < 1 then dw_prompt.InsertRow(0)
	
	dw_prompt.SetItem(1, "prompt_ind", ii_prompt_ind)
end if

wf_set_current_data_array()
wf_get_high_low_notes()	
ii_begin_note = 2
ii_end_note = upperbound(is_cur_text_list)	
ls_shmem_buf = string(ll_pb_win_handle, "00000000") + string(ii_prompt_ind, "00") + string(ii_low_note, "000")  + string(ii_high_note,"000")
ls_shmem_buf = ls_shmem_buf + "01"  + is_finger_prompt + is_right_dev_name// + space(82 - len(ls_device1))
extSetMusicNoteToSharedMemory(ls_shmem_buf) // set variable in share memory for MusicLesson.exe to pick up
MessageBox("is_right_dev_name", is_right_dev_name)
//run("MusicLesson.exe " + is_startupfile)
if not IsWindow(il_player_handle) then
	extStartPianoThread(ll_pb_win_handle,is_startupfile,il_thread_id)
else
	Send(il_player_handle, 1032, 0, 0)
	ShowWindow(il_player_handle, 5)
end if
visible = true
//MessageBox("Multi-Threading Test", ls_shmem_buf)
uo_1.x = 40
uo_1.width = width - 120
uo_1.height = height - 200
ii_p_1_y_orig = uo_1.p_1.y
cb_start.visible = true
ib_playing_token = true

end subroutine

public function integer wf_note_to_seq (string as_note);integer li_i, ll_level, li_seq
string ls_note_list[] = {"C","C","D","D","E","F","F","G","G","A","A","B"}

for li_i = 1 to 12
	if left(as_note, 1) = ls_note_list[li_i] then exit
next
if pos(as_note, "#") > 0 then li_i++

if pos(as_note, "1") > 0 then
	ll_level = 1
elseif pos(as_note, "2") > 0 then
	ll_level = 2
elseif pos(as_note, "3") > 0 then
	ll_level = 3
elseif pos(as_note, "4") > 0 then
	ll_level = 4
elseif pos(as_note, "5") > 0 then
	ll_level = 5
else
	ll_level = 0
end if
	
li_seq = 12*(ll_level + 2) + li_i - 1

return li_seq
end function

public function boolean wf_note_clicked (integer ai_x, integer ai_y);integer li_BeginX, li_BeginY, li_EndX, li_EndY

if not st_11.visible then return false

li_BeginX = st_11.x - uo_1.p_1.x
li_BeginY = st_11.y - uo_1.p_1.y 
li_EndX = st_3.x - uo_1.p_1.x
li_EndY = st_4.y - uo_1.p_1.y

if ai_x >= li_BeginX and ai_x <= li_EndX and ai_y >= li_BeginY and ai_y <= li_EndY then
	return true
end if

return false

end function

public subroutine wf_get_high_low_notes ();integer i,total_note_count=0,right_hand_note_count=0,left_hand_note_count=0
integer right_hand_notes[5],left_hand_notes[5]
integer li_current_note, li_note
string ls_note_to_keyboard 

//trim(is_cur_text_list[ii_current_note])

//ii_high_note = 36
//ii_low_note = 84

ii_high_note = 36
ii_low_note = 84


for li_current_note = 2 to upperbound(is_cur_text_list)
	ls_note_to_keyboard = right(is_cur_text_list[li_current_note], len(is_cur_text_list[li_current_note]) - 16)
//	MessageBox(string(li_current_note), ls_note_to_keyboard)
	total_note_count = len(ls_note_to_keyboard)/8
	right_hand_note_count = total_note_count/2
	left_hand_note_count = total_note_count/2
	if mod(total_note_count, 2) =1 then
		right_hand_note_count++
	end if
	for i=1 to right_hand_note_count
		right_hand_notes[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 5, 2))
		if right_hand_notes[i] > ii_high_note and right_hand_notes[i] > 0 then ii_high_note = right_hand_notes[i]
		if right_hand_notes[i] < ii_low_note and right_hand_notes[i] > 0 then ii_low_note = right_hand_notes[i]
	next
	for i=1 to left_hand_note_count
		left_hand_notes[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 13, 2))
		if left_hand_notes[i] > ii_high_note and left_hand_notes[i] > 0 then ii_high_note = left_hand_notes[i]
		if left_hand_notes[i] < ii_low_note and left_hand_notes[i] > 0 then ii_low_note = left_hand_notes[i]
	next
	if right_hand_note_count > 0 then
		if right_hand_notes[1] > 0 then
			st_11.text = wf_seq_to_note(right_hand_notes[1])	
		end if
	end if
	
	if left_hand_note_count > 0 then
		if left_hand_notes[1] > 0 then
			st_4.text = wf_seq_to_note(left_hand_notes[1])	
		end if
	end if
next

//MessageBox("wf_get_high_low_notes", "H: " + string(ii_high_note) + " L: " + string(ii_low_note))

end subroutine

public function integer wf_get_note_num (integer ai_bar, integer ai_x, integer ai_y);// wf_get_note_num: called by set bar

integer li_current_note//, li_note
integer li_BeginX, li_BeginY, li_EndX, li_EndY, li_width, li_height

// set car depending on right hand or left hand
//ii_prompt_ind 
if ai_bar = 1 then // begin bar
	for li_current_note = 2 to upperbound(is_cur_text_list)
		li_BeginX = integer(mid(is_cur_text_list[li_current_note], 1, 4))*idb_width_ratio + uo_1.p_1.x
		li_BeginY = integer(mid(is_cur_text_list[li_current_note], 5, 4))*idb_height_ratio + uo_1.p_1.y
		li_EndX = integer(mid(is_cur_text_list[li_current_note], 9, 4))*idb_width_ratio + uo_1.p_1.x
		li_EndY = integer(mid(is_cur_text_list[li_current_note], 13, 4))*idb_height_ratio + uo_1.p_1.y
		li_width = li_EndX - li_BeginX
		li_height = li_EndY - li_BeginY
		if ai_y >= li_BeginY and ai_y <= li_EndY then
			if ai_x < li_BeginX then
				return li_current_note
			end if
		end if
	next
end if
if ai_bar = 2 then // end bar
	for li_current_note = upperbound(is_cur_text_list) to 2 step -1 
		li_BeginX = integer(mid(is_cur_text_list[li_current_note], 1, 4))*idb_width_ratio + uo_1.p_1.x
		li_BeginY = integer(mid(is_cur_text_list[li_current_note], 5, 4))*idb_height_ratio + uo_1.p_1.y
		li_EndX = integer(mid(is_cur_text_list[li_current_note], 9, 4))*idb_width_ratio + uo_1.p_1.x
		li_EndY = integer(mid(is_cur_text_list[li_current_note], 13, 4))*idb_height_ratio + uo_1.p_1.y
		li_width = li_EndX - li_BeginX
		li_height = li_EndY - li_BeginY
		if ai_y >= li_BeginY and ai_y <= li_EndY then
			if ai_x > li_EndX then
				return li_current_note
			end if
		end if
	next
end if
		
return 0
	
end function

public function integer wf_set_measure_range (integer ai_bar, integer ai_x, integer ai_y);integer i,total_note_count=0,right_hand_note_count=0,left_hand_note_count=0
integer right_hand_notes[5],left_hand_notes[5]
integer li_current_note, li_note
string ls_note_to_keyboard 

//trim(is_text_list[ii_current_note])

li_note = wf_get_note_num(ai_bar, ai_x, ai_y)

if li_note = 0 then
//	MessageBox("Error", "Invalid Position Drop")
	return 0
end if
if ai_bar = 1 then // begin bar
	if li_note > ii_end_note then // begin bar cannot be greater than end bar
//		MessageBox("Error", "Begin Bar Cannot Be Greater Than End Bar")
		return 0
	end if
	ii_begin_note = li_note
	cb_start.event clicked()
	wf_set_bar(ai_bar, ii_begin_note)
	wf_set_bar(2, ii_end_note)
else				// end bar
	if li_note < ii_begin_note then // begin bar cannot be greater than end bar
		return 0
	end if	
	ii_end_note = li_note
	wf_set_bar(ai_bar, ii_end_note)
end if

return 1
end function

public subroutine wf_set_bar (integer ai_bar, integer ai_note);integer li_current_note//, li_note
integer li_BeginX, li_BeginY, li_EndX, li_EndY, li_width, li_height
string ls_note_to_keyboard

li_current_note = ai_note
//MessageBox(string(ai_note), upperbound(is_cur_text_list))
li_BeginX = integer(mid(is_cur_text_list[li_current_note], 1, 4))*idb_width_ratio + uo_1.p_1.x
li_BeginY = integer(mid(is_cur_text_list[li_current_note], 5, 4))*idb_height_ratio + uo_1.p_1.y
li_EndX = integer(mid(is_cur_text_list[li_current_note], 9, 4))*idb_width_ratio + uo_1.p_1.x
li_EndY = integer(mid(is_cur_text_list[li_current_note], 13, 4))*idb_height_ratio + uo_1.p_1.y
li_width = li_EndX - li_BeginX
li_height = li_EndY - li_BeginY
if ai_bar = 1 then // begin bar
	uo_1.st_start.x = li_BeginX - li_width/2
	uo_1.st_start.y = li_BeginY
	uo_1.st_start.height = li_height
	ii_begin_note = ai_note
//	wf_rec_move(is_cur_text_list[li_current_note])
//	MessageBox("wf_set_bar ii_begin_note", ii_begin_note)

	wf_rec_move(is_cur_text_list[ii_begin_note])
//	ls_note_to_keyboard = right(is_cur_text_list[li_current_note], len(is_cur_text_list[li_current_note]) - 16)
//	Send(il_player_handle, 1027, ii_prompt_ind, 0)
	ls_note_to_keyboard = mid(is_cur_text_list[ii_begin_note], 17, len(is_cur_text_list[ii_begin_note]) - 16)
//	if mod(len(ls_note_to_keyboard)/8, 2) = 1 then ls_note_to_keyboard = ls_note_to_keyboard + "00000000"
	extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
	Send(il_player_handle, 1025, 0, 0)
	uo_1.st_start.BringToTop = true
	uo_1.st_end.BringToTop = true
	uo_1.st_start.visible = true
	uo_1.st_end.visible = true
else
	uo_1.st_end.x = li_EndX + li_width/2
	uo_1.st_end.y = li_BeginY
	uo_1.st_end.height = li_height
	uo_1.st_end.BringToTop = true
	uo_1.st_start.BringToTop = true
	uo_1.st_start.visible = true
	uo_1.st_end.visible = true
	ii_end_note = ai_note
end if
	
end subroutine

public subroutine wf_set_token (boolean ab_value);//
ib_busy_token = ab_value
end subroutine

public function integer wf_get_rh_lh_note_list ();integer li_i, li_j, li_first_head = 0, li_second_head = 0, li_first_tail = 0, li_second_tail = 0
integer li_l,li_r,li_b,li_l_begin,li_r_begin,li_b_begin,li_l_end,li_r_end,li_b_end
integer li_total_note_count, li_right_hand_note_count, li_left_hand_note_count
string ls_note_to_keyboard, ls_note, ls_note_wing
boolean lb_true_note

for li_i = 2 to upperbound(is_text_list)
	if pos(is_text_list[li_i], "repeat") > 0 then continue
	ls_note_to_keyboard = mid(is_text_list[li_i], 17, len(is_text_list[li_i]) - 16)
	li_total_note_count = len(ls_note_to_keyboard)/8
	li_right_hand_note_count = li_total_note_count/2
	li_left_hand_note_count = li_total_note_count/2
	if(mod(li_total_note_count, 2) = 1) then
		li_right_hand_note_count = li_right_hand_note_count + 1
	end if
	for li_j = 1 to li_right_hand_note_count
		ls_note = mid(ls_note_to_keyboard, 16*(li_j - 1) + 1, 8)
		if ls_note <> "00000000" then ib_right_exists = true
	next
	for li_j = 1 to li_left_hand_note_count
		ls_note = mid(ls_note_to_keyboard, 16*(li_j - 1) + 9, 8)
		if ls_note <> "00000000" then ib_left_hand_exists = true
	next
next

if ib_left_hand_exists and ib_right_exists then ib_both_exists = true

li_l_begin = 2
li_r_begin = 2
li_b_begin = 2

//MessageBox("title", title)
is_rh_text_list[1] = is_text_list[1]
is_lh_text_list[1] = is_text_list[1]
is_bh_text_list[1] = is_text_list[1]
is_rh_wave_list[1] = is_wave_list[1]
is_lh_wave_list[1] = is_wave_list[1]
is_bh_wave_list[1] = is_wave_list[1]
is_rh_picture_list[1] = is_picture_list[1]
is_lh_picture_list[1] = is_picture_list[1]
is_bh_picture_list[1] = is_picture_list[1]

for li_i = 2 to upperbound(is_text_list)
	if trim(is_text_list[li_i]) = "repeatBegin" then
		if upperbound(is_lh_text_list) > 1 then
			li_l_begin = upperbound(is_lh_text_list) + 1
		end if
		if upperbound(is_rh_text_list) > 1 then
			li_r_begin = upperbound(is_rh_text_list) + 1
		end if
		if upperbound(is_bh_text_list) > 1 then
			li_b_begin = upperbound(is_bh_text_list) + 1
		end if
		continue
	end if
	if trim(is_text_list[li_i]) = "repeatEnd" then
		if upperbound(is_rh_text_list) > 1 then
			li_r = upperbound(istr_rh_repeat) + 1
			istr_rh_repeat[li_r].repeatEnd = upperbound(is_rh_text_list)
			istr_rh_repeat[li_r].repeatBegin = li_r_begin
			istr_rh_repeat[li_r].played = false
		end if
		if upperbound(is_lh_text_list) > 1 then
			li_l = upperbound(istr_lh_repeat) + 1
			istr_lh_repeat[li_l].repeatEnd = upperbound(is_lh_text_list)
			istr_lh_repeat[li_l].repeatBegin = li_l_begin
			istr_lh_repeat[li_l].played = false
		end if
		if upperbound(is_bh_text_list) > 1 then
			li_b = upperbound(istr_bh_repeat) + 1
			istr_bh_repeat[li_b].repeatEnd = upperbound(is_bh_text_list)
			istr_bh_repeat[li_b].repeatBegin = li_b_begin
			istr_bh_repeat[li_b].played = false
		end if
		continue
	end if
	if ib_both_exists then
		is_bh_text_list[upperbound(is_bh_text_list) + 1] = is_text_list[li_i]
		is_bh_wave_list[upperbound(is_bh_wave_list) + 1] = is_wave_list[li_i]
		is_bh_picture_list[upperbound(is_bh_picture_list) + 1] = is_picture_list[li_i]
	end if
	ls_note_to_keyboard = mid(is_text_list[li_i], 17, len(is_text_list[li_i]) - 16)
//	MessageBox(string(li_i), is_text_list[li_i])
	li_total_note_count = len(ls_note_to_keyboard)/8
	li_right_hand_note_count = li_total_note_count/2
	li_left_hand_note_count = li_total_note_count/2
	if(mod(li_total_note_count, 2) = 1) then
		li_right_hand_note_count = li_right_hand_note_count + 1
	end if
	lb_true_note = false
	ls_note_wing = ""
	for li_j = 1 to li_right_hand_note_count
		ls_note = mid(ls_note_to_keyboard, 16*(li_j - 1) + 1, 8)
		if ls_note <> "00000000" then
			lb_true_note = true
		end if
		ls_note_wing = ls_note_wing + ls_note
		if li_j < li_right_hand_note_count then
			ls_note_wing = ls_note_wing + "00000000"
		end if
	next
	if lb_true_note then
		is_rh_text_list[upperbound(is_rh_text_list) + 1] = left(is_text_list[li_i], 16) + ls_note_wing
		is_rh_wave_list[upperbound(is_rh_wave_list) + 1] = is_wave_list[li_i]
		is_rh_picture_list[upperbound(is_rh_picture_list) + 1] = is_picture_list[li_i]
	end if
	lb_true_note = false
	ls_note_wing = ""
	for li_j = 1 to li_left_hand_note_count
		ls_note = mid(ls_note_to_keyboard, 16*(li_j - 1) + 9, 8)
		if ls_note <> "00000000" then
			lb_true_note = true
		end if
		ls_note_wing = ls_note_wing + "00000000" + ls_note 
	next
	if lb_true_note then
		is_lh_text_list[upperbound(is_lh_text_list) + 1] = left(is_text_list[li_i], 16) + ls_note_wing
		is_lh_wave_list[upperbound(is_lh_wave_list) + 1] = is_wave_list[li_i]
		is_lh_picture_list[upperbound(is_lh_picture_list) + 1] = is_picture_list[li_i]
	end if
next
ii_rh_text_count = upperbound(is_rh_text_list)
ii_lh_text_count = upperbound(is_lh_text_list)
ii_bh_text_count = upperbound(is_bh_text_list)

wf_set_prompt_list(40)
//int li_FileNum
//li_FileNum = FileOpen("music_entry", LineMode!, Write!, LockWrite!, Replace!)		
//string ls_buf
//for li_i = 1 to upperbound(is_text_list)
//	ls_buf = string(li_i, "000") + " " + is_text_list[li_i]
//	FileWrite(li_FileNum, ls_buf)
//next
//FileClose(li_FileNum)
return 1
end function

public function integer wf_set_current_data_array ();// description: set right, left, or both as the current data array

//string is_rh_text_list[], is_lh_text_list[]
//integer ii_rh_text_count = 0, ii_lh_text_count = 0
//string is_rh_wave_list[], is_lh_wave_list[]
//string is_rh_picture_list[], is_lh_picture_list[]

//string is_cur_wave_list[], is_cur_picture_list[], is_cur_text_list[]
//integer ii_cur_text_count

// 0 - "None", 
// 1 - "RH Note Prompt", 
// 2 - "RH Key Prompt", 
// 3 - "RH Note and Key Prompt", 
// 4 - "RH Prompt With Demo", &								
// 5 - "LH Note Prompt", 
// 6 - "LH Key Prompt", 
// 7 - "LH Note and Key Prompt", 
// 8 - "LH Prompt With Demo", &
// 9 - "Both Note Prompt", 
//10 - "Both Key Prompt", 
//11 - "Both Note and Key Prompt", 
//12 - "Both Prompt With Demo"}		
if isnull(ii_prompt_ind) then ii_prompt_ind = 0
if ii_prompt_ind < 0 then ii_prompt_ind = 0
if ii_prompt_ind = 0 or ii_prompt_ind >= 9 then // both hand
	is_cur_text_list = is_bh_text_list
	is_cur_wave_list = is_bh_wave_list
	is_cur_picture_list = is_bh_picture_list
	ii_cur_piece = 3
	is_cur_mid_lesson = "both_" + is_lesson_name
	istr_cur_repeat = istr_bh_repeat
elseif ii_prompt_ind >= 1 and ii_prompt_ind <= 4 then // right hand
	is_cur_text_list = is_rh_text_list
	is_cur_wave_list = is_rh_wave_list
	is_cur_picture_list = is_rh_picture_list
	is_cur_mid_lesson = "right_" + is_lesson_name
	ii_cur_piece = 1
	istr_cur_repeat = istr_rh_repeat
elseif ii_prompt_ind >= 5 and ii_prompt_ind <= 8 then // left hand
	is_cur_text_list = is_lh_text_list
	is_cur_wave_list = is_lh_wave_list
	is_cur_picture_list = is_lh_picture_list
	is_cur_mid_lesson = "left_" + is_lesson_name
	ii_cur_piece = 2
	istr_cur_repeat = istr_lh_repeat
end if
//MessageBox("wf_set_current_data_array is_cur_text_list", upperbound(is_cur_text_list))
//MessageBox("wf_set_current_data_array is_text_list", upperbound(is_text_list))
is_cur_mid_lesson = is_lesson_name
return 1 
end function

public function integer wf_save_mdi ();// save recorded MIDI file
long ll_init_time, ll_time_interval
integer li_i
long li_data_count_right = 0
long li_data_count_left = 0
long li_data_count_both = 0
long li_data_count_total
long ll_file_len1, ll_current_blob_pos = 1
integer li_file_num
string ls_file_name
boolean lb_file_available = false
blob lblb_data_tmp, lblb_data_right, lblb_data_left, lblb_data_both, lblb_data_final
//blob{8000} lblb_data_combo
blob lblb_data_combo
blob lblb_data_played
// open existing file and parse the music MIDI into right, left, and both

ls_file_name = is_cur_mid_lesson + ".mdi"

if il_data_count = 0 then
	MessageBox("Error", "No Data To Be Saved!")
	return 0
end if

if FileExists(ls_file_name) then // local file exists
	lb_file_available = true
end if

if lb_file_available then
	ll_file_len1 = FileLength(ls_file_name)
	li_file_num = FileOpen(ls_file_name, StreamMode!, Read!)
	FileRead(li_file_num, lblb_data_tmp)
	FileClose(li_file_num)
	li_data_count_right = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	if li_data_count_right > 0 then
		lblb_data_right = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_right)
		ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_right
	end if
	li_data_count_left = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	if li_data_count_left > 0 then
		lblb_data_left = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_left)
		ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_left
	end if
	li_data_count_both = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	if li_data_count_both > 0 then
		lblb_data_both = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_both)
		ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_both
	end if
end if

//ll_data_count = upperbound(il_midi_data)
lblb_data_played = Blob(space(il_data_count*2* 4))
ll_current_blob_pos = 1

//BlobEdit ( lblb_data_played, ll_current_blob_pos, il_data_count)
//ll_current_blob_pos = ll_current_blob_pos + 4
ll_init_time = il_midi_time[1]
for li_i = 1 to il_data_count
	if li_i = 1 then
		ll_time_interval = 0
	else 
		ll_time_interval = il_midi_time[li_i] - il_midi_time[li_i - 1]
	end if
	BlobEdit ( lblb_data_played, ll_current_blob_pos, ll_time_interval)
	ll_current_blob_pos = ll_current_blob_pos + 4
	BlobEdit ( lblb_data_played, ll_current_blob_pos, il_midi_data[li_i])
	ll_current_blob_pos = ll_current_blob_pos + 4
next

if ii_cur_piece = 1 then // right
	li_data_count_right = il_data_count
	lblb_data_right = lblb_data_played
elseif ii_cur_piece = 2 then // left
	li_data_count_left = il_data_count
	lblb_data_left = lblb_data_played
else	// both
	li_data_count_both = il_data_count
	lblb_data_both = lblb_data_played
end if
li_data_count_total = li_data_count_right + li_data_count_left + li_data_count_both
lblb_data_combo = Blob(space((li_data_count_total*2 + 3) * 4))

ll_current_blob_pos = 1
BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_right)
ll_current_blob_pos = ll_current_blob_pos + 4
if li_data_count_right > 0 then
	BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_right)
	ll_current_blob_pos = ll_current_blob_pos + li_data_count_right*2*4
end if
BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_left)
ll_current_blob_pos = ll_current_blob_pos + 4
if li_data_count_left > 0 then
	BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_left)
	ll_current_blob_pos = ll_current_blob_pos + li_data_count_left*2*4
end if
BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_both)
ll_current_blob_pos = ll_current_blob_pos + 4
if li_data_count_both > 0 then
	BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_both)
end if

li_file_num = FileOpen(ls_file_name, StreamMode!, Write!, LockWrite!, Replace!)
if li_file_num = -1 then
	MessageBox("Error", "Cannot Create File To Write!")
	return 0
end if
FileWrite(li_file_num, lblb_data_combo)
//ll_current_blob_pos = 1
//if ii_cur_piece = 1 then // right
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, il_data_count)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	BlobEdit(lblb_data_combo, ll_current_blob_pos, BlobMid(lblb_data_played, 1, 2*4*il_data_count))
//	ll_current_blob_pos = ll_current_blob_pos + 2*4*il_data_count
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_left)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	if li_data_count_left > 0 then
//	   BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_left)
//		ll_current_blob_pos = ll_current_blob_pos + 2*4*li_data_count_left
//	end if
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_both)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	if li_data_count_both > 0 then
//	   BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_both)
//		ll_current_blob_pos = ll_current_blob_pos + 2*4*li_data_count_both
//	end if
//	lblb_data_final = BlobMid(lblb_data_combo, 1, ll_current_blob_pos - 1)
//	FileWrite(li_file_num, lblb_data_final)
//elseif ii_cur_piece = 2 then // left
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_right)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	if li_data_count_right > 0 then
//	   BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_right)
//		ll_current_blob_pos = ll_current_blob_pos + 2*4*li_data_count_right
//	end if  
//	BlobEdit(lblb_data_combo, ll_current_blob_pos, il_data_count)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	BlobEdit(lblb_data_combo, ll_current_blob_pos, BlobMid(lblb_data_played, 1, 2*4*il_data_count))
//	ll_current_blob_pos = ll_current_blob_pos + 2*4*il_data_count
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_both)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	if li_data_count_both > 0 then
//	   BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_both)
//		ll_current_blob_pos = ll_current_blob_pos + 2*4*li_data_count_both
//	end if
//	lblb_data_final = BlobMid(lblb_data_combo, 1, ll_current_blob_pos - 1)
//	FileWrite(li_file_num, lblb_data_final)
//else	// both
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_right)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	if li_data_count_right > 0 then
//	   BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_right)
//		ll_current_blob_pos = ll_current_blob_pos + 2*4*li_data_count_right
//	end if  
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, li_data_count_left)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	if li_data_count_left > 0 then
//	   BlobEdit(lblb_data_combo, ll_current_blob_pos, lblb_data_left)
//		ll_current_blob_pos = ll_current_blob_pos + 2*4*li_data_count_left
//	end if
//   BlobEdit(lblb_data_combo, ll_current_blob_pos, il_data_count)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	BlobEdit(lblb_data_combo, ll_current_blob_pos, BlobMid(lblb_data_played, 1, 2*4*il_data_count))
//	ll_current_blob_pos = ll_current_blob_pos + 2*4*il_data_count
//	lblb_data_final = BlobMid(lblb_data_combo, 1, ll_current_blob_pos - 1)
//	FileWrite(li_file_num, lblb_data_final)
//end if
FileClose(li_file_num)
return 1
end function

public function integer wf_play_demo ();// save recorded MIDI file
long ll_init_time, ll_time_interval
integer li_i, li_note, li_check_repeat
long li_data_count_right = 0
long li_data_count_left = 0
long li_data_count_both = 0
long ll_file_len1, ll_current_blob_pos = 1
integer li_file_num
string ls_file_name, ls_note_to_keyboard, ls_local_filename
boolean lb_file_available = false
blob lblb_data_tmp, lblb_data_right, lblb_data_left, lblb_data_both
blob lb_data

// open existing file and parse the music MIDI into right, left, and both

ls_file_name = gn_appman.is_sys_temp + "\" + is_cur_mid_lesson + ".mdi"
//	MessageBox(ls_file_name, is_cur_picture_list[1])

if f_GetCacheResourceFile(is_cur_picture_list[1], ls_file_name) = 0 then
	MessageBox(ls_file_name, is_cur_picture_list[1])
end if
//ls_file_name = is_cur_mid_lesson + ".mdi"

if not FileExists(ls_file_name) then
	MessageBox("Error", "No Demo Music Available!")
	return 0
end if

ll_current_blob_pos = 1
ll_file_len1 = FileLength(ls_file_name)
li_file_num = FileOpen(ls_file_name, StreamMode!, Read!)
FileRead(li_file_num, lblb_data_tmp)
FileClose(li_file_num)

li_data_count_right = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
ll_current_blob_pos = ll_current_blob_pos + 4
if li_data_count_right > 0 then
	lblb_data_right = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_right)
	ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_right
end if
li_data_count_left = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
ll_current_blob_pos = ll_current_blob_pos + 4
if li_data_count_left > 0 then
	lblb_data_left = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_left)
	ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_left
end if
li_data_count_both = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
ll_current_blob_pos = ll_current_blob_pos + 4
if li_data_count_both > 0 then
	lblb_data_both = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_both)
	ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_both
end if

if ii_cur_piece = 1 then // right hand
	il_data_count = li_data_count_right
	if il_data_count = 0 then
		MessageBox("Error", "No Righthand Music Recorded!")
		return 0
	end if
	lb_data = lblb_data_right
elseif ii_cur_piece = 2 then
	il_data_count = li_data_count_left
	if il_data_count = 0 then
		MessageBox("Error", "No Lefthand Music Recorded!")
		return 0
	end if
	lb_data = lblb_data_left
else
	il_data_count = li_data_count_both
	if il_data_count = 0 then
		MessageBox("Error", "Full Music Recorded!")
		return 0
	end if
	lb_data = lblb_data_both
end if

ll_current_blob_pos =  1


for li_i = 1 to il_data_count
	il_midi_time[li_i] = long(BlobMid ( lb_data, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	il_midi_data[li_i] = long(BlobMid ( lb_data, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
next

ib_playing_demo = true


Send(il_player_handle, 1027, ii_prompt_ind, 0)

ii_current_note = 2
wf_rec_move(is_cur_text_list[ii_current_note])
wf_build_demo_note_entry(is_cur_text_list[ii_current_note])
extSetMusicNoteToSharedMemory(is_empty_note)
Send(il_player_handle, 1025, 0, 1)
ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note], 17, len(is_cur_text_list[ii_current_note]) - 16)
extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
Send(il_player_handle, 1025, 0, 1)
//wf_rec_move(is_cur_text_list[ii_current_note])
//MessageBox(is_cur_text_list[ii_current_note], ii_current_note)
//ii_current_note++
//MessageBox("loop start", "wait")

ll_current_blob_pos =  1


ib_play_demo = true



for li_i = 1 to il_data_count
	il_midi_time[li_i] = long(BlobMid ( lb_data, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	il_midi_data[li_i] = long(BlobMid ( lb_data, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
next


for li_i = 1 to il_data_count
	yield()
//	timer(il_midi_time[li_i], this)
	sleeping(il_midi_time[li_i])
	if isnull(il_midi_data[li_i]) then MessageBox("IS NULL", li_i)
	Send(il_player_handle, 1028, 0, il_midi_data[li_i])
//MessageBox(is_cur_text_list[ii_current_note], ii_current_note)
	if GetBitNum(il_midi_data[li_i], 0, 7) = 144 then // pressed
		li_note = GetBitNum(il_midi_data[li_i], 8, 15)
		if wf_validate_demo_note(li_note) then // all note played, pressed, move on to next
			post wf_rec_move(is_cur_text_list[ii_current_note])
			li_check_repeat = wf_check_repeat(ii_current_note)
			if li_check_repeat = 0 then
				ii_current_note++
			else
				ii_current_note = li_check_repeat
			end if
			if ii_current_note <= upperbound(is_cur_text_list) then
				if pos(lower(is_cur_picture_list[ii_current_note]),".jpg") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".bmp") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".gif") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".png") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".tif") > 0 then
					ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + string(ii_current_note, "000") + right(is_cur_picture_list[ii_current_note], 4)
					f_GetCacheResourceFile(is_cur_picture_list[ii_current_note], ls_local_filename)
					uo_1.p_1.PictureName = ls_local_filename
					wf_reset_pic_coord()
				end if
//				MessageBox(string(ii_current_note), is_cur_text_list[ii_current_note])
				wf_build_demo_note_entry(is_cur_text_list[ii_current_note])
				ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note - 1], 17, len(is_cur_text_list[ii_current_note - 1]) - 16)
				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
				Send(il_player_handle, 1025, 0, 1)		
			end if
			if ii_current_note = upperbound(is_cur_text_list) + 1 then
				ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note - 1], 17, len(is_cur_text_list[ii_current_note - 1]) - 16)
				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
				Send(il_player_handle, 1025, 0, 1)		
			end if			
			
//			ii_current_note++
		end if
	end if
next
//extSetMusicNoteToSharedMemory(is_empty_note)
//Send(il_player_handle, 1025, 0, 1)

ib_playing_demo = false

ii_current_note = ii_begin_note
ls_note_to_keyboard = right(is_cur_text_list[ii_current_note], len(is_cur_text_list[ii_current_note]) - 16)
extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
Send(il_player_handle, 1025, 0, 0)
ib_playing_demo = false
post wf_set_bar(1, ii_begin_note)
post wf_set_bar(2, ii_end_note)
//Send(il_player_handle, 1025, 0, 0)
ii_prompt_ind = dw_prompt.GetItemNumber(1, "prompt_ind")

//Post(il_player_handle, 1027, ii_prompt_ind, 0)
cb_start.post event clicked()

//post Send(il_player_handle, 1026, 0, 0)
//post wf_reset_pos()


return 1


end function

public function integer wf_play_back ();long ll_init_time, ll_time_interval
integer li_i, li_note, li_check_repeat
long li_data_count_right = 0
long li_data_count_left = 0
long li_data_count_both = 0
long ll_file_len1, ll_current_blob_pos = 1
integer li_file_num
string ls_file_name, ls_note_to_keyboard, ls_local_filename
boolean lb_file_available = false
blob lblb_data_tmp, lblb_data_right, lblb_data_left, lblb_data_both
blob lb_data

if il_data_count < 1 then
	MessageBox("Error", "No Music Recorded!")
	return 0
end if

ii_current_note = 2
wf_rec_move(is_cur_text_list[ii_current_note])
wf_build_demo_note_entry(is_cur_text_list[ii_current_note])
extSetMusicNoteToSharedMemory(is_empty_note)
Send(il_player_handle, 1025, 0, 1)
ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note], 17, len(is_cur_text_list[ii_current_note]) - 16)
extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
Send(il_player_handle, 1025, 0, 1)
//wf_rec_move(is_cur_text_list[ii_current_note])
//ii_current_note++
ib_playing_demo = true
ll_init_time = il_midi_time[1]
for li_i = 1 to il_data_count
//MessageBox("loop start", li_i)
	ll_time_interval = il_midi_time[li_i] - ll_init_time 
	yield()
	sleeping(ll_time_interval)
	ll_init_time = il_midi_time[li_i]
	Send(il_player_handle, 1028, 0, il_midi_data[li_i])
//	if GetBitNum(il_midi_data[li_i], 0, 7) = 128 then // pressed
	if GetBitNum(il_midi_data[li_i], 0, 7) = 144 then // pressed
		li_note = GetBitNum(il_midi_data[li_i], 8, 15)
		if wf_validate_demo_note(li_note) then // all note played, pressed, move on to next
			wf_rec_move(is_cur_text_list[ii_current_note])
			li_check_repeat = wf_check_repeat(ii_current_note)
			if li_check_repeat = 0 then
				ii_current_note++
			else
				ii_current_note = li_check_repeat
			end if
			if ii_current_note > upperbound(is_cur_text_list) then exit
			if ii_current_note <= upperbound(is_cur_text_list) then
				if pos(lower(is_cur_picture_list[ii_current_note]),".jpg") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".bmp") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".gif") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".png") > 0 or &
					pos(lower(is_cur_picture_list[ii_current_note]),".tif") > 0 then
					uo_1.p_1.PictureName = is_cur_picture_list[ii_current_note]
					wf_reset_pic_coord()
				end if
				wf_build_demo_note_entry(is_cur_text_list[ii_current_note])
				ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note - 1], 17, len(is_cur_text_list[ii_current_note - 1]) - 16)
				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
				Send(il_player_handle, 1025, 0, 1)		
			end if
			if ii_current_note = upperbound(is_cur_text_list) + 1 then
				ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note - 1], 17, len(is_cur_text_list[ii_current_note - 1]) - 16)
				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
				Send(il_player_handle, 1025, 0, 1)		
			end if
		end if
	end if
next
//wf_rec_move(is_cur_text_list[ii_current_note])

ib_playing_demo = false
post wf_set_bar(1, ii_begin_note)
post wf_set_bar(2, ii_end_note)

cb_start.event clicked()

return 1


end function

public function integer wf_build_demo_note_entry (string as_current_note);// description: build right and left hand list
long ll_total_note_count, ll_right_hand_note_count, ll_left_hand_note_count
integer li_i, li_note
string ls_note, ls_continuous_ind
ii_rh_list_demo = ii_empty_list
ii_lh_list_demo = ii_empty_list
ii_rh_count_demo = 0
ii_lh_count_demo = 0

ls_note = right(as_current_note, len(as_current_note) - 16)
ll_total_note_count = len(ls_note)/8
ll_right_hand_note_count = ll_total_note_count/2
ll_left_hand_note_count = ll_total_note_count/2
if mod(ll_total_note_count, 2) = 1 then
	ll_right_hand_note_count++
end if

for li_i=1 to ll_right_hand_note_count
	li_note = integer(mid(ls_note, 16*(li_i - 1) + 5, 2))
	ls_continuous_ind = mid(ls_note,16*(li_i - 1) + 7, 1)
	if li_note > 0 and ls_continuous_ind <> "2" then
		ii_rh_list_demo[upperbound(ii_rh_list_demo) + 1] = li_note
		ii_rh_count_demo++
	end if
next
for li_i=1 to ll_left_hand_note_count
	li_note = integer(mid(ls_note, 16*(li_i - 1) + 13, 2))
		ls_continuous_ind = mid(ls_note,16*(li_i - 1) + 15, 1)
	if li_note > 0 and ls_continuous_ind <> "2" then
		ii_lh_list_demo[upperbound(ii_lh_list_demo) + 1] = li_note
		ii_lh_count_demo++
	end if
next

return 1


end function

public function boolean wf_validate_demo_note (integer ai_note);// description: build right and left hand list
long ll_total_note_count, ll_right_hand_note_count, ll_left_hand_note_count
integer li_i, li_note
string ls_note
boolean lb_all_note_played = true

for li_i=1 to upperbound(ii_rh_list_demo)
	if ai_note = ii_rh_list_demo[li_i] then
		ii_rh_list_demo[li_i] = 0
	end if
next
for li_i=1 to upperbound(ii_lh_list_demo)
	if ai_note = ii_lh_list_demo[li_i] then
		ii_lh_list_demo[li_i] = 0
	end if
next
for li_i=1 to upperbound(ii_rh_list_demo)
	if ii_rh_list_demo[li_i] > 0 then
		lb_all_note_played = false
	end if
next
for li_i=1 to upperbound(ii_lh_list_demo)
	if ii_lh_list_demo[li_i] > 0 then
		lb_all_note_played = false
	end if
next
return lb_all_note_played


end function

public subroutine wf_fresh_bring_to_top ();
BringTotop =  true
pb_1.BringToTop = true
pb_2.BringToTop = true
pb_3.BringToTop = true
cb_close.BringToTop = true
cb_start.BringToTop = true
st_5.BringToTop = true
cb_start_record.BringToTop = true
cb_play_demo.BringToTop = true
cb_save.BringToTop = true
cb_playback.BringToTop = true
cbx_note_sound.BringToTop = true
sle_1.BringToTop = false
sle_1.visible = false
cb_1.BringToTop = true
dw_prompt.BringToTop = true

uo_1.p_1.BringToTop = false
uo_1.BringToTop = false


//
end subroutine

public function integer wf_check_repeat (integer ai_i);integer li_i

for li_i = 1 to upperbound(istr_cur_repeat)
	if istr_cur_repeat[li_i].repeatEnd = ai_i and not istr_cur_repeat[li_i].played then
		istr_cur_repeat[li_i].played = true
		return istr_cur_repeat[li_i].repeatBegin
	end if
next

li_i = ai_i

string ls_note_to_keyboard 
integer i,total_note_count=0,right_hand_note_count=0,left_hand_note_count=0;
integer right_hand_notes[5],left_hand_notes[5]
integer right_note_fraction[5], right_note_denomitor[5],left_note_fraction[5], left_note_denomitor[5]

boolean lb_continuous = true
char ls_continuous_ind

do while lb_continuous and li_i < ii_end_note
	li_i++
	ls_note_to_keyboard = right(is_cur_text_list[li_i], len(is_cur_text_list[li_i]) - 16)
//	MessageBox("ls_note_to_keyboard",ls_note_to_keyboard)
	//ii_current_note	
	total_note_count = len(ls_note_to_keyboard)/8
	right_hand_note_count = total_note_count/2
	left_hand_note_count = total_note_count/2
	
	if mod(total_note_count, 2) =1 then
		right_hand_note_count++
	end if
	
	for i=1 to right_hand_note_count
		right_hand_notes[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 5, 2))
		ls_continuous_ind = mid(ls_note_to_keyboard,16*(i - 1) + 7, 1)
		if right_hand_notes[i] <> 0 and ls_continuous_ind <> "2" then // real note and not continue
			return li_i
		end if
	next
	
	for i=1 to left_hand_note_count
		left_hand_notes[i] = integer(mid(ls_note_to_keyboard,16*(i - 1) + 13, 2))
		ls_continuous_ind = mid(ls_note_to_keyboard,16*(i - 1) + 15, 1)
		if left_hand_notes[i] <> 0 and ls_continuous_ind <> "2" then // real note and not continue
			return li_i
		end if
	next	
	//04390368055908120402640304026403
loop


return 0
end function

public subroutine wf_set_prompt_list (integer al_method_id);long ll_prompt_list[], ll_i, ll_row, ll_prompt_ind
string ls_prompt_list[]
datawindowchild ldwc

//ll_prompt_list = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
//ls_prompt_list = {"None", "RH Note Prompt", "RH Key Prompt", "RH Note and Key Prompt", "RH Prompt With Demo", &
//						"LH Note Prompt", "LH Key Prompt", "LH Note and Key Prompt", "LH Prompt With Demo", &
//						"Both Note Prompt", "Both Key Prompt", "Both Note and Key Prompt", "Both Prompt With Demo"}		

if ib_both_exists then
	ll_prompt_list = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
	ls_prompt_list = {"None", "RH Note Prompt", "RH Key Prompt", "RH Note and Key Prompt", "RH Prompt With Demo", &
							"LH Note Prompt", "LH Key Prompt", "LH Note and Key Prompt", "LH Prompt With Demo", &
							"Both Note Prompt", "Both Key Prompt", "Both Note and Key Prompt", "Both Prompt With Demo"}		
elseif ib_right_exists then
	ll_prompt_list = {0, 1, 2, 3, 4}
	ls_prompt_list = {"None", "RH Note Prompt", "RH Key Prompt", "RH Note and Key Prompt", "RH Prompt With Demo"}		
else						// Left Hand
	ll_prompt_list = {0, 5, 6, 7, 8}
	ls_prompt_list = {"None", "LH Note Prompt", "LH Key Prompt", "LH Note and Key Prompt", "LH Prompt With Demo"}				
end if

if dw_prompt.GetChild("prompt_ind", ldwc) = -1 then
	MessageBox("prompt_ind", "GetChild Error")
	dw_prompt.visible = false
else
	ll_prompt_ind = dw_prompt.GetItemNumber(1, "prompt_ind")
	ldwc.Reset()
	for ll_i = 1 to upperbound(ll_prompt_list)
		ll_row = ldwc.InsertRow(0)
		ldwc.SetItem(ll_row, "description", ls_prompt_list[ll_i])
		ldwc.SetItem(ll_row, "id", ll_prompt_list[ll_i])
		if ll_prompt_ind = ll_prompt_list[ll_i] then
			dw_prompt.SetFocus()
			dw_prompt.SetColumn("prompt_ind")
//			dw_prompt.SetText(ls_prompt_list[ll_i])
		end if
	next
	if dw_prompt.RowCount() = 0 then
		dw_prompt.InsertRow(0)
	end if
end if

end subroutine

public subroutine wf_adjust_bars (integer ai_bar, integer ai_x_delta, integer ai_y_delta);if ai_bar = 1 then // start bar
	uo_1.st_start.x += ai_x_delta
	uo_1.st_start.y += ai_y_delta
else 				  // end bar
	uo_1.st_end.x += ai_x_delta
	uo_1.st_end.y += ai_y_delta	
end if
	
end subroutine

public subroutine wf_scroll_sheet (integer ai_delta);integer li_delta_page, li_i

li_delta_page = ai_delta/50

if li_delta_page > 0 then // scroll down
	for li_i = 1 to li_delta_page
		Send(handle(uo_1),277,3,0) // 6=TOP, 2=UP 3 DOWN
	next
elseif li_delta_page < 0  then
	for li_i = 1 to (0 - li_delta_page)
		Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3 DOWN
	next
end if

//
end subroutine

public subroutine wf_reset_pic_coord ();// reset picture coordinates after loading
uo_1.p_1.x = (uo_1.width - uo_1.p_1.width)/2
idb_width_ratio = double(uo_1.p_1.width/ii_orig_width)
idb_height_ratio = double(uo_1.p_1.height/ii_orig_height)

visible = true


end subroutine

on w_lesson_music_dll.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_11=create st_11
this.cb_start_record=create cb_start_record
this.cb_play_demo=create cb_play_demo
this.cb_save=create cb_save
this.cb_playback=create cb_playback
this.cbx_note_sound=create cbx_note_sound
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_3=create cb_3
this.st_start=create st_start
this.st_end=create st_end
this.cbx_keyboard=create cbx_keyboard
this.sle_beat_rate=create sle_beat_rate
this.st_5=create st_5
this.sle_1=create sle_1
this.cb_1=create cb_1
this.pb_3=create pb_3
this.uo_1=create uo_1
this.sle_2=create sle_2
this.cbx_finger_hint=create cbx_finger_hint
this.cb_2=create cb_2
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_11
this.Control[iCurrent+5]=this.cb_start_record
this.Control[iCurrent+6]=this.cb_play_demo
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_playback
this.Control[iCurrent+9]=this.cbx_note_sound
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.st_start
this.Control[iCurrent+14]=this.st_end
this.Control[iCurrent+15]=this.cbx_keyboard
this.Control[iCurrent+16]=this.sle_beat_rate
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.sle_1
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.pb_3
this.Control[iCurrent+21]=this.uo_1
this.Control[iCurrent+22]=this.sle_2
this.Control[iCurrent+23]=this.cbx_finger_hint
this.Control[iCurrent+24]=this.cb_2
this.Control[iCurrent+25]=this.cb_4
end on

on w_lesson_music_dll.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_11)
destroy(this.cb_start_record)
destroy(this.cb_play_demo)
destroy(this.cb_save)
destroy(this.cb_playback)
destroy(this.cbx_note_sound)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_3)
destroy(this.st_start)
destroy(this.st_end)
destroy(this.cbx_keyboard)
destroy(this.sle_beat_rate)
destroy(this.st_5)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.pb_3)
destroy(this.uo_1)
destroy(this.sle_2)
destroy(this.cbx_finger_hint)
destroy(this.cb_2)
destroy(this.cb_4)
end on

event open;call super::open;//long ll_pb_win_handle
//string ls_shmem_buf

//super::event open()

visible = false
uo_1.visible = false

uo_1.iw_parent = this
uo_1.st_11.visible = false
uo_1.st_2.visible = false
uo_1.st_3.visible = false
uo_1.st_4.visible = false

cb_start_record.visible = false
cb_play_demo.visible = false
cb_playback.visible = false
cb_play_demo.visible = true
cb_save.visible = false

uo_1.st_start.BringToTop = true
uo_1.st_End.BringToTop = true
MessageBox("is_startupfile", is_startupfile)
if ProfileString ( is_startupfile, "SOUND_DRIVER", "SOUND_SEPERATION", "NO" ) = "YES" then
	ib_sound_seperation = true
end if
is_left_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "LEFT_HAND_SOUND_DEVICE", "" )
is_right_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "RIGHT_HAND_SOUND_DEVICE", "" )
is_midi_input_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "MIDI_INPUT_DEVICE", "" )
is_midi_output_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "MIDI_OUTPUT_DEVICE", "" )
//is_right_dev_name = is_midi_output_dev_name
MessageBox("is_right_dev_name", is_right_dev_name)
//MessageBox("is_midi_output_dev_name", is_midi_output_dev_name)
if IsWindow(gl_player_handle) then
	il_player_handle = gl_player_handle
end if


post wf_reset_pos()

end event

event closequery;call super::closequery;//extCloseMusicSharedMemory()
//Send(il_player_handle, 1026, 0, 0)

//if ib_sound_seperation then
//	SetProfileString ( is_startupfile, "SOUND_DRIVER", "SOUND_SEPERATION", "YES" )
//else
//	SetProfileString ( is_startupfile, "SOUND_DRIVER", "SOUND_SEPERATION", "NO" )
//end if
//SetProfileString ( is_startupfile, "SOUND_DRIVER", "LEFT_HAND_SOUND_DEVICE", is_left_dev_name )
//SetProfileString ( is_startupfile, "SOUND_DRIVER", "RIGHT_HAND_SOUND_DEVICE", is_right_dev_name )
//SetProfileString ( is_startupfile, "SOUND_DRIVER", "MIDI_INPUT_DEVICE", is_midi_input_dev_name )
//SetProfileString ( is_startupfile, "SOUND_DRIVER", "MIDI_OUTPUT_DEVICE", is_midi_output_dev_name )

end event

event close;call super::close;//Send(il_player_handle, 1026, 0, 0) //
if IsWindow(il_player_handle) then
	gl_player_handle = il_player_handle
	ShowWindow(il_player_handle, 0)
end if
super::event close()


end event

event key;call super::key;call super::key;integer li_row
long ll_count
string ls_comment_type, ls_win_title
if KeyDown(KeyControl!) and KeyDown(KeyH!) and KeyDown(KeyA!) and KeyDown(KeyN!) then
	cb_start_record.visible = true
	cb_play_demo.visible = true
	cb_playback.visible = true
	cb_play_demo.visible = true
	cb_start_record.visible = true
	cb_save.visible = true
end if
end event

event timer;call super::timer;keybd_event(13, 0, 0, 0)	
timer(0, this)

end event

type dw_reward from w_lesson`dw_reward within w_lesson_music_dll
end type

type cb_close from w_lesson`cb_close within w_lesson_music_dll
string tag = "1508040"
integer x = 4507
integer width = 210
integer height = 96
end type

event cb_close::clicked;if MessageBox('Warning', 'Do You Want To Close The Lesson?', Question!, YesNo!, 2) = 1 then
	close(parent)
end if
end event

type cb_start from w_lesson`cb_start within w_lesson_music_dll
string tag = "1508040"
integer x = 4274
integer y = 20
integer width = 201
integer height = 96
string text = "&Start"
end type

event cb_start::clicked;call super::clicked;integer li_i

string ls_note_to_keyboard, ls_text, ls_local_filename
uo_1.p_1.visible = true
uo_1.p_1.BringToTop = true

//MessageBox(string(upperbound(is_cur_text_list)), ii_begin_note)

ii_current_note = ii_begin_note // first note
ls_text = trim(is_cur_text_list[ii_current_note])
for li_i =  1 to upperbound(istr_cur_repeat)
	istr_cur_repeat[li_i].played = false
next


for ii_current_note = ii_begin_note to upperbound(is_cur_picture_list) 
	// paint music sheet
	if pos(lower(is_cur_picture_list[ii_current_note]),".jpg") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".bmp") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".gif") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".png") > 0 or &
		pos(lower(is_cur_picture_list[ii_current_note]),".tif") > 0 then
		ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + string(ii_current_note, "000") + right(is_cur_picture_list[ii_current_note], 4)
		f_GetCacheResourceFile(is_cur_picture_list[ii_current_note], ls_local_filename)
		uo_1.p_1.PictureName = ls_local_filename
		wf_reset_pic_coord()
//		uo_1.p_1.y = 1
		exit
	end if
next

ii_current_note = ii_begin_note // first note
ls_text = trim(is_cur_text_list[ii_current_note])

if ii_prompt_ind <> 0 and mod(ii_prompt_ind, 4) <> 2 then // not 0 and 2
	// move hint highlight
	wf_rec_move(ls_text)
	uo_1.st_11.visible = true
	uo_1.st_2.visible = true
	uo_1.st_3.visible = true
	uo_1.st_4.visible = true
else
	uo_1.st_11.visible = false
	uo_1.st_2.visible = false
	uo_1.st_3.visible = false
	uo_1.st_4.visible = false	
end if

//MessageBox("ii_prompt_ind", ii_prompt_ind)
//Send(il_player_handle, 1027, ii_prompt_ind, 0) //reset prompt

ls_note_to_keyboard = mid(ls_text, 17, len(ls_text) - 16)
//if mod(len(ls_note_to_keyboard)/8, 2) = 1 then ls_note_to_keyboard = ls_note_to_keyboard + "00000000"
//MessageBox("ls_note_to_keyboard", ls_note_to_keyboard)
extSetMusicNoteToSharedMemory(ls_note_to_keyboard) //set key-note information to sharememory
Sleep(1)

//MessageBox(ls_note_to_keyboard, ii_prompt_ind)
if ii_prompt_ind > 0 then
	Send(il_player_handle, 1025, 0, 0)	// send message to the music player to inform Next Note to play data in sharemory
end if
end event

type dw_2 from w_lesson`dw_2 within w_lesson_music_dll
end type

type p_1 from w_lesson`p_1 within w_lesson_music_dll
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
integer x = 3726
integer y = 252
integer width = 165
integer height = 104
boolean enabled = true
end type

event p_1::ue_lbuttondown;integer li_x, li_y, li_prompt_ind = 11, li_note_seq = 0
long ll_midi_data

if cbx_note_sound.checked then
	li_x = PointerX()
	li_y = PointerY()
	if wf_note_clicked(li_x, li_y) then
		if trim(st_11.text) <> "" then
			li_note_seq = wf_note_to_seq(st_11.text)
		elseif trim(st_4.text) <> "" then
			li_note_seq = wf_note_to_seq(st_4.text)
		end if
		if li_note_seq > 0 then
			Send(il_player_handle, 1027, li_prompt_ind, 0)
			ib_note_clicked = true
			ll_midi_data = 127*(65536) + li_note_seq*256 + 144
			Send(il_player_handle, 1028, 0, ll_midi_data)
		end if
	end if
end if
		  

end event

event p_1::ue_lbuttonup;integer li_x, li_y, li_note_seq
long ll_midi_data
string ls_local_filename, ls_text, ls_note_to_keyboard


if cbx_note_sound.checked and ib_note_clicked then
	li_x = PointerX()
	li_y = PointerY()
	ib_note_clicked = false
	if wf_note_clicked(li_x, li_y) then
		li_note_seq = wf_note_to_seq(st_11.text)
		ll_midi_data = li_note_seq*256 + 128
		Send(il_player_handle, 1028, 0, ll_midi_data)
		if ii_current_note <= upperbound(is_text_list) then
			if pos(lower(is_picture_list[ii_current_note]),".jpg") > 0 or &
				pos(lower(is_picture_list[ii_current_note]),".bmp") > 0 or &
				pos(lower(is_picture_list[ii_current_note]),".gif") > 0 or &
				pos(lower(is_picture_list[ii_current_note]),".png") > 0 or &
				pos(lower(is_picture_list[ii_current_note]),".tif") > 0 then
				ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + string(ii_current_note, "000") + right(is_picture_list[ii_current_note], 4)
				f_GetCacheResourceFile(is_picture_list[ii_current_note], ls_local_filename)
				uo_1.p_1.PictureName = ls_local_filename
				wf_reset_pic_coord()
			end if
		end if
		ii_current_note++
		if ii_current_note > upperbound(is_text_list) then 
			cb_start.enabled = true
			cb_start.visible = true
			cb_close.visible = true
			if ib_batch_run then
				il_current_repeat++
		//		MessageBox(string(il_repeat), il_current_repeat)
				if il_current_repeat = il_repeat then
					post close(parent)
				end if
			end if
			if ii_prompt_ind > 3 then
				sleep(1)
				cb_play_demo.post event clicked()
			else
				ii_current_note = ii_begin_note
				ls_text = trim(is_text_list[ii_current_note])
				wf_rec_move(ls_text)	
				ls_note_to_keyboard = right(is_text_list[ii_current_note], len(is_text_list[ii_current_note]) - 16)
				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
				Send(il_player_handle, 1025, 0, 0)
			end if
		else
			wf_rec_move(is_text_list[ii_current_note])
		end if
	end if
end if


		  

end event

event p_1::clicked;call super::clicked;integer li_x, li_y

li_x = PointerX()
li_y = PointerY()

if wf_note_clicked(li_x, li_y) then
	// play the note
end if
end event

event p_1::dragdrop;call super::dragdrop;integer li_x, li_y, li_current_begin_note, li_i = 0

li_x = PointerX() + uo_1.p_1.x
li_y = PointerY() + uo_1.p_1.y

ib_busy_token = true

if source = st_start then
	li_current_begin_note = ii_begin_note
		Send(il_player_handle, 1031, 0, 0)
	if wf_set_measure_range(1, li_x, li_y) = 1 then
//		Send(il_player_handle, 1031, 0, 0)
	end if
//	ib_busy_token = false
	st_start.BringToTop = true
end if	
if source = st_end then
	wf_set_measure_range(2, li_x, li_y)
	st_end.BringToTop = true
end if
sleeping(200)
post wf_set_token(false)

end event

type st_1 from w_lesson`st_1 within w_lesson_music_dll
integer x = 2085
integer y = 108
integer width = 73
integer height = 184
integer textsize = -12
long textcolor = 8388608
string text = ""
end type

type dw_1 from w_lesson`dw_1 within w_lesson_music_dll
end type

type dw_prompt from w_lesson`dw_prompt within w_lesson_music_dll
integer x = 2939
integer width = 1120
string dataobject = "d_prompt_piano"
end type

event dw_prompt::itemchanged;call super::itemchanged;//ShowWindow(il_player_handle, 5)
//MessageBox("itemchanged", 5)
//SetItem(row, "prompt_ind", integer(data))
//ii_prompt_ind = integer(data)
sle_2.text = string(row) + ":" + data
if row < 1 then return
//Send(il_player_handle, 1026, 0, 0)
//Sleep(1)
ii_begin_note = 2
ii_end_note = upperbound(is_cur_text_list)

post wf_reset_pos()
//
end event

type st_2 from statictext within w_lesson_music_dll
boolean visible = false
integer x = 1870
integer y = 148
integer width = 41
integer height = 116
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 65535
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_lesson_music_dll
boolean visible = false
integer x = 2235
integer y = 140
integer width = 41
integer height = 116
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 65535
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_lesson_music_dll
boolean visible = false
integer x = 1655
integer y = 164
integer width = 41
integer height = 116
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 65535
alignment alignment = center!
boolean focusrectangle = false
end type

type st_11 from statictext within w_lesson_music_dll
boolean visible = false
integer x = 2354
integer y = 156
integer width = 41
integer height = 116
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 65535
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_start_record from commandbutton within w_lesson_music_dll
integer x = 3054
integer y = 88
integer width = 169
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start Record"
end type

event clicked;integer li_i, li_prompt_ind = 10

il_data_count = 0
//MessageBox("start rec", "1")
Send(il_player_handle, 1027, ii_prompt_ind, 1)
//MessageBox("start rec", "2")

//for li_i = 1 to 10
//	il_midi_data[li_i] = li_i
//	il_midi_time[li_i] = cpu()
//	il_data_count++
//	sleep(1)
//next


end event

type cb_play_demo from commandbutton within w_lesson_music_dll
integer x = 2619
integer y = 16
integer width = 320
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Play Demo"
end type

event clicked;cb_3.event clicked()

wf_play_demo()

return 1


end event

type cb_save from commandbutton within w_lesson_music_dll
integer x = 2889
integer y = 76
integer width = 114
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;
wf_save_mdi()

//integer li_file_num, li_i
//long ll_current_blob_pos, ll_init_time, ll_time_interval
////long ll_data_count
//string ls_file_name
//blob{4000} lb_data
//
//ls_file_name = is_cur_mid_lesson + ".mdi"
//
//li_file_num = FileOpen(ls_file_name, StreamMode!, Write!, LockWrite!, Replace!)
//
//if li_file_num = -1 then
//	MessageBox("Error", "Cannot Create File To Write!")
//	return 0
//end if
//
//if il_data_count = 0 then
//	MessageBox("Error", "No Recorded Data!")
//	return 0
//end if
//
////ll_data_count = upperbound(il_midi_data)
//ll_current_blob_pos = 1
//BlobEdit ( lb_data, ll_current_blob_pos, il_data_count)
//ll_current_blob_pos = ll_current_blob_pos + 4
//
//ll_init_time = il_midi_time[1]
//
//for li_i = 1 to il_data_count
//	if li_i = 1 then
//		ll_time_interval = 0
//	else 
//		ll_time_interval = il_midi_time[li_i] - il_midi_time[li_i - 1]
//	end if
////	il_midi_time[li_i] = il_midi_time[li_i] - ll_init_time
//	BlobEdit ( lb_data, ll_current_blob_pos, ll_time_interval)
//	ll_current_blob_pos = ll_current_blob_pos + 4
//	BlobEdit ( lb_data, ll_current_blob_pos, il_midi_data[li_i])
//	ll_current_blob_pos = ll_current_blob_pos + 4
//next
//
//FileWrite(li_file_num, lb_data)
//FileClose(li_file_num)

end event

type cb_playback from commandbutton within w_lesson_music_dll
integer x = 2633
integer y = 76
integer width = 215
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Playback"
end type

event clicked;
wf_play_back()

return






integer li_file_num, li_i, li_prompt_ind = 11, li_begin_data_id, li_end_data_id
long ll_current_blob_pos
//long ll_data_count
string ls_file_name, ls_local_filename
blob{4000} lb_data

ls_file_name = is_cur_mid_lesson + ".mdi"

li_file_num = FileOpen(ls_file_name, StreamMode!, Read!)

if li_file_num = -1 then
	MessageBox("Error", "Cannot Open File To Read!")
	return 0
end if
FileRead(li_file_num, lb_data)
FileClose(li_file_num)

ll_current_blob_pos = 1
il_data_count = long(BlobMid ( lb_data, ll_current_blob_pos, 4))

//MessageBox("il_data_count", il_data_count)
ll_current_blob_pos = ll_current_blob_pos + 4

if il_data_count = 0 then
	MessageBox("Error", "No Recorded Data!")
	return 0
end if

if il_data_count >499 then
	MessageBox("Error", "Data Count Error!")
	return 0
end if

//ll_data_count = upperbound(il_midi_data)

Send(il_player_handle, 1027, li_prompt_ind, 0)

ii_current_note = ii_begin_note
li_begin_data_id = (ii_begin_note - 1)*2 - 1 
li_end_data_id = (ii_end_note - 1)*2

for li_i = 1 to il_data_count
	il_midi_time[li_i] = long(BlobMid ( lb_data, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	il_midi_data[li_i] = long(BlobMid ( lb_data, ll_current_blob_pos, 4))
	ll_current_blob_pos = ll_current_blob_pos + 4
	if li_i < li_begin_data_id or li_i > li_end_data_id then continue
//	parent.SetRedraw(false)
	yield()
	sleeping(il_midi_time[li_i])
//	parent.SetRedraw(true)
	Send(il_player_handle, 1028, 0, il_midi_data[li_i])
	if mod(li_i, 2) = 1 then
		if ii_current_note <= ii_end_note then
			if pos(lower(is_cur_picture_list[ii_current_note]),".jpg") > 0 or &
				pos(lower(is_cur_picture_list[ii_current_note]),".bmp") > 0 or &
				pos(lower(is_cur_picture_list[ii_current_note]),".gif") > 0 or &
				pos(lower(is_cur_picture_list[ii_current_note]),".png") > 0 or &
				pos(lower(is_cur_picture_list[ii_current_note]),".tif") > 0 then
				ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + string(ii_current_note, "000") + right(is_cur_picture_list[ii_current_note], 4)
				f_GetCacheResourceFile(is_cur_picture_list[ii_current_note], ls_local_filename)
				uo_1.p_1.PictureName = ls_local_filename
				wf_reset_pic_coord()
			end if
			wf_rec_move(is_cur_text_list[ii_current_note])
		end if	
		ii_current_note++
	end if
//	MessageBox(string(il_midi_data[li_i]), il_midi_time[li_i])
next


end event

type cbx_note_sound from checkbox within w_lesson_music_dll
integer x = 14
integer y = 16
integer width = 549
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Sound From Note"
end type

type pb_1 from picturebutton within w_lesson_music_dll
integer x = 1326
integer y = 20
integer width = 151
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "arraw_up.JPG"
alignment htextalign = left!
end type

event clicked;Send(il_player_handle, 1029, 0, 0)

end event

type pb_2 from picturebutton within w_lesson_music_dll
integer x = 1481
integer y = 20
integer width = 146
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "arraw_down.JPG"
alignment htextalign = left!
end type

event clicked;Send(il_player_handle, 1030, 0, 0)

end event

type cb_3 from commandbutton within w_lesson_music_dll
integer x = 2112
integer y = 12
integer width = 489
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset Measures"
end type

event clicked;Send(handle(uo_1),277,6,0) // 6=TOP, 2=UP 3 DOWN
ii_begin_note = 2
ii_end_note = upperbound(is_cur_text_list)
//uo_1.p_1.y = 1
wf_set_bar(1, ii_begin_note)
wf_set_bar(2, ii_end_note)

end event

type st_start from st_1 within w_lesson_music_dll
integer x = 2578
integer y = 0
integer width = 41
integer height = 76
string dragicon = "Information!"
boolean dragauto = true
string pointer = "HyperLink!"
long backcolor = 65280
boolean enabled = true
borderstyle borderstyle = styleraised!
end type

type st_end from st_1 within w_lesson_music_dll
integer x = 2647
integer y = 0
integer width = 41
integer height = 60
string dragicon = "Hand!"
boolean dragauto = true
string pointer = "HyperLink!"
long backcolor = 255
boolean enabled = true
borderstyle borderstyle = styleraised!
end type

type cbx_keyboard from checkbox within w_lesson_music_dll
integer x = 585
integer y = 16
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Keyboard"
boolean checked = true
end type

event clicked;if checked then // keyboard on
	ShowWindow(il_player_handle, 5) 
else
	ShowWindow(il_player_handle, 0) 	
end if
end event

type sle_beat_rate from singlelineedit within w_lesson_music_dll
integer x = 1906
integer y = 12
integer width = 187
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_lesson_music_dll
integer x = 1623
integer y = 32
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Beats/Min"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_lesson_music_dll
integer x = 4114
integer y = 20
integer width = 247
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_lesson_music_dll
boolean visible = false
integer x = 2473
integer y = 4
integer width = 247
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resave"
end type

event clicked;// save re-save recorded MIDI file
long ll_init_time, ll_time_interval
integer li_i
long li_data_count_right = 0
long li_data_count_left = 0
long li_data_count_both = 0
long ll_file_len1, ll_current_blob_pos = 1, ll_count = 0
integer li_file_num
string ls_file_name
boolean lb_file_available = false
blob{4000} lblb_data_right
blob{4000} lblb_data_both
blob lblb_data_tmp, lblb_mid_data
blob lb_data, lb_data2
// open existing file and parse the music MIDI into right, left, and both

ls_file_name = gn_appman.is_sys_temp + "\" + is_cur_mid_lesson + ".mdi"

if FileExists(ls_file_name) then // local file exists
	lb_file_available = true
elseif f_GetCacheResourceFile(is_cur_picture_list[1], ls_file_name) = 1 then // existing file
	if FileExists(ls_file_name) then
		lb_file_available = true
	else
		MessageBox("Error", "MDI File Not Available!")
		return
	end if
end if

li_file_num = FileOpen(ls_file_name, StreamMode!, Read!)
FileRead(li_file_num, lblb_data_tmp)
FileClose(li_file_num)
MessageBox("len(lblb_data_tmp)", len(lblb_data_tmp))

MessageBox("ii_cur_piece", ii_cur_piece)
if ii_cur_piece = 1 then // right
	li_data_count_right = long(BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4))
	BlobEdit (lblb_data_right, ll_current_blob_pos, li_data_count_right)
	ll_current_blob_pos = ll_current_blob_pos + 4
	
	if li_data_count_right > 0 then
		lblb_mid_data = BlobMid ( lblb_data_tmp, ll_current_blob_pos, 4*2*li_data_count_right)
		BlobEdit (lblb_data_right, ll_current_blob_pos, lblb_mid_data)
		ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_right
	else
		MessageBox("Error", "Righthand Data Are Not Available!")
		return 0
	end if
	BlobEdit (lblb_data_right, ll_current_blob_pos, li_data_count_left)
	ll_current_blob_pos = ll_current_blob_pos + 4
	BlobEdit (lblb_data_right, ll_current_blob_pos, li_data_count_both)
	ll_current_blob_pos = ll_current_blob_pos + 4
	lb_data2 = BlobMid(lblb_data_right, 1, ll_current_blob_pos - 1)
elseif ii_cur_piece = 2 then // left
	MessageBox("Error", "Should Not Have Left Hand Data")
	return 0
else	// both
	BlobEdit (lblb_data_both, ll_current_blob_pos, li_data_count_right)
	ll_current_blob_pos = ll_current_blob_pos + 4
	BlobEdit (lblb_data_both, ll_current_blob_pos, li_data_count_left)
	ll_current_blob_pos = ll_current_blob_pos + 4
	li_data_count_both = long(BlobMid ( lblb_data_tmp, 1, 4))
	BlobEdit (lblb_data_both, ll_current_blob_pos, li_data_count_both)
	ll_current_blob_pos = ll_current_blob_pos + 4
	if li_data_count_both > 0 then
		lblb_mid_data = BlobMid ( lblb_data_tmp, ll_current_blob_pos - 8, 4*2*li_data_count_both)
		BlobEdit (lblb_data_both, ll_current_blob_pos, lblb_mid_data)
		ll_current_blob_pos = ll_current_blob_pos + 4*2*li_data_count_both
		lb_data2 = BlobMid(lblb_data_both, 1, ll_current_blob_pos - 1)
	else
		MessageBox("Error", "Two-hand Data Are Not Available!")
		return 0
	end if
end if
MessageBox("len(lb_data2)", len(lb_data2))
li_file_num = FileOpen(is_cur_mid_lesson + ".mdi", StreamMode!, Write!, LockWrite!, Replace!)
FileWrite(li_file_num, lb_data2)
FileClose(li_file_num)

return 1
end event

type pb_3 from picturebutton within w_lesson_music_dll
integer x = 4069
integer width = 137
integer height = 124
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
string picturename = "speaker_icon.jpg"
alignment htextalign = left!
end type

event clicked;any la_tmp, la_null

gn_appman.of_set_parm("Left Sound Device", is_left_dev_name)
gn_appman.of_set_parm("Right Sound Device", is_right_dev_name)
gn_appman.of_set_parm("Sound Seperation Ind", ib_sound_seperation)
gn_appman.of_set_parm("MIDI Input Device", is_midi_input_dev_name)
gn_appman.of_set_parm("MIDI Output Device", is_midi_output_dev_name)

open(w_sound_drive_setup)

if trim(Message.StringParm) = "1" then
	gn_appman.of_get_parm("Left Sound Device", la_tmp)
	is_left_dev_name = la_tmp
	la_tmp = la_null
	gn_appman.of_get_parm("Right Sound Device", la_tmp)
	is_right_dev_name = la_tmp
	la_tmp = la_null
	gn_appman.of_get_parm("MIDI Input Device", la_tmp)
	is_midi_input_dev_name = la_tmp
	la_tmp = la_null
	gn_appman.of_get_parm("MIDI Output Device", la_tmp)
	is_midi_output_dev_name = la_tmp
	la_tmp = la_null
	gn_appman.of_get_parm("Sound Seperation Ind", la_tmp)
	ib_sound_seperation = la_tmp
end if
end event

type uo_1 from uo_music_sheet within w_lesson_music_dll
event ue_vscroll pbm_vscroll
integer x = 73
integer y = 148
integer width = 3634
integer height = 2028
integer taborder = 70
boolean bringtotop = true
boolean vscrollbar = true
boolean border = true
integer unitsperline = 50
integer linesperpage = 1
borderstyle borderstyle = stylelowered!
end type

event ue_vscroll;//MessageBox(string(scrollpos), scrollcode)
if scrollcode = 6 then ii_current_scroll = 0
if scrollcode = 2 then // up
	if ii_current_scroll > 0 then ii_current_scroll -= 1
end if
if scrollcode = 3 then // down
	ii_current_scroll += 1
end if
sle_2.text = "scrollcode:" + string(scrollcode) + "scrollpos:" + string(scrollpos) + " cur_scroll" + string(ii_current_scroll)

//ii_current_scroll
end event

on uo_1.destroy
call uo_music_sheet::destroy
end on

type sle_2 from singlelineedit within w_lesson_music_dll
boolean visible = false
integer x = 1655
integer y = 128
integer width = 1051
integer height = 76
integer taborder = 70
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

type cbx_finger_hint from checkbox within w_lesson_music_dll
integer x = 942
integer y = 16
integer width = 370
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Finger Hint"
boolean checked = true
end type

event clicked;if checked then
	is_finger_prompt = "01"
else
	is_finger_prompt = "00"
end if

end event

type cb_2 from commandbutton within w_lesson_music_dll
boolean visible = false
integer x = 1019
integer y = 92
integer width = 128
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "U"
end type

event clicked;
Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3 DOWN

end event

type cb_4 from commandbutton within w_lesson_music_dll
boolean visible = false
integer x = 1166
integer y = 92
integer width = 128
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D"
end type

event clicked;Send(handle(uo_1),277,3,0) // 6=TOP, 2=UP 3 DOWN

end event

