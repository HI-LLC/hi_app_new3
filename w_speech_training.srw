$PBExportHeader$w_speech_training.srw
forward
global type w_speech_training from w_response
end type
type cb_playback from u_commandbutton within w_speech_training
end type
type cb_save_train_group from u_commandbutton within w_speech_training
end type
type cb_delete_group from u_commandbutton within w_speech_training
end type
type cb_add_group from u_commandbutton within w_speech_training
end type
type dw_speech_train_group from u_datawindow within w_speech_training
end type
type sle_duration from singlelineedit within w_speech_training
end type
type st_1 from statictext within w_speech_training
end type
type st_duration from statictext within w_speech_training
end type
type st_amplitude from statictext within w_speech_training
end type
type cb_close from u_commandbutton within w_speech_training
end type
type cb_play from u_commandbutton within w_speech_training
end type
type cb_update from u_commandbutton within w_speech_training
end type
type cb_add from u_commandbutton within w_speech_training
end type
type dw_speech_data_stat from u_datawindow within w_speech_training
end type
type cb_record from u_commandbutton within w_speech_training
end type
type hpb_2 from hprogressbar within w_speech_training
end type
type hpb_3 from hprogressbar within w_speech_training
end type
end forward

global type w_speech_training from w_response
integer width = 2254
integer height = 2200
string title = "Speech Training Data"
event soundrec_data pbm_custom01
event soundplay_data pbm_custom02
cb_playback cb_playback
cb_save_train_group cb_save_train_group
cb_delete_group cb_delete_group
cb_add_group cb_add_group
dw_speech_train_group dw_speech_train_group
sle_duration sle_duration
st_1 st_1
st_duration st_duration
st_amplitude st_amplitude
cb_close cb_close
cb_play cb_play
cb_update cb_update
cb_add cb_add
dw_speech_data_stat dw_speech_data_stat
cb_record cb_record
hpb_2 hpb_2
hpb_3 hpb_3
end type
global w_speech_training w_speech_training

type prototypes
SUBROUTINE extMakeDataFile(string FnInput, string FnOutput) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extMakeDataFile@8"
FUNCTION long extAddTrainedData(string FileNamePrefix, string WaveFileName, long Age, string Gender) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extAddTrainedData@16"
FUNCTION long extUpdateTrainedData(string FileNamePrefix, string WaveFileName, long Index, long Age, string Gender) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extUpdateTrainedData@20"
FUNCTION long extSpeechRecognizing(string FileNamePrefix, string WaveFileName, long Age, string Gender, long Interval, long RecogLevel) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extSpeechRecognizing@20"
FUNCTION long extGetTrainDataStat(string FileNamePrefix, long Age, string Gender, ref long SetSize,ref double MaxOverlap[], ref double MinOverlap[], ref double MeanOverlap[]) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetTrainDataStat@28"
FUNCTION long extGetMeanFileData(string FileName, ref decimal Data) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetMeanFileData@8"
FUNCTION long extGetMeanSoundData(string FileName, long Size, ref decimal Data) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetMeanSoundData@8"
FUNCTION long extDumpTrainedData(string FileNamePrefix, long Age, ref decimal Data) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extDumpTrainedData@8"
FUNCTION double extGetWaveDuration(string FnInput) LIBRARY "VoiceMan.DLL" ALIAS FOR  "_extGetWaveDuration@4"
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
long il_full_length, il_current_word_duration=0, il_duration=0
long il_content_id, il_current_row = 0, il_stat_current_row = 0, il_group_row
string is_path, is_prefix, is_current_path, is_current_sound_file, is_sound_tmp_file
end variables

forward prototypes
public subroutine wf_refresh_stat_data (long al_row)
end prototypes

event soundrec_data;long ll_current_word_duration_tmp, ll_pause_tmp, ll_read_word_duration, li_i
long ll_total_vows=0, ll_total_cons=0, ll_word_vows=0, ll_word_cons=0, ll_total_spaces=0
boolean lb_word_read = false
string ls_current_word, ls_current_sentence
real lr_total, lr_fraction
//il_sound_sample_index = il_sound_sample_index + 1

//sle_duration.text = string(lparam)

