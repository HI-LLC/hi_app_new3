$PBExportHeader$w_lesson.srw
forward
global type w_lesson from w_sheet
end type
type cb_close from commandbutton within w_lesson
end type
type cb_start from commandbutton within w_lesson
end type
type dw_1 from datawindow within w_lesson
end type
type dw_2 from datawindow within w_lesson
end type
type p_1 from picture within w_lesson
end type
type st_1 from statictext within w_lesson
end type
type point from structure within w_lesson
end type
type msg from structure within w_lesson
end type
end forward

type POINT from structure
	integer		x
	integer		y
end type

type MSG from structure
	long		hwnd
	integer		message
	integer		wParam
	long		lParam
	long		time
	POINT		pt
end type

global type w_lesson from w_sheet
string tag = "1500000"
integer x = 823
integer y = 360
integer width = 3557
integer height = 2248
string title = "Lesson"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 15780518
event ue_get_new_item pbm_custom01
cb_close cb_close
cb_start cb_start
dw_1 dw_1
dw_2 dw_2
p_1 p_1
st_1 st_1
end type
global w_lesson w_lesson

type prototypes
FUNCTION long get_message ( ref MSG lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "bcdll.dll"
FUNCTION long peek_message ( ref MSG lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "bcdll.dll"
FUNCTION long remove_message ( ref MSG lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "bcdll.dll"   
FUNCTION long show_cursor ( int cursor_ind ) LIBRARY "bcdll.dll"   

SUBROUTINE extMakeDataFile(string FnInput, string FnOutput) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extMakeDataFile@8"
FUNCTION long extAddTrainedData(string FileNamePrefix, string WaveFileName, long Age, string Gender) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extAddTrainedData@16"
FUNCTION long extUpdateTrainedData(string FileNamePrefix, string WaveFileName, long Index, long Age, string Gender) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extUpdateTrainedData@20"
FUNCTION long extLoadTrainedData(string FileNamePrefix, long Age, string Gender) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extLoadTrainedData@12"
FUNCTION long extSpeechRecognizing(long Interval, long RecogLevel) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extSpeechRecognizing@8"
FUNCTION long extGetTrainDataStat(string FileNamePrefix, long Age, string Gender, ref long SetSize,ref double MaxOverlap[], ref double MinOverlap[], ref double MeanOverlap[]) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetTrainDataStat@28"
FUNCTION long extGetMeanFileData(string FileName, ref decimal Data) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetMeanFileData@8"
FUNCTION long extGetMeanSoundData(string FileName, long Size, ref decimal Data) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetMeanSoundData@8"
FUNCTION long extDumpTrainedData(string FileNamePrefix, long Age, ref decimal Data) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extDumpTrainedData@8"
FUNCTION double extGetWaveDuration(string FnInput) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetWaveDuration@4"
FUNCTION long extGetBestIndex(string FileNamePrefix, long Age, string Gender) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetBestIndex@12"
subroutine InitSoundObject(ulong eThreadID, ulong eMessage, string SoundTmpFile) Library "voiceman.dll" ALIAS FOR "_InitSoundObject@12"
subroutine StartRecord(ulong EchoInd) Library "voiceman.dll"  ALIAS FOR "_StartRecord@4"
subroutine StopRecord() Library "voiceman.dll" ALIAS FOR "_StopRecord@0"
subroutine PlayBack() Library "voiceman.dll" ALIAS FOR "_PlayBack@0"
//subroutine StopPlayBack() Library "voiceman.dll" ALIAS FOR "_PlayBack@0"
subroutine StartPlaySoundFile(string FileName) Library "voiceman.dll" ALIAS FOR "_StartPlaySoundFile@4"
//subroutine StopPlaySoundFile(string FileName) Library "voiceman.dll" ALIAS FOR "_PlaySoundFile@4"
subroutine ExitRecord() Library "voiceman.dll" ALIAS FOR "_ExitRecord@0"
Function ulong WaveFileDuration(string filename) Library "voiceman.dll" ALIAS FOR "_WaveFileDuration@4"

end prototypes

type variables
protected:
datastore ids_lesson, ids_lesson_container
string is_wave_list[]
string is_picture_list[]
string is_text_list[]
string is_mask_list[]
string is_distract_list[]
string is_instruction
string is_instruction2
string is_response_to_right
string is_response_to_wrong
string is_preposition_1
string is_preposition_2
string is_prompt_instruction

string is_source_wave_list[]
string is_source_picture_list[]
string is_source_bean_wave_list[]
string is_source_bean_picture_list[]
string is_source_selected_ind_list[]
string is_dest_wave_list[]
string is_dest_picture_list[]
string is_dest_bean_wave_list[]
string is_dest_bean_picture_list[]
string is_dest_selected_ind_list[]
string is_picture_ind, is_text_ind
string is_gender

integer ii_degree
integer ii_tries
integer ii_item_presented[]
integer ii_correct_item
integer ii_answer_item
integer ii_total_items
integer ii_random_list[]
integer ii_current_try
integer ii_current_question_id = 1
integer ii_current_answer_id = 1
integer ii_selected_source = 0
integer ii_selected_dest = 0
integer ii_type
integer ii_current_list_offset = 1
integer ii_current_state = 0
constant integer ici_init_state = 0
constant integer ici_query_state = 1
constant integer ici_answer_expecting_state = 2
constant integer ici_lesson_end_state = 3

boolean ib_data_collection = false
boolean ib_batch_run = false
boolean ib_prompt = false
boolean ib_error_correction = false

str_lesson_program istr_lp
integer ii_number_list[]

long il_total_tries[]
long il_total_correct_answers[]
long il_progress_data_id
long il_lesson_id
long il_lesson_content_pair_ind[]
// speech recognition
long il_speech_recog_level
long il_content_id[]
long il_age
long il_noice_level


integer ii_count[]
integer ii_answer_list[]
integer ii_prompt_ind = 0
Pointer ip_orig_pointer
w_container iw_source[], iw_dest[]
w_dummy iw_dummy
public:
integer ii_trial_target = 0
boolean ib_drag = false
boolean ib_misspelled = false
boolean ib_done_prompt = false
boolean ib_waiting = false
integer ii_x0, ii_y0
end variables

forward prototypes
public subroutine wf_random_list ()
public subroutine wf_random_list (ref integer ai_list[], integer ai_count)
public subroutine wf_random_list (ref string as_list[])
public subroutine wf_get_new_item ()
public function integer wf_init_container ()
public function boolean wf_is_in_list (integer ai_item, ref integer ai_list[])
public subroutine wf_question_announcer ()
public subroutine wf_lesson_filter (string as_filter_expresson)
public subroutine wf_random_list (ref string as_list)
public subroutine wf_sort_list (ref integer ai_list[])
public subroutine wf_random_list (ref integer ai_list[])
public subroutine wf_insert_progress_data (long al_lesson_id)
public subroutine wf_mousemove (integer xpos, integer ypos)
public function integer wf_init_lesson ()
public subroutine wf_play_video (string as_video_file)
public subroutine wf_update_statistic ()
public subroutine wf_response ()
public subroutine wf_response (boolean ab_correct)
public subroutine wf_set_lesson_mode (boolean ab_lesson_on)
public subroutine wf_check_batch ()
public subroutine wf_dragdrop (dragobject source)
public function boolean wf_yield_wait (long al_max_wait_time)
end prototypes

event ue_get_new_item;//MessageBox("ue_get_new_item", "a")
if isvalid(iw_dummy) then
	close(iw_dummy)
end if
wf_get_new_item()
return 1
end event

public subroutine wf_random_list ();integer li_i, li_list[], li_index

for li_i = 1 to ii_degree
	do
		li_index = rand(ii_degree)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i]= li_index
	ii_random_list[li_i] = li_index
next



end subroutine

public subroutine wf_random_list (ref integer ai_list[], integer ai_count);integer li_i, li_list[], li_index

for li_i = 1 to ai_count
	do
		li_index = rand(ai_count)
	loop while wf_is_in_list(li_index, li_list)
	ai_list[li_i] = li_index
next


end subroutine

public subroutine wf_random_list (ref string as_list[]);integer li_i, li_list[], li_index, li_count
string ls_list_tmp[]
li_count = upperbound(as_list)
for li_i = 1 to li_count
	do
		li_index = rand(li_count)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i]= li_index
	ls_list_tmp[li_i] = as_list[li_index]
next
for li_i = 1 to li_count
	as_list[li_i] = ls_list_tmp[li_i]
next

end subroutine

public subroutine wf_get_new_item ();
end subroutine

public function integer wf_init_container ();
return 1
end function

public function boolean wf_is_in_list (integer ai_item, ref integer ai_list[]);integer i
for i = 1 to upperbound(ai_list)
	if ai_item = ai_list[i] then

		return true
	end if
next
return false
end function

public subroutine wf_question_announcer ();
end subroutine

public subroutine wf_lesson_filter (string as_filter_expresson);datawindowchild ldwc_lesson
if dw_2.GetChild('lesson', ldwc_lesson) = 1 then
	ldwc_lesson.SetFilter(as_filter_expresson)
	ldwc_lesson.Filter()
else
	MessageBox("Error", "Lesson Selection Fails")
end if
end subroutine

public subroutine wf_random_list (ref string as_list);integer li_i, li_list[], li_index, li_count
string ls_list_tmp[]
string ls_tmp = ""
li_count = len(as_list)
for li_i = 1 to li_count
	ls_list_tmp[li_i] = mid(as_list, li_i, 1)
next
wf_random_list(ls_list_tmp)
for li_i = 1 to li_count
	ls_tmp = ls_tmp + ls_list_tmp[li_i]
next
as_list = ls_tmp

end subroutine

public subroutine wf_sort_list (ref integer ai_list[]);integer li_tmp_list[], li_tmp_list2[], li_i, li_j, li_k = 1, li_min = 1000, li_tmp_i, li_max = -1
boolean lb_found

for li_i = 1 to upperbound(ai_list)
	if ai_list[li_i] > li_max then li_max = ai_list[li_i] 
next
for li_i = 1 to li_max 
	li_tmp_list[li_i] = -1
next
for li_i = 1 to upperbound(ai_list)
	if ai_list[li_i] <= upperbound(li_tmp_list) then
		li_tmp_list[ai_list[li_i]] = ai_list[li_i]
	end if
next
for li_i = 1 to upperbound(li_tmp_list)
	if li_tmp_list[li_i] <> -1 then
		li_tmp_list2[upperbound(li_tmp_list2) + 1] = li_tmp_list[li_i]
	end if
next
ai_list = li_tmp_list2

end subroutine

public subroutine wf_random_list (ref integer ai_list[]);integer li_i, li_list[], li_index, li_count
integer li_list_tmp[]
li_count = upperbound(ai_list)
for li_i = 1 to li_count
	do
		li_index = rand(li_count)
	loop while wf_is_in_list(li_index, li_list)
	li_list[li_i]= li_index
	li_list_tmp[li_i] = ai_list[li_index]
next
for li_i = 1 to li_count
	ai_list[li_i] = li_list_tmp[li_i]
next

end subroutine

public subroutine wf_insert_progress_data (long al_lesson_id);long ll_count, ll_progress_data_id, ll_row, ll_lesson_content_id
DateTime ldt_present
ldt_present = DateTime(today(), now())
select count(progress_data_id) into :ll_count
from progress_data
where lesson_id = :al_lesson_id;
if ll_count = 0 then
	insert into progress_data(lesson_content_id, progress_data_id, lesson_id, begin_date, end_date)
	select lesson_content_id, 1, lesson_id, :ldt_present, :ldt_present
	from lesson_content
	where lesson_id = :al_lesson_id;
	commit;
end if

end subroutine

public subroutine wf_mousemove (integer xpos, integer ypos);if ib_drag and (abs(xpos - ii_x0) > 15 or abs(ypos - ii_y0) > 15) then 
	p_1.x = xpos
	p_1.y = ypos
	ii_x0 = xpos
	ii_y0 = ypos
end if
end subroutine

public function integer wf_init_lesson ();integer il_row
string ls_tmp, ls_resource_path, ls_data_col_ind, ls_pathprefix
long ll_bestindex
ib_prompt = false					
ib_error_correction = false
is_picture_ind = ids_lesson.GetItemString(1, 'lesson_picture_ind')
is_text_ind = ids_lesson.GetItemString(1, 'lesson_text_ind')
if not isnull(ids_lesson.GetItemString(1, 'lesson_prompt_ind')) then 
	ii_prompt_ind = integer(ids_lesson.GetItemString(1, 'lesson_prompt_ind'))
	choose case ii_prompt_ind
		case 1
			ib_prompt = true
		case 2
			ib_error_correction = true
	end choose
else
	ii_prompt_ind = 0
end if
if not isnull(ids_lesson.GetItemNumber(1, 'lesson_degree')) then
	ii_degree = integer(ids_lesson.GetItemNumber(1, 'lesson_degree'))
else
	ii_degree = 2
end if
if not isnull(ids_lesson.GetItemString(1, 'lesson_pair_ind')) then
	ii_trial_target = integer(ids_lesson.GetItemString(1, 'lesson_pair_ind'))
end if
if ii_trial_target > ii_degree then ii_trial_target = ii_degree
ii_total_items = ids_lesson.RowCount()
for il_row = 1 to ii_total_items
	il_total_tries[il_row] = 0
	il_total_correct_answers[il_row] = 0
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if (not isnull(ls_tmp)) and isnumber(ls_tmp) then
		ii_number_list[il_row] = integer(ls_tmp)
	else
		ii_number_list[il_row] = 0
	end if
	is_picture_list[il_row] = ""
	is_text_list[il_row] = ""	
	is_mask_list[il_row] = ""	
	is_distract_list[il_row] = ""	
	ls_resource_path = ids_lesson.GetItemString(il_row, 'subject_description') + '\' + &
								ids_lesson.GetItemString(il_row, 'chapter_description') + '\' 
	is_wave_list[il_row] = gn_appman.is_wavefile_path + ls_resource_path + ids_lesson.GetItemString(il_row, 'content_wave_file')		
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_bitmap_file')
	if not isnull(ls_tmp) /* and is_picture_ind = '1' */ then 
			is_picture_list[il_row] = gn_appman.is_bitmap_path + ls_resource_path + ls_tmp
	end if
	if not isnull(ids_lesson.GetItemString(il_row, 'content_details')) then 
		is_text_list[il_row] = ids_lesson.GetItemString(il_row, 'content_details')
	end if
	if not isnull(ids_lesson.GetItemString(il_row, 'lesson_content_mask')) then 
		is_mask_list[il_row] = ids_lesson.GetItemString(il_row, 'lesson_content_mask')
	end if
	if not isnull(ids_lesson.GetItemString(il_row, 'lesson_content_distraction')) then 
		is_distract_list[il_row] = ids_lesson.GetItemString(il_row, 'lesson_content_distraction')
	end if
	il_lesson_content_pair_ind[il_row] = ids_lesson.GetItemNumber(il_row, 'content_pair_ind')
next
ls_data_col_ind = ids_lesson.GetItemString(1, 'data_collection_ind')
if not isnull(ls_data_col_ind) then
	if ls_data_col_ind = '1' then
		ib_data_collection = true
	end if
end if
if not isnull(ids_lesson.GetItemNumber(1, 'lesson_instruction_id2')) then
	il_speech_recog_level = integer(ids_lesson.GetItemNumber(1, 'lesson_instruction_id2'))
else
	il_speech_recog_level = 0
end if
ls_resource_path = gn_appman.is_app_path + "Static Table\wave\"
is_response_to_right = ls_resource_path + "Response To Right\" + ids_lesson.GetItemString(1, 'response_to_right_wave_file')
is_response_to_wrong = ls_resource_path + "Response To Wrong\" + ids_lesson.GetItemString(1, 'response_to_wrong_wave_file')
is_instruction = ls_resource_path + "Instruction\" + ids_lesson.GetItemString(1, 'instruction_wave_file')
is_instruction2 = ls_resource_path + "Instruction\" + ids_lesson.GetItemString(1, 'instruction2_wave_file')
is_prompt_instruction = ls_resource_path + "Prompt\" + ids_lesson.GetItemString(1, 'prompt_prompt_inst')	
is_preposition_1 = ls_resource_path + "Preposition\" + ids_lesson.GetItemString(1, 'preposition_1')
is_preposition_2 =ls_resource_path +  "Preposition\" + ids_lesson.GetItemString(1, 'preposition_2')
il_lesson_id = ids_lesson.GetItemNumber(1, 'lesson_id') 
ii_degree = integer(ids_lesson.GetItemNumber(1, 'lesson_degree'))
ii_tries = ids_lesson.GetItemNumber(1, 'lesson_tries')
ii_type = ids_lesson.GetItemNumber(1, 'lesson_method_id')
if ii_degree > ii_total_items then
	ii_degree = ii_total_items
end if
if ii_degree > 4 then
	ii_degree = 4
end if

// for speech lesson
select student.gender, student.age into :is_gender, :il_age &
from lesson, student where lesson.student_id = student.student_id and lesson.lesson_id = :il_lesson_id;
if isnull(is_gender) then is_gender = ""
if isnull(il_age) then il_age = 0

if ii_trial_target > ii_degree then ii_trial_target = ii_degree
for il_row = 1 to ii_total_items
	il_total_tries[il_row] = 0
	il_total_correct_answers[il_row] = 0
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if (not isnull(ls_tmp)) and isnumber(ls_tmp) then
		ii_number_list[il_row] = integer(ls_tmp)
	else
		ii_number_list[il_row] = 0
	end if
	is_picture_list[il_row] = ""
	is_text_list[il_row] = ""	
	ls_resource_path = ids_lesson.GetItemString(il_row, 'subject_description') + '\' + &
								ids_lesson.GetItemString(il_row, 'chapter_description') + '\' 
	il_content_id[il_row] = ids_lesson.GetItemNumber(il_row, 'lesson_content_content_id')
	if lower(ids_lesson.GetItemString(il_row, 'subject_presentation_type')) = "speech" then
		ls_pathprefix = gn_appman.is_wavefile_path + ls_resource_path +  + string(il_content_id[il_row], "0000000000")		
		ll_bestindex = extGetBestIndex(ls_pathprefix, il_age, is_gender)	
		if ll_bestindex = -1 then
			MessageBox("Error", "Speech trained data file: " + ls_pathprefix + string(il_age, "00") + is_gender + " not found.");
			return 0
		end if
		is_wave_list[il_row] = 	ls_pathprefix + string(il_age, "00") + is_gender + string(ll_bestindex, "00") + ".wav"
	else
		is_wave_list[il_row] = gn_appman.is_wavefile_path + ls_resource_path + ids_lesson.GetItemString(il_row, 'content_wave_file')		
	end if
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_bitmap_file')
	if not isnull(ls_tmp) and is_picture_ind = '1' then 
			is_picture_list[il_row] = gn_appman.is_bitmap_path + ls_resource_path + ls_tmp
	end if
	ls_tmp = ids_lesson.GetItemString(il_row, 'content_details')
	if not isnull(ls_tmp) then 
		is_text_list[il_row] = ls_tmp
	end if
	il_lesson_content_pair_ind[il_row] = ids_lesson.GetItemNumber(il_row, 'content_pair_ind')
next
ls_data_col_ind = ids_lesson.GetItemString(1, 'data_collection_ind')
if not isnull(ls_data_col_ind) then
	if ls_data_col_ind = '1' then
		ib_data_collection = true
	end if
end if
ii_current_question_id = 0
ii_current_try = 0
ii_current_list_offset = 1
ulong lu_handle, lu_message
string ls_sound_tmp_file
if pos(classname(), "w_lesson_speech") > 0 then
	lu_handle = handle(this)
	lu_message = 1024
	ls_sound_tmp_file = gn_appman.is_wavefile_path + "sound_tmptmp.wav"
	InitSoundObject(lu_handle, lu_message, ls_sound_tmp_file)
end if
return 1
end function

public subroutine wf_play_video (string as_video_file);//gn_appman
//OpenWithParm(gn_appman.iw_play_avi, as_video_file, gn_appman.iw_frame)
OpenWithParm(w_play_avi, as_video_file, gn_appman.iw_frame)
if isvalid(gnvo_is.iw_demo_selection) then
	if gnvo_is.iw_demo_selection.classname() = "w_demo_trial_selection" then
		Open (w_signup)
	end if		
end if
	
end subroutine

public subroutine wf_update_statistic ();integer li_row, li_row_count, ll_count, li_row_count_progress_data, ll_progress_data_id, li_new_prompt_ind
long ll_lesson_content_id, ll_lesson_lesson_content_id, ll_min_threshold_counts, ll_method_id, ll_method_id_2 = 50
long ll_total_trials, ll_total_correct_answers, ll_student_id, ll_lesson_id, ll_method_id_inserting
long ll_fold, ll_remain, ll_start, ll_end, ll_i, ll_j
long ll_mastered_data_id_2 = 0
long ll_total_items = 0, ll_total_items_passed = 0
date ldt_date_picture, ldt_date_text, ldt_mastered_date
string ls_mastered_picture, ls_mastered_text, ls_prompt_ind
decimal ldec_threshold, ldec_mastered_ratio
datetime ldt_present
boolean lb_update_statistic = false, lb_generate_report = false
string ls_details, ls_notes
boolean lb_inserting
datastore lds_progress_report
lds_progress_report = create datastore
lds_progress_report.dataobject = 'd_progress_report_list'
ldt_mastered_date = today()
ll_student_id = dw_1.GetItemNumber(1, "student")
ll_lesson_id = dw_2.GetItemNumber(1, "lesson")
ldt_present = DateTime(today(), now())
li_row_count = ids_lesson.RowCount()
ll_min_threshold_counts = ids_lesson.GetItemNumber(1, "lesson_threshold_min_count")
if isnull(ll_min_threshold_counts) then ll_min_threshold_counts = 0
ldec_threshold = ids_lesson.GetItemDecimal(1, "lesson_threshold")
if isnull(ldec_threshold) then ldec_threshold = 0
ll_method_id = ii_type
if isnull(ldec_threshold) then ldec_threshold = 0.0
if isnull(ll_min_threshold_counts) then ll_min_threshold_counts = 0
for li_row = 1 to li_row_count
	if il_total_tries[li_row] > 0 then
		ids_lesson.SetItem(li_row, 'lesson_content_total_tries', ids_lesson.object.lesson_content_total_tries[li_row] + il_total_tries[li_row])
		ids_lesson.SetItem(li_row, 'lesson_content_total_correct_answers', ids_lesson.object.lesson_content_total_correct_answers[li_row] + il_total_correct_answers[li_row])
		ids_lesson.SetItem(li_row, 'lesson_content_lastupdatedon', ldt_present)
		lb_update_statistic = true
	end if
next
if ids_lesson.ModifiedCount() > 0 then
	if ids_lesson.update() = -1 then
		f_log_error("Update Lesson Count", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot Update Lesson Counts!")
	else
		commit;
	end if
end if
ls_prompt_ind = string(ii_prompt_ind)
if ib_data_collection and lb_update_statistic then
	select count(progress_data_id) into :ll_count
	from progress_data
	where lesson_id = :il_lesson_id;
	if ll_count = 0 then
		if gn_appman.ii_site_license_num < 10 then
			il_progress_data_id = 1	
		else 
			il_progress_data_id = 2
		end if		
		insert into progress_data(lesson_content_id, progress_data_id, lesson_id, begin_date, end_date, prompt_ind)
		select lesson_content_id, :il_progress_data_id, lesson_id, :ldt_present, :ldt_present, :ls_prompt_ind
		from lesson_content
		where lesson_id = :il_lesson_id;
		commit;
	else
		select max(progress_data_id) into :il_progress_data_id
		from progress_data
		where lesson_id = :il_lesson_id;
	end if
	for li_row = 1 to li_row_count
		ll_lesson_content_id = ids_lesson.GetItemNumber(li_row, 'lesson_content_id')
		update progress_data
		set end_date = :ldt_present, total_tries = isnull(total_tries, 0) + :il_total_tries[li_row], &
				total_correct_answers = isnull(total_correct_answers, 0) + :il_total_correct_answers[li_row]
		where lesson_content_id = :ll_lesson_content_id and progress_data_id = :il_progress_data_id;
	next
	if SQLCA.sqlcode <> 0 then
		f_log_error("Update Progress Report", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot Update Progress Report!")
		rollback;
	else
		commit;	
	end if
end if
lds_progress_report.SetTransObject(SQLCA)
li_row_count_progress_data = lds_progress_report.Retrieve(il_lesson_id, il_progress_data_id)
// update mastered data
if ll_min_threshold_counts > 0 and ldec_threshold > 0.0 then // automatic push data into mastered vocabulary
	for li_row = 1 to li_row_count
		lb_inserting = false
		ls_notes = "The trial item again:"
//		MessageBox("li_row", string(li_row))

//		MessageBox("il_total_tries[" + string(li_row) + "]", string(il_total_tries[li_row]))
		if il_total_tries[li_row] > 0 then
			ll_total_items = ll_total_items + 1			
			ll_lesson_content_id = ids_lesson.GetItemNumber(li_row, 'lesson_content_content_id')
			ll_lesson_lesson_content_id = ids_lesson.GetItemNumber(li_row, 'lesson_content_lesson_content_id')
			if lds_progress_report.RowCount() < 1 then
				ll_total_trials = ids_lesson.GetItemNumber(li_row, 'lesson_content_total_tries')
				ll_total_correct_answers = ids_lesson.GetItemNumber(li_row, 'lesson_content_total_correct_answers')
			else
				ll_total_trials = lds_progress_report.GetItemNumber(li_row, 'total_tries')
				ll_total_correct_answers = lds_progress_report.GetItemNumber(li_row, 'total_correct_answers')
			end if
			if ll_total_trials >= ll_min_threshold_counts then
				lb_generate_report = true
			end if
			ldec_mastered_ratio = dec(ll_total_correct_answers)/dec(ll_total_trials)
			if ldec_mastered_ratio >= ldec_threshold and ll_total_trials >= ll_min_threshold_counts then
				ll_total_items_passed = ll_total_items_passed + 1
				if ii_prompt_ind > 0 then continue
				if ii_trial_target > 0 then // pair up
					ll_fold = li_row/ii_degree
					for ll_i = ll_fold*ii_degree + 1 to (ll_fold + 1) *ii_degree
						if ll_i <> li_row then
							ls_notes = ls_notes + ' ' + is_text_list[ll_i]
							if ll_method_id = 23 or ll_method_id = 24 then // addition or substraction
								ll_mastered_data_id_2 = ids_lesson.GetItemNumber(ll_i, 'lesson_content_content_id')
							end if
						end if
					next
				else
					for ll_i = li_row + 1 to li_row + ii_degree - 1
						ll_j = mod(ll_i,li_row_count)
						if ll_j = 0 then ll_j = li_row_count
						ls_notes = ls_notes + ' ' + is_text_list[ll_j]
						if ll_method_id = 23 or ll_method_id = 24 then // addition or substraction
							ll_mastered_data_id_2 = ids_lesson.GetItemNumber(ll_j, 'lesson_content_content_id')
						end if
					next						
				end if	
//				MessageBox("ll_method_id", string(ll_method_id))
				if ll_method_id <> 2 then
					select count(*) into :ll_count from mastered_data 
					where student_id = :ll_student_id and 
							mastered_data_id = :ll_lesson_content_id and
							mastered_data_id_2 = :ll_mastered_data_id_2 and						
							data_source = :ll_method_id;
				else
					if (is_picture_ind = '1' and is_text_ind = '0') then
						select count(*) into :ll_count from mastered_data 
						where student_id = :ll_student_id and 
								mastered_data_id = :ll_lesson_content_id and
								mastered_data_id_2 = :ll_mastered_data_id_2 and						
								data_source = :ll_method_id;
					elseif (is_picture_ind = '0' and is_text_ind = '1') then 
						select count(*) into :ll_count from mastered_data 
						where student_id = :ll_student_id and 
								mastered_data_id = :ll_lesson_content_id and
								mastered_data_id_2 = :ll_mastered_data_id_2 and						
								data_source = :ll_method_id_2;			
					else
						ll_count = 1
					end if
//MessageBox("li_row: " + string(li_row) + " mastered_data_id: " + string(ll_lesson_content_id), &
//"mastered_data_id_2: " + string(ll_mastered_data_id_2) + " data_source: " + string(ll_method_id_2))
				end if
				if ll_count = 0 then // 
					choose case ll_method_id
						case 2 // Object Identification
							if (is_picture_ind = '1' and is_text_ind = '0') or (is_picture_ind = '0' and is_text_ind = '1') then 
								lb_inserting = true
								if is_picture_ind = '0' then
									ll_method_id_inserting = 25 // word identification
								else
									ll_method_id_inserting = ll_method_id
								end if
							end if
						// 3,4,5,6,7,8,9,10,11,12,13,17,18,19 Comparison
						// 14cNumber Matching counting
						//23, 24  Addition, Subtraction
						//16  Multi-word command
						//21, 22  Unscramble Words, Sentences
						case 3,4,5,6,7,8,9,10,11,12,13,17,18,19,23, 24
							lb_inserting = true
							ll_method_id_inserting = ll_method_id
						case 14, 16, 21, 22, 25	// 
							setnull(ls_notes)
							ll_method_id_inserting = ll_method_id
							lb_inserting = true
					end choose					
					if lb_inserting = true then 
						insert into mastered_data ( 
							student_id, mastered_data_id, mastered_data_id_2, data_source, lesson_content_id,
							mastered_date, notes) 
						values ( 
							:ll_student_id, :ll_lesson_content_id, :ll_mastered_data_id_2, :ll_method_id_inserting, :ll_lesson_lesson_content_id,
							:ldt_mastered_date, :ls_notes
						);
					end if					
				end if
			end if
		end if
	next
end if
// update prmopt indicator
li_new_prompt_ind = ii_prompt_ind
ls_prompt_ind =  string(li_new_prompt_ind)
//MessageBox("ll_total_items_passed", string(ll_total_items_passed))
//MessageBox("ll_total_items", string(ll_total_items))
//MessageBox("ii_prompt_ind", string(ii_prompt_ind))
if ll_total_items_passed > 0 and ll_total_items = ll_total_items_passed and ii_prompt_ind > 0 then // all pass threshold and prompt IND is not NONE
	choose case ll_method_id
		case 2, 3,4,5,6,7,8,9,10,11,12,13,17,18,19,16,25
			li_new_prompt_ind = 0			
		case 14
			if ii_prompt_ind = 3 then li_new_prompt_ind = 2
			if ii_prompt_ind = 2 then li_new_prompt_ind = 0		
		case 21, 22, 23, 24
			li_new_prompt_ind = ii_prompt_ind - 1			
	end choose
	if li_new_prompt_ind < ii_prompt_ind then
		ls_prompt_ind = string(li_new_prompt_ind)
		update lesson
		set prompt_ind = :ls_prompt_ind
		where lesson_id = :il_lesson_id;
	end if
end if
if ll_total_items = ll_total_items_passed and ii_prompt_ind = 0 then // all item passed, no need to generate progress report
	lb_generate_report = false
end if
// general progress report
if lb_generate_report = true then
	select count(progress_data_id) into :ll_count
	from progress_data
	where lesson_id = :il_lesson_id;
	if ll_count = 0 then
		if gn_appman.ii_site_license_num < 10 then
			il_progress_data_id = 1	
		else 
			il_progress_data_id = 2
		end if
	else
		select max(progress_data_id) into :il_progress_data_id
		from progress_data
		where lesson_id = :il_lesson_id;
		il_progress_data_id = il_progress_data_id + 1		
		if gn_appman.ii_site_license_num < 10 then
			if mod(il_progress_data_id, 2) = 0 then // it is event, change to ODD
				il_progress_data_id = il_progress_data_id + 1
			end if
		else 
			if mod(il_progress_data_id, 2) = 1 then // it is odd, change to event
				il_progress_data_id = il_progress_data_id + 1
			end if
		end if		
	end if	
	insert into progress_data(lesson_content_id, progress_data_id, lesson_id, begin_date, end_date, prompt_ind)
	select lesson_content_id, :il_progress_data_id, lesson_id, :ldt_present, :ldt_present, :ls_prompt_ind
	from lesson_content
	where lesson_id = :il_lesson_id;
end if

if SQLCA.sqlcode <> 0 then
	f_log_error("Update Mastered Data", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
	MessageBox("Error", "Cannot Update Mastered Data!")
	rollback;
else
	commit;	
end if
for li_row = 1 to li_row_count
	il_total_correct_answers[li_row] = 0
	il_total_tries[li_row] = 0
next
destroy lds_progress_report
end subroutine

public subroutine wf_response ();
end subroutine

public subroutine wf_response (boolean ab_correct);
end subroutine

public subroutine wf_set_lesson_mode (boolean ab_lesson_on);w_label_main_mdi lw_mdi
lw_mdi = ParentWindow()

if ab_lesson_on then
	cb_close.visible = false
	cb_start.visible = false
	dw_1.visible = false
	dw_2.visible = false
	lw_mdi.controlmenu = false
else	
//	if gnvo_is.ib_demo_is_going and gnvo_is.iw_demo_selection.classname() = "w_demo_trial_selection" then
//		post close(this)
//	end if		
	cb_close.visible = true
	cb_start.visible = true
	dw_1.visible = true
	dw_2.visible = true
	lw_mdi.controlmenu = true
end if
end subroutine

public subroutine wf_check_batch ();if ib_batch_run then
	istr_lp.current_try_num = istr_lp.current_try_num + 1
	if istr_lp.current_try_num > istr_lp.retry_num then
		cb_close.post event clicked()
	else
		cb_start.post event clicked()
	end if
end if
end subroutine

public subroutine wf_dragdrop (dragobject source);w_lesson lw_tmp
integer li_count
integer li_y
integer li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
boolean lb_found = false, lb_misspelled = false
string ls_dragobject_name, ls_dragicon
uo_count_alpha luo_count_alpha
uo_count_number luo_count_number
w_container_unscramble_word lw_container_unscramble_word
w_container_number_match lw_container_number_match
if not isvalid(source) then return
if source.classname() = 'uo_count_alpha' then
	for li_i = 1 to upperbound(iw_dest)
		lw_container_unscramble_word = iw_dest[li_i]
		if lw_container_unscramble_word.st_1.visible = false then
//			MessageBox("lw_container_unscramble_word.st_1.text", lw_container_unscramble_word.st_1.text)
			lb_found = true
			exit
		end if
		if lw_container_unscramble_word.st_1.text <> lw_container_unscramble_word.is_char then
			lb_misspelled = true
		end if
	next
	luo_count_alpha = source
	lx = source.x 
	ly = source.y 
//	MessageBox("luo_count_alpha.st_number.text", luo_count_alpha.st_number.text)
	if is_text_ind = "4" then // dictation without error prevention
		if not lb_found and (not lb_misspelled or asc(luo_count_alpha.st_number.text) <> 8) then return
		if asc(luo_count_alpha.st_number.text) = 8 then // backspace
			if li_i > 1 then
				lw_container_unscramble_word = iw_dest[li_i - 1]
				lw_container_unscramble_word.st_1.visible = false
				lw_container_unscramble_word.st_1.text = lw_container_unscramble_word.is_char
			end if
			return
		end if
		// if the entered char is a space or at the end of the phrase or sentence  
		// and the word is misspelled, stop from entering
		if lw_container_unscramble_word.is_char = ' ' and lb_misspelled then return
		if lb_misspelled then 
			lw_container_unscramble_word.st_1.backcolor = 65535
		else
			lw_container_unscramble_word.st_1.backcolor = 16711680
		end if
		lw_container_unscramble_word.st_1.text = luo_count_alpha.st_number.text
		lw_container_unscramble_word.visible = true				
		lw_container_unscramble_word.st_1.visible = true
		lw_container_unscramble_word.BringToTop = true								
		lw_container_unscramble_word.st_1.BringToTop = true	
		luo_count_alpha.enabled = false
		luo_count_alpha.visible = false
		if luo_count_alpha.st_number.text = lw_container_unscramble_word.is_char then
			if dynamic wf_check_alpha() then
				wf_response(true)
				timer(0, this)
			else
				dynamic wf_next_dest()
			end if
		else			
			lw_container_unscramble_word.st_1.backcolor = 65535
			ib_misspelled = true
		end if		
	else // others
		if not lb_found then return	
//		MessageBox("wf_dragdrop", "A")
		if luo_count_alpha.iw_parent <> lw_container_unscramble_word then // from other bucket
//			MessageBox("wf_dragdrop", "B")
			if lw_container_unscramble_word.ib_target then
//				MessageBox("wf_dragdrop", "C")
				if luo_count_alpha.st_number.text = lw_container_unscramble_word.st_1.text then
//					MessageBox("wf_dragdrop", "D")
					lw_container_unscramble_word.visible = true				
					lw_container_unscramble_word.st_1.visible = true
					lw_container_unscramble_word.BringToTop = true								
					lw_container_unscramble_word.st_1.BringToTop = true	
					luo_count_alpha.enabled = false
					luo_count_alpha.visible = false
					if dynamic wf_check_alpha() then
						wf_response(true)
						timer(0, this)
					else
						dynamic wf_next_dest()
					end if
				else
					ib_misspelled = true
				end if

			end if
		end if
	end if
elseif source.classname() = 'uo_count_number' then
	if this.classname() = "w_lesson_numbermatch_count" then
		lw_container_number_match = iw_source[2]
	else
		lw_container_number_match = iw_source[3]
	end if
	luo_count_number = source
	lx = source.x 
	ly = source.y 
	if luo_count_number.iw_parent <> lw_container_number_match then // from other bucket
		if lw_container_number_match.ib_target then
			li_count = long(luo_count_number.st_number.text)
			if this.dynamic wf_check_number(li_count) then
				lw_container_number_match.st_1.text = string(li_count)
				lw_container_number_match.st_1.visible = true
				wf_response(true)
			else
				wf_response(false)
			end if
		end if
	end if
end if


end subroutine

public function boolean wf_yield_wait (long al_max_wait_time);long ll_counter = 0
do while ll_counter < al_max_wait_time
	Sleep(100)
	ll_counter = ll_counter + 100
	if not ib_waiting then
		return true
	end if
	Yield()
loop

return false

end function

on w_lesson.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_start=create cb_start
this.dw_1=create dw_1
this.dw_2=create dw_2
this.p_1=create p_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_start
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_1
end on

on w_lesson.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_start)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.p_1)
destroy(this.st_1)
end on

event open;long ll_student_id, ll_count
string ls_expression
istr_lp = Message.PowerobjectParm
Super::EVENT open()
x = 1
y = 1
if not gnvo_is.ib_demo_is_going and gn_appman.ib_trial_version then
	OpenWithParm(w_trial_version_message, "Lesson")
end if
dw_1.InsertRow(0)
dw_2.InsertRow(0)
datawindowchild ldwc_tmp
//dwobject dwo
dw_1.GetChild('student', ldwc_tmp)
ldwc_tmp.SetTransObject(SQLCA)
ldwc_tmp.Retrieve()

if istr_lp.str_name = "BATCH" then
	ib_batch_run = true
end if

if ib_batch_run then
	dw_1.visible = false
	dw_2.visible = false
	cb_start.visible = false
	cb_close.visible = false
	select student_id into :ll_student_id
	from lesson
	where lesson_id = :istr_lp.lesson_id;
	dw_1.SetItem(1, "student", ll_student_id)
	dw_2.SetItem(1, "lesson", istr_lp.lesson_id)
elseif not gnvo_is.ib_demo_is_going then
	select count(student_id) into :ll_count from student;
	if ll_count = 1 then
		select min(student_id) into :ll_student_id from student;
		dw_1.SetItem(1, "student", ll_student_id)		
		dw_1.SetText(string(ll_student_id))
		dw_1.AcceptText()
		choose case classname()
			case "w_lesson_addition"
				ls_expression = 'method_id = 23'			
			case "w_lesson_comp_object"
				ls_expression = 'method_id >= 17 and method_id <= 19'			
			case "w_lesson_comp_scale"
				ls_expression = 'method_id > 2 and method_id < 14'			
			case "w_lesson_discrete_trial"
				ls_expression = 'method_id = 2'			
			case "w_lesson_dragdrop_count"
				ls_expression = 'method_id = 15'			
			case "w_lesson_mw_cmmnd"
				ls_expression = 'method_id = 16'			
			case "w_lesson_numbermatch_count"
				ls_expression = 'method_id = 14'			
			case "w_lesson_subtraction"
				ls_expression = 'method_id = 24'			
			case "w_lesson_subtraction"
				ls_expression = 'method_id = 23'			
			case "w_lesson_unscramble_sentence"
				ls_expression = 'method_id = 22'			
			case "w_lesson_unscramble_word"
				ls_expression = 'method_id = 21'			
			case "w_lesson_matching"
				ls_expression = 'method_id = 25'			
		end choose
		wf_lesson_filter(ls_expression)
		dw_2.GetChild('lesson', ldwc_tmp)
		ldwc_tmp.SetTransObject(SQLCA)
		ldwc_tmp.Retrieve(ll_student_id)
	end if
end if


ids_lesson = create datastore
ids_lesson.dataobject = 'd_lesson'
ids_lesson.SetTransObject(SQLCA)
//MessageBox("stop", "stop")
if ib_batch_run then
	ids_lesson.Retrieve(istr_lp.lesson_id)
	cb_start.post event clicked()
end if

p_1.visible = false
st_1.visible = false
// disable CTRL+ALT+DEL hot key
//disable_ctrl_alt_del()
end event

event key;call super::key;integer li_row
long ll_count
string ls_comment_type, ls_win_title
w_container_discrete_trial lw_tmp
if KeyDown(KeyControl!) and KeyDown(KeyC!) then
	if MessageBox('Warning', 'Do you want to quit the lesson?', Question!, YesNo!, 2) = 1 then
//		enable_ctrl_alt_del()
		wf_set_lesson_mode(false)		
		choose case classname()
			case "w_lesson_matching", "w_lesson_discrete_trial", "w_lesson_comp_object"				
				for li_row = 1 to ii_degree
					lw_tmp = iw_source[li_row]	
					if not lw_tmp.ib_stopped then
						lw_tmp.ib_stopped = true
						lw_tmp.ib_to_stop_movie = true
						lw_tmp.ole_1.object.Stop()
					end if
				next 		
		end choose				
	end if
end if

if KeyDown(KeyControl!) and KeyDown(KeyZ!) then
	if il_lesson_id < 0 then return
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

event close;call super::close;//window lw_window
//w_label_main_mdi lw_mdi
//long ll_handle
//lw_window = this
//lw_mdi = this.ParentWindow()
//
//lw_mdi.wf_remove_from_tab(lw_window)
if isvalid(gw_money_board) then
	gw_money_board.visible = false
end if

// enable CTRL+ALT+DEL hot key
//enable_ctrl_alt_del()
if isvalid(gnvo_is.iw_demo_selection) then
	if gnvo_is.iw_demo_selection.classname() = "w_demo_trial_selection" then
		gnvo_is.iw_demo_selection.BringToTop = true
		gnvo_is.ib_demo_is_going = false
	end if
end if
if ib_batch_run then
	post post(handle(istr_lp.handle), 1024, 0, 0)
end if

end event

event dragwithin;call super::dragwithin;long li_x, li_y
str_mousepos i_mousepos
GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_x = li_x - WorkSpaceX()
li_y = li_y - WorkSpaceY()
wf_mousemove(li_x, li_y)
end event

event timer;call super::timer;string ls_wave_file
string ls_1st_letter, ls_word, ls_dict_sound_file
choose case classname()
	case "w_lesson_unscramble_word", "w_lesson_unscramble_sentence", "w_lesson_matching", &
			"w_lesson_discrete_trial", "w_lesson_comp_object"
		if ii_current_state = ici_answer_expecting_state then
			ls_word = is_text_list[ii_current_question_id]
			ls_1st_letter = upper(left(ls_word, 1))
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
			elseif pos(ls_wave_file, "DICTIONARY") > 0 then
				ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
				if FileExists(ls_dict_sound_file) then
					sndPlaySoundA(ls_dict_sound_file, 1)
				else
					MessageBox("Error", "Sound file - " + ls_dict_sound_file + " does not exist!")
				end if
			end if			
		elseif ii_current_state = ici_lesson_end_state then
			keybd_event(13, 0, 0, 0)	
			timer(0, this)
		end if
	case "w_lesson_mw_cmmnd"
		if ii_current_state = ici_answer_expecting_state then
			if pos(is_instruction, ".wav") > 0 then
				inv_sound_play.play_st_sound(is_instruction)
			else
				wf_play_video(is_instruction)
			end if
		elseif ii_current_state = ici_lesson_end_state then
			keybd_event(13, 0, 0, 0)	
			timer(0, this)
		end if
	case "w_lesson_subtraction", "w_lesson_numbermatch_count", "w_lesson_dragdrop_count", &
			"w_lesson_comp_scale", "w_lesson_addition"
		if ii_current_state = ici_lesson_end_state then
			keybd_event(13, 0, 0, 0)	
			timer(0, this)
		end if
		
end choose
end event

type cb_close from commandbutton within w_lesson
event ue_paint pbm_paint
integer x = 3282
integer y = 12
integer width = 247
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event clicked;close(parent)
end event

type cb_start from commandbutton within w_lesson
event ue_paint pbm_paint
integer x = 2743
integer y = 12
integer width = 530
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Start Lesson"
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event clicked;Constant Long WindowPosFlags = 83 // = SWP_NOACTIVATE + SWP_SHOWWINDOW + SWP_NOMOVE + SWP_NOSIZE
Constant Long HWND_TOPMOST = -1
Constant Long HWND_NOTOPMOST = -2
long ll_student_id
integer li_width, li_height
ii_current_question_id = 0
wf_init_lesson()
if wf_init_container() = -1 then // Error
	return
end if
wf_set_lesson_mode(true)
if gb_money_board_on then
	ll_student_id = dw_1.GetItemNUmber(1, "student")
	gn_appman.of_set_parm("Lesson Stutent", ll_student_id)
	if Isvalid(gw_money_board) then
		gw_money_board.invo_reward_program.of_init()
		gw_money_board.visible = true
		gw_money_board.BringToTop = true
	else
		open(gw_money_board)
		gw_money_board.x = parent.x
		gw_money_board.y = parent.y
	end if
	li_width = UnitsToPixels(gw_money_board.width, XUnitsToPixels!)
	li_height = UnitsToPixels(gw_money_board.height, YUnitsToPixels!)
	SetWindowPos (Handle (gw_money_board), HWND_TOPMOST, 1, 1, li_width, li_height, WindowPosFlags)	
end if
wf_get_new_item()
end event

type dw_1 from datawindow within w_lesson
event key pbm_dwnkey
event ue_paint pbm_paint
integer x = 5
integer y = 12
integer width = 933
integer height = 96
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_student_l"
boolean border = false
boolean livescroll = true
end type

event key;parent.event key(key, keyflags)
end event

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event itemchanged;datawindowchild ldwc_tmp

if dwo.name = 'student' then
	dw_2.GetChild('lesson', ldwc_tmp)
	ldwc_tmp.SetTransObject(SQLCA)
	ldwc_tmp.Retrieve(long(data))
end if
end event

type dw_2 from datawindow within w_lesson
event key pbm_dwnkey
event keydown pbm_keydown
event ue_paint pbm_paint
integer x = 946
integer y = 12
integer width = 1376
integer height = 88
integer taborder = 40
boolean bringtotop = true
string title = "Lesson - Comparison"
string dataobject = "d_lesson_comparison"
boolean border = false
boolean livescroll = true
end type

event key;parent.event key(key, keyflags)
end event

event keydown;parent.event key(key, keyflags)
end event

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

type p_1 from picture within w_lesson
integer x = 23
integer y = 208
integer width = 325
integer height = 228
boolean bringtotop = true
boolean enabled = false
string picturename = ".\Chair.BMP"
boolean focusrectangle = false
end type

type st_1 from statictext within w_lesson
boolean visible = false
integer y = 256
integer width = 448
integer height = 248
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 65535
boolean enabled = false
string text = "88"
alignment alignment = center!
boolean focusrectangle = false
end type

