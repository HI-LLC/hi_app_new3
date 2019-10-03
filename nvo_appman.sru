$PBExportHeader$nvo_appman.sru
forward
global type nvo_appman from nonvisualobject
end type
end forward

global type nvo_appman from nonvisualobject
end type
global nvo_appman nvo_appman


type variables
constant date id_build_date = today()
environment ie_env
/*
window iw_frame
w_status iw_status
w_play_avi iw_play_avi
w_picture_pop iw_picture_pop
//inv_datastore ids_shared_acct, ids_shared_exam
string is_empty_list[]
string is_response_to_right_list[]
string is_response_to_wrong_list[]
string is_reward_list[]
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
string is_static_table_path
string is_garbage_file_list[]
string is_dict_index_file // for ilearninghelper compatibility
string is_dict_image_file
string is_resource_index_file
string is_resource_image_file
string is_datawindow_index_file
string is_datawindow_image_file
string is_sql_cache
string is_sys_temp

int dmPelsWidth, dmPelsHeight, dmBitsperPel
long il_login_id, il_transaction_code, il_local_login_ind
boolean ib_reset_display = false
boolean ib_trial_version = false
boolean ib_home_version = false
boolean ib_show_report = true
boolean ib_online_data = true
boolean ib_movie_playing = false
boolean ib_update_datawindow_cache = false
integer ii_site_license_num = 1, ii_student_count = 1
uint iu_home_license_num = 0
long il_account_id, il_student_id, il_lesson_id, il_data_threshold = 10
long il_tv_group_id = 1
long il_student_group_id = 1
long il_popup_x = 1
long il_popup_y = 1
long il_wmp_handle
nvo_linkedlist inv_linkedlist
str_resource_data istr_resource_data[]
datastore ids_lesson[]
str_lesson_package istr_lesson_package
nvo_sqlite invo_sqlite
nvo_filedir invo_filedir

string is_account_type
boolean ib_lesson_training_only = false
long il_training_account_id=0, il_training_student_id=0, il_training_method_id=0, il_training_lesson_id=0
*/

end variables

forward prototypes
public function window of_get_parentwindow (powerobject po)
public subroutine of_set_parm (string as_name, any aa_data)
public function integer of_get_parm (string as_name, ref any aa_data)
public subroutine of_delete_parm (string as_name)
public subroutine of_centerwindow (window win)
end prototypes


public function window of_get_parentwindow (powerobject po);window w

//if po.TypeOf() <> window! then
//	w=gf_get_parentwindow(po.GetParent())
//else
//	w=po
//end if

return w

end function

public subroutine of_set_parm (string as_name, any aa_data);
//inv_linkedlist.of_add_node(as_name, aa_data)
end subroutine

public function integer of_get_parm (string as_name, ref any aa_data);
//return inv_linkedlist.of_get_node(as_name, aa_data)
return 1
end function

public subroutine of_delete_parm (string as_name);
//inv_linkedlist.of_delete_node(as_name)
end subroutine

public subroutine of_centerwindow (window win);
//win.move(&
//	(PixelsToUnits(gn_appman.ie_env.ScreenWidth,XPixelsToUnits!) - win.Width)/2,&
//	(PixelsToUnits(gn_appman.ie_env.ScreenHeight,YPixelsToUnits!) - win.Height)/2)
end subroutine



event constructor;//inv_linkedlist = create nvo_linkedlist 
//invo_filedir = create nvo_filedir 
//invo_sqlite = create nvo_sqlite

end event

event constructor;//is_bitmap_path = ProfileString(is_startupfile, "resources", "bitmapfile", "")
/*
is_bitmapfile_path = is_bitmap_path
is_wavefile_path = ProfileString(is_startupfile, "resources", "wavefile", "")
is_videofile_path = ProfileString(is_startupfile, "resources", "videofile", "")
is_app_path = ProfileString(is_startupfile, "resources", "app_path", "")
is_help_path = ProfileString(is_startupfile, "resources", "help_dir", "")
is_static_table_path = ProfileString(is_startupfile, "resources", "static_table", "")
is_dictionary_wave = is_app_path + "Static Table\wave\Dictionary\"
is_dictionary_bitmap = is_app_path + "Static Table\bitmap\Dictionary\"
//is_dictionary_wave = is_static_table_path + "wave\Dictionary\"
//is_dictionary_bitmap = is_static_table_path + "bitmap\Dictionary\"
inv_linkedlist = create nvo_linkedlist 
invo_filedir = create nvo_filedir 
invo_sqlite = create nvo_sqlite

//if SharedObjectRegister("w_play_avi","my_play_avi") = SharedObjectCreatePBSessionError! then
////	SharedObjectGet("my_play_avi",iw_play_avi)
////else
//	MessageBox("SharedObjectCreatePBSessionError!", "Error")
//else
//	SharedObjectGet("my_play_avi",iw_play_avi)
//end if

*/
end event

event destructor;//inv_linkedlist.of_delete_all()
//destroy inv_linkedlist
//destroy invo_filedir
//destroy invo_sqlite

end event

on nvo_appman.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_appman.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

