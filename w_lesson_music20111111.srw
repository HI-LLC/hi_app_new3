$PBExportHeader$w_lesson_music.srw
forward
global type w_lesson_music from w_lesson2
end type
type st_2 from statictext within w_lesson_music
end type
type st_3 from statictext within w_lesson_music
end type
type st_4 from statictext within w_lesson_music
end type
type st_11 from statictext within w_lesson_music
end type
type cb_start_record from commandbutton within w_lesson_music
end type
type cb_play_demo from commandbutton within w_lesson_music
end type
type cb_save from commandbutton within w_lesson_music
end type
type cb_playback from commandbutton within w_lesson_music
end type
type cbx_note_sound from checkbox within w_lesson_music
end type
type cb_reset from commandbutton within w_lesson_music
end type
type st_start from st_1 within w_lesson_music
end type
type st_end from st_1 within w_lesson_music
end type
type cbx_keyboard from checkbox within w_lesson_music
end type
type sle_beat_rate from singlelineedit within w_lesson_music
end type
type st_5 from statictext within w_lesson_music
end type
type sle_1 from singlelineedit within w_lesson_music
end type
type cb_1 from commandbutton within w_lesson_music
end type
type pb_3 from picturebutton within w_lesson_music
end type
type uo_1 from uo_music_sheet_dummy within w_lesson_music
end type
type sle_2 from singlelineedit within w_lesson_music
end type
type cbx_finger_hint from checkbox within w_lesson_music
end type
type cb_2 from commandbutton within w_lesson_music
end type
type cb_4 from commandbutton within w_lesson_music
end type
type p_keyboard1 from uo_dummy within w_lesson_music
end type
type cb_5 from commandbutton within w_lesson_music
end type
type sle_3 from singlelineedit within w_lesson_music
end type
type p_top from picture within w_lesson_music
end type
type p_bottom from picture within w_lesson_music
end type
type p_left from picture within w_lesson_music
end type
type p_right from picture within w_lesson_music
end type
type p_bottom2 from picture within w_lesson_music
end type
end forward

global type w_lesson_music from w_lesson2
string tag = "1508000"
integer width = 5029
integer height = 2924
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = popup!
long backcolor = 33554431
boolean toolbarvisible = false
integer ii_current_i = 1
event ue_get_player_handle pbm_custom01
event ue_key_played pbm_custom02
event ue_record_msg pbm_custom03
event ue_get_player_bound pbm_custom04
event ue_mouseover pbm_nchittest
event ue_mousemove pbm_mousemove
event ue_paint pbm_paint
event ue_keyboard_painted pbm_custom05
st_2 st_2
st_3 st_3
st_4 st_4
st_11 st_11
cb_start_record cb_start_record
cb_play_demo cb_play_demo
cb_save cb_save
cb_playback cb_playback
cbx_note_sound cbx_note_sound
cb_reset cb_reset
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
p_keyboard1 p_keyboard1
cb_5 cb_5
sle_3 sle_3
p_top p_top
p_bottom p_bottom
p_left p_left
p_right p_right
p_bottom2 p_bottom2
end type
global w_lesson_music w_lesson_music

type variables
integer ii_counter = 0

constant integer REAPEAT_FINGERING = 9
constant integer NO_FINGERING = 0
constant integer LEFTHAND_FINGERING = 1
constant integer RIGHTHAND_FINGERING = 2
constant integer FINGERING_ATTR_LEN = 17

integer ii_bean_drop_style, ii_char_index =  1, ii_high_note, ii_low_note, ii_the_high_note, ii_the_low_note
boolean ib_alternation_switch = false
boolean ib_missing_list[]
boolean ib_note_clicked = false
boolean ib_play_demo = false
boolean ib_reset_pos = false
boolean ib_popup_menu = false
boolean ib_paint = true
boolean ib_paint_bottom = false

string is_finger_prompt = "00"
string is_current_mask, is_current_distraction, is_the_missing_word
string is_lesson_name_eng = "", is_lesson_name_chn = ""
string is_bh_fingering_image = "", is_rh_fingering_image = "", is_lh_fingering_image = "", is_cur_fingering_image = ""
string is_finger_graphic = ""
// variable for loading window background graph

string is_BitmapPtr
long  il_ascii_size, il_bin_size, il_win_handle
long	il_listview_handle
boolean 	ib_paint_ready = false

integer ii_current_state = 0
long il_reading_question_id
integer ii_current_scroll = 0

integer ii_current_note = 1
integer ii_current_measure = 1
integer ii_begin_note = 2, ii_end_note
integer ii_BeginX, ii_BeginY, ii_EndX, ii_EndY, ii_orig_width, ii_orig_height,ii_p_1_y_orig = -2000
integer ii_midi_input = 0, ii_midi_output = 0
double idb_width_ratio,idb_height_ratio
long il_player_handle = 0, il_player_handle_lh = 0

// midi recording and playing back
long il_midi_data[], il_midi_time[], il_data_count = 0
double idb_beat_rate, idb_beat_duration, idb_note_per_beat
double idb_right_note_duration[5], idb_left_note_duration[5], idb_left_min_duration = 10.0
double idb_right_note_duration0[5], idb_left_note_duration0[5], idb_right_min_duration = 10.0
double idb_min_duration = 10.0
double idb_right_note_duration1[5], idb_left_note_duration1[5], idb_left_min_duration1 = 10.0
double idb_right_note_duration00[5], idb_left_note_duration00[5], idb_right_min_duration1 = 10.0

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
string is_rh_finger_list[], is_lh_finger_list[], is_bh_finger_list[], is_finger_list[]

string is_cur_wave_list[], is_cur_picture_list[], is_cur_text_list[], is_cur_finger_list[]
string is_cur_mid_lesson = "dummy.mid"

string is_left_dev_name = "", is_right_dev_name = ""
string is_midi_input_dev_name = "", is_midi_output_dev_name = ""

integer ii_cur_text_count, ii_cur_piece

integer ii_rh_list_index[],ii_lh_list_index[],ii_bh_list_index[], ii_cur_list_index[]
integer ii_rh_list_demo[],ii_lh_list_demo[],ii_bh_list_demo[],ii_empty_list[],ii_rh_count_demo,ii_lh_count_demo,ii_bh_count_demo
str_rect win_rect // music player window position

//uo_popup_menu iuo_popup_menu
w_popup_menu iw_popup_menu

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
long il_kb_dc, il_kb_handle, il_thread_id = 0

ulong iul_counter = 0

nvo_timing invo_timing

long il_text_high_light_color = 16711680, il_text_default_color = 255
//nvo_cust_control inv_english_rb, inv_chinese_rb
nvo_cust_control inv_repeat_rb, inv_advance_rb, inv_trans_cb
nvo_cust_control inv_forward_button, inv_backward_button

// for prompt 

string is_menu_list0[] = {"None","RH Note Prompt","RH Key Prompt","RH Fingering Prompt",&
								  "LH Note Prompt","LH Key Prompt","LH Fingering Prompt", &
								  "Both Note Prompt","Both Key Prompt","Both Fingering  Prompt"}
								  	//	9							10							11
								  
								  // 0    1                 2                3
string is_menu_list1[] = {"None","RH Note Prompt","RH Key Prompt","RH Fingering Prompt"}
									// 0 		5						6						7
string is_menu_list2[] = {"None","LH Note Prompt","LH Key Prompt","LH Fingering Prompt"}								  
long il_unicode_list0[] = {26080,25552,31034, 21491,25163,20048,35889,25552,31034, 21491,25163,29748,38190,25552,31034, 21491,25163,25351,27861,25552,31034, &
						  24038,25163,20048,35889,25552,31034, 24038,25163,29748,38190,25552,31034, 24038,25163,25351,27861,25552,31034, &
						  21452,25163,20048,35889,25552,31034, 21452,25163,29748,38190,25552,31034, 21452,25163,25351,27861,25552,31034}
long il_unicode_list1[] = {26080,25552,31034, 24038,25163,20048,35889,25552,31034, 24038,25163,29748,38190,25552,31034, 24038,25163,25351,27861,25552,31034}
long il_unicode_list2[] = {26080,25552,31034, 21452,25163,20048,35889,25552,31034, 21452,25163,29748,38190,25552,31034, 21452,25163,25351,27861,25552,31034}

integer ii_unicode_index0[] = {1,4,10,16,22,28,34,40,46,52}
integer ii_unicode_index1[] = {1,4,10,16}
integer ii_unicode_index2[] = {1,4,10,16}
integer ii_both_prompt_list[] = {0,1,2,3,5,6,7,9,10,11}
integer ii_rh_prompt_list[] = {0,1,2,3}
integer ii_lh_prompt_list[] = {0,5,6,7}

// moving interval
string is_menu_list3[] = {"One Note","Two Notes","Three Notes","Five Notes", &
								  "One Measures","Two Measures","Three Measures","One Paragraph"}
//One Fingering		- 1
//Two Fingerings		- 2
//Three Fingerings	- 3
//Five Fingerings		- 4
//One Measures			- 5
//Two Measures			- 6
//Three Measures		- 7
//One Paragraph		- 8


long il_unicode_list3[] = {	&						
19968,20010,38899,31526,  &
20004,20010,38899,31526,  &
19977,20010,38899,31526,  &
20116,20010,38899,31526,  &
19968,23567,33410,  &
20004,23567,33410,  &
19977,23567,33410,  &
19968,27573,33853}
integer ii_unicode_index3[] = {1,5,9,13,17,20,23,26}

// tempo
string is_menu_list4[] = {"0","10","20","30","40","50","60","70","80"}

long il_unicode_list4[] = {&						
48, &
49,48, &
50,48, &
51,48, &
52,48, &
53,48, &
54,48, &
55,48, &
56,48}
integer ii_unicode_index4[] = {1,2,4,6,8,10,12,14,16}


integer ii_moving_inteval_ind = 1
//str_rect_long rect
str_rect_long rect_top, rect_bottom, rect_left, rect_right

//foot switch control, in order to prevent note advacing events triggered 
//constantly when foot switch is being held pressed, boolean and cpu timer to
//control it
boolean ib_foot_switch_released = true
boolean ib_foot_switch_in_process = false
long ll_cpu = 0, il_cpu_counter = 1, il_cpu = 0, il_cpu_prev = 0
long ll_cpu_list[]
long il_moving_ind = 1 //	1=ADVANCE 0=REPEAT
integer ii_moving_interval_type = 1
integer ii_interval_begin = 2, ii_interval_end = 2
boolean ib_auto_fingering = false
boolean ib_keyboard_fingering_painted = true
string is_measure_size
double idb_measure_size
integer ii_measure_right_begin_index[], ii_measure_right_end_index[]
integer ii_measure_left_begin_index[], ii_measure_left_end_index[]
integer ii_measure_both_begin_index[], ii_measure_both_end_index[]
integer ii_measure_cur_begin_index[], ii_measure_cur_end_index[]
integer ii_keyboard_height
boolean ib_keyboard_set = false, ib_playing_trans_image = false
integer ii_tempo = 1
integer ii_played_notes[]
long il_image_seq[], il_trans_list[], il_empty_list[]
long il_trans_image_index = 1, il_trans_image_count = 1
double idb_trans_timer, idb_note_timer
long il_display_trans_fingering = 0
boolean ib_animate_fingering = false
long il_animate_id = 0
double idb_animate_timer = 0, idb_animate_time_remain
long il_pb_win_handle, il_begin_play_time = 0
end variables

forward prototypes
public subroutine wf_init_container ()
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
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
public function boolean isnaturalnote (integer ai_note)
public function integer getarrayrange (long al_array[])
public function integer wf_rec_move (string as_note)
public subroutine wf_init_lesson ()
public function integer wf_parse_finger_entry (string as_input, ref string as_output_list[])
public function integer wf_get_finger_entry_id (ref string as_input_list[], ref long al_entry_id_list[], ref string as_entry_id_list[])
public function integer wf_load_finger_graphs ()
public function integer wf_parse_note_attribute (string as_current_note_entry, ref string as_note_coordinate, ref string as_note_to_keyboard, ref integer ai_total_note_set_count, ref integer ai_rh_note_set_count, ref integer ai_lh_note_set_count, ref string as_rh_time_fraction[], ref string as_lh_time_fraction[], ref string as_rh_note_value[], ref string as_lh_note_value[], ref string as_rh_note_char[], ref string as_lh_note_char[], ref string as_rh_note_finger[], ref string as_lh_note_finger[])
public function integer closepopupmenu ()
public subroutine wf_set_cust_control ()
public function integer wf_prompt_change (integer ai_prompt_indicator, integer ai_prompt_index)
public function integer wf_goto_rec (integer ai_x, integer ai_y)
public function string wf_fraction_to_string (double adb_input)
public function double wf_string_to_fraction (string as_input)
public subroutine wf_set_moving_interval (integer ai_moving_interval_type)
public subroutine wf_note_advancing ()
public subroutine wf_set_tempo (integer ai_tempo)
public subroutine wf_play_note ()
public subroutine wf_add_played_note (integer ai_note)
public subroutine wf_remove_played_note (integer ai_note)
public function double wf_get_min_time ()
public subroutine wf_get_lesson_name ()
public function integer wf_send_note (boolean ab_clicked)
public function integer wf_make_string_list (string as_input, ref string as_output[])
end prototypes

event ue_get_player_handle;long ll_pb_win_handle
string ls_shmem_buf
string ls_device1 = "SoundMAX Digital Audio"
string ls_device2 = "SSS USB Headphone Set"

//MessageBox("1024", ib_sound_seperation)
//return

//ll_pb_win_handle = handle(this)
//ls_shmem_buf = string(ll_pb_win_handle, "00000000") + string(ii_prompt_ind, "00") + string(ii_low_note, "000")  + string(ii_high_note,"000")
//ls_shmem_buf = ls_shmem_buf + "02"  + is_finger_prompt + is_left_dev_name// + space(82 - len(ls_device2))
//extSetMusicNoteToSharedMemory(ls_shmem_buf) // set variable in share memory for MusicLesson.exe to pick up
sle_2.text = "ue_get_player_handle"
cb_start.enabled = true
cb_start.post event clicked()
post wf_set_bar(1, ii_begin_note)
post wf_set_bar(2, ii_end_note)


/* the below code is for the VC++ App based code, it is not need for PB window based keyboard
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
		Sleep(2)
		cb_start.enabled = true
		cb_start.post event clicked()
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
end if
*/

return 1
end event

event ue_key_played;// the keyboard control send this message (1025), when key is detected as played

string ls_note_to_keyboard, ls_local_filename, ls_text, ls_shmem_buf
double ldb_note_duration
long ll_note_duration = 0
long ll_i, ll_pb_win_handle
integer li_check_repeat
//sle_2.text = "a ue_key_played: ii_current_note=" + string(ii_current_note)
//Messagebox("debug", sle_2.text)
//return
if ib_playing_demo then return 0
if ib_busy_token then return 0
//MessageBox("ue_key_played: ii_current_note",ii_current_note)
//sle_2.text = "b ue_key_played: ii_current_note=" + string(ii_current_note)
li_check_repeat = wf_check_repeat(ii_current_note)
if li_check_repeat = 0 then
	ii_current_note++
else
	ii_current_note = li_check_repeat
end if

if ii_current_note <= ii_end_note then
	post wf_reset_pic_coord()
	yield()
	if idb_right_note_duration[1] > 0.0 then
		ll_note_duration = idb_right_note_duration[1]*1000
	end if
	if idb_left_note_duration[1] > 0.0 then
		ll_note_duration = idb_left_note_duration[1]*1000
	end if
	if ii_prompt_ind <> 0 and  mod(ii_prompt_ind, 2) <> 2 then // not 0 and not 2
		wf_rec_move(is_cur_text_list[ii_current_note])
	end if
	wf_send_note(false)
else
//	MessageBox("ii_prompt_ind", ii_prompt_ind)
	Sleep(2)
	ii_current_note = ii_begin_note
	ls_text = trim(is_cur_text_list[ii_current_note])
	if ii_prompt_ind > 1 then
		wf_rec_move(ls_text)	
	end if
	if ii_begin_note = 2 then
		cb_reset.event clicked()
	end if	
	
	return 1
	// NEED TO RESET PARAMETERS
	
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
			cb_reset.event clicked()
		end if
		// RESTART THE THREAD IF NEEDED
		
	end if
end if
return 1
end event

event ue_record_msg;if ib_playing_demo then return 
il_midi_data[upperbound(il_midi_data) + 1] = lparam
il_midi_time[upperbound(il_midi_time) + 1] = cpu()
il_data_count++

end event

event ue_get_player_bound;// keyboard and fingering graphics have been painted

ib_keyboard_fingering_painted = true
if not ib_keyboard_set then
	if ii_prompt_ind = 0 or ii_prompt_ind = 1 or ii_prompt_ind = 5 or ii_prompt_ind = 9 then
		uo_1.height = height - 400	
		p_keyboard1.height = 1
		
	else
		uo_1.height = (height - p_keyboard1.height) - 400
		p_keyboard1.height = ii_keyboard_height
		
	end if
end if

ib_keyboard_set = true



end event

event ue_mouseover;//sle_3.text = "x=" + string(x) + " y=" + string(y)
//sle_3.text = "W=" + string(width) + " H=" + string(height) + " x=" + string(xpos) + " y=" + string(ypos)
//sle_3.text = "x=" + string(x) + " y=" + string(y) + " wksX=" + string(WorkSpaceX()) + " wksY=" + string(WorkSpaceY())

if xpos > uo_1.uo_1.x and xpos < uo_1.uo_1.x + uo_1.uo_1.width and ypos > 0 and ypos < uo_1.uo_1.y then
//	if Not ib_popup_menu and Not IsValid(iuo_popup_menu) Then
//		ib_popup_menu =  true
//		openuserobject(iuo_popup_menu, uo_1.uo_1.x, 1)
//	end if
	if Not ib_popup_menu and Not IsValid(iw_popup_menu) Then
		ib_popup_menu =  true
		open(iw_popup_menu, this)
	end if
else
	close(iw_popup_menu)
//	CloseUserObject(iuo_popup_menu)
	ib_popup_menu =  false
end if

end event

event ue_paint;//MessageBox("ue_paint", "1")
//p_top.post event ue_paint(0)
//p_bottom.post event ue_paint(0)
return

//gl_lang_ind 0=English 1=Chinese
long ll_dc, ll_x, ll_y, ll_array_size,ll_x2, ll_y2, ll_array_size2, ll_text_list[],ll_text_list2[], ll_empty_list[], ll_pos
long ll_unicode_list[] = {25552,31034,24335,38899,20048,38190,30424,32451,20064,26354,32,45,32}
long ll_color, ll_i, ll_char_width
ulong ul_unicode_list[]
string ls_seperator, ls_lesson_name_eng = "", ls_lesson_name_chn = ""
string ls_text_title = "Hint Based Keyboard Music Lesson - "
ll_dc = GetDC(il_win_handle)
ll_color = 	16777215
str_logfont logfont
str_rect_long rect, rect2
ls_seperator = "||"
ll_pos = pos(is_lesson_name, ls_seperator)
ls_seperator = " | |"
if ll_pos = 0 then ll_pos = pos(is_lesson_name, ls_seperator)
if ll_pos > 0 then
	ls_lesson_name_eng = left(is_lesson_name, ll_pos - 1)
	ls_lesson_name_chn = right(is_lesson_name, len(is_lesson_name) - (ll_pos + (len(ls_seperator) - 1)))
	for ll_i = 1 to len(ls_lesson_name_chn)/4
		ul_unicode_list[ll_i] = 0
	next
	extHexString2Number(ls_lesson_name_chn, ul_unicode_list)
else
	ls_lesson_name_eng = is_lesson_name
end if

ll_text_list = ll_empty_list
if gl_lang_ind = 0 then
	ll_char_width = 10
	for ll_i = 1 to len(ls_text_title)
		ll_text_list[ll_i] = asc(mid(ls_text_title, ll_i, 1))
	next	
	for ll_i = 1 to len(ls_lesson_name_eng)
		ll_text_list[len(ls_text_title) + ll_i] = asc(mid(ls_lesson_name_eng, ll_i, 1))
	next	
	f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
else	// chinese
	ll_char_width = 25
	ll_text_list = ll_unicode_list	
	for ll_i = 1 to upperbound(ul_unicode_list)
		ll_text_list[upperbound(ll_text_list) + 1] = ul_unicode_list[ll_i]
	next
	f_set_logfont(logfont,24,FW_BOLD,char(GB2312_CHARSET),"FongSong")
end if
ll_array_size = upperbound(ll_text_list)

il_win_handle = handle(this)
ll_dc = GetDC(il_win_handle)
rect.left = 0
rect.top = 0
rect.right = UnitsToPixels(width, XUnitsToPixels!)
rect.bottom = UnitsToPixels(height, YUnitsToPixels!)
//DrawGraph(ll_dc,  "music_lesson_bk.png", rect,0,0,1,255)

// prepare for prompt info to be show on the window frame
//if ib_left_hand_exists and ib_right_exists then ib_both_exists = true
//integer li_both_prompt_list[] = {0,1,2,3,5,6,7,9,10,11}
//integer li_rh_prompt_list[] = {0,1,2,3}
//integer li_lh_prompt_list[] = {0,5,6,7}
string ls_menu_list[]
long ll_unicode_list2[]
integer li_prompt_list[], li_i, li_found, li_char_index,li_unicode_index[]

ll_array_size = upperbound(ll_text_list)


//if ib_reset_pos then
	
	if ib_both_exists then
		li_prompt_list = ii_both_prompt_list
		ls_menu_list = is_menu_list0
		ll_unicode_list2 = il_unicode_list0
		li_unicode_index = ii_unicode_index0
	elseif ib_right_exists then
		li_prompt_list = ii_rh_prompt_list
		ls_menu_list = is_menu_list1
		ll_unicode_list2 = il_unicode_list1
		li_unicode_index = ii_unicode_index1
	else
		li_prompt_list = ii_lh_prompt_list
		ls_menu_list = is_menu_list2
		ll_unicode_list2 = il_unicode_list2
		li_unicode_index = ii_unicode_index2
	end if
	
	
	for li_i = 1 to upperbound(li_prompt_list)
		if ii_prompt_ind = li_prompt_list[li_i] then li_found = li_i
	next
	ll_text_list2 = ll_empty_list
	if li_found = 0 then li_found = 1
	if gl_lang_ind = 0 then
		ll_char_width = 10
		for ll_i = 1 to len(ls_menu_list[li_found])
			ll_text_list2[ll_i] = asc(mid(ls_menu_list[li_found], ll_i, 1))
		next	
	else	// chinese
		ll_char_width = 25
		if li_found < upperbound(li_prompt_list) then
//			MessageBox(string(li_found), upperbound(li_unicode_index))
			ll_array_size2 = li_unicode_index[li_found+1] - li_unicode_index[li_found]
		else
			ll_array_size2 = upperbound(ll_unicode_list2) - li_unicode_index[li_found] + 1
		end if 
		for ll_i = 1 to ll_array_size2
			li_char_index = li_unicode_index[li_found] + ll_i - 1
			ll_text_list2[ll_i] = ll_unicode_list2[li_char_index]
		next
	end if

	
	ll_x = UnitsToPixels(width/2, XUnitsToPixels!) - ll_array_size*ll_char_width/2
	ll_y = 5
	ll_x2 = UnitsToPixels(width/2, XUnitsToPixels!) - ll_array_size2*ll_char_width/2
	ll_y2 = UnitsToPixels(p_keyboard1.y + p_keyboard1.height, YUnitsToPixels!) + 10
//	if not ib_paint_ready then
		ib_paint_ready = true
//		do_paint_ext(il_win_handle, is_BitmapPtr, il_ascii_size, il_bin_size)
		extTextOutFromPB(ll_dc,gl_lang_ind,ll_x,ll_y,ll_text_list,ll_array_size,ll_color,logfont) 
		extTextOutFromPB(ll_dc,gl_lang_ind,ll_x2,ll_y2,ll_text_list2,ll_array_size2,ll_color,logfont) 
		ib_paint_ready = false

		inv_forward_button.event ue_paint(0,0) 
		inv_backward_button.event ue_paint(0,0) 
//	end if
//	uo_1.uo_1.p_1.event ue_paint(0)
//end if