if wparam >= 500 then 
	st_amplitude.width = il_full_length
else
	st_amplitude.width = long(dec(il_full_length)*dec(wparam)/500.00)
end if
il_current_word_duration = il_current_word_duration + lparam
st_duration.SetRedraw(false)
if il_current_word_duration >= il_duration then
//	ln_1.endx = ln_beginx + il_full_length
	st_duration.width = il_full_length
	StopRecord()
	cb_record.text = "Record"
	cb_play.enabled = true
else
//	ln_1.endx = ln_beginx + il_full_length
	st_duration.width = long(dec(il_full_length)*dec(il_current_word_duration)/dec(il_duration))	
end if
st_duration.SetRedraw(true)

//if
//ll_current_word_duration_tmp = il_current_word_duration
//if wparam > ii_degree then // amplitude over threshold
//	il_pause = 0
//	if ib_discarding_data then 
//		il_current_word_duration = 0
//		return
//	else
//		il_current_word_duration = il_current_word_duration + lparam
//		lb_word_read = wf_is_word(il_current_word_duration)
//		if lb_word_read then 
//			ib_discarding_data = true
//			il_current_word_duration = 0
//		else // continue data sampling
//			return
//		end if
//	end if
//else // pause 
//	ib_discarding_data = false
//	if il_pause = 0 and il_current_word_duration > 0 then // new pause and there are data read
//		lb_word_read = wf_is_word(long(real(il_current_word_duration)*5.0/3.0))
//	end if
//	il_pause = lparam
//	il_current_word_duration = 0
//end if
//
//
//long ll_elapsed_time, ll_total_time_need, ll_postion
//decimal ld_installed_pct
//integer li_ret
//if ib_software_installed then return
//ll_elapsed_time = cpu() - il_start_file_copying_time
//if idec_copying_rate > 0 then
//	ll_total_time_need = long(dec(il_current_file_size)/idec_copying_rate)
//	ld_installed_pct = dec(ll_elapsed_time)/dec(ll_total_time_need)
//	ll_postion = ceiling(dec(il_full_length)*ld_installed_pct)
//	if ll_postion > il_full_length then ll_postion = il_full_length
//	st_4.width = ll_postion
//else
//	st_4.width = 0
//end if
//return 1
end event

event soundplay_data;real lr_total, lr_fraction
//il_sound_sample_index = il_sound_sample_index + 1

il_current_word_duration = il_current_word_duration + lparam
if wparam >= 500 then 
	st_amplitude.width = il_full_length
else
	st_amplitude.width = long(dec(il_full_length)*dec(wparam)/500.00)
end if
st_duration.SetRedraw(false)
if il_current_word_duration >= il_duration then
	st_duration.width = il_full_length
//	StopRecord()
//	cb_record.text = "Record"
	cb_play.enabled = true
	cb_record.enabled = true
else
	st_duration.width = long(dec(il_full_length)*dec(il_current_word_duration)/dec(il_duration))	
end if
st_duration.SetRedraw(true)


end event

public subroutine wf_refresh_stat_data (long al_row);string ls_std_file, ls_gender, ls_FnPrefix, ls_WaveFile
long ll_age, ll_SetSize, ll_i, ll_return
double ldb_Max[], ldb_Min[], ldb_Mean[], ldb_duration
ll_age = dw_speech_train_group.GetItemNumber(il_group_row, "age_group")
ls_gender = trim(dw_speech_train_group.GetItemString(il_group_row, "gender"))
ls_FnPrefix = is_path + "\" + string(il_content_id, "0000000000")
ls_std_file = ls_FnPrefix  + string(ll_age, "00") + ls_gender + ".std"
if FileExists(ls_std_file) then
	for ll_i = 1 to 10
		ldb_Max[ll_i] = 0.0
		ldb_Min[ll_i] = 0.0
		ldb_Mean[ll_i] = 0.0
	next
//	MessageBox("before", "a")
	ll_return = extGetTrainDataStat(ls_FnPrefix,ll_age,ls_gender,ll_SetSize,ldb_Max,ldb_Min,ldb_Mean) 
