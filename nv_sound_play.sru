$PBExportHeader$nv_sound_play.sru
forward
global type nv_sound_play from nonvisualobject
end type
end forward

global type nv_sound_play from nonvisualobject autoinstantiate
end type

type variables
string is_wavefile_path
end variables

forward prototypes
public subroutine play_sound ()
public subroutine play_sound (string as_wave_file, string as_subject_path)
public subroutine play_sound (string as_wave_file, string as_subject_path, string as_chapter_path)
public subroutine play_st_sound (string as_wave_file)
public subroutine play_sound (string as_wave_file)
public subroutine play_sound (string as_wave_file, integer ai_table_ind, long al_table_id)
public function string of_get_prefix ()
public subroutine play_number_sound (string as_wave_file)
end prototypes

public subroutine play_sound ();
end subroutine

public subroutine play_sound (string as_wave_file, string as_subject_path);string ls_wave_file
SetPointer(HourGlass!)
if isnull(as_wave_file) then
	MessageBox("Error", "Sound file is selected.")
	return
end if
ls_wave_file = gn_appman.is_wavefile_path + as_subject_path + '\' + as_wave_file	
if FileExists(ls_wave_file) then
	sndPlaySoundA(ls_wave_file, 0)
else
	MessageBox("Error", "Sound file - " + ls_wave_file + " does not exist!")
end if


end subroutine

public subroutine play_sound (string as_wave_file, string as_subject_path, string as_chapter_path);string ls_wave_file
SetPointer(HourGlass!)
if isnull(ls_wave_file) then
	MessageBox("Error", "Sound file is selected.")
	return
end if
ls_wave_file = gn_appman.is_wavefile_path + as_subject_path + '\' + as_chapter_path + '\' + as_chapter_path
if FileExists(ls_wave_file) then
	sndPlaySoundA(ls_wave_file, 0)
else
	MessageBox("Error", "Sound file - " + ls_wave_file + " does not exist!")
end if


end subroutine

public subroutine play_st_sound (string as_wave_file);
string ls_local_file
if gn_appman.ib_online_data then
//	MessageBox("play_st_sound", "A")
	f_getonlinefile(as_wave_file, ls_local_file)
//	MessageBox(as_wave_file, ls_local_file)
else
	ls_local_file = as_wave_file
	f_GetResourceFile(as_wave_file)
end if
//if isnull("c:\" + as_wave_file) then
//	MessageBox("Error", "Sound file is selected.")
//	return
//end if
//if FileExists("c:\" + as_wave_file) then
//	sndPlaySoundA("c:\" + as_wave_file, 0)
//else
//	MessageBox("Error", "Sound file - " + "c:\" + as_wave_file + " does not exist!")
//end if
if isnull(ls_local_file) then
	MessageBox("Error", "No Sound file is selected.")
	return
end if
if FileExists(ls_local_file) then
	sndPlaySoundA(ls_local_file, 0)
else
	MessageBox("Error", "Sound file - " + ls_local_file + " does not exist!")
end if
//FileDelete(as_wave_file)
end subroutine

public subroutine play_sound (string as_wave_file);string ls_wave_file, ls_subject, ls_chapter
SetPointer(HourGlass!)
if isnull(as_wave_file) then
	MessageBox("Error", "Sound file is selected.")
	return
end if
ls_wave_file = /*gn_appman.is_wavefile_path + */ as_wave_file
if FileExists(ls_wave_file) then
	sndPlaySoundA(ls_wave_file, 0)
else
	MessageBox("Error", "Sound file - " + ls_wave_file + " does not exist!")
end if
end subroutine

public subroutine play_sound (string as_wave_file, integer ai_table_ind, long al_table_id);string ls_wave_file, ls_subject, ls_chapter
long ll_subject_id
//choose case ai_table_ind
//	case 0 // wave file in base dir
//		ls_wave_file = gn_appman.is_wavefile_path + as_wave_file
//	case 1 // wave file under subject
//		select description into :ls_subject
//		from subject
//		where subject_id = :al_table_id;
//		ls_wave_file = gn_appman.is_wavefile_path + ls_subject + '\' + as_wave_file
//	case else // wave file under chapter
//		select description, subject_id into :ls_chapter, :ll_subject_id
//		from chapter
//		where chapter_id = :al_table_id;	
//		select description into :ls_subject
//		from subject
//		where subject_id = :ll_subject_id;	
//		ls_wave_file = gn_appman.is_wavefile_path + ls_subject + '\' + ls_chapter + '\' + as_wave_file
//end choose

SetPointer(HourGlass!)
if isnull(ls_wave_file) then
	MessageBox("Error", "Sound file is selected.")
	return
end if
if FileExists(ls_wave_file) then
	sndPlaySoundA(ls_wave_file, 0)
else
	MessageBox("Error", "Sound file - " + ls_wave_file + " does not exist!")
end if		
end subroutine

public function string of_get_prefix ();return ""
end function

public subroutine play_number_sound (string as_wave_file);
string ls_local_file
SetPointer(HourGlass!)
if gn_appman.ib_online_data then
	f_getonlinefile(as_wave_file, ls_local_file)
else
	ls_local_file = as_wave_file
	f_GetResourceFile(as_wave_file)
end if
if isnull(ls_local_file) then
	MessageBox("Error", "Sound file is selected.")
	return
end if
if FileExists(ls_local_file) then
	sndPlaySoundA(ls_local_file, 0)
else
	MessageBox("Error", "Sound file - " + ls_local_file + " does not exist!")
end if
end subroutine

on nv_sound_play.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_sound_play.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_wavefile_path = ProfileString("Learning Helper.INI", "Resources", "wavefile", "")

end event