//25552 U+63d0 ti cce1 
//31034 U+793a shi cabe
//24335 U+5f0f shi cabd
//38899 U+97f3 yin d2f4
//20048 U+4e50 yue c0d6 
//38190 U+952e jian bcfc
//30424 U+76d8 pan c5cc
//32451 U+7ec3 lian c1b7
//20064 U+4e60 xi cfb0 
//26354 U+66f2 qi c7fa


end event

event ue_keyboard_painted;ib_keyboard_fingering_painted = true
return
Sleep(1)
if ib_auto_fingering then
	if ii_current_note >= ii_interval_begin and ii_current_note < ii_interval_end then
		ii_current_note++
		if ii_current_note = ii_interval_end then
			if il_moving_ind = 0 then //repeat
				ii_current_note = ii_interval_begin
			end if		
		 	ib_auto_fingering = false
		end if
		wf_rec_move(is_cur_text_list[ii_current_note])
		wf_send_note(false)		
//		yield()
	end if
end if
end event

public subroutine wf_init_container ();// function name: wf_init_container()
// description: set up dimensions of objects in the window
// called by: open event()

long il_row, ll_width, ll_height
string ls_local_filename
gs_vedio_file = "NO"


if upperbound(is_picture_list) > 1 then // obtain original picture demension
	uo_1.uo_1.is_picture_name = is_picture_list[2]
//	ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + String(Today(), "yymd") + right(uo_1.uo_1.is_picture_name, 4)
	if pos(lower(uo_1.uo_1.is_picture_name),".jpg") > 0 or &
		pos(lower(uo_1.uo_1.is_picture_name),".bmp") > 0 or &
		pos(lower(uo_1.uo_1.is_picture_name),".gif") > 0 or &
		pos(lower(uo_1.uo_1.is_picture_name),".png") > 0 then
//		ls_local_filename = "t1.png"
//		f_GetCacheResourceFile(uo_1.uo_1.is_picture_name, ls_local_filename)
//		MessageBox(ls_local_filename,uo_1.uo_1.is_picture_name)
		f_set_picture_with_cache_resource2(uo_1.uo_1.is_picture_name, uo_1.uo_1.p_1, ll_width, ll_height)
//		GetGraphDim(ls_local_filename, ll_width, ll_height)
		uo_1.uo_1.il_width = PixelsToUnits(ll_width, XPixelsToUnits!)
		uo_1.uo_1.il_height = PixelsToUnits(ll_height, YPixelsToUnits!)
		idb_width_ratio = 1.0
		idb_height_ratio = 1.0
		uo_1.uo_1.height = uo_1.uo_1.il_height
		uo_1.uo_1.p_1.width = uo_1.uo_1.il_width
		uo_1.uo_1.p_1.height = uo_1.uo_1.il_height

		uo_1.uo_1.x = 0
		uo_1.uo_1.y = 0
		uo_1.uo_1.p_1.x = 0
		uo_1.uo_1.p_1.y = 0
		uo_1.UnitsPerLine = (uo_1.uo_1.il_height + 100 - uo_1.height)/100 	// 
		uo_1.LinesPerPage = 2								// UnitsPerPage = UnitsPerLine*LinesPerPage

	end if
	
//	uo_1.uo_1.p_1.y = uo_1.uo_1.y + 20
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

public function string wf_seq_to_note (integer ai_seq);/*
integer li_i
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
*/


integer li_i, ll_level
string ls_level, ls_scale_note
string ls_note_list[] = {"C","C","D","D","E","F","F","G","G","A","A","B"}
string ls_sharp_list[] = {"","#","","#","","","#","","#","","#",""}

if ai_seq = 0 then return ""

ll_level = ai_seq/12
li_i = mod(ai_seq, 12)
ls_scale_note = ls_note_list[li_i + 1] + ls_sharp_list[li_i + 1] + string(ll_level)

return ls_scale_note

// NEW FORMAT
//  C       D       E   F       G       A       B   Level
//     C#      D#          F#      G#      A#
//  *       *       *   *       *       *       *
//      1   2   3   4   5   6   7   8   9  10  11   0
// 12  13  14  15  16  17  18  19  20  21  22  23   1
// 24  25  26  27  28  29  30  31  32  33  34  35   2
// 36  37  38  39  40  41  42  43  44  45  46  47   3
// 48  49  50  51  52  53  54  55  56  57  58  59   4
// 60  61  62  63  64  65  66  67  68  69  70  71   5
// 72  73  74  75  76  77  78  79  80  81  82  83   6
// 84  85  86  87  88  89  90  91  92  93  94  95   7
// 96  97  98  99 100 101 102 103 104 105 106 107   8
//108                                               9
//
//
//a natural key can be determined by mod 12 with remaining of 0 2 4 5 7 9 or 11
//and on contrery a non-natural key by mod 12 with remaining of 1 3 6 8 or 10

//piano beginning at 21 and end at 108 (totally there are 88 keys)

//hex	dec	Score
//24	36	C1
//25		C1#
//30	48	C2
//3C	60	C3
//48	72	C4
//54	84	C5
//12	C
//24	C0
//25	C0#
//26	D0
//27	D0#
//28	E0
//29	F0
//30	F0#
//31	G0
//32	G0#
//33	A0
//34	A0#
//35	B0
//36	



end function

public subroutine wf_reset_pos ();long ll_i, ll_pb_win_handle,ll_lo_note,ll_hi_note,ll_prim_or_second,ll_prompt_ind,ll_finger_prompt_ind
string ls_shmem_buf, msg, ls_dev_name2 = "dummy"
string ls_title = "Piano"
string ls_dll_name, ls_dll_func_name
ls_dll_name = "MusicLesson.dll"
ulong lul_startPlayer, llextStartPianoThread
ll_pb_win_handle = handle(this)
try
ii_prompt_ind = dw_prompt.GetItemNumber(1, "prompt_ind")
dw_prompt.Modify("prompt_ind.dddw.Lines=13")
//MessageBox("wf_reset_post 1",ii_prompt_ind)
if not ib_data_process then // First time call to process left-right note
//	ii_prompt_ind = 11
	il_moving_ind = 1
	wf_get_lesson_name()
//	wf_set_cust_control()
	ib_data_process = true	
	is_finger_prompt = "01"
	wf_get_rh_lh_note_list()
	wf_load_finger_graphs()
//	MessageBox("wf_reset_post","4")
	if ib_both_exists then
		if ii_prompt_ind < 0 or ii_prompt_ind > 12 then
			ii_prompt_ind = 11
		end if
	elseif ib_right_exists then
		if ii_prompt_ind < 0 or ii_prompt_ind > 5 then
			ii_prompt_ind = 3
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
//MessageBox("wf_reset_post 2",ii_prompt_ind)

if not ib_reset_pos then // first time this funciton called
	ib_reset_pos = true
	uo_1.x = 150
	uo_1.width = width - 300
	if is_finger_prompt = "01" then
		p_keyboard1.height = p_keyboard1.height + p_keyboard1.height/2	
	end if
	ii_keyboard_height = p_keyboard1.height
	uo_1.height = (height - p_keyboard1.height) - 400
	p_keyboard1.x = uo_1.x
	p_keyboard1.width = uo_1.width
	p_keyboard1.y = uo_1.y + uo_1.height + 20
	uo_1.uo_1.width = uo_1.width
	if uo_1.uo_1.il_width > 0 then // there is a valid music sheet, center the music sheet picture
		uo_1.uo_1.p_1.x = (uo_1.uo_1.width - uo_1.uo_1.il_width)/2
	end if
	wf_set_cust_control()

	ii_begin_note = 2
	ii_current_note = ii_begin_note
	wf_set_current_data_array()
	wf_get_high_low_notes()	
	ii_end_note = upperbound(is_cur_text_list)	
	
	il_pb_win_handle = handle(this)
	//end if
	
	ll_lo_note = ii_low_note
	ll_hi_note = ii_high_note
	//MessageBox("wf_reset_pos " + string(ii_low_note), ii_high_note)
	ll_prim_or_second = 1
//	ll_prompt_ind = ii_prompt_ind
	ll_finger_prompt_ind = long(is_finger_prompt)
	//MessageBox(string(ll_lo_note), ll_hi_note)
	extSetKeyboardParms(ll_pb_win_handle,ll_lo_note,ll_hi_note,ll_prim_or_second,11,ll_finger_prompt_ind,is_right_dev_name,ls_dev_name2) 
	//MessageBox("is_right_dev_name", is_right_dev_name)
	il_kb_handle = handle(p_keyboard1)
	il_kb_dc = GetDC(il_kb_handle)
	if il_thread_id = 0 then
		extStartPianoThread2(ll_pb_win_handle,il_kb_handle,il_kb_dc,is_startupfile,il_thread_id)
	//	il_thread_id = 1
	end if
	
	p_left.SetFocus()
else	
	if ii_prompt_ind = 0 or ii_prompt_ind = 1 or ii_prompt_ind = 5 or ii_prompt_ind = 9 then
		uo_1.height = height - 400	
		p_keyboard1.height = 1
		
	else
		uo_1.height = (height - p_keyboard1.height) - 400
		p_keyboard1.height = ii_keyboard_height		
	end if
	
end if
//MessageBox("wf_reset_post 3",ii_prompt_ind)
p_1.x = p_keyboard1.x
p_1.y = p_keyboard1.y
p_1.width = p_keyboard1.width
p_1.height = p_keyboard1.height
if ii_moving_interval_type = 1 then // one note advance
	p_1.visible = false
	p_1.BringToTop = false
	p_keyboard1.visible = true
else			// animation like
	if mod(ii_prompt_ind, 4) > 1 then
		p_1.visible = true
		p_1.BringToTop = true
	end if
	p_keyboard1.visible = false
end if
//ii_prompt_ind = ll_prompt_ind
//MessageBox("wf_reset_post 4",ii_prompt_ind)

ii_begin_note = 2
ii_current_note = ii_begin_note
wf_set_current_data_array()
//wf_get_high_low_notes()	
ii_end_note = upperbound(is_cur_text_list)


uo_1.uo_1.st_11.visible = (ii_prompt_ind > 0)
uo_1.uo_1.st_2.visible = (ii_prompt_ind > 0)
uo_1.uo_1.st_3.visible = (ii_prompt_ind > 0)
uo_1.uo_1.st_4.visible = (ii_prompt_ind > 0)
uo_1.uo_1.st_start.visible = (ii_prompt_ind > 0)
uo_1.uo_1.st_end.visible = (ii_prompt_ind > 0)
uo_1.UnitsPerLine = (uo_1.uo_1.il_height + 100 - uo_1.height)/100 	// 

// just scroll all the way up
for ll_i = 1 to 100/uo_1.LinesPerPage
	Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3 DOWN
next

post wf_set_bar(1, ii_begin_note)
post wf_set_bar(2, ii_end_note)

wf_rec_move(is_cur_text_list[ii_current_note])
wf_send_note(true)		

return
visible = true
ii_p_1_y_orig = uo_1.uo_1.p_1.y
//cb_start.visible = true
ib_playing_token = true

CATCH(RuntimeError re1)
	msg = "Class=" + re1.Class + " Line=" + string(re1.Line) + " Number=" + string(re1.Number) + " RoutineName=" + re1.RoutineName + " Text=" + re1.Text
	MessageBox("msg", msg)
END TRY
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
elseif pos(as_note, "6") > 0 then
	ll_level = 6
elseif pos(as_note, "7") > 0 then
	ll_level = 7
elseif pos(as_note, "8") > 0 then
	ll_level = 8
elseif pos(as_note, "9") > 0 then
	ll_level = 9
else
	ll_level = 0
end if

ll_level = ll_level + 2
li_seq = 12*ll_level + li_i - 1


return li_seq
end function

public function boolean wf_note_clicked (integer ai_x, integer ai_y);// function name: wf_note_clicked
// parms: ai_x = the x coordinate where the left button of the mouse is clicked
//        ai_y = the y coordinate where the left button of the mouse is clicked

integer li_BeginX, li_BeginY, li_EndX, li_EndY

if not uo_1.uo_1.st_11.visible then return false

li_BeginX = uo_1.uo_1.st_11.x - uo_1.uo_1.p_1.x
li_BeginY = uo_1.uo_1.st_11.y - uo_1.uo_1.p_1.y 
li_EndX = uo_1.uo_1.st_3.x - uo_1.uo_1.p_1.x
li_EndY = uo_1.uo_1.st_4.y - uo_1.uo_1.p_1.y

if ai_x >= li_BeginX and ai_x <= li_EndX and ai_y >= li_BeginY and ai_y <= li_EndY then
	return true
end if

return false

end function

public subroutine wf_get_high_low_notes ();// function name: wf_get_high_low_notes
// description: get high and low notes for this lesson

string ls_note_coordinate,ls_note_to_keyboard, ls_empty_list[], ls_note_list
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
integer li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count
integer li_current_note,li_total_increment,i,li_i,li_min_note,li_max_note
string ls_header

ii_high_note = 0
ii_low_note = 120
integer file_num
//file_num = FileOpen("t1.txt", LineMode!, Write!, LockWrite!, Replace!)
//for li_i = 2 to upperbound(is_cur_text_list)
for li_i = 2 to upperbound(is_text_list)
	ls_rh_time_fraction = ls_empty_list
	ls_rh_note_value = ls_empty_list
	ls_rh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	ls_lh_time_fraction = ls_empty_list
	ls_lh_note_value = ls_empty_list
	ls_lh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	li_total_note_set_count = 0
	li_lh_note_set_count = 0
	wf_parse_note_attribute(is_text_list[li_i],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
		ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)	
	ls_note_list = ""
	for i=1 to li_rh_note_set_count
		if integer(ls_rh_note_value[i]) > 0 then
			if integer(ls_rh_note_value[i]) > ii_high_note and integer(ls_rh_note_value[i]) > 0 then ii_high_note = integer(ls_rh_note_value[i])
			if integer(ls_rh_note_value[i]) < ii_low_note and integer(ls_rh_note_value[i]) > 0 then ii_low_note = integer(ls_rh_note_value[i])
			ls_note_list = ls_note_list + ls_rh_note_value[i] + " "
		end if
	next
	for i=1 to li_lh_note_set_count
		if integer(ls_lh_note_value[i]) > 0 then
			if integer(ls_lh_note_value[i]) > ii_high_note and integer(ls_lh_note_value[i]) > 0 then ii_high_note = integer(ls_lh_note_value[i])
			if integer(ls_lh_note_value[i]) < ii_low_note and integer(ls_lh_note_value[i]) > 0 then ii_low_note = integer(ls_lh_note_value[i])
			ls_note_list = ls_note_list + ls_lh_note_value[i] + " "
		end if
	next
//	FileWrite(file_num, string(li_i, "000") + " " + ls_note_list + " ii_low_note:" + string(ii_low_note) + " ii_high_note:" + string(ii_high_note))
next
li_min_note = ii_low_note
li_max_note = ii_high_note
//MessageBox(string(ii_low_note), ii_high_note)

li_total_increment = li_max_note - li_min_note + 1

if li_total_increment < 34 then
	li_max_note = li_max_note + (34 - li_total_increment)/2
	li_min_note = li_min_note - (34 - li_total_increment)/2
end if

if not IsNaturalNote(li_min_note) then 
	li_min_note = li_min_note - 1
end if

if not IsNaturalNote(li_max_note) then 
	li_max_note = li_max_note + 1
end if

ii_low_note = li_min_note
ii_high_note = li_max_note

ls_header = is_text_list[1]
//MessageBox("ls_header", ls_header)
if len(ls_header) = 19 then
	li_min_note = integer(left(right(ls_header, 6), 3))
	li_max_note = integer(right(ls_header, 3))
	if li_min_note <= ii_low_note and li_max_note >= ii_high_note then
		ii_low_note = li_min_note
		ii_high_note = li_max_note		
	end if
end if
//FileWrite(file_num, "999 " + " ii_low_note:" + string(ii_low_note) + " ii_high_note:" + string(ii_high_note))
//FileClose(file_num)

end subroutine

public function integer wf_get_note_num (integer ai_bar, integer ai_x, integer ai_y);// wf_get_note_num: called by set bar
// parms: ai_bar = begin or end bar indicator, 1=begin bar, 2=end bar
// description: to find the note in music sheet that next to the range bar
//              it is used in reset the range bar when they are dragged


integer li_current_note//, li_note
integer li_BeginX, li_BeginY, li_EndX, li_EndY, li_width, li_height

// set car depending on right hand or left hand
//ii_prompt_ind 
if ai_bar = 1 then // begin bar
	for li_current_note = 2 to upperbound(is_cur_text_list)
		li_BeginX = integer(mid(is_cur_text_list[li_current_note], 1, 4))*idb_width_ratio + uo_1.uo_1.p_1.x
		li_BeginY = integer(mid(is_cur_text_list[li_current_note], 5, 5))*idb_height_ratio + uo_1.uo_1.p_1.y
		li_EndX = integer(mid(is_cur_text_list[li_current_note], 10, 4))*idb_width_ratio + uo_1.uo_1.p_1.x
		li_EndY = integer(mid(is_cur_text_list[li_current_note], 14, 5))*idb_height_ratio + uo_1.uo_1.p_1.y
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
		li_BeginX = integer(mid(is_cur_text_list[li_current_note], 1, 4))*idb_width_ratio + uo_1.uo_1.p_1.x
		li_BeginY = integer(mid(is_cur_text_list[li_current_note], 5, 5))*idb_height_ratio + uo_1.uo_1.p_1.y
		li_EndX = integer(mid(is_cur_text_list[li_current_note], 10, 4))*idb_width_ratio + uo_1.uo_1.p_1.x
		li_EndY = integer(mid(is_cur_text_list[li_current_note], 14, 5))*idb_height_ratio + uo_1.uo_1.p_1.y
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
li_BeginX = integer(mid(is_cur_text_list[li_current_note], 1, 4))*idb_width_ratio + uo_1.uo_1.p_1.x
li_BeginY = integer(mid(is_cur_text_list[li_current_note], 5, 5))*idb_height_ratio + uo_1.uo_1.p_1.y
li_EndX = integer(mid(is_cur_text_list[li_current_note], 10, 4))*idb_width_ratio + uo_1.uo_1.p_1.x
li_EndY = integer(mid(is_cur_text_list[li_current_note], 14, 5))*idb_height_ratio + uo_1.uo_1.p_1.y
li_width = li_EndX - li_BeginX
li_height = li_EndY - li_BeginY
if ai_bar = 1 then // begin bar
	uo_1.uo_1.st_start.x = li_BeginX - li_width/2
	uo_1.uo_1.st_start.y = li_BeginY
	uo_1.uo_1.st_start.height = li_height
	ii_begin_note = ai_note
//	wf_rec_move(is_cur_text_list[li_current_note])
//	MessageBox("wf_set_bar ii_begin_note", ii_begin_note)
	ii_current_note = ii_begin_note
	wf_rec_move(is_cur_text_list[ii_begin_note])
	wf_send_note(true)
//	ls_note_to_keyboard = right(is_cur_text_list[li_current_note], len(is_cur_text_list[li_current_note]) - 16)
//	Send(il_player_handle, 1027, ii_prompt_ind, 0)
	ls_note_to_keyboard = mid(is_cur_text_list[ii_begin_note], 19, len(is_cur_text_list[ii_begin_note]) - 18)
//	if mod(len(ls_note_to_keyboard)/8, 2) = 1 then ls_note_to_keyboard = ls_note_to_keyboard + "00000000"
//	extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
//	Send(il_player_handle, 1025, 0, 0)
	uo_1.uo_1.st_start.BringToTop = true
	uo_1.uo_1.st_end.BringToTop = true
	uo_1.uo_1.st_start.visible = (ii_prompt_ind > 0)
	uo_1.uo_1.st_end.visible = (ii_prompt_ind > 0)
else
	uo_1.uo_1.st_end.x = li_EndX + li_width/2
	uo_1.uo_1.st_end.y = li_BeginY
	uo_1.uo_1.st_end.height = li_height
	uo_1.uo_1.st_end.BringToTop = true
	uo_1.uo_1.st_start.BringToTop = true
	uo_1.uo_1.st_start.visible = (ii_prompt_ind > 0)
	uo_1.uo_1.st_end.visible = (ii_prompt_ind > 0)
	ii_end_note = ai_note
end if
	
end subroutine

public subroutine wf_set_token (boolean ab_value);//
ib_busy_token = ab_value
end subroutine

public function integer wf_get_rh_lh_note_list ();
// function name: wf_get_rh_lh_note_list
// description: to get note lists of left hand, right hand, and both hand from the input list, is_text_list

string msg, ls_fingering = ""
string ls_note_coordinate,ls_note_to_keyboard, ls_empty_list[]
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
string ls_rh_time_fraction1[],ls_rh_note_value1[],ls_rh_note_char1[],ls_rh_note_finger1[]
string ls_lh_time_fraction1[],ls_lh_note_value1[],ls_lh_note_char1[],ls_lh_note_finger1[]
string ls_rh_time_fraction0[],ls_rh_note_value0[],ls_rh_note_char0[],ls_rh_note_finger0[]
string ls_lh_time_fraction0[],ls_lh_note_value0[],ls_lh_note_char0[],ls_lh_note_finger0[]
string ls_rh_time_fraction00[],ls_rh_note_value00[],ls_rh_note_char00[],ls_rh_note_finger00[]
string ls_lh_time_fraction00[],ls_lh_note_value00[],ls_lh_note_char00[],ls_lh_note_finger00[]
string ls_finger_entry_list[], ls_finger_attr
integer li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, li_note_set_count
integer li_total_note_set_count1,li_rh_note_set_count1,li_lh_note_set_count1
integer li_total_note_set_count0=0,li_rh_note_set_count0=0,li_lh_note_set_count0=0
integer li_total_note_set_count00=0,li_rh_note_set_count00=0,li_lh_note_set_count00=0
integer li_current_note, li_entry_count, li_pos1, li_pos2, li_fingering_ind, ii_rh_note_tmp, ii_lh_note_tmp

integer li_i, li_j,li_k,li_k1, li_first_head = 0, li_second_head = 0, li_first_tail = 0, li_second_tail = 0
integer li_l,li_r,li_b,li_l_begin,li_r_begin,li_b_begin,li_l_end,li_r_end,li_b_end
integer li_total_note_count, li_right_hand_note_count, li_left_hand_note_count
string ls_note, ls_note_wing, ls_finger_entry
boolean lb_true_note, lb_rh_true_note, lb_lh_true_note
string ls_measure_size, ls_header
double ldb_measure_size, ldb_right_offset, ldb_left_offset, ldb_both_offset
double ldb_right, ldb_left, ldb_right_cur, ldb_left_cur, ldb_tmp, ldb_tmp1

//integer ii_measure_begin_index[], ii_measure_end_index[]

ls_header = is_text_list[1]
ls_measure_size = mid(ls_header, 2, 4)
ldb_measure_size = wf_string_to_fraction(ls_measure_size)
ldb_right_offset = wf_string_to_fraction(mid(ls_header, 6, 4))
ldb_left_offset = wf_string_to_fraction(mid(ls_header, 10, 4))

if ldb_right_offset > ldb_left_offset then
	ldb_both_offset = ldb_right_offset
else
	ldb_both_offset = ldb_left_offset
end if

for li_i = 1 to 5
	idb_right_note_duration0[li_i] = 0.0
	idb_left_note_duration0[li_i] = 0.0
next

integer li_num3, li_num1, li_num2, li_num
//		li_num1 = FileOpen("right.txt", LineMode!, Write!, LockWrite!, Replace!)
//		li_num2 = FileOpen("left.txt", LineMode!, Write!, LockWrite!, Replace!)
//		li_num3 = FileOpen("both.txt", LineMode!, Write!, LockWrite!, Replace!)
		li_num = FileOpen("dummy.txt", LineMode!, Write!, LockWrite!, Replace!)


// to find the existence of RH, LH, and Both hand note
for li_i = 2 to upperbound(is_text_list)
	if pos(is_text_list[li_i], "repeat") > 0 then continue
	ls_rh_time_fraction = ls_empty_list
	ls_rh_note_value = ls_empty_list
	ls_rh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	ls_lh_time_fraction = ls_empty_list
	ls_lh_note_value = ls_empty_list
	ls_lh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	li_total_note_set_count = 0
	li_total_note_set_count = 0
	li_lh_note_set_count = 0
	wf_parse_note_attribute(is_text_list[li_i],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
		ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)	