//	MessageBox("after", "b")
	if ll_return = 1 then
		dw_speech_data_stat.Reset()
		for ll_i = 1 to ll_SetSize
			ls_WaveFile = ls_FnPrefix + string(ll_age, "00") &
					+ ls_gender + string(ll_i, "00") + ".wav"
			ldb_duration = extGetWaveDuration(ls_WaveFile)
			dw_speech_data_stat.InsertRow(0)
			dw_speech_data_stat.SetItem(ll_i, "sequence", ll_i)
			dw_speech_data_stat.SetItem(ll_i, "maxoverlap", ldb_Max[ll_i])
			dw_speech_data_stat.SetItem(ll_i, "minoverlap", ldb_Min[ll_i])
			dw_speech_data_stat.SetItem(ll_i, "meanoverlap", ldb_Mean[ll_i])
			dw_speech_data_stat.SetItem(ll_i, "duration", ldb_duration)
		next
	else
		choose case ll_return
			case -1
				MessageBox("Error", "Cannot refresh statistic data, the file is not available!")
			case -2
				MessageBox("Warning", "Cannot refresh statistic data, only one dataset and no overlap availabl!")
		end choose		
	end if
else
	dw_speech_data_stat.Reset()	
end if

end subroutine

on w_speech_training.create
int iCurrent
call super::create
this.cb_playback=create cb_playback
this.cb_save_train_group=create cb_save_train_group
this.cb_delete_group=create cb_delete_group
this.cb_add_group=create cb_add_group
this.dw_speech_train_group=create dw_speech_train_group
this.sle_duration=create sle_duration
this.st_1=create st_1
this.st_duration=create st_duration
this.st_amplitude=create st_amplitude
this.cb_close=create cb_close
this.cb_play=create cb_play
this.cb_update=create cb_update
this.cb_add=create cb_add
this.dw_speech_data_stat=create dw_speech_data_stat
this.cb_record=create cb_record
this.hpb_2=create hpb_2
this.hpb_3=create hpb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_playback
this.Control[iCurrent+2]=this.cb_save_train_group
this.Control[iCurrent+3]=this.cb_delete_group
this.Control[iCurrent+4]=this.cb_add_group
this.Control[iCurrent+5]=this.dw_speech_train_group
this.Control[iCurrent+6]=this.sle_duration
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_duration
this.Control[iCurrent+9]=this.st_amplitude
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.cb_play
this.Control[iCurrent+12]=this.cb_update
this.Control[iCurrent+13]=this.cb_add
this.Control[iCurrent+14]=this.dw_speech_data_stat
this.Control[iCurrent+15]=this.cb_record
this.Control[iCurrent+16]=this.hpb_2
this.Control[iCurrent+17]=this.hpb_3
end on

on w_speech_training.destroy
call super::destroy
destroy(this.cb_playback)
destroy(this.cb_save_train_group)
destroy(this.cb_delete_group)
destroy(this.cb_add_group)
destroy(this.dw_speech_train_group)
destroy(this.sle_duration)
destroy(this.st_1)
destroy(this.st_duration)
destroy(this.st_amplitude)
destroy(this.cb_close)
destroy(this.cb_play)
destroy(this.cb_update)
destroy(this.cb_add)
destroy(this.dw_speech_data_stat)
destroy(this.cb_record)
destroy(this.hpb_2)
destroy(this.hpb_3)
end on

event open;call super::open;any la_parm, la_empty
ulong lu_handle, lu_message
gn_appman.of_get_parm("Wave File Path", la_parm)
is_path = la_parm
la_parm = la_empty
gn_appman.of_get_parm("Wave File Prefix",  la_parm)
is_prefix = la_parm
la_parm = la_empty
title = "Training Data For Content: '" + is_prefix + "'"
gn_appman.of_get_parm("Content ID",  la_parm)
il_content_id = la_parm
il_full_length = st_duration.width
is_current_path = space(200)
lu_handle = handle(this)
lu_message = 1024
is_sound_tmp_file = is_path + "\sound_tmptmp.wav"
InitSoundObject(lu_handle, lu_message, is_sound_tmp_file)
GetCurrentDir(200, is_current_path)
dw_speech_train_group.SetTransobject(SQLCA)
dw_speech_train_group.Retrieve(il_content_id)
end event

