$PBExportHeader$nvo_aba_appman.sru
forward
global type nvo_aba_appman from nonvisualobject
end type
end forward

global type nvo_aba_appman from nonvisualobject
end type
global nvo_aba_appman nvo_aba_appman

type variables
constant date id_build_date = today()
environment ie_env
window iw_frame
//w_status iw_status
//inv_datastore ids_shared_acct, ids_shared_exam
string is_wavefile_path
string is_bitmap_path
string is_bitmapfile_path
string is_videofile_path = ".\videos"
string is_app_path
string is_dictionary
string is_dictionary_wave
string is_dictionary_bitmap
string is_help_path
string is_res_file_name
string is_current_lesson_name
string is_host_name
string is_remote_home_path
string is_remote_site_path
string is_garbage_file_list[]
int dmPelsWidth, dmPelsHeight, dmBitsperPel
long il_login_id, il_transaction_code
boolean ib_reset_display = false
boolean ib_trial_version = false
boolean ib_home_version = false
boolean ib_show_report = true
boolean ib_online_data = true
integer ii_site_license_num = 1, ii_student_count = 1
uint iu_home_license_num = 0
long il_account_id, il_student_id, il_lesson_id, il_data_threshold = 10
long il_tv_group_id = 1
long il_student_group_id = 1
nvo_linkedlist inv_linkedlist
str_resource_data istr_resource_data[]
datastore ids_lesson[]
str_lesson_package istr_lesson_package
nvo_sqlite invo_sqlite
//nvo_filedir invo_filedir




end variables

forward prototypes
public function window of_get_parentwindow (powerobject po)
public subroutine of_set_parm (string as_name, any aa_data)
public function integer of_get_parm (string as_name, ref any aa_data)
public subroutine of_delete_parm (string as_name)
public subroutine of_centerwindow (window win)
end prototypes

public function window of_get_parentwindow (powerobject po);window w

if po.TypeOf() <> window! then
	w=gf_get_parentwindow(po.GetParent())
else
	w=po
end if

return w

end function

public subroutine of_set_parm (string as_name, any aa_data);inv_linkedlist.of_add_node(as_name, aa_data)
end subroutine

public function integer of_get_parm (string as_name, ref any aa_data);return inv_linkedlist.of_get_node(as_name, aa_data)
end function

public subroutine of_delete_parm (string as_name);inv_linkedlist.of_delete_node(as_name)
end subroutine

public subroutine of_centerwindow (window win);win.move(&
	(PixelsToUnits(gn_appman.ie_env.ScreenWidth,XPixelsToUnits!) - win.Width)/2,&
	(PixelsToUnits(gn_appman.ie_env.ScreenHeight,YPixelsToUnits!) - win.Height)/2)
end subroutine

on nvo_aba_appman.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_aba_appman.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_bitmap_path = ProfileString(is_startupfile, "resources", "bitmapfile", "")
is_bitmapfile_path = is_bitmap_path
is_wavefile_path = ProfileString(is_startupfile, "resources", "wavefile", "")
//is_videofile_path = ProfileString(is_startupfile, "resources", "videofile", "")
is_app_path = ProfileString(is_startupfile, "resources", "app_path", "")
is_help_path = ProfileString(is_startupfile, "resources", "help_dir", "")
is_dictionary_wave = is_app_path + "Static Table\wave\Dictionary\"
is_dictionary_bitmap = is_app_path + "Static Table\bitmap\Dictionary\"
inv_linkedlist = create nvo_linkedlist 
invo_sqlite = create nvo_sqlite
//invo_filedir = create nvo_filedir 

end event

event destructor;integer li_i
if isvalid(inv_linkedlist) then
	inv_linkedlist.of_delete_all()
	destroy inv_linkedlist
end if
if isvalid(invo_sqlite) then
	invo_sqlite = create nvo_sqlite
end if
//if isvalid(invo_filedir) then
//	destroy invo_filedir
//end if
for li_i = 1 to upperbound(ids_lesson)
	if isvalid(ids_lesson[li_i]) then
		destroy ids_lesson[li_i]
	end if
next
if FileExists(is_res_file_name) then
	FileDelete(is_res_file_name)
end if
if FileExists("c:\LH_sound_tmp.wav") then
	FileDelete("c:\LH_sound_tmp.wav")
end if
for li_i = 1 to upperbound(is_garbage_file_list) 
	if FileExists(is_garbage_file_list[li_i]) then
//		FileDelete(is_garbage_file_list[li_i])
	end if
next

end event