//	MessageBox("is_text_list[li_i]", is_text_list[li_i])
	for li_j = 1 to li_rh_note_set_count
		if ls_rh_note_value[li_j] <> "000" then ib_right_exists = true
	next
	for li_j = 1 to li_lh_note_set_count
		if ls_lh_note_value[li_j] <> "000" then ib_left_hand_exists = true
	next
next

if ib_left_hand_exists and ib_right_exists then ib_both_exists = true


li_l_begin = 2
li_r_begin = 2
li_b_begin = 2

//MessageBox("title", title)
//MessageBox("upperbound(is_text_list)", upperbound(is_text_list))

//MessageBox("upperbound(is_text_list)", upperbound(is_text_list))
is_rh_text_list[1] = is_text_list[1]
is_lh_text_list[1] = is_text_list[1]
is_bh_text_list[1] = is_text_list[1]
is_rh_wave_list[1] = is_wave_list[1]
is_lh_wave_list[1] = is_wave_list[1]
is_bh_wave_list[1] = is_wave_list[1]
is_rh_picture_list[1] = is_picture_list[1]
is_lh_picture_list[1] = is_picture_list[1]
is_bh_picture_list[1] = is_picture_list[1]
is_rh_finger_list[1] = is_finger_list[1]
is_lh_finger_list[1] = is_finger_list[1]
is_bh_finger_list[1] = is_finger_list[1]
ii_rh_list_index[1] = 1
ii_lh_list_index[1] = 1
ii_bh_list_index[1] = 1

try
for li_i = 2 to upperbound(is_text_list)
	//note attribute redistribution
	//
	//1) merge last note attributes with the current note attributes
	//2) build the new note attributes with minimum time duration for the attributes
	//3) generate the remaining attributes which are those notes that have the 
	//   remaining time duration greater than 0
	//4) repeat the loop	
	//get repeat note information
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
//		is_bh_text_list[upperbound(is_bh_text_list) + 1] = is_text_list[li_i]
		is_bh_wave_list[upperbound(is_bh_wave_list) + 1] = is_wave_list[li_i]
		is_bh_picture_list[upperbound(is_bh_picture_list) + 1] = is_picture_list[li_i]
		if is_finger_list[li_i] <> "FB9FE" then ls_fingering = is_finger_list[li_i] 
		is_bh_finger_list[upperbound(is_bh_finger_list) + 1] = ls_fingering
	end if
	
	ls_rh_time_fraction = ls_empty_list
	ls_rh_note_value = ls_empty_list
	ls_rh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	ls_lh_time_fraction = ls_empty_list
	ls_lh_note_value = ls_empty_list
	ls_lh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	ls_lh_note_finger = ls_empty_list
	li_total_note_set_count = 0
	li_lh_note_set_count = 0
	li_rh_note_set_count = 0
	ls_rh_time_fraction1 = ls_empty_list
	ls_rh_note_value1 = ls_empty_list
	ls_rh_note_char1 = ls_empty_list
	ls_rh_note_finger1 = ls_empty_list
	ls_lh_time_fraction1 = ls_empty_list
	ls_lh_note_value1 = ls_empty_list
	ls_lh_note_char1 = ls_empty_list
	ls_rh_note_finger1 = ls_empty_list
	ls_lh_note_finger1 = ls_empty_list
	li_total_note_set_count1 = 0
	li_lh_note_set_count1 = 0
	li_rh_note_set_count1 = 0
	wf_parse_note_attribute(is_text_list[li_i],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
		ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)
	wf_parse_note_attribute(is_text_list[li_i],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count1,li_rh_note_set_count1,li_lh_note_set_count1, &
		ls_rh_time_fraction1,ls_lh_time_fraction1,ls_rh_note_value1,ls_lh_note_value1,ls_rh_note_char1,ls_lh_note_char1,ls_rh_note_finger1,ls_lh_note_finger1)

	// process measure count information
	ii_rh_note_tmp = 0 
	ii_lh_note_tmp = 0
	if ib_right_exists then	// use righthand info
		//  find max time
		ldb_right_cur = 0
		for li_j = 1 to upperbound(ls_rh_time_fraction)
			ldb_tmp = wf_string_to_fraction(ls_rh_time_fraction[li_j])
			if ldb_right_cur < ldb_tmp then ldb_right_cur = ldb_tmp
		next
	end if
	ldb_right = ldb_right + ldb_right_cur
	if ib_left_hand_exists then
		//  find max time
		ldb_left_cur = 0
		for li_j = 1 to upperbound(ls_lh_time_fraction)
			ldb_tmp = wf_string_to_fraction(ls_lh_time_fraction[li_j])
			if ldb_left_cur < ldb_tmp then ldb_left_cur = ldb_tmp
		next	
	end if
	ldb_left = ldb_left + ldb_left_cur
	

	// reset time duration
	for li_j = 1 to 5
		idb_right_note_duration[li_j] = 0.0
		idb_left_note_duration[li_j] = 0.0
	next
	idb_min_duration = 10.0
	idb_left_min_duration = 10.0
	idb_right_min_duration = 10.0
	// convert time fraction
	for li_j = 1 to li_rh_note_set_count
		ii_rh_note_tmp = ii_rh_note_tmp + integer(ls_rh_note_value[li_j])
		idb_right_note_duration[li_j] = wf_string_to_fraction(ls_rh_time_fraction[li_j])
		idb_right_note_duration1[li_j] = wf_string_to_fraction(ls_rh_time_fraction1[li_j])
	next
//	if li_rh_note_set_count > 0 then
//		FileWrite(li_num, string(li_i) + " " + ls_rh_time_fraction[1] + " " + string(idb_right_note_duration[1]))
//	end if
	for li_j = 1 to li_lh_note_set_count
		idb_left_note_duration[li_j] = wf_string_to_fraction(ls_lh_time_fraction[li_j])
		idb_left_note_duration1[li_j] = wf_string_to_fraction(ls_lh_time_fraction1[li_j])
	next
	// merge previous righthand note set with current note set
	for li_j = 1 to li_rh_note_set_count	
		if li_rh_note_set_count0 > 0 then
			for li_k = 1 to li_rh_note_set_count0
				if ls_rh_note_value[li_j] = ls_rh_note_value0[li_k] then
					idb_right_note_duration[li_j] = idb_right_note_duration[li_j] + idb_right_note_duration0[li_k]
					idb_right_note_duration0[li_k] = 0
				end if
			next
		end if
	next
	for li_j = 1 to li_rh_note_set_count1	
		if li_rh_note_set_count00 > 0 then
			for li_k = 1 to li_rh_note_set_count00
				if ls_rh_note_value1[li_j] = ls_rh_note_value00[li_k] then
					idb_right_note_duration1[li_j] = idb_right_note_duration1[li_j] + idb_right_note_duration00[li_k]
					idb_right_note_duration00[li_k] = 0
				end if
			next
		end if
	next
	li_k = li_rh_note_set_count
	// add previous note set that are not found in the current note set to the the current note set
	for li_j = 1 to li_rh_note_set_count0
		if idb_right_note_duration0[li_j] > 0 then
			li_k = li_k + 1
			ls_rh_note_value[li_k] = ls_rh_note_value0[li_j]
			ls_rh_time_fraction[li_k] = wf_fraction_to_string(idb_right_note_duration0[li_j])
			ls_rh_note_finger[li_k] = ls_rh_note_finger0[li_j]
			ls_rh_note_char[li_k] = "2"
		end if
	next
	li_rh_note_set_count = li_k
	li_k = li_rh_note_set_count1
	// add previous note set that are not found in the current note set to the the current note set
	for li_j = 1 to li_rh_note_set_count00
		if idb_right_note_duration00[li_j] > 0 then
			li_k = li_k + 1
			ls_rh_note_value1[li_k] = ls_rh_note_value00[li_j]
			ls_rh_time_fraction1[li_k] = wf_fraction_to_string(idb_right_note_duration00[li_j])
			ls_rh_note_finger1[li_k] =   ls_rh_note_finger00[li_j]
			ls_rh_note_char1[li_k] = "2"
		end if
	next
	li_rh_note_set_count1 = li_k
	// find the minimum time duration
	idb_right_min_duration = 10.0
	for li_j = 1 to li_rh_note_set_count	
		if idb_right_min_duration > idb_right_note_duration[li_j] and idb_right_note_duration[li_j] > 0.0 then 
			idb_right_min_duration = idb_right_note_duration[li_j]
		end if
	next	
	idb_right_min_duration1 = 10.0
	for li_j = 1 to li_rh_note_set_count1	
		if idb_right_min_duration1 > idb_right_note_duration1[li_j] and idb_right_note_duration1[li_j] > 0.0 then 
			idb_right_min_duration1 = idb_right_note_duration1[li_j]
		end if
	next	
	
	// convert time fraction
	for li_j = 1 to li_lh_note_set_count
		ii_lh_note_tmp = ii_lh_note_tmp + integer(ls_lh_note_value[li_j])
		idb_left_note_duration[li_j] = wf_string_to_fraction(ls_lh_time_fraction[li_j])
		idb_left_note_duration1[li_j] = wf_string_to_fraction(ls_lh_time_fraction1[li_j])
	next
	// merge previous left note set with current note set
	for li_j = 1 to li_lh_note_set_count	
		if li_lh_note_set_count0 > 0 then
			for li_k = 1 to li_lh_note_set_count0
				if ls_lh_note_value[li_j] = ls_lh_note_value0[li_k] then
					idb_left_note_duration[li_j] = idb_left_note_duration[li_j] + idb_left_note_duration0[li_k]
					idb_left_note_duration0[li_k] = 0
				end if
			next
		end if
	next
	for li_j = 1 to li_lh_note_set_count1	
		if li_lh_note_set_count00 > 0 then
			for li_k = 1 to li_lh_note_set_count00
				if ls_lh_note_value1[li_j] = ls_lh_note_value00[li_k] then
					idb_left_note_duration1[li_j] = idb_left_note_duration1[li_j] + idb_left_note_duration00[li_k]
					idb_left_note_duration00[li_k] = 0
				end if
			next
		end if
	next
	li_k = li_lh_note_set_count
	// add previous note set that are not found in the current note set to the the current note set
	for li_j = 1 to li_lh_note_set_count0
		if idb_left_note_duration0[li_j] > 0 then 
			li_k = li_k + 1
			ls_lh_note_value[li_k] = ls_lh_note_value0[li_j]
			ls_lh_time_fraction[li_k] = wf_fraction_to_string(idb_left_note_duration0[li_j])
			ls_lh_note_finger[li_k] = ls_lh_note_finger0[li_j]
			ls_lh_note_char[li_k] = "2"		// continuous note
		end if
	next
	li_lh_note_set_count = li_k
	
	li_k = li_lh_note_set_count1
	for li_j = 1 to li_lh_note_set_count00
		if idb_left_note_duration00[li_j] > 0 then
			li_k = li_k + 1
			ls_lh_note_value1[li_k] = ls_lh_note_value00[li_j]
			ls_lh_time_fraction1[li_k] = wf_fraction_to_string(idb_left_note_duration00[li_j])
			ls_lh_note_finger1[li_k] = ls_lh_note_finger00[li_j]
			ls_lh_note_char1[li_k] = "2"
		end if
	next
	li_lh_note_set_count1 = li_k
	// find the minimum time duration
	idb_left_min_duration = 10.0
	for li_j = 1 to li_lh_note_set_count	
		if idb_left_min_duration > idb_left_note_duration[li_j] and idb_left_note_duration[li_j] > 0.0 then 
			idb_left_min_duration = idb_left_note_duration[li_j]
		end if
	next	
	
	idb_min_duration = 10.0
	for li_j = 1 to li_rh_note_set_count1
		if idb_min_duration > idb_right_note_duration1[li_j] and idb_right_note_duration1[li_j] > 0.0 then 
			idb_min_duration = idb_right_note_duration1[li_j]
		end if
	next	
	for li_j = 1 to li_lh_note_set_count1
		if idb_min_duration > idb_left_note_duration1[li_j] and idb_left_note_duration1[li_j] > 0.0 then 
			idb_min_duration = idb_left_note_duration1[li_j]
		end if
	next	
	
	// generate new right hand set
	for li_j = 1 to 5
		idb_left_note_duration0[li_j] = 0.0
		idb_right_note_duration0[li_j] = 0.0
		idb_left_note_duration00[li_j] = 0.0
		idb_right_note_duration00[li_j] = 0.0
	next				

	if li_rh_note_set_count > 0 then
		ls_rh_time_fraction[1] = wf_fraction_to_string(idb_right_min_duration) 	
//		FileWrite(li_num, string(li_i) + " ls_rh_time_fraction[1] " + ls_rh_time_fraction[1] + " idb_right_min_duration" + string(idb_right_min_duration))
//		FileWrite(li_num, string(li_i) + " ls_rh_time_fraction1[1] " + ls_rh_time_fraction[1] + " idb_min_duration" + string(idb_min_duration))
		li_k = 0
		for li_j = 1 to li_rh_note_set_count	
			ls_rh_time_fraction[li_j] = ls_rh_time_fraction[1]
			idb_right_note_duration[li_j] = idb_right_note_duration[li_j] - idb_right_min_duration
			if idb_right_note_duration[li_j] > 0 then // create remaining note set
				li_k = li_k + 1
				idb_right_note_duration0[li_k] = idb_right_note_duration[li_j]
				ls_rh_note_value0[li_k] = ls_rh_note_value[li_j]
				ls_rh_note_finger0[li_k] = ls_rh_note_finger[li_j]
			end if 
		next	
		li_rh_note_set_count0 = li_k
	else
		li_rh_note_set_count0 = 0
	end if
	
	if li_rh_note_set_count1 > 0 then
		ls_rh_time_fraction1[1] = wf_fraction_to_string(idb_min_duration) 	
		li_k = 0
		for li_j = 1 to li_rh_note_set_count1	
			ls_rh_time_fraction1[li_j] = ls_rh_time_fraction1[1]
			idb_right_note_duration1[li_j] = idb_right_note_duration1[li_j] - idb_min_duration
			if idb_right_note_duration1[li_j] > 0 then // create remaining note set
				li_k = li_k + 1
				idb_right_note_duration00[li_k] = idb_right_note_duration1[li_j]
				ls_rh_note_value00[li_k] = ls_rh_note_value1[li_j]
				ls_rh_note_finger00[li_k] = ls_rh_note_finger1[li_j]
			end if 
		next		
		li_rh_note_set_count00 = li_k	
	else
		li_rh_note_set_count00 = 0
	end if
	
	if li_lh_note_set_count > 0 then
		ls_lh_time_fraction[1] = wf_fraction_to_string(idb_left_min_duration) 	
//		FileWrite(li_num, string(li_i) + " ls_lh_time_fraction[1] " + ls_lh_time_fraction[1] + " idb_left_min_duration" + string(idb_left_min_duration))
//		FileWrite(li_num, string(li_i) + " ls_lh_time_fraction1[1] " + ls_lh_time_fraction[1] + " idb_min_duration" + string(idb_min_duration))
		li_k = 0
		for li_j = 1 to li_lh_note_set_count	
			ls_lh_time_fraction[li_j] = ls_lh_time_fraction[1]
			idb_left_note_duration[li_j] = idb_left_note_duration[li_j] - idb_left_min_duration
			if idb_left_note_duration[li_j] > 0 then // create remaining note set
				li_k = li_k + 1
				idb_left_note_duration0[li_k] = idb_left_note_duration[li_j]
				ls_lh_note_value0[li_k] = ls_lh_note_value[li_j]
				ls_lh_note_finger0[li_k] = ls_lh_note_finger[li_j]
			end if 
		next	
		li_lh_note_set_count0 = li_k
	else
		li_lh_note_set_count0 = 0
	end if
	
	if li_lh_note_set_count1 > 0 then
		ls_lh_time_fraction1[1] = wf_fraction_to_string(idb_min_duration) 	
		li_k = 0
		for li_j = 1 to li_lh_note_set_count1	
			ls_lh_time_fraction1[li_j] = ls_lh_time_fraction1[1]
			idb_left_note_duration1[li_j] = idb_left_note_duration1[li_j] - idb_min_duration
			if idb_left_note_duration1[li_j] > 0 then // create remaining note set
				li_k = li_k + 1
				idb_left_note_duration00[li_k] = idb_left_note_duration1[li_j]
				ls_lh_note_value00[li_k] = ls_lh_note_value1[li_j]
				ls_lh_note_finger00[li_k] = ls_lh_note_finger1[li_j]
			end if 
		next		
		li_lh_note_set_count00 = li_k	
	else
		li_lh_note_set_count00 = 0
	end if	
		
	lb_rh_true_note = false
	ls_note_wing = ""
	for li_j = 1 to li_rh_note_set_count		
		if ls_rh_note_value[li_j] <> "000" then lb_rh_true_note = true 
		ls_note = ls_rh_time_fraction[li_j] + ls_rh_note_value[li_j] + ls_rh_note_char[li_j] + ls_rh_note_finger[li_j]
		ls_note_wing = ls_note_wing + ls_note
		if li_j < li_rh_note_set_count then		// pat the note attribute
			ls_note_wing = ls_note_wing + "000000000"
		end if
	next
	if lb_rh_true_note then // there are righthand notes
		ii_rh_list_index[upperbound(ii_rh_list_index) + 1] = li_i
		is_rh_text_list[upperbound(is_rh_text_list) + 1] = ls_note_coordinate + ls_note_wing
		is_rh_wave_list[upperbound(is_rh_wave_list) + 1] = is_wave_list[li_i]
		is_rh_picture_list[upperbound(is_rh_picture_list) + 1] = is_picture_list[li_i]
		// get right hand fingering graph ID
		if is_finger_list[li_i] <> "FB9FE" then ls_fingering = is_finger_list[li_i] 
		ls_finger_entry = ls_fingering
		li_pos1 = pos(ls_finger_entry, "FB")
		li_pos2 = pos(ls_finger_entry, "FE")		
		li_fingering_ind = integer(mid(ls_finger_entry, li_pos1 + 2, 1))
		if li_fingering_ind = REAPEAT_FINGERING or li_fingering_ind = NO_FINGERING then //
			is_rh_finger_list[upperbound(is_rh_finger_list)+1] = ls_fingering
		else
			ls_finger_attr = mid(ls_finger_entry, li_pos1 + 2, li_pos2 - li_pos1 - 2)
			ls_finger_entry_list = ls_empty_list
			li_entry_count = wf_parse_finger_entry(ls_finger_attr, ls_finger_entry_list)
			ls_finger_entry = "FB"
			for li_j = 1 to li_entry_count
				if left(ls_finger_entry_list[li_j], 1) = "2" then // get right finger entries
					ls_finger_entry = ls_finger_entry + ls_finger_entry_list[li_j] 
				end if
			next
			ls_finger_entry = ls_finger_entry + "FE"
			is_rh_finger_list[upperbound(is_rh_finger_list)+1] = 	ls_finger_entry	
			end if
	end if
	
	lb_lh_true_note = false
	ls_note_wing = ""
//	MessageBox(is_text_list[li_i], li_i)
//	MessageBox("'li_lh_note_set_count", li_lh_note_set_count)
//	MessageBox("Debug", "ls_lh_time_fraction:" + string(upperbound(ls_lh_time_fraction)) + " ls_lh_note_value:" + string(upperbound(ls_lh_note_value)) + &
//			" ls_lh_note_char:" + string(upperbound(ls_lh_note_char)) + " ls_lh_note_finger:" + string(upperbound(ls_lh_note_finger)))
	for li_j = 1 to li_lh_note_set_count
		if ls_lh_note_value[li_j] <> "000" then lb_lh_true_note = true
		ls_note = ls_lh_time_fraction[li_j] + ls_lh_note_value[li_j] + ls_lh_note_char[li_j] + ls_lh_note_finger[li_j]
		ls_note_wing = ls_note_wing + "000000000" + ls_note 
	next
//	MessageBox("ls_note_wing", ls_note_wing)
	if lb_lh_true_note then
		ii_lh_list_index[upperbound(ii_lh_list_index) + 1] = li_i
		is_lh_text_list[upperbound(is_lh_text_list) + 1] = ls_note_coordinate + ls_note_wing
		is_lh_wave_list[upperbound(is_lh_wave_list) + 1] = is_wave_list[li_i]
		is_lh_picture_list[upperbound(is_lh_picture_list) + 1] = is_picture_list[li_i]
		
		// get left hand fingering graph ID

		if is_finger_list[li_i] <> "FB9FE" then ls_fingering = is_finger_list[li_i] 
		ls_finger_entry = ls_fingering
		li_pos1 = pos(ls_finger_entry, "FB")
		li_pos2 = pos(ls_finger_entry, "FE")		
		li_fingering_ind = integer(mid(ls_finger_entry, li_pos1 + 2, 1))
		if li_fingering_ind = REAPEAT_FINGERING or li_fingering_ind = NO_FINGERING then 
			is_lh_finger_list[upperbound(is_lh_finger_list)+1] = ls_fingering
		else
			ls_finger_attr = mid(ls_finger_entry, li_pos1 + 2, li_pos2 - li_pos1 - 2)
			ls_finger_entry_list = ls_empty_list
			li_entry_count = wf_parse_finger_entry(ls_finger_attr, ls_finger_entry_list)
			ls_finger_entry = "FB"
			for li_j = 1 to li_entry_count
				if left(ls_finger_entry_list[li_j], 1) = "1" then
					ls_finger_entry = ls_finger_entry + ls_finger_entry_list[li_j] 
				end if
			next
			ls_finger_entry = ls_finger_entry + "FE"
			is_lh_finger_list[upperbound(is_lh_finger_list)+1] = 	ls_finger_entry					
		end if
	end if
	
	if ib_both_exists then
		ls_note_wing = ""
		if not lb_lh_true_note then li_lh_note_set_count = 0
		if not lb_rh_true_note then li_rh_note_set_count = 0
		if li_rh_note_set_count1 > li_lh_note_set_count1 then
			li_note_set_count = li_rh_note_set_count1
		else
			li_note_set_count = li_lh_note_set_count1
		end if
		if li_note_set_count = 0 then 
			ls_note_wing = "000000000000000000"
		else
			for li_j = 1 to li_note_set_count
				if li_j <= li_rh_note_set_count1 then 
					ls_note = ls_rh_time_fraction1[li_j] + ls_rh_note_value1[li_j] + ls_rh_note_char1[li_j] + ls_rh_note_finger1[li_j]
					ls_note_wing = ls_note_wing + ls_note 
				else
					ls_note_wing = ls_note_wing + "000000000"
				end if
				if li_j <= li_lh_note_set_count1 then
					ls_note = ls_lh_time_fraction1[li_j] + ls_lh_note_value1[li_j] + ls_lh_note_char1[li_j] + ls_lh_note_finger1[li_j]
					ls_note_wing = ls_note_wing + ls_note 
				else
					ls_note_wing = ls_note_wing + "000000000"
				end if
			next
		end if
		is_bh_text_list[upperbound(is_bh_text_list) + 1] = ls_note_coordinate + ls_note_wing
		ii_bh_list_index[upperbound(ii_bh_list_index) + 1] = li_i
end if	
	
	if ii_rh_note_tmp > 0 and upperbound(ii_measure_right_begin_index) = upperbound(ii_measure_right_end_index) then
		ii_measure_right_begin_index[upperbound(ii_measure_right_begin_index) + 1] = upperbound(is_rh_text_list)
	end if
	if ii_lh_note_tmp > 0 and upperbound(ii_measure_left_begin_index) = upperbound(ii_measure_left_end_index) then
		ii_measure_left_begin_index[upperbound(ii_measure_left_begin_index) +1] = upperbound(is_lh_text_list)
	end if
	if (ii_rh_note_tmp > 0 or ii_lh_note_tmp > 0) and upperbound(ii_measure_both_begin_index) = upperbound(ii_measure_both_end_index) then
		ii_measure_both_begin_index[upperbound(ii_measure_both_begin_index) +1] = upperbound(is_bh_text_list)
	end if
	
	if ib_right_exists then	
		if ldb_right > 0 and mod(ldb_right - ldb_right_offset, ldb_measure_size) = 0 and &
				upperbound(ii_measure_right_begin_index) - 1 = upperbound(ii_measure_right_end_index) then  // end of a right hand measure
			ii_measure_right_end_index[upperbound(ii_measure_right_end_index) + 1] = upperbound(is_rh_text_list)
		end if
	end if
		
	if ib_left_hand_exists then		
		if ldb_left > 0 and mod(ldb_left - ldb_left_offset, ldb_measure_size) = 0 and &
				upperbound(ii_measure_left_begin_index) - 1 = upperbound(ii_measure_left_end_index) then  // end of a left hand measure
			ii_measure_left_end_index[upperbound(ii_measure_left_end_index) + 1] = upperbound(is_lh_text_list)
		end if
	end if
	
	if ib_both_exists then	
		if ((ldb_right > 0 and mod(ldb_right - ldb_right_offset, ldb_measure_size) = 0) and &
				(ldb_left > 0 and mod(ldb_left - ldb_left_offset, ldb_measure_size) = 0)) and &
				(upperbound(ii_measure_both_begin_index) - 1 = upperbound(ii_measure_both_end_index)) then //end of a both hand measure
			ii_measure_both_end_index[upperbound(ii_measure_both_end_index) + 1] = upperbound(is_bh_text_list)
		end if
	end if	
	FileWrite(li_num, string(ldb_right) + " " + string(ldb_left))
	