event closequery;call super::closequery;ExitRecord()
end event

type cb_playback from u_commandbutton within w_speech_training
integer x = 398
integer y = 2000
integer width = 320
integer height = 84
integer taborder = 40
string text = "PlayBack"
end type

event clicked;call super::clicked;double ldb_duration
st_duration.width = 1
if FileExists(is_sound_tmp_file) then
	st_duration.width = 1
	st_amplitude.width = 1
	cb_play.enabled = false
	cb_record.enabled = false
	il_current_word_duration = 0
	ldb_duration = extGetWaveDuration(is_sound_tmp_file)
	il_duration = long(ldb_duration*1000.0)
	sle_duration.text = string(ldb_duration)
	PlayBack()
end if

end event

type cb_save_train_group from u_commandbutton within w_speech_training
integer x = 1870
integer y = 640
integer width = 320
integer height = 84
integer taborder = 40
string text = "&Save"
end type

event clicked;call super::clicked;long ll_row, ll_rowcount, ll_age_group
if dw_speech_train_group.RowCount() < 1 then return
if dw_speech_train_group.ModifiedCount() < 1 then return
ll_rowcount = dw_speech_train_group.RowCount()
for ll_row = 1 to ll_rowcount
	ll_age_group = dw_speech_train_group.GetItemNumber(ll_row, "age_group")
	if isnull(ll_age_group) then
		MessageBox("Error", "Age group absence, cannot save!")
		return
	end if