//	if li_i <= upperbound(is_rh_text_list) then FileWrite(li_num1, is_rh_text_list[li_i])
//	if li_i <= upperbound(is_lh_text_list) then FileWrite(li_num2, is_lh_text_list[li_i])
//	if li_i <= upperbound(is_bh_text_list) then FileWrite(li_num3, is_bh_text_list[li_i])
//	if upperbound(is_rh_text_list) > 0 then
////		FileWrite(li_num1, string(li_i) + " " + string(upperbound(is_rh_text_list)) + " " + is_rh_text_list[upperbound(is_rh_text_list)])
//		FileWrite(li_num1, is_rh_text_list[upperbound(is_rh_text_list)])
//	end if
//	if upperbound(is_lh_text_list) > 0 then
////		FileWrite(li_num2, string(li_i) + " " + string(upperbound(is_lh_text_list)) + " " + is_lh_text_list[upperbound(is_lh_text_list)])
//		FileWrite(li_num2, is_lh_text_list[upperbound(is_lh_text_list)])
//	end if
//	if upperbound(is_bh_text_list) > 0 then
////		FileWrite(li_num3, string(li_i) + " " + string(upperbound(is_bh_text_list)) + " " + is_bh_text_list[upperbound(is_bh_text_list)])
//		FileWrite(li_num3, is_bh_text_list[upperbound(is_bh_text_list)])
//	end if
next

if ib_right_exists then	
	if upperbound(ii_measure_right_end_index) < upperbound(ii_measure_right_begin_index) then
		ii_measure_right_end_index[upperbound(ii_measure_right_end_index) + 1]   = upperbound(is_rh_text_list)
	end if
end if
if ib_left_hand_exists then	
	if upperbound(ii_measure_left_end_index) < upperbound(ii_measure_left_begin_index) then
		ii_measure_left_end_index[upperbound(ii_measure_left_end_index) + 1]   = upperbound(is_lh_text_list)
	end if
end if
if ib_both_exists then	
	if upperbound(ii_measure_both_end_index) < upperbound(ii_measure_both_begin_index) then
		ii_measure_both_end_index[upperbound(ii_measure_both_end_index) + 1]   = upperbound(is_bh_text_list)
	end if
end if

	FileWrite(li_num, "right begin count=" + string(upperbound(ii_measure_right_begin_index)) + "right end count=" + string(upperbound(ii_measure_right_end_index)))
	FileWrite(li_num, "left begin count=" + string(upperbound(ii_measure_left_begin_index)) + "left end count=" + string(upperbound(ii_measure_left_end_index)))
	FileWrite(li_num, "both begin count=" + string(upperbound(ii_measure_both_begin_index)) + "right end count=" + string(upperbound(ii_measure_both_end_index)))
FileClose(li_num)
//FileClose(li_num1)
//FileClose(li_num2)
//FileClose(li_num3)
CATCH(RuntimeError re1)
//FileClose(li_num1)
//FileClose(li_num2)
//FileClose(li_num3)
	msg = "Class=" + re1.Class + " Line=" + string(re1.Line) + " Number=" + string(re1.Number) + " RoutineName=" + re1.RoutineName + " Text=" + re1.Text
	msg = msg + " li_i:" + string(li_i)
	MessageBox("msg", msg)
END TRY

if not ib_both_exists then
	if ib_right_exists then
		is_bh_text_list = is_rh_text_list
	elseif ib_left_hand_exists then
		is_bh_text_list = is_lh_text_list
	end if
end if 
ii_rh_text_count = upperbound(is_rh_text_list)
ii_lh_text_count = upperbound(is_lh_text_list)
ii_bh_text_count = upperbound(is_bh_text_list)

//MessageBox("ii_rh_text_count", ii_rh_text_count)
//MessageBox("ii_lh_text_count", ii_lh_text_count)
//MessageBox("ii_bh_text_count", ii_bh_text_count)
//
//for li_i = 2 to ii_lh_text_count
//	MessageBox(is_lh_text_list[li_i], li_i)
//next
//if ib_left_hand_exists and ib_right_exists then ib_both_exists = true
wf_set_prompt_list(40)

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

//ii_prompt_ind = 8
if ii_prompt_ind = 0 or ii_prompt_ind >= 9 then // both hand
	ii_cur_list_index = ii_bh_list_index
	is_cur_fingering_image = is_bh_fingering_image
	is_cur_text_list = is_bh_text_list
	is_cur_wave_list = is_bh_wave_list
	is_cur_picture_list = is_bh_picture_list
	is_cur_finger_list = is_bh_finger_list
	ii_cur_piece = 3
	is_cur_mid_lesson = "both_" + is_lesson_name
	istr_cur_repeat = istr_bh_repeat
	ii_measure_cur_begin_index = ii_measure_both_begin_index
	ii_measure_cur_end_index = ii_measure_both_end_index
elseif ii_prompt_ind >= 1 and ii_prompt_ind <= 4 then // right hand
	ii_cur_list_index = ii_rh_list_index
	is_cur_fingering_image = is_rh_fingering_image
	is_cur_text_list = is_rh_text_list
	is_cur_wave_list = is_rh_wave_list
	is_cur_picture_list = is_rh_picture_list
	is_cur_finger_list = is_rh_finger_list
	is_cur_mid_lesson = "right_" + is_lesson_name
	ii_cur_piece = 1
	istr_cur_repeat = istr_rh_repeat
	ii_measure_cur_begin_index = ii_measure_right_begin_index
	ii_measure_cur_end_index = ii_measure_right_end_index
elseif ii_prompt_ind >= 5 and ii_prompt_ind <= 8 then // left hand
	ii_cur_list_index = ii_lh_list_index
	is_cur_fingering_image = is_lh_fingering_image
	is_cur_text_list = is_lh_text_list
	is_cur_wave_list = is_lh_wave_list
	is_cur_picture_list = is_lh_picture_list
	is_cur_finger_list = is_lh_finger_list
	is_cur_mid_lesson = "left_" + is_lesson_name
	ii_cur_piece = 2
	istr_cur_repeat = istr_lh_repeat
	ii_measure_cur_begin_index = ii_measure_left_begin_index
	ii_measure_cur_end_index = ii_measure_left_end_index
end if

//MessageBox("upperbound(is_cur_text_list)", upperbound(is_cur_text_list))
//MessageBox("upperbound(is_rh_text_list)", upperbound(is_rh_text_list))
//MessageBox("upperbound(is_lh_text_list)", upperbound(is_lh_text_list))
//MessageBox("upperbound(is_text_list)", upperbound(is_text_list))
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


//extPostThreadMessage(il_player_handle, 1027, ii_prompt_ind, 0)
extPostThreadMessage(il_thread_id, 1027, ii_prompt_ind, 0)	// set prompt indicator
ii_current_note = 2
wf_rec_move(is_cur_text_list[ii_current_note])
wf_build_demo_note_entry(is_cur_text_list[ii_current_note])
wf_send_note(true)

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
//	Send(il_player_handle, 1028, 0, il_midi_data[li_i])
	extPostThreadMessage(il_thread_id, 1028,0, il_midi_data[li_i])	// send data to MIDI output
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
					uo_1.uo_1.p_1.PictureName = ls_local_filename
					wf_reset_pic_coord()
				end if
//				MessageBox(string(ii_current_note), is_cur_text_list[ii_current_note])
				wf_build_demo_note_entry(is_cur_text_list[ii_current_note])
				ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note - 1], 17, len(is_cur_text_list[ii_current_note - 1]) - 16)
//				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
//				Send(il_player_handle, 1025, 0, 1)		
				wf_send_note(true)
			end if
			if ii_current_note = upperbound(is_cur_text_list) + 1 then
				ls_note_to_keyboard = mid(is_cur_text_list[ii_current_note - 1], 17, len(is_cur_text_list[ii_current_note - 1]) - 16)
//				extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
//				Send(il_player_handle, 1025, 0, 1)		
				wf_send_note(true)
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
//extSetMusicNoteToSharedMemory(ls_note_to_keyboard)
//Send(il_player_handle, 1025, 0, 0)
				wf_send_note(true)
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
					uo_1.uo_1.p_1.PictureName = is_cur_picture_list[ii_current_note]
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

public function integer wf_build_demo_note_entry (string as_current_note);// function name: wf_build_demo_note_entry
// parm: string as_current_note, current note string
// description: build right and left hand list

string ls_note_coordinate,ls_note_to_keyboard
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
integer li_i,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count

wf_parse_note_attribute(as_current_note,ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
		ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)

ii_rh_list_demo = ii_empty_list
ii_lh_list_demo = ii_empty_list
ii_rh_count_demo = 0
ii_lh_count_demo = 0

for li_i=1 to li_rh_note_set_count
	if integer(ls_rh_note_value[li_i]) > 0 and ls_rh_note_char[li_i] <> "2" then // not a continue note
		ii_rh_list_demo[upperbound(ii_rh_list_demo) + 1] = integer(ls_rh_note_value[li_i])
		ii_rh_count_demo++
	end if
next		
for li_i=1 to li_lh_note_set_count
	if integer(ls_lh_note_value[li_i]) > 0 and ls_lh_note_char[li_i] <> "2" then // not a continue note
		ii_lh_list_demo[upperbound(ii_lh_list_demo) + 1] = integer(ls_lh_note_value[li_i])
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

public subroutine wf_fresh_bring_to_top ();// function name: wf_fresh_bring_to_top
// description: as some of the objects maybe over shadowed by other other objects, this funciton updates the objects topology

BringTotop =  true
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

uo_1.uo_1.p_1.BringToTop = false
uo_1.uo_1.BringToTop = false


//
end subroutine

public function integer wf_check_repeat (integer ai_i);// function name: wf_check_repeat
// parm: integer ai_i, current note array index
// description: return the next current note array index in considering repeat note

string ls_note_coordinate,ls_note_to_keyboard, ls_empty_list[]
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
integer i,li_i,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count

for li_i = 1 to upperbound(istr_cur_repeat)
	if istr_cur_repeat[li_i].repeatEnd = ai_i and not istr_cur_repeat[li_i].played then
		istr_cur_repeat[li_i].played = true
		return istr_cur_repeat[li_i].repeatBegin
	end if
next

li_i = ai_i

do while li_i < ii_end_note
	li_i++
	ls_note_to_keyboard = right(is_cur_text_list[li_i], len(is_cur_text_list[li_i]) - 16)
	ls_rh_time_fraction = ls_empty_list
	ls_rh_note_value = ls_empty_list
	ls_rh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	ls_lh_time_fraction = ls_empty_list
	ls_lh_note_value = ls_empty_list
	ls_lh_note_char = ls_empty_list
	ls_rh_note_finger = ls_empty_list
	li_total_note_set_count = 0
	li_total_note_set_count = 0
	li_lh_note_set_count = 0
	
	wf_parse_note_attribute(is_cur_text_list[li_i],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
		ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)	
	
	for i=1 to li_rh_note_set_count
		if integer(ls_rh_note_value[i]) <> 0 and ls_rh_note_char[i] <> "2" then // real note and not continue
			return li_i
		end if
	next
	
	for i=1 to li_lh_note_set_count
		if integer(ls_lh_note_value[i]) <> 0 and ls_lh_note_char[i] <> "2" then // real note and not continue
			return li_i
		end if
	next
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

ll_prompt_ind = dw_prompt.GetItemNumber(1, "prompt_ind")

if ib_both_exists then
	ll_prompt_list = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
	ls_prompt_list = {"None", "RH Note Prompt", "RH Key Prompt", "RH Note and Key Prompt", "RH Prompt With Demo", &
							"LH Note Prompt", "LH Key Prompt", "LH Note and Key Prompt", "LH Prompt With Demo", &
							"Both Note Prompt", "Both Key Prompt", "Both Note and Key Prompt", "Both Prompt With Demo"}	
	if ll_prompt_ind < 0 or ll_prompt_ind > 12 then ll_prompt_ind = 11						
elseif ib_right_exists then
	ll_prompt_list = {0, 1, 2, 3, 4}
	ls_prompt_list = {"None", "RH Note Prompt", "RH Key Prompt", "RH Note and Key Prompt", "RH Prompt With Demo"}		
	if ll_prompt_ind < 0 or ll_prompt_ind > 4 then ll_prompt_ind = 3						
else						// Left Hand
	ll_prompt_list = {0, 5, 6, 7, 8}
	ls_prompt_list = {"None", "LH Note Prompt", "LH Key Prompt", "LH Note and Key Prompt", "LH Prompt With Demo"}				
	if ll_prompt_ind < 0 or (ll_prompt_ind < 5 or ll_prompt_ind > 8) then ll_prompt_ind = 7						
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

public subroutine wf_adjust_bars (integer ai_bar, integer ai_x_delta, integer ai_y_delta);// function name: wf_adjust_bars
// parms: integer ai_bar=the bard indicator, 1=start bar, 2=end bar
//        integer ai_x_delta=x increment for the bar
//        integer ai_y_delta=y increment for the bar
// description: reset a bar position based on input x and y increment

if ai_bar = 1 then // start bar
	uo_1.uo_1.st_start.x += ai_x_delta
	uo_1.uo_1.st_start.y += ai_y_delta
else 				  // end bar
	uo_1.uo_1.st_end.x += ai_x_delta
	uo_1.uo_1.st_end.y += ai_y_delta	
end if
	
end subroutine

public subroutine wf_scroll_sheet (integer ai_delta);integer li_delta_page, li_i, li_y0_offset, li_equivalent_y_at_uo, li_y1_offset
integer li_header = -50, li_y_pre

// determine if ii_EndY will be within uo_1.height
li_equivalent_y_at_uo = ii_EndY + uo_1.uo_1.y
if li_equivalent_y_at_uo > uo_1.height then // scroll needed, let scroll to the top of page
	li_y_pre = uo_1.uo_1.y
	for li_i = 1 to 100/uo_1.LinesPerPage
		Send(handle(uo_1),277,3,0) // 6=TOP, 2=UP 3 DOWN
		if li_y_pre = uo_1.uo_1.y then // can't downscroll any more
			exit
		end if
		if (ii_BeginY + li_header) + uo_1.uo_1.y < 0 then // scroll over, scroll up
			Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3=DOWN
			exit
		end if
		li_y_pre = uo_1.uo_1.y	
	next
end if	

end subroutine

public subroutine wf_reset_pic_coord ();// reset picture coordinates after loading
//uo_1.uo_1.p_1.x = (uo_1.uo_1.width - uo_1.uo_1.p_1.width)/2
//idb_width_ratio = double(uo_1.uo_1.p_1.width/ii_orig_width)
//idb_height_ratio = double(uo_1.uo_1.p_1.height/ii_orig_height)
//
visible = true

end subroutine

public function boolean isnaturalnote (integer ai_note);// function name: IsNaturalNote
// parm: integer ai_note, input music chromatic note
// description: return true if it is a natural note, otherwise return false

integer li_mod_remain

li_mod_remain =  mod(ai_note, 12)
choose case li_mod_remain
	case 0, 2, 4, 5, 7, 9, 11 // a natural key
		return true
end choose

return false
end function

public function integer getarrayrange (long al_array[]);// function name: GetArrayRange
// parm: long al_rray, input array
// description: return the range of input array

integer li_i

long ll_min = 9999, ll_max = -9999

if upperbound(al_array) = 0 then return -1

for li_i = 1 to upperbound(al_array)
	if al_array[li_i] < ll_min then ll_min = al_array[li_i]
	if al_array[li_i] > ll_max then ll_max = al_array[li_i]
next

return ll_max - ll_min + 1
end function

public function integer wf_rec_move (string as_note);integer right_hand_notes[5],left_hand_notes[5], rh_note_list[], lh_note_list[]
integer right_note_fraction[5], right_note_denomitor[5],left_note_fraction[5], left_note_denomitor[5]
integer li_y_adjust


string ls_note_coordinate,ls_note_to_keyboard
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
string ls_note
integer li_i,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count


if ii_prompt_ind < 1 then return 0

wf_parse_note_attribute(as_note,ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
		ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)


SetRedraw(false)

il_beat_rate = long(sle_beat_rate.text)
if il_beat_rate > 0 then
	idb_beat_duration = 60.0/double(il_beat_rate)
else
	idb_beat_duration = 0.0
end if
if il_note_beat_denomitor > 0 then
	idb_note_per_beat = 1.0/double(il_note_beat_denomitor)
end if

for li_i= 1 to 5
	idb_right_note_duration[li_i] = 0.0
	idb_left_note_duration[li_i] = 0.0
next 

for li_i=1 to li_rh_note_set_count
	right_hand_notes[li_i] = integer(ls_rh_note_value[li_i])
	if right_hand_notes[li_i] > 0 then rh_note_list[upperbound(rh_note_list) + 1] = right_hand_notes[li_i]
	right_note_denomitor[li_i] = integer(left(ls_rh_time_fraction[li_i], 2))
	right_note_fraction[li_i] = integer(right(ls_rh_time_fraction[li_i], 2))
	if il_beat_rate > 0 and il_note_beat_denomitor > 0 and right_note_denomitor[li_i] > 0 then
		idb_right_note_duration[li_i] = ((double(right_note_fraction[li_i])/double(right_note_denomitor[li_i]))/idb_note_per_beat)*idb_beat_duration		
	end if
	sle_1.text = string(idb_right_note_duration[li_i])
next

for li_i=1 to li_lh_note_set_count
	left_hand_notes[li_i] = integer(ls_lh_note_value[li_i])
	if left_hand_notes[li_i] > 0 then lh_note_list[upperbound(lh_note_list) + 1] = left_hand_notes[li_i]
	left_note_denomitor[li_i] = integer(left(ls_lh_time_fraction[li_i], 2))
	left_note_fraction[li_i] = integer(right(ls_lh_time_fraction[li_i], 2))
	if il_beat_rate > 0 and il_note_beat_denomitor > 0 and left_note_denomitor[li_i] > 0 then
		idb_left_note_duration[li_i] = ((double(left_note_fraction[li_i])/double(left_note_denomitor[li_i]))/idb_note_per_beat)*idb_beat_duration		
	end if
	sle_1.text = string(idb_left_note_duration[li_i])
next

if upperbound(rh_note_list) > 0 then
	wf_sort_list(rh_note_list)
end if
if upperbound(lh_note_list) > 0 then
	wf_sort_list(lh_note_list)
end if

uo_1.uo_1.st_11.text = ""
uo_1.uo_1.st_4.text = ""

//if li_rh_note_set_count > 0 then
//	if right_hand_notes[1] > 0 then
//		ls_note = wf_seq_to_note(right_hand_notes[1])
//		ls_note = left(ls_note, len(ls_note) - 1)
//		uo_1.uo_1.st_11.text = ls_note	
//	end if
//end if

if upperbound(rh_note_list) > 0 then
	for li_i = 1 to upperbound(rh_note_list)
		ls_note = wf_seq_to_note(rh_note_list[li_i])
		ls_note = left(ls_note, len(ls_note) - 1)
		if len(ls_note) = 1 then ls_note = ls_note + " "
		uo_1.uo_1.st_11.text = ls_note + uo_1.uo_1.st_11.text
	next
end if

//if li_lh_note_set_count > 0 then
//	if left_hand_notes[1] > 0 then
//		ls_note = wf_seq_to_note(left_hand_notes[1])
//		ls_note = left(ls_note, len(ls_note) - 1)
//		uo_1.uo_1.st_4.text = ls_note
//	end if
//end if

if upperbound(lh_note_list) > 0 then
	for li_i = 1 to upperbound(lh_note_list)
		ls_note = wf_seq_to_note(lh_note_list[li_i])
		ls_note = left(ls_note, len(ls_note) - 1)
		if len(ls_note) = 1 then ls_note = ls_note + " "
		uo_1.uo_1.st_4.text = ls_note + uo_1.uo_1.st_4.text
	next
end if


ii_BeginX = integer(mid(as_note, 1, 4)) + uo_1.uo_1.p_1.x
ii_EndX = integer(mid(as_note, 10, 4)) + uo_1.uo_1.p_1.x

integer ii_BeginY_prev,ii_EndY_prev
ii_BeginY_prev = ii_BeginY
ii_EndY_prev = ii_EndY
ii_BeginY = integer(mid(as_note, 5, 5))
ii_EndY = integer(mid(as_note, 14, 5))	

// re-adjust Y

li_y_adjust = (ii_EndY - ii_BeginY)*3/7

if ib_both_exists then
	if ii_cur_piece = 1 then // right hand music adjust bottom
		ii_EndY = ii_EndY - li_y_adjust
	end if
	if ii_cur_piece = 2 then // left hand music adjust top
		ii_BeginY = ii_BeginY + li_y_adjust
	end if	
end if

uo_1.uo_1.st_11.x = ii_BeginX
uo_1.uo_1.st_11.y = ii_BeginY
uo_1.uo_1.st_11.width = ii_EndX + 10 - ii_BeginX
if upperbound(rh_note_list) > 0 then
	uo_1.uo_1.st_11.height = 72*upperbound(rh_note_list)
else
	uo_1.uo_1.st_11.height = 40
end if

uo_1.uo_1.st_2.x = ii_BeginX
uo_1.uo_1.st_2.y = ii_BeginY
uo_1.uo_1.st_2.width = 10
uo_1.uo_1.st_2.height = ii_EndY - ii_BeginY

uo_1.uo_1.st_3.x = ii_EndX
uo_1.uo_1.st_3.y = ii_BeginY
uo_1.uo_1.st_3.width = 10
uo_1.uo_1.st_3.height = ii_EndY - ii_BeginY

uo_1.uo_1.st_4.x = ii_BeginX
uo_1.uo_1.st_4.y = ii_EndY
uo_1.uo_1.st_4.width = ii_EndX + 10 - ii_BeginX
if upperbound(lh_note_list) > 0 then
	uo_1.uo_1.st_4.height = 72*upperbound(lh_note_list)
else
	uo_1.uo_1.st_4.height = 40
end if


wf_scroll_sheet(ii_EndY - ii_EndY_prev)

SetRedraw(true)
uo_1.uo_1.p_1.event ue_paint(0)
//MessageBox("1","1")
return 1
end function

public subroutine wf_init_lesson ();int li_i, li_pos1, li_pos2
super::wf_init_lesson()

if upperbound(is_text_list) < 2 then return

//integer li_num, li_num1, li_num2
//li_num = FileOpen("t.txt", LineMode!, Write!, LockWrite!, Replace!)
//li_num1 = FileOpen("t1.txt", LineMode!, Write!, LockWrite!, Replace!)
//li_num2 = FileOpen("t2.txt", LineMode!, Write!, LockWrite!, Replace!)
//if li_num = -1 then
//	MessageBox("Error", "wf_init_lesson: Fail to open to write!")
//	return 
//end if

integer li_num_test, li_Return
string test_list[], tmp_buf
if FileExists("music_test_file.txt") then // replace is_text_list with the music_test_file
	li_num_test = FileOpen("music_test_file.txt")
 	li_Return = FileRead(li_num_test ,tmp_buf)
	do while(li_Return <> -100)
		test_list[upperbound(test_list) + 1] = tmp_buf
	 	li_Return = FileRead(li_num_test ,tmp_buf)
	loop
	FileClose(li_num_test)

	if upperbound(test_list) = upperbound(is_text_list) then
		for li_i = 1 to upperbound(is_text_list)
			is_text_list[li_i] = test_list[li_i]
		next
		sle_3.visible = true
		sle_3.text = "TESTING A PIECE UNDER COMPILING"
	else
		MessageBox("Error", "The testing piece and original music are uncompatible: " + string(upperbound(test_list)) + " vs " + string(upperbound(is_text_list)))
	end if

end if

is_finger_list[1] = is_text_list[1]
//FileWrite(li_num, is_text_list[1])
//FileWrite(li_num1, is_text_list[1])
//FileWrite(li_num2, is_finger_list[1])
//MessageBox(is_text_list[1], 1)
for li_i = 2 to upperbound(is_text_list)
//	FileWrite(li_num, is_text_list[li_i])
//MessageBox(is_text_list[li_i], li_i)
	
	if pos(is_text_list[li_i], "repeat") > 0 then 
		is_finger_list[li_i] = is_text_list[li_i]
//	FileWrite(li_num1, is_text_list[li_i])
//	FileWrite(li_num2, is_finger_list[li_i])
		continue
	end if
	li_pos1 = pos(is_text_list[li_i], "FB")
	li_pos2 = pos(is_text_list[li_i], "FE")
	if li_pos1 < 1 or li_pos2 < 1 or li_pos2 < li_pos1 then
		MessageBox(string(li_pos1) + " " + string(li_pos2), is_text_list[li_i])
		MessageBox("Error", "Line - " + string(li_i) + " Corrupted Data!")
		return
	end if
	is_finger_list[li_i] = left(is_text_list[li_i], li_pos2 + 1)
	is_text_list[li_i] = right(is_text_list[li_i], len(is_text_list[li_i]) - (li_pos2 + 1))
//	FileWrite(li_num1, is_text_list[li_i])
//	FileWrite(li_num2, is_finger_list[li_i])
next
//string is_rh_finger_list[], is_lh_finger_list[], is_bh_finger_list[]

//		FileClose(li_num)
//
//		FileClose(li_num1)
//		FileClose(li_num2)


end subroutine

public function integer wf_parse_finger_entry (string as_input, ref string as_output_list[]);// function name: wf_parse_finger_entry
//	parms: string as_input = the string to be parsed
//        string as_output_list[], the array of parsed string
//as_input
//as_output_list[]

integer li_i

for li_i = 1 to len(as_input)/FINGERING_ATTR_LEN
	as_output_list[li_i] = mid(as_input, FINGERING_ATTR_LEN*(li_i - 1) + 1, FINGERING_ATTR_LEN)
next

return len(as_input)/FINGERING_ATTR_LEN


end function

public function integer wf_get_finger_entry_id (ref string as_input_list[], ref long al_entry_id_list[], ref string as_entry_id_list[]);// function name: wf_get_finger_entry_id
// parm: integer long al_entry_id_list[], return finger entry ID list in long data type
//	              string as_entry_id_list[], return finger entry ID list in string
// description: traver the input list, is_text_list, to generate finger entry ID list


integer li_i, li_j, li_k, li_pos1, li_pos2, li_fingering_ind, li_entry_count
string ls_entry,ls_id, ls_finger_attr, ls_finger_entry_list[], ls_empty_list[]
long ll_id
boolean lb_found = false

for li_i = 2 to upperbound(as_input_list)
	ls_entry = as_input_list[li_i]
	li_pos1 = pos(ls_entry, "FB")
	li_pos2 = pos(ls_entry, "FE")
	if li_pos1 < 1 or li_pos2 < 1 or li_pos2 < li_pos1 then continue
	li_fingering_ind = integer(mid(ls_entry, li_pos1 + 2, 1))
	if li_fingering_ind = REAPEAT_FINGERING or li_fingering_ind = NO_FINGERING then continue
	ls_finger_attr = mid(ls_entry, li_pos1 + 2, li_pos2 - li_pos1 - 2)
//	MessageBox("ls_finger_attr", ls_finger_attr)
	ls_finger_entry_list = ls_empty_list
	li_entry_count = wf_parse_finger_entry(ls_finger_attr, ls_finger_entry_list)
//	MessageBox("li_entry_count", li_entry_count)
	for li_j = 1 to li_entry_count
		ls_id = left(ls_finger_entry_list[li_j], 4)
		if left(ls_id, 1) <> "1" and left(ls_id, 1) <> "2" then MessageBox("finger id error", "li_i=" + string(li_i) + "ls_id=" + ls_id)
		ll_id = long(ls_id)
		lb_found = false
		for li_k = 1 to upperbound(al_entry_id_list) 
			if ll_id = al_entry_id_list[li_k] then
				lb_found = true
				exit
			end if
		next
		if not lb_found then
			as_entry_id_list[upperbound(as_entry_id_list) + 1] = ls_id
			al_entry_id_list[upperbound(al_entry_id_list) + 1]  = ll_id
		end if
	next	
next

return 1
end function

public function integer wf_load_finger_graphs ();long ll_id[], ll_x_array[], ll_y_array[], ll_array_size
integer li_i, li_j
string ls_name_id[] // = {"1100","1200","1300","1400","1500","2100","2200","2300","2400","2500"}

wf_get_finger_entry_id(is_finger_list, ll_id, ls_name_id)

extClearGraphLib()
for li_i = 1 to upperbound(ls_name_id)
	ll_array_size = extGetCoordGraphCount(is_finger_graphic + ".lhi", is_finger_graphic + ".lhm", ls_name_id[li_i])
	
	for li_j = 1 to ll_array_size
		ll_x_array[li_j] = 0
		ll_y_array[li_j] = 0
	next
//	MessageBox(string(ll_array_size), is_finger_graphic + ".lhi")
	if ll_array_size > 0 then
		extGetCoordGraphFile(is_finger_graphic + ".lhi", is_finger_graphic + ".lhm", ll_x_array, ll_y_array, ll_array_size, ls_name_id[li_i])
	else
		MessageBox("Error", ls_name_id[li_i] + " not found in the resource file!")
		return 0
	end if
	extLoadGraphData(ll_x_array, ll_y_array, ll_array_size, long(ls_name_id[li_i]))
//	MessageBox(ls_name_id[li_i], ll_array_size)
next


return 1
end function

public function integer wf_parse_note_attribute (string as_current_note_entry, ref string as_note_coordinate, ref string as_note_to_keyboard, ref integer ai_total_note_set_count, ref integer ai_rh_note_set_count, ref integer ai_lh_note_set_count, ref string as_rh_time_fraction[], ref string as_lh_time_fraction[], ref string as_rh_note_value[], ref string as_lh_note_value[], ref string as_rh_note_char[], ref string as_lh_note_char[], ref string as_rh_note_finger[], ref string as_lh_note_finger[]);// function name: wf_parse_note_attribute
// input parms:
//				as_current_note_entry = input note entry string to be parsed
//				as_note_coordinate = the note coordinate returned
//				as_note_to_keyboard = the note attribute to be sent to keyboard returned
//				ai_total_note_set_count = total note set count returned
//				ai_rh_note_set_count = total right hand note set count returned
//				ai_lh_note_set_count = total left hand note set count returned
//				as_rh_time_fraction[] = array of time fraction for right hand note returned
//				as_lh_time_fraction[] = array of time fraction for left hand note returned
//				as_rh_note_value[] = array of note value for right hand note returned
//				as_lh_note_value[] = array of note value for left hand note returned
//				as_rh_note_char[] = array of note character for right hand note returned
//				as_lh_note_char[] = array of note character for left hand note returned
//				as_rh_note_finger[] = array of finger number for right hand note returned
//				as_lh_note_finger[] = array of finger number for left hand note returned
// description: to parse note attributes of an input note entry	

constant integer COORDINATE_LEN = 18
constant integer NOTE_UNIT_LEN = 9
constant integer  NOTE_LEN = 9  	// It was 8, and changed to 9
constant integer	TIME_FRACTION_LEN	= 4
constant integer	NOTE_VALUE_LEN	= 3 // it was 2 changed to 3
constant integer	NOTE_CHAR_LEN	= 1
constant integer	NOTE_FINGER_LEN = 1
integer li_i, li_offset, li_j

as_note_coordinate = left(as_current_note_entry, COORDINATE_LEN)
as_note_to_keyboard = right(as_current_note_entry, len(as_current_note_entry) - COORDINATE_LEN)
ai_total_note_set_count = len(as_note_to_keyboard)/NOTE_UNIT_LEN
ai_rh_note_set_count = ai_total_note_set_count/2
if mod(ai_total_note_set_count, 2) = 1 then
	ai_rh_note_set_count++
end if
ai_lh_note_set_count = ai_total_note_set_count/2

li_j = 0
for li_i=1 to ai_rh_note_set_count
	li_offset = NOTE_UNIT_LEN*2*(li_i - 1) + 1
	if mid(as_note_to_keyboard, li_offset, NOTE_UNIT_LEN) <> "000000000" then
		li_j = li_j + 1
		as_rh_time_fraction[upperbound(as_rh_time_fraction) + 1] = mid(as_note_to_keyboard, li_offset, TIME_FRACTION_LEN)
		li_offset = li_offset + TIME_FRACTION_LEN	
		as_rh_note_value[upperbound(as_rh_note_value) + 1] = mid(as_note_to_keyboard, li_offset, NOTE_VALUE_LEN)
		li_offset = li_offset + NOTE_VALUE_LEN
		as_rh_note_char[upperbound(as_rh_note_char) + 1] = mid(as_note_to_keyboard, li_offset, NOTE_CHAR_LEN)
		li_offset = li_offset + NOTE_CHAR_LEN
		as_rh_note_finger[upperbound(as_rh_note_finger) + 1] = mid(as_note_to_keyboard, li_offset, NOTE_FINGER_LEN)
	end if
next
ai_rh_note_set_count = li_j
li_j = 0 
for li_i=1 to ai_lh_note_set_count
	li_offset = NOTE_UNIT_LEN*2*(li_i - 1) + NOTE_UNIT_LEN + 1
	if mid(as_note_to_keyboard, li_offset, NOTE_UNIT_LEN) <> "000000000" then
		li_j = li_j + 1
		as_lh_time_fraction[upperbound(as_lh_time_fraction) + 1] = mid(as_note_to_keyboard, li_offset, TIME_FRACTION_LEN)
		li_offset = li_offset + TIME_FRACTION_LEN	
		as_lh_note_value[upperbound(as_lh_note_value) + 1] = mid(as_note_to_keyboard, li_offset, NOTE_VALUE_LEN)
		li_offset = li_offset + NOTE_VALUE_LEN
		as_lh_note_char[upperbound(as_lh_note_char) + 1] = mid(as_note_to_keyboard, li_offset, NOTE_CHAR_LEN)
		li_offset = li_offset + NOTE_CHAR_LEN
		as_lh_note_finger[upperbound(as_lh_note_finger) + 1] = mid(as_note_to_keyboard, li_offset, NOTE_FINGER_LEN)
	end if
next
ai_lh_note_set_count = li_j

return 1


end function

public function integer closepopupmenu ();//MessageBox("test", "ClosePopMenu")
//if IsValid(iuo_popup_menu) then 
//	ib_popup_menu =  false
//	CloseUserObject(iuo_popup_menu)
//end if
//MessageBox("test", "ClosePopMenu")
if IsValid(iw_popup_menu) then 
	ib_popup_menu =  false
	Close(iw_popup_menu)
end if

return 1
end function

public subroutine wf_set_cust_control ();long ll_height, ll_width
//long ll_unicode_list[] = {20013, 25991} //ZHONG WEN
long ll_unicode_list[], ll_empty_list[]
long ll_lang_ind = 0, ll_dc,ll_x,ll_y,ll_radius,ll_char_width,ll_char_height, ll_color
long ll_top_dc, ll_bottom_dc
integer li_i, ll_font_type
string ls_text

ll_dc = GetDC(il_win_handle)
ll_top_dc = GetDC(handle(p_top))
ll_bottom_dc = GetDC(handle(p_bottom))
ll_width = UnitsToPixels(width, XUnitsToPixels!)
ll_height = UnitsToPixels(height, YUnitsToPixels!)


ls_text = "Advance"
ll_unicode_list[] = {21069,36827} //qian jin

ll_x = uo_1.x
ll_y = 30
ll_radius = 16

if gl_lang_ind = 0 then // English
	inv_advance_rb.f_set_logfont(16,FW_BOLD,char(0),"Arial")
	inv_repeat_rb.f_set_logfont(16,FW_BOLD,char(0),"Arial")
	inv_trans_cb.f_set_logfont(16,FW_BOLD,char(0),"Arial")	
	ll_char_width = 10
	ll_char_height = 12
else
	inv_advance_rb.f_set_logfont(16,FW_BOLD,char(GB2312_CHARSET),"FongSong")
	inv_repeat_rb.f_set_logfont(16,FW_BOLD,char(GB2312_CHARSET),"FongSong")
	inv_trans_cb.f_set_logfont(16,FW_BOLD,char(GB2312_CHARSET),"FongSong")
	ll_char_width = 16
	ll_char_height = 16
end if

inv_advance_rb.f_set_parms1(gl_lang_ind,ll_bottom_dc,ll_x,ll_y,ll_radius,ll_char_width,ll_char_height)
inv_advance_rb.f_set_parms2(ls_text,ll_unicode_list,16777215,255,RADIO_BUTTON)
inv_advance_rb.f_set_parms5(1)	// button value
inv_advance_rb.f_set_on_off_ind(1, il_moving_ind)

if gl_lang_ind = 0 then // English
	ll_x = ll_x + PixelsToUnits(len(ls_text)*ll_char_width + ll_radius*3/2, XPixelsToUnits!) + 50
else
	ll_x = ll_x + PixelsToUnits(upperbound(ll_unicode_list)*ll_char_width + ll_radius*3/2, XPixelsToUnits!) + 50
end if

ls_text = "Repeat"
ll_unicode_list[] = {37325,22797} //chong fu

inv_repeat_rb.f_set_parms1(gl_lang_ind,ll_bottom_dc,ll_x,ll_y,ll_radius,ll_char_width,ll_char_height)
inv_repeat_rb.f_set_parms2(ls_text,ll_unicode_list,16777215,255,0)
inv_repeat_rb.f_set_parms5(0)	// button value

inv_repeat_rb.f_set_on_off_ind(0, il_moving_ind)

if gl_lang_ind = 0 then // English
	ll_x = ll_x + PixelsToUnits(len(ls_text)*ll_char_width + ll_radius*3/2, XPixelsToUnits!) + 100
else
	ll_x = ll_x + PixelsToUnits(upperbound(ll_unicode_list)*ll_char_width + ll_radius*3/2, XPixelsToUnits!) + 100
end if


ls_text = "Display Transitional Fingerings"
ll_unicode_list[] = {26174,31034,36807,24230,21464,21270,25351,21457} //xiang shi guo du bian hua zhi fa

inv_trans_cb.f_set_parms1(gl_lang_ind,ll_bottom_dc,ll_x,ll_y,ll_radius,ll_char_width,ll_char_height)
inv_trans_cb.f_set_parms2(ls_text,ll_unicode_list,16777215,255,CHECKBOX_BUTTON)
inv_trans_cb.f_set_parms5(0)	// button value

inv_trans_cb.f_set_on_off_ind(0, il_display_trans_fingering)



//string ls_english_rb = "English"
string ls_english_rb = ""


ll_x = uo_1.uo_1.x
ll_y = p_keyboard1.y + p_keyboard1.height 
ll_radius = 16
ll_char_width = 10
ll_char_height = 12

long ll_poly_x[] = {0, 40,  40, 60, 40, 40, 0, 0}
long ll_poly_y[] = {0,  0, -10, 10, 30, 20, 20,0}
long  ll_point_counts[] = {8}

ll_x = uo_1.uo_1.x + uo_1.uo_1.width  - 300
//ll_y = height - 180
ll_y = 50

for li_i = 1 to upperbound(ll_poly_x)
	ll_poly_x[li_i] = ll_poly_x[li_i] + UnitsToPixels(ll_x, XUnitsToPixels!)	
	ll_poly_y[li_i] = ll_poly_y[li_i] + UnitsToPixels(ll_y, YUnitsToPixels!)	
next

ll_radius = 20
ll_char_width = 10
ll_char_height = 12
ll_color = 16777215
//ll_color = 0
ll_unicode_list = ll_empty_list
inv_forward_button.f_set_logfont(16,FW_BOLD,char(0),"Arial")
inv_forward_button.f_set_parms1(gl_lang_ind,ll_bottom_dc,ll_x,ll_y,ll_radius,ll_char_width,ll_char_height)
inv_forward_button.f_set_parms2(ls_english_rb,ll_unicode_list,0,ll_color,POLYGON_BUTTON)
inv_forward_button.f_set_parms3(ll_poly_x,ll_poly_y,ll_point_counts,1)

ll_x = ll_x - 400
ll_poly_x[] = {60, 20, 20,  0, 20, 20, 60, 60}
ll_poly_y[] = {0,  0, -10, 10, 30, 20, 20, 0}

for li_i = 1 to upperbound(ll_poly_x)
	ll_poly_x[li_i] = ll_poly_x[li_i] + UnitsToPixels(ll_x, XUnitsToPixels!)	
	ll_poly_y[li_i] = ll_poly_y[li_i] + UnitsToPixels(ll_y, YUnitsToPixels!)	
next

inv_backward_button.f_set_logfont(16,FW_BOLD,char(0),"Arial")
inv_backward_button.f_set_parms1(gl_lang_ind,ll_bottom_dc,ll_x,ll_y,ll_radius,ll_char_width,ll_char_height)
inv_backward_button.f_set_parms2(ls_english_rb,ll_unicode_list,0,ll_color,POLYGON_BUTTON)
inv_backward_button.f_set_parms3(ll_poly_x,ll_poly_y,ll_point_counts,1)



//return
// window background image
str_rect_long rect
//str_rect_long rect_top, rect_bottom, rect_left, rect_right
il_win_handle = handle(this)
ll_dc = GetDC(il_win_handle)
rect.left = 0
rect.top = 0
rect.right = UnitsToPixels(width, XUnitsToPixels!)
rect.bottom = UnitsToPixels(height, YUnitsToPixels!)
p_top.visible = false
p_bottom.visible = false
p_bottom2.visible = false
p_left.visible = false
p_right.visible = false

DrawGraph(ll_dc,  "music_lesson_bk.png", rect,0,0,1,255)


long ll_dc2, ll_x2, ll_y2, ll_array_size,ll_text_list[], ll_pos
long ll_unicode_list2[] = {25552,31034,24335,38899,20048,38190,30424,32451,20064,26354,32,45,32}
long ll_color2, ll_i, ll_char_width2
ulong ul_unicode_list[]

ll_dc2 = GetDC(handle(p_top))
string ls_seperator //, ls_lesson_name_eng = "", ls_lesson_name_chn = ""
string ls_text_title = "Hint Based Keyboard Music Lesson - "
ll_color = 	16777215	// white
str_logfont logfont
str_rect_long rect2
ls_seperator = "||"
ll_pos = pos(is_lesson_name, ls_seperator)
ls_seperator = " | |"
if ll_pos = 0 then ll_pos = pos(is_lesson_name, ls_seperator)
if ll_pos > 0 then
//	is_lesson_name_eng = left(is_lesson_name, ll_pos - 1)
//	is_lesson_name_chn = right(is_lesson_name, len(is_lesson_name) - (ll_pos + (len(ls_seperator) - 1)))
	for ll_i = 1 to len(is_lesson_name_chn)/4
		ul_unicode_list[ll_i] = 0
	next
	extHexString2Number(is_lesson_name_chn, ul_unicode_list)
//else
//	is_lesson_name_eng = is_lesson_name
end if

//is_bh_fingering_image = is_lesson_name_eng + "_image"
//is_rh_fingering_image = is_bh_fingering_image + "_right"
//is_lh_fingering_image = is_bh_fingering_image + "_left"
//is_cur_fingering_image = is_bh_fingering_image
//is_finger_graphic = is_lesson_name_eng + "_finger_lib_001"

ll_text_list = ll_empty_list
if gl_lang_ind = 0 then
	ll_char_width = 10
	for ll_i = 1 to len(ls_text_title)
		ll_text_list[ll_i] = asc(mid(ls_text_title, ll_i, 1))
	next	
	for ll_i = 1 to len(is_lesson_name_eng)
		ll_text_list[len(ls_text_title) + ll_i] = asc(mid(is_lesson_name_eng, ll_i, 1))
	next	
	f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
else	// chinese
	ll_char_width = 25
	ll_text_list = ll_unicode_list2	
	for ll_i = 1 to upperbound(ul_unicode_list)
		ll_text_list[upperbound(ll_text_list) + 1] = ul_unicode_list[ll_i]
	next
	f_set_logfont(logfont,24,FW_BOLD,char(GB2312_CHARSET),"FongSong")
end if
ll_array_size = upperbound(ll_text_list)

if ib_reset_pos then
	ll_x = UnitsToPixels(width/2, XUnitsToPixels!) - ll_array_size*ll_char_width/2
	ll_y = 5
	extTextOutFromPB(ll_dc,gl_lang_ind,ll_x,ll_y,ll_text_list,ll_array_size,ll_color,logfont) 
//	MessageBox("ue_paint", "1")
end if


p_top.x = 0
p_top.y = 0
p_top.width = width
p_top.height = uo_1.y

p_bottom.x = 0
p_bottom.y = p_keyboard1.y + p_keyboard1.height
p_bottom.width = width
p_bottom.height = height - p_bottom.y

p_bottom2.x = 0
p_bottom2.y = p_keyboard1.y + p_keyboard1.height
p_bottom2.width = width
p_bottom2.height = height - p_bottom2.y

p_left.x = 0
p_left.y = p_top.height + 1
p_left.width = uo_1.x
p_left.height =  height - (p_top.height + p_bottom.height)

p_right.x = uo_1.x + uo_1.width
p_right.y = p_top.height + 1
p_right.width = width - p_right.x
p_right.height =  p_left.height

// use right for width, and bottom for height
rect_top.left = UnitsToPixels(p_top.x, XUnitsToPixels!)
rect_top.right = UnitsToPixels(p_top.width, XUnitsToPixels!)
rect_top.top = UnitsToPixels(p_top.y, YUnitsToPixels!)
rect_top.bottom = UnitsToPixels(p_top.height, YUnitsToPixels!)
rect_bottom.left = UnitsToPixels(p_bottom.x, XUnitsToPixels!)
rect_bottom.right = UnitsToPixels(p_bottom.width, XUnitsToPixels!)
rect_bottom.top = UnitsToPixels(p_bottom.y, YUnitsToPixels!)
rect_bottom.bottom = UnitsToPixels(p_bottom.height, YUnitsToPixels!)
rect_left.left = UnitsToPixels(p_left.x, XUnitsToPixels!)
rect_left.right = UnitsToPixels(p_left.width, XUnitsToPixels!)
rect_left.top = UnitsToPixels(p_left.y, YUnitsToPixels!)
rect_left.bottom = UnitsToPixels(p_left.height, YUnitsToPixels!)
rect_right.left = UnitsToPixels(p_right.x, XUnitsToPixels!)
rect_right.right = UnitsToPixels(p_right.width, XUnitsToPixels!)
rect_right.top = UnitsToPixels(p_right.y, YUnitsToPixels!)
rect_right.bottom = UnitsToPixels(p_right.height, YUnitsToPixels!)

ll_dc2 = GetDC(handle(p_top))
f_set_picture_copy_image(p_top, ll_dc, rect_top.left, rect_top.top, rect_top.right, rect_top.bottom)
f_set_picture_copy_image(p_bottom, ll_dc, rect_bottom.left, rect_bottom.top, rect_bottom.right, rect_bottom.bottom)
f_set_picture_copy_image(p_bottom2, ll_dc, rect_bottom.left, rect_bottom.top, rect_bottom.right, rect_bottom.bottom)
f_set_picture_copy_image(p_left, ll_dc, rect_left.left, rect_left.top, rect_left.right, rect_left.bottom)
f_set_picture_copy_image(p_right, ll_dc, rect_right.left, rect_right.top, rect_right.right, rect_right.bottom)

p_top.visible = true
p_bottom.visible = true
p_left.visible = true
p_right.visible = true

ll_dc2 = GetDC(handle(p_bottom))
//p_top.post event ue_paint(0)
p_bottom.event ue_paint(0)

f_set_picture_copy_image(p_bottom, ll_dc2, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)

// Get Image Seq
string ls_buf
integer li_image_size = 0