next
if dw_speech_train_group.Update() <> 1 then
	f_log_error("dw_speech_train_group", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
	MessageBox("Error", "Cannot save the data!")
	return
end if
commit;


end event

type cb_delete_group from u_commandbutton within w_speech_training
integer x = 398
integer y = 640
integer width = 320
integer height = 84
integer taborder = 20
string text = "Delete"
end type

event clicked;call super::clicked;long ll_row, ll_age_group
long ll_speech_train_id,ll_itemcount, ll_index
string ls_file_wildcard, ls_gender, ls_file_list[]
string ls_message, ls_std_file
if dw_speech_train_group.Rowcount() < 1 then return
ll_row = dw_speech_train_group.GetSelectedRow(0)
if ll_row = 0 then return
ll_speech_train_id = dw_speech_train_group.GetItemNumber(ll_row, "speech_train_id")
ll_age_group = dw_speech_train_group.GetItemNumber(ll_row, "age_group")
ls_gender = trim(dw_speech_train_group.GetItemString(ll_row, "gender"))
dw_speech_train_group.SetFocus()	
if isnull(ll_speech_train_id) then
	dw_speech_train_group.DeleteRow(ll_row)
	dw_speech_train_group.ResetUpdate( ) 
	return
end if
ls_file_wildcard = is_path + string(il_content_id, "##########") + string(ll_age_group, "##") + ls_gender + "??.wav"
ls_std_file = is_path + string(il_content_id, "##########") + string(ll_age_group, "##") + ls_gender + ".std"
ll_itemcount = fnDirListCount(ls_file_wildcard)
for ll_index = 1 to ll_itemcount
	ls_file_list[ll_index] = space(100)
next

ll_itemcount = fnDirList(ls_file_wildcard, ls_file_list)

if ll_itemcount = 0 then
	ls_message = "Do you want to delete the selected data?"
else
	ls_message = "The the selected data and following files:~r~n"
	for ll_index = 1 to ll_itemcount
		ls_message = ls_message + ls_file_list[ll_index] + "~r~n"
	next
	ls_message = ls_message + ", do you want to proceed?"
end if
	
if MessageBox("Warning", ls_message, Question!, YesNo!) = 1 then
	delete speech_train where speech_train.content_id = :il_content_id and speech_train_id = :ll_speech_train_id;
	if SQLCA.sqlcode <> 0 then
		f_log_error("speech_train", SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot delete the data!")
		return
	end if
	commit;
	dw_speech_train_group.DeleteRow(ll_row)
	dw_speech_train_group.ResetUpdate( ) 
	for ll_index = 1 to ll_itemcount
		FileDelete(is_path + "\" + ls_file_list[ll_index])
	next	
	FileDelete(ls_std_file)
end if


end event

type cb_add_group from u_commandbutton within w_speech_training
integer x = 37
integer y = 640
integer width = 320
integer height = 84
integer taborder = 40
string text = "Add"
end type

event clicked;call super::clicked;long ll_row
ll_row = dw_speech_train_group.InsertRow(0)
dw_speech_train_group.SetItem(ll_row, "content_id", il_content_id)
il_current_row = ll_row

end event

type dw_speech_train_group from u_datawindow within w_speech_training
integer x = 37
integer y = 44
integer width = 2153
integer height = 576
string dataobject = "d_speech_train_group"
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then return
il_current_row = row
il_group_row = row
SelectRow(0, false)
SelectRow(row, true)
wf_refresh_stat_data(il_group_row)
end event

type sle_duration from singlelineedit within w_speech_training
integer x = 1888
integer y = 1840
integer width = 297
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "10"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_speech_training
integer x = 1888
integer y = 1776
integer width = 233
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Duration"
boolean focusrectangle = false
end type

type st_duration from statictext within w_speech_training
integer x = 46
integer y = 1864
integer width = 1806
integer height = 44
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
long textcolor = 255
long backcolor = 255
boolean focusrectangle = false
end type

type st_amplitude from statictext within w_speech_training
integer x = 46
integer y = 1788
integer width = 1806
integer height = 44
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
long textcolor = 33554432
long backcolor = 8388608
boolean focusrectangle = false
end type

type cb_close from u_commandbutton within w_speech_training
integer x = 1870
integer y = 2000
integer width = 320
integer height = 84
integer taborder = 30
string text = "&Close"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_play from u_commandbutton within w_speech_training
integer x = 754
integer y = 2000
integer width = 320
integer height = 84
integer taborder = 20
string text = "&Play"
end type

event clicked;call super::clicked;long ll_age
string ls_std_file, ls_gender, ls_FnPrefix, ls_WaveFile, ls_WaveFileTmp, ls_message
if il_stat_current_row < 1 then return
ll_age = dw_speech_train_group.GetItemNumber(il_group_row, "age_group")
ls_gender = trim(dw_speech_train_group.GetItemString(il_group_row, "gender"))
ls_WaveFile = is_path + "\" + string(il_content_id, "0000000000") + string(ll_age, "00") &
			+ ls_gender + string(il_stat_current_row, "00") + ".wav"
If not FileExists(ls_WaveFile) then
	MessageBox("Error", "Sound file is not available!")
	return
end if
st_duration.width = 1
il_duration = long(sle_duration.text)*1000
il_current_word_duration = 0
cb_play.enabled = false
cb_record.enabled = false
StartPlaySoundFile(ls_WaveFile)

	
end event

type cb_update from u_commandbutton within w_speech_training
integer x = 1467
integer y = 2000
integer width = 320
integer height = 84
integer taborder = 20
string text = "&Update"
end type

event clicked;call super::clicked;long ll_age, ll_return
string ls_std_file, ls_gender, ls_FnPrefix, ls_WaveFile,ls_message
if il_stat_current_row < 1 then return
ls_message = "Do you want to update the train data NO. " + string(il_stat_current_row) + "?"
If FileExists(is_sound_tmp_file) then
	if MessageBox("Warning", ls_message, Question!, YesNo!) = 1 then		
		ls_FnPrefix = is_path + "\" + string(il_content_id, "0000000000")
		ll_age = dw_speech_train_group.GetItemNumber(il_group_row, "age_group")
		ls_gender = trim(dw_speech_train_group.GetItemString(il_group_row, "gender"))
		ll_return = extUpdateTrainedData(ls_FnPrefix,is_sound_tmp_file,il_stat_current_row,ll_age,ls_gender)
		if ll_return = 1 then
			wf_refresh_stat_data(il_group_row)
			ls_WaveFile = is_path + "\" + string(il_content_id, "0000000000") + string(ll_age, "00") &
					+ ls_gender + string(il_stat_current_row, "00") + ".wav"
			fnCopyFile(is_sound_tmp_file, ls_WaveFile, 0)
		else
			choose case ll_return
				case -1
					MessageBox("Error", "Cannot update trained data, the wave file is not available!")
				case -2
					MessageBox("Warning", "Cannot update trained data, the train file does not available!")
			end choose
		end if
	end if
end if

end event

type cb_add from u_commandbutton within w_speech_training
integer x = 1111
integer y = 2000
integer width = 320
integer height = 84
integer taborder = 20
string text = "Add"
end type

event clicked;call super::clicked;long ll_row, ll_age, ll_return
string ls_std_file, ls_gender, ls_FnPrefix, ls_WaveFile
if il_group_row = 0 then
	MessageBox("Error", "Cannot add trained data, a training group is not selected!")
	return
end if
if dw_speech_data_stat.Rowcount() = 10 then 
	MessageBox("Error", "Cannot add trained data, the train dataset exceeds the maximum number!")
	return
end if
If FileExists(is_sound_tmp_file) then
	if MessageBox("Warning", "Do you want to add the recorded sound to the train data?", Question!, YesNo!) = 1 then		
		ls_FnPrefix = is_path + "\" + string(il_content_id, "0000000000")
		ll_age = dw_speech_train_group.GetItemNumber(il_group_row, "age_group")
		ls_gender = trim(dw_speech_train_group.GetItemString(il_group_row, "gender"))
		ll_return = extAddTrainedData(ls_FnPrefix,is_sound_tmp_file,ll_age,ls_gender)
		if ll_return = 1 then
			wf_refresh_stat_data(il_group_row)
//			ll_row = dw_speech_data_stat.RowCount()
//			ls_WaveFile = is_path + string(il_content_id, "0000000000") + string(ll_age, "00") &
//					+ ls_gender + string(ll_row, "00") + ".wav"
//			fnCopyFile(is_sound_tmp_file, ls_WaveFile, 0)
		else
			choose case ll_return
				case -1
					MessageBox("Error", "Cannot add trained data, the wave file is not available!")
				case -2
					MessageBox("Warning", "Only one trained data, no statistics available!")
				case -3
					MessageBox("Error", "Cannot add trained data, reach maximum numbers!")
				case else
					MessageBox("Error", "Cannot add trained data, unspecified error!")		
			end choose
		end if
	end if
end if

end event

type dw_speech_data_stat from u_datawindow within w_speech_training
integer x = 37
integer y = 736
integer width = 2153
integer height = 1028
string dataobject = "d_speech_data_stat"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_age
double ldb_duration
string ls_WaveFile, ls_gender, ls_FnPrefix
if currentrow < 1 then return
il_stat_current_row = currentrow
SelectRow(0, false)
SelectRow(currentrow, true)
ll_age = dw_speech_train_group.GetItemNumber(il_group_row, "age_group")
ls_gender = trim(dw_speech_train_group.GetItemString(il_group_row, "gender"))
ls_FnPrefix = is_path + "\" + string(il_content_id, "0000000000")
ls_WaveFile = is_path + "\" + string(il_content_id, "0000000000") + string(ll_age, "00") &
		+ ls_gender + string(il_stat_current_row, "00") + ".wav"
if FileExists(ls_WaveFile) then
	ldb_duration = extGetWaveDuration(ls_WaveFile)
	sle_duration.text = string(ldb_duration)
end if




end event

type cb_record from u_commandbutton within w_speech_training
integer x = 41
integer y = 2000
integer width = 320
integer height = 84
string text = "&Record"
end type

event clicked;call super::clicked;
if cb_record.Text = "Stop" then
	StopRecord()
	cb_record.text = "Record"
	cb_play.enabled = true
else
	sle_duration.text = "1500"
	st_duration.width = 1
	st_amplitude.width = 1
	il_current_word_duration = 0
	il_duration = long(sle_duration.text)*1000
	StartRecord(0)
	cb_record.text = "Stop"
	cb_play.enabled = false
end if

end event

type hpb_2 from hprogressbar within w_speech_training
integer x = 37
integer y = 1776
integer width = 1833
integer height = 68
unsignedinteger maxposition = 100
integer setstep = 10
end type

type hpb_3 from hprogressbar within w_speech_training
integer x = 37
integer y = 1852
integer width = 1833
integer height = 68
unsignedinteger maxposition = 100
integer setstep = 10
end type