li_image_size = extGetResourceImageSize(is_cur_fingering_image + ".lhi", "SEQUENCE_NUMBER")
ls_buf = space(li_image_size)
extGetImage(is_cur_fingering_image + ".lhi",is_cur_fingering_image + ".lhm","SEQUENCE_NUMBER",ls_buf)
for li_i = 1 to li_image_size/6
	il_image_seq[li_i] = long(mid(ls_buf, (li_i - 1)*6 + 1, 6))
//	MessageBox(string(li_i), il_image_seq[li_i])
next

p_bottom2.visible = true
ll_dc2 = GetDC(handle(p_bottom2))
f_set_picture_copy_image(p_bottom, ll_dc2, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)
p_bottom2.visible = false
ib_paint_bottom = true
timer(1, this)

end subroutine

public function integer wf_prompt_change (integer ai_prompt_indicator, integer ai_prompt_index);long ll_dc,ll_dc2, ll_x2, ll_y2, ll_array_size2, ll_text_list[],ll_text_list2[], ll_empty_list[], ll_pos
long ll_color, ll_i, ll_char_width
ulong ul_unicode_list[]
ll_color = 	16777215	// white
str_logfont logfont
str_rect_long rect, rect2

//SetRedraw(false)
string ls_menu_list[]
long ll_unicode_list2[]
integer li_prompt_list[], li_i, li_found, li_char_index,li_unicode_index[]
dw_prompt.SetItem(1, "prompt_ind", ai_prompt_indicator)
closepopupmenu()
wf_reset_pos()
p_bottom2.visible = true
ll_dc2 = GetDC(handle(p_bottom2))
f_set_picture_copy_image(p_bottom, ll_dc2, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)
p_bottom2.visible = false
ib_paint_bottom = true
timer(1, this)

//cb_2.event clicked()
return 1
//p_bottom.event ue_paint(0)
//ll_dc = GetDC(Handle(p_bottom))
//f_set_picture_copy_image(p_bottom, ll_dc, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)




//ll_dc = GetDC(handle(p_bottom))
//ll_dc2 = GetDC(handle(p_bottom2))
//p_bottom2.visible = true
//f_set_picture_copy_image(p_bottom, ll_dc2, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)

/*
	if ib_both_exists then
		li_prompt_list = ii_both_prompt_list
		ls_menu_list = is_menu_list0
		ll_unicode_list2 = il_unicode_list0
		li_unicode_index = ii_unicode_index0
	elseif ib_right_exists then
		li_prompt_list = ii_rh_prompt_list
		ls_menu_list = is_menu_list1
		ll_unicode_list2 = il_unicode_list1
		li_unicode_index = ii_unicode_index1
	else
		li_prompt_list = ii_lh_prompt_list
		ls_menu_list = is_menu_list2
		ll_unicode_list2 = il_unicode_list2
		li_unicode_index = ii_unicode_index2
	end if	
	for li_i = 1 to upperbound(li_prompt_list)
		if ii_prompt_ind = li_prompt_list[li_i] then li_found = li_i
	next
	ll_text_list2 = ll_empty_list
	if li_found = 0 then li_found = 1
	if gl_lang_ind = 0 then
		ll_char_width = 10
		for ll_i = 1 to len(ls_menu_list[li_found])
			ll_text_list2[ll_i] = asc(mid(ls_menu_list[li_found], ll_i, 1))
		next	
		f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
	else	// chinese
		ll_char_width = 25
		if li_found < upperbound(li_prompt_list) then
//			MessageBox(string(li_found), upperbound(li_unicode_index))
			ll_array_size2 = li_unicode_index[li_found+1] - li_unicode_index[li_found]
		else
			ll_array_size2 = upperbound(ll_unicode_list2) - li_unicode_index[li_found] + 1
		end if 
		for ll_i = 1 to ll_array_size2
			li_char_index = li_unicode_index[li_found] + ll_i - 1
			ll_text_list2[ll_i] = ll_unicode_list2[li_char_index]
		next
		f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
	end if	
	ll_x2 = UnitsToPixels(width/2, XUnitsToPixels!) - ll_array_size2*ll_char_width/2
	ll_y2 = 10
	extTextOutFromPB(ll_dc,gl_lang_ind,ll_x2,ll_y2,ll_text_list2,ll_array_size2,ll_color,logfont) 
*/	
//	p_bottom.post event ue_paint(0)

//	inv_forward_button.event ue_paint(0,0) 
//	inv_backward_button.event ue_paint(0,0) 
//	ll_dc = GetDC(Handle(p_bottom))
//	post f_set_picture_copy_image(p_bottom, ll_dc, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)
//closepopupmenu()


end function

public function integer wf_goto_rec (integer ai_x, integer ai_y);// to the record and finger, key position directly from x, y coordinates
integer li_i, li_begin_x, li_begin_y, li_end_x, li_end_y
integer li_num
//		li_num = FileOpen("dummy2.txt", LineMode!, Write!, LockWrite!, Replace!)
//FileWrite(li_num, "ai_x=" + string(ai_x) + " ai_y" + string(ai_y))
for li_i = 2 to upperbound(is_cur_text_list)
	li_begin_x = integer(mid(is_cur_text_list[li_i], 1, 4))
	li_begin_y = integer(mid(is_cur_text_list[li_i], 5, 5))
	li_end_x = integer(mid(is_cur_text_list[li_i], 10, 4))
	li_end_y = integer(mid(is_cur_text_list[li_i], 14, 5))
//	FileWrite(li_num, string(li_i) + " li_begin_x=" + string(li_begin_x) + " li_begin_y=" + string(li_begin_y) + " li_end_x=" + string(li_end_x) + " li_end_y=" + string(li_end_y))
	if ai_x >= li_begin_x and ai_x <= li_end_x and ai_y >= li_begin_y and ai_y <= li_end_y then
//		MessageBox("wf_goto_rec", "1")
//		FileWrite(li_num, "found: " + string(li_i))
		ii_current_note = li_i
		wf_rec_move(is_cur_text_list[ii_current_note])
		wf_send_note(true)
		exit
	end if
next	
//FileClose(li_num)
return 1
end function

public function string wf_fraction_to_string (double adb_input);double ldb_tmp, ldb_input
integer li_denominator = 1, li_numerator, li_i = 0

ldb_input = round(adb_input, 5)
do while true
	if truncate(ldb_input*2^li_i, 0) = ldb_input*2^li_i then
		li_numerator = integer(ldb_input*2^li_i)
		li_denominator = 2^li_i
		exit
	end if
	if li_i > 100 then
		exit
	end if
	li_i ++
loop

return string(li_denominator, "00") + string(li_numerator, "00")
end function

public function double wf_string_to_fraction (string as_input);// convert fraction time in string into double data type
if double(left(as_input, 2)) = 0.0 then
	return 0.0
else
	return double(right(as_input, 2))/double(left(as_input, 2))
end if
end function

public subroutine wf_set_moving_interval (integer ai_moving_interval_type);long ll_dc2, ll_i, ll_color = 	16777215	// white
str_logfont logfont
str_rect_long rect, rect2

ii_moving_interval_type = ai_moving_interval_type
//MessageBox("ii_moving_interval_type", ii_moving_interval_type)
closepopupmenu()
//wf_reset_pos()
//ii_current_note
if ii_moving_interval_type >= 5 and ii_moving_interval_type <= 7 then // moving by measure, move to the beginning of next measure
	for ll_i = 1 to upperbound(ii_measure_cur_begin_index)
		if ii_current_note >= ii_measure_cur_begin_index[ll_i] and ii_current_note >= ii_measure_cur_end_index[ll_i] then
			ii_current_measure = ll_i
			exit
		end if
	next
	ii_current_note = ii_measure_cur_begin_index[ii_current_measure]
end if
wf_reset_pos()
if ii_moving_interval_type = 8 then // moving within section
	ii_current_note = ii_begin_note
	wf_rec_move(is_cur_text_list[ii_current_note])
	wf_send_note(true)			
end if

p_bottom2.visible = true
ll_dc2 = GetDC(handle(p_bottom2))
f_set_picture_copy_image(p_bottom, ll_dc2, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)
p_bottom2.visible = false
ib_paint_bottom = true

timer(1, this)


end subroutine

public subroutine wf_note_advancing ();long ll_i, ll_interval, ll_units_per_scroll_uo_1
integer li_measuer_count, li_begin_measure, li_end_measure
double ldb_min_timer

//	for li_i = 1 to 100/uo_1.LinesPerPage
if ii_prompt_ind = 0 then // NONE PROMPTING
	// just scroll down one quater
	ll_units_per_scroll_uo_1 = 100*uo_1.height/((uo_1.uo_1.height - uo_1.height)*uo_1.LinesPerPage)
	for ll_i = 1 to ll_units_per_scroll_uo_1/4
		Send(handle(uo_1),277,3,0) // 6=TOP, 2=UP 3 DOWN
	next
	return
end if

if ii_current_note < ii_end_note then
	if ii_moving_interval_type = 1 then // one note advance
		ii_current_note++
		wf_rec_move(is_cur_text_list[ii_current_note])
//		wf_play_note()
		wf_send_note(true)		
		return 
	elseif ii_moving_interval_type >= 2 and ii_moving_interval_type <= 4 then	// moving between 2 to 4 notes	
		choose case ii_moving_interval_type
			case 2		//Two Fingerings		- 2
				ll_interval = 2
			case 3		//Three Fingerings	- 3
				ll_interval = 3
			case 4		//Five Fingerings		- 4
				ll_interval = 5
		end choose
		ii_interval_begin = ii_current_note
		ii_interval_end = ii_current_note + ll_interval
		ib_auto_fingering = true
	elseif ii_moving_interval_type >= 5 and ii_moving_interval_type <= 7 then // moving by measure, move to the beginning of next measure
		for ll_i = 1 to upperbound(ii_measure_cur_begin_index)
			if ii_current_note >= ii_measure_cur_begin_index[ll_i] and ii_current_note <= ii_measure_cur_end_index[ll_i] then
				ii_current_measure = ll_i
				exit
			end if
		next
		li_measuer_count = ii_moving_interval_type - 5
		if il_moving_ind = 1 then // advance
			if ii_current_note = ii_measure_cur_end_index[ii_current_measure] then // advance to next measure
				if ii_current_measure < upperbound(ii_measure_cur_begin_index) then ii_current_measure++
			end if
			li_begin_measure = ii_current_measure
			if li_begin_measure + li_measuer_count > upperbound(ii_measure_cur_begin_index) then
				li_end_measure = upperbound(ii_measure_cur_begin_index)
			else
				li_end_measure = li_begin_measure + li_measuer_count
			end if
		else		// repeat
			if ii_current_note = ii_measure_cur_end_index[ii_current_measure] then // repeat has run, reset it
				ii_current_measure = ii_current_measure - li_measuer_count
				if ii_current_measure < 1 then ii_current_measure = 1
			end if
			li_begin_measure = ii_current_measure
			if li_begin_measure + li_measuer_count > upperbound(ii_measure_cur_begin_index) then
				li_end_measure = upperbound(ii_measure_cur_begin_index)
			else
				li_end_measure = li_begin_measure + li_measuer_count
			end if
		end if
		ii_current_note = ii_measure_cur_begin_index[ii_current_measure]
		ii_interval_begin = ii_measure_cur_begin_index[li_begin_measure]
		ii_interval_end = ii_measure_cur_end_index[li_end_measure]
		ii_current_note = ii_interval_begin				
		ib_auto_fingering = true					
		st_2.text = "wf_note_advancing: ii_moving_interval_type >= 5 and ii_moving_interval_type <= 7"
	elseif ii_moving_interval_type = 8 then // moving within section
		ib_auto_fingering = true					
		ii_current_note = ii_begin_note
		ii_interval_begin = ii_current_note
		ii_interval_end = ii_end_note
//			Messagebox(string(ii_interval_begin), ii_interval_end)
		wf_rec_move(is_cur_text_list[ii_current_note])
		wf_send_note(true)		
	end if		
	if ii_tempo = 1 then // constant interval
		wf_rec_move(is_cur_text_list[ii_current_note])
		wf_send_note(true)		
		timer(2, this)
	else
		
		if upperbound(ii_played_notes) > 0 then
			for ll_i = 1 to upperbound(ii_played_notes)
				extPostThreadMessage(il_thread_id, 1041, ii_played_notes[ll_i], 0)
			next
			ii_played_notes = ii_empty_list
		end if
		
		ldb_min_timer = wf_get_min_time()
		wf_rec_move(is_cur_text_list[ii_current_note])
		wf_send_note(false)	
		wf_play_note()
		wf_send_note(false)	
		sle_2.text = "wf_note_advancing ldb_min_timer=" + string(ldb_min_timer)

		ib_auto_fingering = true	
		timer(0, this)
//MessageBox("wf_note_advancing ib_auto_fingering", "ii_interval_begin=" + string(ii_interval_begin) + " ii_interval_end=" + string(ii_interval_end))
//MessageBox("wf_note_advancing ldb_min_timer", ldb_min_timer)
		timer(ldb_min_timer, this)
	end if
end if

end subroutine

public subroutine wf_set_tempo (integer ai_tempo);long ll_dc2
integer ii_prev_tempo

extStartPianoThread2(il_pb_win_handle,il_kb_handle,il_kb_dc,is_startupfile,il_thread_id)	

if ii_tempo = 0 and ai_tempo > 0 then // turn on thread
	extStartPianoThread2(il_pb_win_handle,il_kb_handle,il_kb_dc,is_startupfile,il_thread_id)	
elseif ii_tempo > 0 and ai_tempo = 0 then // turn off thread
	extPostThreadMessage(il_thread_id,18,0,0)
	il_thread_id = 0
//	extClearCurGraph()
//	extClearGraphLib() 	
end if
ii_tempo = ai_tempo

closepopupmenu()

p_bottom2.visible = true
ll_dc2 = GetDC(handle(p_bottom2))
f_set_picture_copy_image(p_bottom, ll_dc2, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)
p_bottom2.visible = false
ib_paint_bottom = true
timer(1, this)

wf_reset_pos()


end subroutine

public subroutine wf_play_note ();string ls_note_coordinate,ls_note_to_keyboard
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
integer li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, li_note_set_count
integer li_current_note, li_entry_count, ii_rh_note_tmp, ii_lh_note_tmp

integer li_i, li_j,li_k,li_k1, li_first_head = 0, li_second_head = 0, li_first_tail = 0, li_second_tail = 0
integer li_l,li_r,li_b,li_l_begin,li_r_begin,li_b_begin,li_l_end,li_r_end,li_b_end
integer li_total_note_count, li_right_hand_note_count, li_left_hand_note_count
string ls_note, ls_note_wing, ls_finger_entry
double ldb_min, ldb_tmp, ldb_tmp1

if ii_moving_inteval_ind = 0 then // there is a continuous note advancing, let's play notes
	return
end if


integer li_retain_notes[]
wf_parse_note_attribute(is_cur_text_list[ii_current_note],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
	ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)

// add extending note to retain note list
for li_i = 1 to li_rh_note_set_count
	if integer(ls_rh_note_value[li_i]) > 0 then
		for li_j = 1 to upperbound(ii_played_notes)
			if integer(ls_rh_note_value[li_i]) = ii_played_notes[li_j] and ls_rh_note_char[li_i] = "2" then // retain note
				li_retain_notes[upperbound(li_retain_notes) + 1] = ii_played_notes[li_j]
			end if
		next
	end if
next
for li_i = 1 to li_lh_note_set_count
	if integer(ls_lh_note_value[li_i]) > 0 then
		for li_j = 1 to upperbound(ii_played_notes)
			if integer(ls_lh_note_value[li_i]) = ii_played_notes[li_j] and ls_lh_note_char[li_i] = "2" then // retain note
				li_retain_notes[upperbound(li_retain_notes) + 1] = ii_played_notes[li_j]
			end if
		next
	end if
next	

// traverse through retain note list, if a played note is not in the retain note list, then remove(release) the key, message 1041
boolean lb_found = false
for li_i = 1 to upperbound(ii_played_notes)
	lb_found = false
	for li_j = 1 to upperbound(li_retain_notes)
		if ii_played_notes[li_i] = li_retain_notes[li_j] then lb_found = true
	next
	if not lb_found then // release the play note key
		wf_remove_played_note(ii_played_notes[li_i])
		extPostThreadMessage(il_thread_id, 1041, ii_played_notes[li_i], 0)
	end if
next

// play new note
for li_i = 1 to li_rh_note_set_count
	if integer(ls_rh_note_value[li_i]) > 0 and ls_rh_note_char[li_i] <> "2" then
		wf_add_played_note(integer(ls_rh_note_value[li_i]))
		extPostThreadMessage(il_thread_id, 1040, integer(ls_rh_note_value[li_i]), 0)		// play the note
	end if
next
for li_i = 1 to li_lh_note_set_count
	if integer(ls_lh_note_value[li_i]) > 0 and ls_lh_note_char[li_i] <> "2" then
		wf_add_played_note(integer(ls_lh_note_value[li_i]))
		extPostThreadMessage(il_thread_id, 1040, integer(ls_lh_note_value[li_i]), 0)		// play the note
	end if
next

return 

end subroutine

public subroutine wf_add_played_note (integer ai_note);integer li_i = 0

for li_i = 1 to upperbound(ii_played_notes)
	if ii_played_notes[li_i] = 0 then exit
next

if li_i > 0 then 
	ii_played_notes[li_i] = ai_note
else
	ii_played_notes[upperbound(ii_played_notes) + 1] = ai_note
end if


end subroutine

public subroutine wf_remove_played_note (integer ai_note);integer li_i

for li_i = 1 to upperbound(ii_played_notes)
	if ii_played_notes[li_i] = ai_note then ii_played_notes[li_i] = 0
next


end subroutine

public function double wf_get_min_time ();string ls_note_coordinate,ls_note_to_keyboard
string ls_rh_time_fraction[],ls_rh_note_value[],ls_rh_note_char[],ls_rh_note_finger[]
string ls_lh_time_fraction[],ls_lh_note_value[],ls_lh_note_char[],ls_lh_note_finger[]
integer li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, li_note_set_count
integer li_current_note, li_entry_count, ii_rh_note_tmp, ii_lh_note_tmp

integer li_i, li_j
integer li_l,li_r,li_b,li_l_begin,li_r_begin,li_b_begin,li_l_end,li_r_end,li_b_end
integer li_total_note_count, li_right_hand_note_count, li_left_hand_note_count
string ls_note, ls_note_wing, ls_finger_entry
double ldb_min_duration = 10.0, ldb_tmp, ldb_seconds_per_bit, ldb_bits_per_minute


wf_parse_note_attribute(is_cur_text_list[ii_current_note],ls_note_coordinate,ls_note_to_keyboard,li_total_note_set_count,li_rh_note_set_count,li_lh_note_set_count, &
	ls_rh_time_fraction,ls_lh_time_fraction,ls_rh_note_value,ls_lh_note_value,ls_rh_note_char,ls_lh_note_char,ls_rh_note_finger,ls_lh_note_finger)

// reset time duration
for li_j = 1 to 5
	idb_right_note_duration[li_j] = 0.0
	idb_left_note_duration[li_j] = 0.0
next

idb_min_duration = 10.0

for li_j = 1 to li_rh_note_set_count	
	if integer(ls_rh_note_value[li_j]) > 0 then
		ldb_tmp = wf_string_to_fraction(ls_rh_time_fraction[li_j])
		if ldb_tmp > 0 then
			if ldb_tmp < ldb_min_duration then ldb_min_duration = ldb_tmp
		end if
	end if
next

for li_j = 1 to li_lh_note_set_count	
	if integer(ls_lh_note_value[li_j]) > 0 then
		ldb_tmp = wf_string_to_fraction(ls_lh_time_fraction[li_j])
		if ldb_tmp > 0 then
			if ldb_tmp < ldb_min_duration then ldb_min_duration = ldb_tmp
		end if
	end if
next

ldb_bits_per_minute = (ii_tempo - 1)*10

ldb_seconds_per_bit = 60.0/ldb_bits_per_minute

ldb_min_duration = (ldb_min_duration/0.25)*ldb_seconds_per_bit

return ldb_min_duration


end function

public subroutine wf_get_lesson_name ();long ll_pos
string ls_seperator
ls_seperator = "||"
ll_pos = pos(is_lesson_name, ls_seperator)
ls_seperator = " | |"
if ll_pos = 0 then ll_pos = pos(is_lesson_name, ls_seperator)
if ll_pos > 0 then
	is_lesson_name_eng = left(is_lesson_name, ll_pos - 1)
	is_lesson_name_chn = right(is_lesson_name, len(is_lesson_name) - (ll_pos + (len(ls_seperator) - 1)))
else
	is_lesson_name_eng = is_lesson_name
end if

//MessageBox("is_lesson_name_eng", is_lesson_name_eng)
is_bh_fingering_image = is_lesson_name_eng + "_fingering_image"
is_rh_fingering_image = is_bh_fingering_image + "_right"
is_lh_fingering_image = is_bh_fingering_image + "_left"
is_cur_fingering_image = is_bh_fingering_image
is_finger_graphic = is_lesson_name_eng + "_finger_lib_001"

end subroutine

public function integer wf_send_note (boolean ab_clicked);long ll_lh_id[],ll_lh_note_id[],ll_lh_note_x[],ll_lh_note_y[],ll_lh_w_pct_y[],ll_lh_h_pct_y[],ll_lh_size
long ll_rh_id[],ll_rh_note_id[],ll_rh_note_x[],ll_rh_note_y[],ll_rh_w_pct_y[],ll_rh_h_pct_y[],ll_rh_size
long ll_width, ll_eight, ll_i

string ls_entry, ls_note_sent_to_keyboard, ls_finger_attr, ls_atom, ls_entry_list[]
integer li_pos1, li_pos2, li_n, li_i, li_l = 0, li_r = 0, li_fingering_ind, file_num
integer li_image_index
long ll_trans_list[]
string msg

if ii_current_note > upperbound(is_cur_finger_list) then return 0
ls_entry = is_cur_finger_list[ii_current_note]
//MessageBox("wf_send_note: ii_current_i", ii_current_i)
//MessageBox("ls_entry", ls_entry)
li_pos1 = pos(ls_entry, "FB")
li_pos2 = pos(ls_entry, "FE")
if li_pos1 = 0 or li_pos2 = 0 or li_pos2 < li_pos1 then
	MessageBox("Error", "wf_send_note Data Corrupted!")
	return 0 // NOT A VALID ENTRY 
end if
li_fingering_ind = integer(mid(ls_entry, li_pos1 + 2, 1))
ls_finger_attr = mid(ls_entry, li_pos1 + 2, li_pos2 - li_pos1 - 2)
ls_note_sent_to_keyboard = right(is_cur_text_list[ii_current_note],len(is_cur_text_list[ii_current_note]) - 18)
//MessageBox("ls_finger_attr", ls_finger_attr)
if li_fingering_ind = LEFTHAND_FINGERING or li_fingering_ind = RIGHTHAND_FINGERING then
	wf_parse_finger_entry(ls_finger_attr, ls_entry_list)
//	MessageBox("upperbound(ls_entry_list)", upperbound(ls_entry_list))
	for li_i = 1 to upperbound(ls_entry_list)
		if left(ls_entry_list[li_i], 1) = "1" then // left hand
			li_l++
			ll_lh_id[li_l] = long(left(ls_entry_list[li_i], 4))
			ll_lh_note_id[li_l] = long(mid(ls_entry_list[li_i], 5, 3))
			ll_lh_note_x[li_l] = long(mid(ls_entry_list[li_i], 8, 2))
			ll_lh_note_y[li_l] = long(mid(ls_entry_list[li_i], 10, 2))
			ll_lh_w_pct_y[li_l] = long(mid(ls_entry_list[li_i], 12, 3))
			ll_lh_h_pct_y[li_l] = long(mid(ls_entry_list[li_i], 15, 3))
//			msg = " ll_lh_id:" + string(ll_lh_id[li_l]) + " ll_lh_note_id:" + string(ll_lh_note_id[li_l]) + " ll_lh_note_x:" + string(ll_lh_note_x[li_l]) + &
//				" ll_lh_note_y:" + string(ll_lh_note_y[li_l]) + " ll_lh_w_pct_y:" + string(ll_lh_w_pct_y[li_l]) 
//			MessageBox(msg, li_l)
		end if
		if left(ls_entry_list[li_i], 1) = "2" then
			li_r++
			ll_rh_id[li_r] = long(left(ls_entry_list[li_i], 4))
			ll_rh_note_id[li_r] = long(mid(ls_entry_list[li_i], 5, 3))
			ll_rh_note_x[li_r] = long(mid(ls_entry_list[li_i], 8, 2))
			ll_rh_note_y[li_r] = long(mid(ls_entry_list[li_i], 10, 2))
			ll_rh_w_pct_y[li_r] = long(mid(ls_entry_list[li_i], 12, 3))
			ll_rh_h_pct_y[li_r] = long(mid(ls_entry_list[li_i], 15, 3))
//			msg = " ll_rh_id:" + string(ll_rh_id[li_r]) + " ll_rh_note_id:" + string(ll_rh_note_id[li_r]) + " ll_rh_note_x:" + string(ll_rh_note_x[li_r]) + &
//				" ll_rh_note_y:" + string(ll_rh_note_y[li_r]) + " ll_rh_w_pct_y:" + string(ll_rh_w_pct_y[li_r]) 
//			MessageBox(msg, li_r)
		end if
	next

//			msg = " ll_lh_id:" + string(ll_lh_id[1]) + " ll_lh_note_id:" + string(ll_lh_note_id[1]) + " ll_lh_note_x:" + string(ll_lh_note_x[1]) + &
//				" ll_lh_note_y:" + string(ll_lh_note_y[1]) + " ll_lh_w_pct_y:" + string(ll_lh_w_pct_y[1]) + " upperbound(ll_rh_id))" + string(upperbound(ll_lh_id))
//			MessageBox(msg, msg)
	
	extCurrentEntry(ll_lh_id,ll_lh_note_id,ll_lh_note_x,ll_lh_note_y,ll_lh_w_pct_y,ll_lh_h_pct_y,upperbound(ll_lh_id),ll_rh_id,ll_rh_note_id,ll_rh_note_x,ll_rh_note_y,ll_rh_w_pct_y,ll_rh_h_pct_y,upperbound(ll_rh_id))

end if

if li_fingering_ind = NO_FINGERING or ii_prompt_ind = 2 or ii_prompt_ind = 6 or ii_prompt_ind = 10 then // clear the fingering
	extClearCurGraph()
end if

sle_3.text = string(ii_current_note) + " " + ls_note_sent_to_keyboard
extSetCurrentNote(ls_note_sent_to_keyboard) 	// place the note string in the global memory

//extPostThreadMessage(il_thread_id, 1025, 0, 0)	// send message to the music player to inform Next Note to pick up data in global memory
//return 1

// the below code is for picture animation

ib_keyboard_fingering_painted = false
if ii_moving_interval_type = 1 then // one note advance
	extPostThreadMessage(il_thread_id, 1025, 0, 0)	// send message to the music player to inform Next Note to pick up data in global memory
else			// animation like
	//extPostThreadMessage(il_thread_id, 1026, 0, 0)	// send dummy message to the music player 
	li_image_index = ii_cur_list_index[ii_current_note]

	for ll_i = 1 to upperbound(il_image_seq)
		if integer(il_image_seq[ll_i]/10) = li_image_index and mod(il_image_seq[ll_i], 10) = 0 then
			ll_trans_list[upperbound(ll_trans_list) + 1] = il_image_seq[ll_i]
			exit
		end if
	next
	sle_2.text = "ii_current_note=" + string(ii_current_note) + " li_image_index=" + string(li_image_index) + " " + string(ll_trans_list[1], "000000")
	if ab_clicked then 	
		f_set_picture_with_lhm(is_cur_fingering_image, string(ll_trans_list[1], "000000") + ".png", p_1, ll_width, ll_eight)
	end if
//		ib_animate_fingering = true
//		il_animate_id = il_trans_list[upperbound(il_trans_list)]
//		idb_animate_timer = ldb_min_timer/3
//		idb_animate_time_remain = ldb_min_timer - idb_animate_timer
//		f_set_picture_with_lhm(is_cur_fingering_image, string(il_trans_list[upperbound(il_trans_list)], "000000") + ".png", p_1, ll_width, ll_height)
//		timer(idb_animate_timer, this)				


//	for ll_i = 1 to upperbound(ll_trans_list)
//		f_set_picture_with_lhm(is_cur_fingering_image, string(ll_trans_list[ll_i], "000000") + ".png", p_1, ll_width, ll_eight)
//	next
//	f_set_picture_with_any_format(string(ii_current_note) + ".png", p_1, ll_width, ll_eight)
end if

//if not ib_reset_pos then // first time this funciton called
//	extPostThreadMessage(il_thread_id, 1025, 0, 0)	// send message to the music player to inform Next Note to pick up data in global memory
//else
//	extPostThreadMessage(il_thread_id, 1026, 0, 0)	// send dummy message to the music player 
//end if
return 1


end function

public function integer wf_make_string_list (string as_input, ref string as_output[]);integer li_i, li_seq, li_begin, li_pos, li_len
string ls_tmp, ls_line

ls_tmp = as_input
if len(ls_tmp) > 0 then
	li_pos = pos(ls_tmp, "~r~n")
	do while li_pos > 0
		ls_line = left(ls_tmp, li_pos - 1)
		as_output[upperbound(as_output) + 1] = ls_line
//		MessageBox(ls_line, ls_line)
		ls_tmp = right(ls_tmp, len(ls_tmp) - li_pos - 1)
		li_pos = pos(ls_tmp, "~r~n")
	loop
	if len(ls_tmp) > 0 then
		ls_line = ls_tmp
		as_output[upperbound(as_output) + 1] = ls_line
//		MessageBox(ls_line, ls_line)		
	end if
end if

return 1
end function

on w_lesson_music.create
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
this.cb_reset=create cb_reset
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
this.p_keyboard1=create p_keyboard1
this.cb_5=create cb_5
this.sle_3=create sle_3
this.p_top=create p_top
this.p_bottom=create p_bottom
this.p_left=create p_left
this.p_right=create p_right
this.p_bottom2=create p_bottom2
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
this.Control[iCurrent+10]=this.cb_reset
this.Control[iCurrent+11]=this.st_start
this.Control[iCurrent+12]=this.st_end
this.Control[iCurrent+13]=this.cbx_keyboard
this.Control[iCurrent+14]=this.sle_beat_rate
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.sle_1
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.pb_3
this.Control[iCurrent+19]=this.uo_1
this.Control[iCurrent+20]=this.sle_2
this.Control[iCurrent+21]=this.cbx_finger_hint
this.Control[iCurrent+22]=this.cb_2
this.Control[iCurrent+23]=this.cb_4
this.Control[iCurrent+24]=this.p_keyboard1
this.Control[iCurrent+25]=this.cb_5
this.Control[iCurrent+26]=this.sle_3
this.Control[iCurrent+27]=this.p_top
this.Control[iCurrent+28]=this.p_bottom
this.Control[iCurrent+29]=this.p_left
this.Control[iCurrent+30]=this.p_right
this.Control[iCurrent+31]=this.p_bottom2
end on

on w_lesson_music.destroy
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
destroy(this.cb_reset)
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
destroy(this.p_keyboard1)
destroy(this.cb_5)
destroy(this.sle_3)
destroy(this.p_top)
destroy(this.p_bottom)
destroy(this.p_left)
destroy(this.p_right)
destroy(this.p_bottom2)
end on

event open;call super::open;integer ret 
any la_tmp
//Get the Listview Handle so the window can communicate with it

gn_appman.of_get_parm("Listview Handle", la_tmp)

il_listview_handle = la_tmp

//BackColor =  2^29 

il_win_handle = handle(this)
//il_bin_size = FileLength("music_lesson_bk.bmp")
//il_ascii_size = il_bin_size*3/2
//is_BitmapPtr = space(il_ascii_size)
//
//LoadGraph(il_win_handle, "music_lesson_bk.bmp", is_BitmapPtr, il_ascii_size, il_bin_size)

p_top.visible = false
p_bottom.visible = false
p_left.visible = false
p_right.visible = false
uo_1.uo_1.iw_parent = this
uo_1.uo_1.st_11.visible = false
uo_1.uo_1.st_2.visible = false
uo_1.uo_1.st_3.visible = false
uo_1.uo_1.st_4.visible = false

cb_start_record.visible = false
cb_play_demo.visible = false
cb_playback.visible = false
cb_play_demo.visible = false
cb_save.visible = false

uo_1.uo_1.st_start.BringToTop = true
uo_1.uo_1.st_End.BringToTop = true
//MessageBox("is_startupfile", is_startupfile)
if ProfileString ( is_startupfile, "SOUND_DRIVER", "SOUND_SEPERATION", "NO" ) = "YES" then
	ib_sound_seperation = true
end if
is_left_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "LEFT_HAND_SOUND_DEVICE", "" )
is_right_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "RIGHT_HAND_SOUND_DEVICE", "" )
is_midi_input_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "MIDI_INPUT_DEVICE", "" )
is_midi_output_dev_name = ProfileString ( is_startupfile, "SOUND_DRIVER", "MIDI_OUTPUT_DEVICE", "" )
//is_right_dev_name = is_midi_output_dev_name
//MessageBox("is_right_dev_name", is_right_dev_name)
//MessageBox("is_midi_output_dev_name", is_midi_output_dev_name)
//if IsWindow(gl_player_handle) then
//	il_player_handle = gl_player_handle
//end if

il_kb_handle = handle(p_keyboard1)
il_kb_dc = GetDC(il_kb_handle)

//long ll_width, ll_eight
//f_set_picture_with_any_format("2.png", p_1, ll_width, ll_eight)

//return
post wf_reset_pos()
//MessageBox("is_remote_lesson_path", is_remote_lesson_path)


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

event close;//Send(il_player_handle, 1026, 0, 0) //
//if IsWindow(il_player_handle) then
//	gl_player_handle = il_player_handle
//	ShowWindow(il_player_handle, 0)
//end if
//SetDlgSignal()
timer(0, this)
extPostThreadMessage(il_thread_id,18,0,0)
il_thread_id = 0
extClearCurGraph()
extClearGraphLib() 
if isValid(invo_timing) then destroy invo_timing
if isValid(iw_popup_menu) then close(iw_popup_menu)

//integer li_num1, li_i
//li_num1 = FileOpen("t1.txt", LineMode!, Write!, LockWrite!, Replace!)
//for li_i = 1 to upperbound(ll_cpu_list)
//	FileWrite(li_num1, string(ll_cpu_list[li_i], "000000"))
//next

post(il_listview_handle, 1024, 0, 0)
super::event close()


end event

event key;call super::key;call super::key;integer li_row
long ll_count, ll_cur_cpu, ll_i
string ls_comment_type, ls_win_title
if KeyDown(KeyControl!) and KeyDown(KeyH!) and KeyDown(KeyA!) and KeyDown(KeyN!) then
	cb_start_record.visible = true
	cb_play_demo.visible = true
	cb_playback.visible = true
	cb_play_demo.visible = true
	cb_start_record.visible = true
	cb_save.visible = true
end if

//if KeyDown(KeyPageDown!) then
//	wf_note_advancing()	
//end if

if KeyDown(KeyPageUp!) then
	if ii_prompt_ind = 0 then // NONE PROMPTING
		// just scroll all the way up
		for ll_i = 1 to 100/uo_1.LinesPerPage
			Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3 DOWN
		next
		return
	end if	
	
	if ii_current_note > ii_begin_note then
		ii_current_note --
		wf_rec_move(is_cur_text_list[ii_current_i])
		wf_send_note(false)
	end if
end if

if not ib_foot_switch_in_process then
	ll_cur_cpu = cpu()
	if (KeyDown(KeyControl!) and KeyDown(KeyShift!) and KeyDown(KeyR!)) or KeyDown(KeyPageDown!) then
		ib_foot_switch_in_process = true
		if ll_cur_cpu - ll_cpu < 500 then 
			ib_foot_switch_released = false
		else
			ib_foot_switch_released = true
		end if	
		if ib_foot_switch_released then
				wf_note_advancing()
			
//			if ii_current_note < ii_end_note then
//				ii_current_note++
//				wf_rec_move(is_cur_text_list[ii_current_note])
//				wf_send_note()
//			end if
		end if
		ll_cpu = ll_cur_cpu
		ib_foot_switch_in_process = false
	end if
end if

return
if not ib_foot_switch_in_process then
	ll_cur_cpu = cpu()
	if KeyDown(KeyControl!) and KeyDown(KeyShift!) and KeyDown(KeyR!) then
		ib_foot_switch_in_process = true
		il_cpu = cpu()
		ib_foot_switch_released = false
		if il_cpu_prev = 0 then
			il_cpu_counter = 1
		elseif il_cpu <> il_cpu_prev then
			ll_cpu_list[upperbound(ll_cpu_list) + 1] = il_cpu_counter
			if il_cpu_counter = 2 then
				ib_foot_switch_released = true
			end if
			il_cpu_counter = 1
		else
			il_cpu_counter++
		end if
		if ib_foot_switch_released then
			if ii_current_note < ii_end_note then
				ii_current_note++
				wf_rec_move(is_cur_text_list[ii_current_note])
				wf_send_note(true)
			end if
		end if
		il_cpu_prev = il_cpu
		ib_foot_switch_in_process = false
	end if
end if

return

//ll_cpu_list[]
	if KeyDown(KeyControl!) and KeyDown(KeyShift!) and KeyDown(KeyR!) then
		il_cpu = cpu()
		if il_cpu_prev = 0 then
			il_cpu_counter = 1
		elseif il_cpu <> il_cpu_prev then
			ll_cpu_list[upperbound(ll_cpu_list) + 1] = il_cpu_counter
			if il_cpu_counter = 2 then
//				MessageBox("key", "moved")
				wf_rec_move(is_cur_text_list[ii_current_note])
				wf_send_note(true)			
			end if
			il_cpu_counter = 1
		else
			il_cpu_counter++
		end if
		il_cpu_prev = il_cpu
//		ll_cpu_list[upperbound(ll_cpu_list) + 1] = cpu()
	end if
end event

event timer;integer WM_TIMER = 275
integer li_image_index
long ll_dc, ll_i, ll_width, ll_height, ll_cpu_now
double ldb_min_timer, ldb_cpu_elapsed

//			sle_2.text = "timer starts"

if ib_paint_bottom then
	ib_paint_bottom = false
	p_bottom.event ue_paint(0)
	ll_dc = GetDC(Handle(p_bottom))
	f_set_picture_copy_image(p_bottom, ll_dc, rect_bottom.left, 0, rect_bottom.right, rect_bottom.bottom)	
end if
timer(0, this)

//if ib_auto_fingering 
if ib_auto_fingering then
	if not ib_playing_trans_image and not ib_animate_fingering then 
		if ii_current_note >= ii_interval_begin and ii_current_note <= ii_interval_end then
			if ii_current_note = ii_interval_end then
				if il_moving_ind = 0 then //repeat
					ii_current_note = ii_interval_begin
					wf_rec_move(is_cur_text_list[ii_current_note])
					wf_send_note(true)
					sle_2.text = "ii_current_note = ii_interval_end il_moving_ind = 0"
				else
					ib_animate_fingering = true
					il_animate_id = ii_cur_list_index[ii_current_note]*10
					idb_animate_timer = 0
					idb_animate_time_remain = ldb_min_timer - idb_animate_timer
					f_set_picture_with_lhm(is_cur_fingering_image, string(il_animate_id, "000000") + ".png", p_1, ll_width, ll_height)
					sle_2.text = "ii_current_note = ii_interval_end il_moving_ind > 0 ii_current_note=" + string(ii_current_note)
				end if		
				ib_auto_fingering = false
	//			timer(0, this)
			else					// auto fingering is in progress
				ii_current_note++
				wf_rec_move(is_cur_text_list[ii_current_note])
//				wf_send_note(false)		
				ll_i = 0
				if ii_tempo > 1 then // 
					ldb_min_timer = wf_get_min_time()
					wf_play_note()
				else
					ldb_min_timer = 2.0
				end if
//				wf_send_note()	
				// prepare trans image
				il_trans_list = il_empty_list
				li_image_index = ii_cur_list_index[ii_current_note]
				for ll_i = 1 to upperbound(il_image_seq)
					// collect transition image index and 
					if (integer(il_image_seq[ll_i]/10) = (li_image_index - 1) and mod(il_image_seq[ll_i], 10) > 0) or &
						(integer(il_image_seq[ll_i]/10) = li_image_index and mod(il_image_seq[ll_i], 10) = 0) then
						il_trans_list[upperbound(il_trans_list) + 1] = il_image_seq[ll_i]
					end if
				next
				il_trans_image_count = upperbound(il_trans_list)
				if il_trans_image_count = 0 then
					sle_2.text = "ii_current_note <> ii_interval_end il_trans_image_count = 0"
					timer(ldb_min_timer, this)		
				elseif il_trans_image_count = 1 then // Only Show Note
					ib_animate_fingering = true
					il_animate_id = il_trans_list[1]
					idb_animate_timer = ldb_min_timer/2.0
//					idb_animate_time_remain = ldb_min_timer - idb_animate_timer
					f_set_picture_with_lhm(is_cur_fingering_image, string(il_trans_list[1], "000000") + ".png", p_1, ll_width, ll_height)
					sle_2.text = "ii_current_note <> ii_interval_end il_trans_image_count = 1"
//					cb_1.visible = true
//					cb_1.BringToTop = true
					il_begin_play_time = cpu()
					timer(idb_animate_timer, this)				
//					timer(ldb_min_timer, this)				
				elseif il_display_trans_fingering = 0 then // Do not display trans images					
					ib_animate_fingering = true
					il_animate_id = il_trans_list[upperbound(il_trans_list)]
					idb_animate_timer = ldb_min_timer/2.0
//					idb_animate_time_remain = ldb_min_timer - idb_animate_timer
//					f_set_picture_with_lhm(is_cur_fingering_image, string(il_trans_list[upperbound(il_trans_list)], "000000") + ".png", p_1, ll_width, ll_height)
//					cb_1.visible = true
//					cb_1.BringToTop = true
					il_begin_play_time = cpu()
					timer(idb_animate_timer, this)				
//					timer(ldb_min_timer, this)				
					sle_2.text = "ii_current_note <> ii_interval_end il_display_trans_fingering = 0"
				else			// there is/are trans image(s)
					idb_trans_timer = ldb_min_timer/(3.0*(il_trans_image_count - 1))
					idb_note_timer = ldb_min_timer*2.0/3.0
					idb_animate_timer = idb_note_timer/2
					f_set_picture_with_lhm(is_cur_fingering_image, string(il_trans_list[1], "000000") + ".png", p_1, ll_width, ll_height)
//					cb_1.visible = true
//					cb_1.BringToTop = true
					il_trans_image_index = 2
					ib_playing_trans_image = true
					il_begin_play_time = cpu()
					timer(idb_trans_timer, this)				
					sle_2.text = "ii_current_note <> ii_interval_end there is/are trans image(s)"
				end if
			end if
		end if
		sle_2.text = "ii_current_note=" + string(ii_current_note) + " ii_interval_end=" + string(ii_interval_end)

	elseif ib_playing_trans_image then		// playing transitional image
		f_set_picture_with_lhm(is_cur_fingering_image, string(il_trans_list[il_trans_image_index], "000000") + ".png", p_1, ll_width, ll_height)
		if il_trans_image_index = il_trans_image_count then // end of transitional image
			ib_playing_trans_image = false
			ib_animate_fingering = true
			il_animate_id = il_trans_list[il_trans_image_index]
			idb_animate_timer = idb_note_timer/2
//			idb_animate_time_remain = idb_note_timer - idb_animate_timer
			il_begin_play_time = cpu()
			timer(idb_animate_timer, this)				
					sle_2.text = "ib_playing_trans_image is true il_trans_image_index = il_trans_image_count "
		else // transitional image still on
			il_trans_image_index++
			sle_2.text = "ib_playing_trans_image is true transitional image still on"
			il_begin_play_time = cpu()
			timer(idb_trans_timer, this)							
		end if
	end if	
else
	sle_2.text = "timer ib_auto_fingering NOT true"	
end if

//return 1
ll_cpu_now = cpu()
ldb_cpu_elapsed = double((ll_cpu_now - il_begin_play_time))/1000.0
if ib_animate_fingering and ldb_cpu_elapsed >= idb_animate_timer then	//
	il_animate_id = il_animate_id + 1000000
	sle_2.text = "cpu_elapsed=" + string(round(ldb_cpu_elapsed, 2)) + " animate_timer=" + string(round(idb_animate_timer, 2))
	f_set_picture_with_lhm(is_cur_fingering_image, string(il_animate_id) + ".png", p_1, ll_width, ll_height)
	ib_animate_fingering = false
	timer(idb_animate_timer, this)
end if
//Yield()

end event

event mousemove;call super::mousemove;if xpos > x + 10 and xpos < x + width - 10 and ypos > y + 10 and ypos < y + 40 then
	if Not ib_popup_menu and Not IsValid(iw_popup_menu) Then
		ib_popup_menu =  true
		open(iw_popup_menu, this)
	end if
else
	close(iw_popup_menu)
	ib_popup_menu =  false
end if

if inv_forward_button.f_is_mouse_over(xpos,ypos) then SetHandCursor()
if inv_backward_button.f_is_mouse_over(xpos,ypos) then SetHandCursor()

end event

event clicked;call super::clicked;//event ue_paint(0)
//SetRedraw(false)
//ib_paint = false
//uo_1.uo_1.SetRedraw(false)
//uo_1.SetRedraw(false)
//MessageBox("clicked", "1")
SetRedraw(false)

if inv_forward_button.f_is_mouse_over(xpos,ypos) then 
	if ii_current_note < ii_end_note then
		ii_current_i++
		wf_rec_move(is_cur_text_list[ii_current_i])
		wf_send_note(true)
	end if
//	event ue_paint(0)
end if
if inv_backward_button.f_is_mouse_over(xpos,ypos) then 
	if ii_current_note > ii_begin_note then
		ii_current_i --
		wf_rec_move(is_cur_text_list[ii_current_i])
		wf_send_note(true)
	end if
//	event ue_paint(0)
end if
//MessageBox("clicked", "2")
ib_paint = true
SetRedraw(true)
//event ue_paint(0)
//MessageBox("ii_counter", ii_counter)
//SetRedraw(true)
//event ue_paint(0)

end event

type dw_reward from w_lesson2`dw_reward within w_lesson_music
end type

type cb_close from w_lesson2`cb_close within w_lesson_music
string tag = "1508040"
boolean visible = false
integer x = 69
integer y = 352
integer width = 146
integer height = 72
end type

event cb_close::clicked;//if MessageBox('Warning', 'Do You Want To Close The Lesson?', Question!, YesNo!, 2) = 1 then
	timer(0, parent)
	close(parent)
//end if
end event

type cb_start from w_lesson2`cb_start within w_lesson_music
string tag = "1508040"
boolean visible = false
integer x = 4274
integer y = 20
integer width = 201
integer height = 96
string text = "&Start"
end type

event cb_start::clicked;call super::clicked;integer li_i

string ls_note_to_keyboard, ls_text, ls_local_filename
uo_1.uo_1.p_1.visible = true
uo_1.uo_1.p_1.BringToTop = true

//cb_playback.visible = true

//MessageBox("start clicked 1-" + string(ii_current_note), ii_begin_note)

ii_current_note = ii_begin_note // first note
//MessageBox("start clicked 2-" + string(ii_current_note), ii_begin_note)
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
//		f_GetCacheResourceFile(is_cur_picture_list[ii_current_note], ls_local_filename)
//		uo_1.uo_1.p_1.PictureName = ls_local_filename
		wf_reset_pic_coord()
		exit
	end if
next

ii_current_note = ii_begin_note // first note
//MessageBox("start clicked 3-" + string(ii_current_note), ii_begin_note)
ls_text = trim(is_cur_text_list[ii_current_note])

if ii_prompt_ind <> 0 and mod(ii_prompt_ind, 4) <> 2 then // not 0 and 2
	// move hint highlight
	wf_rec_move(ls_text)
	uo_1.uo_1.st_11.visible = true
	uo_1.uo_1.st_2.visible = true
	uo_1.uo_1.st_3.visible = true
	uo_1.uo_1.st_4.visible = true
else
	uo_1.uo_1.st_11.visible = false
	uo_1.uo_1.st_2.visible = false
	uo_1.uo_1.st_3.visible = false
	uo_1.uo_1.st_4.visible = false	
end if

//MessageBox("ii_prompt_ind", ii_prompt_ind)
//Send(il_player_handle, 1027, ii_prompt_ind, 0) //reset prompt

//ls_note_to_keyboard = mid(ls_text, 17, len(ls_text) - 16)
//if mod(len(ls_note_to_keyboard)/8, 2) = 1 then ls_note_to_keyboard = ls_note_to_keyboard + "00000000"
//MessageBox("ls_note_to_keyboard", ls_note_to_keyboard)
//extSetMusicNoteToSharedMemory(ls_note_to_keyboard) //set key-note information to sharememory
//Sleep(1)
//
////MessageBox(ls_note_to_keyboard, ii_prompt_ind)
//if ii_prompt_ind > 0 then
//	extPostThreadMessage(il_thread_id, 1025, 0, 0)	// send message to the music player to inform Next Note to play data in sharemory
//end if

//MessageBox("start clicked 4-" + string(ii_current_note), ii_begin_note)
//MessageBox("ii_current_note", ii_current_note)
//sle_3.text = "start clicked ii_current_note=" + string(ii_current_note)
wf_send_note(true)
end event

type dw_2 from w_lesson2`dw_2 within w_lesson_music
end type

type p_1 from w_lesson2`p_1 within w_lesson_music
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
boolean visible = false
integer x = 3726
integer y = 252
integer width = 165
integer height = 104
boolean enabled = true
boolean originalsize = true
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
				uo_1.uo_1.p_1.PictureName = ls_local_filename
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

li_x = PointerX() + uo_1.uo_1.p_1.x
li_y = PointerY() + uo_1.uo_1.p_1.y

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

type st_1 from w_lesson2`st_1 within w_lesson_music
integer x = 2085
integer y = 108
integer width = 73
integer height = 184
integer textsize = -12
long textcolor = 8388608
string text = ""
end type

type dw_1 from w_lesson2`dw_1 within w_lesson_music
end type

type dw_prompt from w_lesson2`dw_prompt within w_lesson_music
boolean visible = false
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

type st_2 from statictext within w_lesson_music
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

type st_3 from statictext within w_lesson_music
boolean visible = false
integer x = 2235
integer y = 120
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

type st_4 from statictext within w_lesson_music
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

type st_11 from statictext within w_lesson_music
boolean visible = false
integer x = 2354
integer y = 156
integer width = 224
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

type cb_start_record from commandbutton within w_lesson_music
boolean visible = false
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

type cb_play_demo from commandbutton within w_lesson_music
boolean visible = false
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

event clicked;cb_reset.event clicked()

wf_play_demo()

return 1


end event

type cb_save from commandbutton within w_lesson_music
boolean visible = false
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

type cb_playback from commandbutton within w_lesson_music
boolean visible = false
integer x = 1632
integer width = 215
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Playback"
end type

event clicked;
//wf_play_back()
extClearGraphLib()
wf_load_finger_graphs()

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
				uo_1.uo_1.p_1.PictureName = ls_local_filename
				wf_reset_pic_coord()
			end if
			wf_rec_move(is_cur_text_list[ii_current_note])
		end if	
		ii_current_note++
	end if
//	MessageBox(string(il_midi_data[li_i]), il_midi_time[li_i])
next


end event

type cbx_note_sound from checkbox within w_lesson_music
boolean visible = false
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

type cb_reset from commandbutton within w_lesson_music
boolean visible = false
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
//uo_1.uo_1.p_1.y = 1
wf_set_bar(1, ii_begin_note)
wf_set_bar(2, ii_end_note)

end event

type st_start from st_1 within w_lesson_music
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

type st_end from st_1 within w_lesson_music
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

type cbx_keyboard from checkbox within w_lesson_music
boolean visible = false
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

type sle_beat_rate from singlelineedit within w_lesson_music
boolean visible = false
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

type st_5 from statictext within w_lesson_music
boolean visible = false
integer x = 1623
integer y = 64
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

type sle_1 from singlelineedit within w_lesson_music
boolean visible = false
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

type cb_1 from commandbutton within w_lesson_music
boolean visible = false
integer x = 2528
integer y = 392
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

type pb_3 from picturebutton within w_lesson_music
boolean visible = false
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

type uo_1 from uo_music_sheet_dummy within w_lesson_music
event ue_vscroll pbm_vscroll
event lbuttondown pbm_lbuttondown
event ue_mouseover pbm_nchittest
event ue_keydown pbm_keydown
integer x = 119
integer y = 152
integer width = 3634
integer height = 1972
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
//sle_2.text = "scrollcode:" + string(scrollcode) + "scrollpos:" + string(scrollpos) + " cur_scroll" + string(ii_current_scroll)
sle_2.text = "uo_1.uo_1.y:" + string(parent.uo_1.uo_1.y) + "uo_1.uo_1.p_1.y:" + string(parent.uo_1.uo_1.p_1.y) + "scrollpos:" + string(scrollpos) + " cur_scroll" + string(ii_current_scroll)
//sle_2.text = "uo_1.uo_1.y:" + string(parent.uo_1.uo_1.y) + "scrollpos:" + string(scrollpos) + " cur_scroll" + string(ii_current_scroll)

//ii_current_scroll
end event

event ue_mouseover;ClosePopupMenu()
end event

event ue_keydown;parent.event key(key, keyflags)
end event

on uo_1.destroy
call uo_music_sheet_dummy::destroy
end on

type sle_2 from singlelineedit within w_lesson_music
boolean visible = false
integer x = 183
integer y = 152
integer width = 2217
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

type cbx_finger_hint from checkbox within w_lesson_music
boolean visible = false
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

type cb_2 from commandbutton within w_lesson_music
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

event clicked;	extPostThreadMessage(il_thread_id, 1040, 60, 0)	// send message to the music player to inform Next Note to pick up data in global memory
	Sleep(2)
	extPostThreadMessage(il_thread_id, 1041, 60, 0)	// send message to the music player to inform Next Note to pick up data in global memory





//parent.uo_1.uo_1.y = parent.uo_1.uo_1.y - 400
////Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3 DOWN
//		Send(handle(uo_1),277,3,0) // 6=TOP, 2=UP 3 DOWN
return 1

long ll_dc
//	inv_forward_button.event ue_paint(0,0) 
//	inv_backward_button.event ue_paint(0,0) 
	p_bottom.event ue_paint(0)
	ll_dc = GetDC(Handle(p_bottom))
	f_set_picture_copy_image(p_bottom, ll_dc, rect_bottom.left, 1, rect_bottom.right, rect_bottom.bottom)

end event

type cb_4 from commandbutton within w_lesson_music
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

event clicked;//Send(handle(uo_1),277,3,0) // 6=TOP, 2=UP 3 DOWN
long ll_win_handle, ll_win_dc, ll_w = 400, ll_h = 30

ll_win_handle = handle(parent)

ll_win_dc = GetDC(ll_win_handle)

CaptureImageRegion(ll_win_dc, "t1.bmp", 0,0,ll_w,ll_h)


end event

type p_keyboard1 from uo_dummy within w_lesson_music
event paint pbm_paint
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
integer x = 119
integer y = 2136
integer width = 3717
integer height = 540
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event paint;//extPostThreadMessage(il_thread_id,15,0,0)

end event

event lbuttondown;long li_x, li_y
long msg_lbutton_down = 1060

li_x = UnitsToPixels(xpos, XUnitsToPixels!)
li_y = UnitsToPixels(ypos, YUnitsToPixels!)
//MessageBox("cliked", xpos);
extPostThreadMessage(il_thread_id,msg_lbutton_down,li_x,li_y)

end event

event lbuttonup;long li_x, li_y
long msg_lbutton_up = 1061

li_x = UnitsToPixels(xpos, XUnitsToPixels!)
li_y = UnitsToPixels(ypos, YUnitsToPixels!)
//MessageBox("cliked", xpos);
extPostThreadMessage(il_thread_id,msg_lbutton_up,0,0)

end event

on p_keyboard1.destroy
call uo_dummy::destroy
end on

type cb_5 from commandbutton within w_lesson_music
boolean visible = false
integer x = 91
integer y = 64
integer width = 402
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop Thread"
end type

event clicked;//STOP THE THREAD

extPostThreadMessage(il_thread_id,18,0,0)

end event

type sle_3 from singlelineedit within w_lesson_music
boolean visible = false
integer x = 2450
integer y = 160
integer width = 1641
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type p_top from picture within w_lesson_music
event ue_paint pbm_paint
event ue_key pbm_keydown
event ue_mouseover pbm_nchittest
integer x = 23
integer y = 412
integer width = 325
integer height = 228
boolean bringtotop = true
boolean enabled = false
boolean focusrectangle = false
end type

event ue_paint;//gl_lang_ind 0=English 1=Chinese
long ll_dc, ll_x, ll_y, ll_array_size,ll_text_list[],ll_empty_list[], ll_pos
long ll_unicode_list[] = {25552,31034,24335,38899,20048,38190,30424,32451,20064,26354,32,45,32}
long ll_color, ll_i, ll_char_width
ulong ul_unicode_list[]

ll_dc = GetDC(handle(p_top))
string ls_seperator, ls_lesson_name_eng = "", ls_lesson_name_chn = ""
string ls_text_title = "Hint Based Keyboard Music Lesson - "
ll_color = 	16777215	// white
str_logfont logfont
str_rect_long rect
ls_seperator = "||"
ll_pos = pos(is_lesson_name, ls_seperator)
ls_seperator = " | |"
if ll_pos = 0 then ll_pos = pos(is_lesson_name, ls_seperator)
if ll_pos > 0 then
	ls_lesson_name_eng = left(is_lesson_name, ll_pos - 1)
	ls_lesson_name_chn = right(is_lesson_name, len(is_lesson_name) - (ll_pos + (len(ls_seperator) - 1)))
	for ll_i = 1 to len(ls_lesson_name_chn)/4
		ul_unicode_list[ll_i] = 0
	next
	extHexString2Number(ls_lesson_name_chn, ul_unicode_list)
else
	ls_lesson_name_eng = is_lesson_name
end if

ll_text_list = ll_empty_list
if gl_lang_ind = 0 then
	ll_char_width = 10
	for ll_i = 1 to len(ls_text_title)
		ll_text_list[ll_i] = asc(mid(ls_text_title, ll_i, 1))
	next	
	for ll_i = 1 to len(ls_lesson_name_eng)
		ll_text_list[len(ls_text_title) + ll_i] = asc(mid(ls_lesson_name_eng, ll_i, 1))
	next	
	f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
else	// chinese
	ll_char_width = 25
	ll_text_list = ll_unicode_list	
	for ll_i = 1 to upperbound(ul_unicode_list)
		ll_text_list[upperbound(ll_text_list) + 1] = ul_unicode_list[ll_i]
	next
	f_set_logfont(logfont,24,FW_BOLD,char(GB2312_CHARSET),"FongSong")
end if
ll_array_size = upperbound(ll_text_list)

string ls_menu_list[]
long ll_unicode_list2[]
integer li_prompt_list[], li_i, li_found, li_char_index,li_unicode_index[]


if ib_reset_pos then
	ll_x = UnitsToPixels(width/2, XUnitsToPixels!) - ll_array_size*ll_char_width/2
	ll_y = 5
	extTextOutFromPB(ll_dc,gl_lang_ind,ll_x,ll_y,ll_text_list,ll_array_size,ll_color,logfont) 
//	MessageBox("ue_paint", "1")
end if

//25552 U+63d0 ti cce1 
//31034 U+793a shi cabe
//24335 U+5f0f shi cabd
//38899 U+97f3 yin d2f4
//20048 U+4e50 yue c0d6 
//38190 U+952e jian bcfc
//30424 U+76d8 pan c5cc
//32451 U+7ec3 lian c1b7
//20064 U+4e60 xi cfb0 
//26354 U+66f2 qi c7fa


end event

event ue_key;parent.event key(key, keyflags)
end event

event ue_mouseover;if xpos > uo_1.uo_1.x and xpos < uo_1.uo_1.x + uo_1.uo_1.width and ypos > 0 and ypos < uo_1.uo_1.y then
//	if Not ib_popup_menu and Not IsValid(iuo_popup_menu) Then
//		ib_popup_menu =  true
//		openuserobject(iuo_popup_menu, uo_1.uo_1.x, 1)
//	end if
	if Not ib_popup_menu and Not IsValid(iw_popup_menu) Then
		ib_popup_menu =  true
		open(iw_popup_menu, parent)
	end if
else
	close(iw_popup_menu)
//	CloseUserObject(iuo_popup_menu)
	ib_popup_menu =  false
end if

end event

type p_bottom from picture within w_lesson_music
event ue_paint pbm_paint
event ue_lbuttonclk pbm_lbuttonclk
event ue_mousemove pbm_mousemove
event ue_keydown pbm_keydown
integer y = 632
integer width = 325
integer height = 228
boolean bringtotop = true
boolean focusrectangle = false
end type

event ue_paint;//gl_lang_ind 0=English 1=Chinese
long ll_dc,ll_dc2, ll_x2, ll_y2, ll_array_size2, ll_text_list[],ll_text_list2[], ll_empty_list[], ll_pos
long ll_color, ll_i, ll_char_width
ulong ul_unicode_list[]
ll_color = 	16777215	// white
str_logfont logfont
str_rect_long rect, rect2

//SetRedraw(false)
string ls_menu_list[]
long ll_unicode_list2[]
integer li_prompt_list[], li_i, li_found, li_char_index,li_unicode_index[]
ll_dc = GetDC(handle(p_bottom))
if ib_both_exists then
	li_prompt_list = ii_both_prompt_list
	ls_menu_list = is_menu_list0
	ll_unicode_list2 = il_unicode_list0
	li_unicode_index = ii_unicode_index0
elseif ib_right_exists then
	li_prompt_list = ii_rh_prompt_list
	ls_menu_list = is_menu_list1
	ll_unicode_list2 = il_unicode_list1
	li_unicode_index = ii_unicode_index1
else
	li_prompt_list = ii_lh_prompt_list
	ls_menu_list = is_menu_list2
	ll_unicode_list2 = il_unicode_list2
	li_unicode_index = ii_unicode_index2
end if	
for li_i = 1 to upperbound(li_prompt_list)
	if ii_prompt_ind = li_prompt_list[li_i] then li_found = li_i
next
ll_text_list2 = ll_empty_list
if li_found = 0 then li_found = 1
if gl_lang_ind = 0 then
	ll_char_width = 10
	for ll_i = 1 to len(ls_menu_list[li_found])
		ll_text_list2[ll_i] = asc(mid(ls_menu_list[li_found], ll_i, 1))
	next	
	ll_text_list2[upperbound(ll_text_list2) + 1] = asc('-')
	for ll_i = 1 to len(is_menu_list3[ii_moving_interval_type])
		ll_text_list2[upperbound(ll_text_list2) + 1] = asc(mid(is_menu_list3[ii_moving_interval_type], ll_i, 1))
	next
	
	ll_text_list2[upperbound(ll_text_list2) + 1] = asc('-')
	for ll_i = 1 to len(is_menu_list4[ii_tempo])
		ll_text_list2[upperbound(ll_text_list2) + 1] = asc(mid(is_menu_list4[ii_tempo], ll_i, 1))
	next
	
	
	f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
	
else	// chinese
	ll_char_width = 25
	if li_found < upperbound(li_prompt_list) then
		ll_array_size2 = li_unicode_index[li_found+1] - li_unicode_index[li_found]
	else
		ll_array_size2 = upperbound(ll_unicode_list2) - li_unicode_index[li_found] + 1
	end if 
	for ll_i = 1 to ll_array_size2
		li_char_index = li_unicode_index[li_found] + ll_i - 1
		ll_text_list2[ll_i] = ll_unicode_list2[li_char_index]
	next
	ll_text_list2[upperbound(ll_text_list2) + 1] = 45

	if ii_moving_interval_type < upperbound(ii_unicode_index3) then
		ll_array_size2 = ii_unicode_index3[ii_moving_interval_type + 1] - ii_unicode_index3[ii_moving_interval_type]
	else
		ll_array_size2 = upperbound(il_unicode_list3) - ii_unicode_index3[ii_moving_interval_type] + 1
	end if 
	for ll_i = 1 to ll_array_size2
		li_char_index = ii_unicode_index3[ii_moving_interval_type] + ll_i - 1
		ll_text_list2[upperbound(ll_text_list2) + 1] = il_unicode_list3[li_char_index]
	next
	ll_text_list2[upperbound(ll_text_list2) + 1] = 45

	if ii_tempo < upperbound(ii_unicode_index4) then
		ll_array_size2 = ii_unicode_index4[ii_tempo + 1] - ii_unicode_index4[ii_tempo]
	else
		ll_array_size2 = upperbound(il_unicode_list4) - il_unicode_list4[ii_tempo] + 1
	end if 
	for ll_i = 1 to ll_array_size2
		li_char_index = ii_unicode_index4[ii_tempo] + ll_i - 1
		if li_char_index <= upperbound(il_unicode_list4) then
			ll_text_list2[upperbound(ll_text_list2) + 1] = il_unicode_list4[li_char_index]
		end if
	next

	f_set_logfont(logfont,24,FW_BOLD,char(0),"Arial")
end if	
ll_x2 = UnitsToPixels(width/2, XUnitsToPixels!) - upperbound(ll_text_list2)*ll_char_width/2
ll_y2 = 10
extTextOutFromPB(ll_dc,gl_lang_ind,ll_x2,ll_y2,ll_text_list2,upperbound(ll_text_list2),ll_color,logfont) 
inv_forward_button.event ue_paint(0,0) 
inv_backward_button.event ue_paint(0,0) 
inv_advance_rb.event ue_paint(0,0) 
inv_repeat_rb.event ue_paint(0,0) 
inv_trans_cb.event ue_paint(0,0) 

end event

event ue_lbuttonclk;//MessageBox("ue_lbuttonclk", "1")
long ll_dc2, ll_i, ll_units_per_scroll_uo_1
integer ll_interval = 1, li_begin_measure, li_end_measure, li_measuer_count

//MessageBox("ue_lbuttonclk", "1")
st_2.text = "ue_lbuttonclk 1"
if inv_forward_button.f_is_mouse_over(xpos,ypos) then 
st_2.text = "ue_lbuttonclk 2"
//MessageBox("ue_lbuttonclk", "2")
	wf_note_advancing()
	return
	
	if ii_current_note < ii_end_note then
		if ii_moving_interval_type = 1 then // one note advance
			ii_current_note++
			wf_rec_move(is_cur_text_list[ii_current_note])
			wf_send_note(true)		
			return 1
		elseif ii_moving_interval_type >= 2 and ii_moving_interval_type <= 4 then		
			choose case ii_moving_interval_type
				case 2		//Two Fingerings		- 2
					ll_interval = 2
				case 3		//Three Fingerings	- 3
					ll_interval = 3
				case 4		//Five Fingerings		- 4
					ll_interval = 5
			end choose
			ii_interval_begin = ii_current_note
			ii_interval_end = ii_current_note + ll_interval
			ib_auto_fingering = true
		elseif ii_moving_interval_type >= 5 and ii_moving_interval_type <= 7 then // moving by measure, move to the beginning of next measure
			for ll_i = 1 to upperbound(ii_measure_cur_begin_index)
				if ii_current_note >= ii_measure_cur_begin_index[ll_i] and ii_current_note <= ii_measure_cur_end_index[ll_i] then
					ii_current_measure = ll_i
					exit
				end if
			next
			li_measuer_count = ii_moving_interval_type - 5
			if il_moving_ind = 1 then // advance
				if ii_current_note = ii_measure_cur_end_index[ii_current_measure] then // advance to next measure
					if ii_current_measure < upperbound(ii_measure_cur_begin_index) then ii_current_measure++
				end if
				li_begin_measure = ii_current_measure
				if li_begin_measure + li_measuer_count > upperbound(ii_measure_cur_begin_index) then
					li_end_measure = upperbound(ii_measure_cur_begin_index)
				else
					li_end_measure = li_begin_measure + li_measuer_count
				end if
			else		// repeat
				if ii_current_note = ii_measure_cur_end_index[ii_current_measure] then // repeat has run, reset it
					ii_current_measure = ii_current_measure - li_measuer_count
					if ii_current_measure < 1 then ii_current_measure = 1
				end if
				li_begin_measure = ii_current_measure
				if li_begin_measure + li_measuer_count > upperbound(ii_measure_cur_begin_index) then
					li_end_measure = upperbound(ii_measure_cur_begin_index)
				else
					li_end_measure = li_begin_measure + li_measuer_count
				end if
			end if
			ii_current_note = ii_measure_cur_begin_index[ii_current_measure]
			ii_interval_begin = ii_measure_cur_begin_index[li_begin_measure]
			ii_interval_end = ii_measure_cur_end_index[li_end_measure]
			ii_current_note = ii_interval_begin				
			ib_auto_fingering = true					
		elseif ii_moving_interval_type = 8 then // moving within section
			ib_auto_fingering = true					
			ii_current_note = ii_begin_note
			ii_interval_begin = ii_current_note
			ii_interval_end = ii_end_note
//			Messagebox(string(ii_interval_begin), ii_interval_end)
			wf_rec_move(is_cur_text_list[ii_current_note])
			wf_send_note(true)		
		end if		
		wf_rec_move(is_cur_text_list[ii_current_note])
		wf_send_note(true)		
		timer(2, parent)

	end if
	event ue_paint(0)
end if
if inv_backward_button.f_is_mouse_over(xpos,ypos) then 
	if ii_prompt_ind = 0 then // NONE PROMPTING
		// just scroll all the way up
		for ll_i = 1 to 100/uo_1.LinesPerPage
			Send(handle(uo_1),277,2,0) // 6=TOP, 2=UP 3 DOWN
		next
		return
	end if	
	
	if ii_current_note > ii_begin_note then
		ii_current_note --
		wf_rec_move(is_cur_text_list[ii_current_i])
		wf_send_note(true)
	end if
	event ue_paint(0)
end if

if inv_advance_rb.f_is_mouse_over(xpos,ypos) then 
	inv_advance_rb.f_set_on_off_ind(1, il_moving_ind)
	inv_repeat_rb.f_set_on_off_ind(0, il_moving_ind)	
	ib_paint_bottom = true
	timer(1, parent)
end if

if inv_repeat_rb.f_is_mouse_over(xpos,ypos) then 
	inv_advance_rb.f_set_on_off_ind(0, il_moving_ind)
	inv_repeat_rb.f_set_on_off_ind(1, il_moving_ind)
	ib_paint_bottom = true
	timer(1, parent)
end if

if inv_trans_cb.f_is_mouse_over(xpos,ypos) then 
	if il_display_trans_fingering = 1 then // change to 0
		inv_trans_cb.f_set_on_off_ind(0, il_display_trans_fingering)
	else
		inv_trans_cb.f_set_on_off_ind(1, il_display_trans_fingering)
	end if
	ib_paint_bottom = true
	timer(1, parent)
end if

end event

event ue_mousemove;if inv_forward_button.f_is_mouse_over(xpos,ypos) then SetHandCursor()
if inv_backward_button.f_is_mouse_over(xpos,ypos) then SetHandCursor()
if inv_advance_rb.f_is_mouse_over(xpos,ypos) then SetHandCursor()
if inv_repeat_rb.f_is_mouse_over(xpos,ypos) then SetHandCursor()
if inv_trans_cb.f_is_mouse_over(xpos,ypos) then SetHandCursor()

end event

event ue_keydown;parent.event key(key, keyflags)
end event

event clicked;integer li_x, li_y
str_mousepos i_mousepos
GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) - this.x - parent.WorkSpaceX()
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) - this.y - parent.WorkSpaceY()

event ue_lbuttonclk(0, li_x, li_y)

end event

type p_left from picture within w_lesson_music
event ue_keydown pbm_keydown
integer y = 944
integer width = 325
integer height = 228
boolean bringtotop = true
boolean focusrectangle = false
end type

event ue_keydown;parent.event key(key, keyflags)
end event

type p_right from picture within w_lesson_music
event ue_keydown pbm_keydown
integer y = 1148
integer width = 325
integer height = 228
boolean bringtotop = true
boolean focusrectangle = false
end type

type p_bottom2 from picture within w_lesson_music
event ue_paint pbm_paint
event ue_lbuttonclk pbm_lbuttonclk
event ue_mousemove pbm_mousemove
event ue_keydown pbm_keydown
integer x = 160
integer y = 692
integer width = 325
integer height = 228
boolean bringtotop = true
boolean focusrectangle = false
end type

event ue_keydown;//parent.event key(key, keyflags)

return 1
end event

