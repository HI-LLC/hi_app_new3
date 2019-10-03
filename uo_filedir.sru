$PBExportHeader$uo_filedir.sru
forward
global type uo_filedir from userobject
end type
end forward

global type uo_filedir from userobject
boolean visible = false
integer width = 1321
integer height = 904
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_filedir uo_filedir

type variables
string is_bitmap_path, is_wavefile_path, is_videofile_path
listbox ilb_1
end variables

forward prototypes
public function boolean of_is_empty_dir (string as_path)
public function integer of_get_bitmap_list (ref picturelistbox a_plb, string a_dirpath)
public function integer of_get_dir_list (string as_path, ref string as_file_list[])
public function integer of_get_dir_list_all (string as_path, ref string as_file_list[])
public function integer of_get_wave_list (datawindowchild a_dddw, string a_column, string a_dirpath)
public function integer of_get_bitmap_list (datawindowchild a_dddw, string a_column, string a_dirpath)
public function integer of_get_video_list (datawindowchild a_dddw, string a_column, string a_dirpath)
end prototypes

public function boolean of_is_empty_dir (string as_path);//boolean lb_tmp
//lb_tmp = lb_1.DirList(as_path + "\*.*", 0)
//if isnull(lb_tmp) or lb_tmp = false then
	return true
//else
//	return false
//end if

end function

public function integer of_get_bitmap_list (ref picturelistbox a_plb, string a_dirpath);integer li_index, li_itemcount, li_pic, li_position
string ls_filelist[], ls_tmp


ls_tmp = is_bitmap_path + a_dirpath + "*.bmp"
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = '                                                                                                    '
next

li_itemcount = fnDirList(ls_tmp, ls_filelist)
a_plb.ReSet()
for li_index = 1 to li_itemcount
	ilb_1.SelectItem(li_index)
	li_pic = a_plb.AddPicture(is_bitmap_path + a_dirpath + ls_filelist[li_index])
	li_position = a_plb.AddItem(a_plb.SelectedItem(), li_pic)
next 

li_pic = a_plb.AddPicture(' ')
li_position = a_plb.AddItem(' ', li_pic)

return 1


end function

public function integer of_get_dir_list (string as_path, ref string as_file_list[]);integer li_index, li_itemcount, li_row
string ls_filelist[], ls_tmp

ls_tmp = as_path + "\*.*"
f_filter_double_char('\', ls_tmp)
MessageBox("uo_filedir", ls_tmp)
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = space(80)
next
li_itemcount = fnDirList(ls_tmp, ls_filelist)
for li_index = 1 to li_itemcount
	MessageBox("uo_filedir-file " + string(li_index), ls_filelist[li_index])
next
as_file_list = ls_filelist

return 1
end function

public function integer of_get_dir_list_all (string as_path, ref string as_file_list[]);integer li_index, li_itemcount, li_row
string ls_filelist[], ls_tmp

ls_tmp = as_path + "\*.*"
f_filter_double_char('\', ls_tmp)
//MessageBox("uo_filedir", ls_tmp)
li_itemcount = fnDirListCountAll(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = space(80)
next
li_itemcount = fnDirListAll(ls_tmp, ls_filelist)
//for li_index = 1 to li_itemcount
//	MessageBox("uo_filedir-file " + string(li_index), ls_filelist[li_index])
//next
as_file_list = ls_filelist

return 1
end function

public function integer of_get_wave_list (datawindowchild a_dddw, string a_column, string a_dirpath);integer li_index, li_itemcount, li_row
string ls_filelist[], ls_tmp
a_dddw.Reset()
ls_tmp = is_wavefile_path + a_dirpath + "*.wav"
f_filter_double_char('\', ls_tmp)
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = space(80)
next
//MessageBox("ls_tmp of_get_wave_list", ls_tmp)
li_itemcount = fnDirList(ls_tmp, ls_filelist)

for li_index = 1 to li_itemcount
	li_row = a_dddw.InsertRow(0)
	a_dddw.SetItem(li_row, a_column, ls_filelist[li_index])
next 
//li_row = a_dddw.InsertRow(0)
//a_dddw.SetItem(li_row, a_column, ' ')

ls_tmp = is_videofile_path + a_dirpath + "*.avi"
f_filter_double_char('\', ls_tmp)
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = space(80)
next
li_itemcount = fnDirList(ls_tmp, ls_filelist)
for li_index = 1 to li_itemcount
	li_row = a_dddw.InsertRow(0)
	a_dddw.SetItem(li_row, a_column, ls_filelist[li_index])
next 
li_row = a_dddw.InsertRow(0)
a_dddw.SetItem(li_row, a_column, ' ')


return 1


end function

public function integer of_get_bitmap_list (datawindowchild a_dddw, string a_column, string a_dirpath);integer li_index, li_itemcount, li_row
string ls_filelist[], ls_tmp

ls_tmp = is_bitmap_path + a_dirpath + "*.*"
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = space(80)
next

li_itemcount = fnDirList(ls_tmp, ls_filelist)
a_dddw.ReSet()
for li_index = 1 to li_itemcount
	li_row = a_dddw.InsertRow(0)
	a_dddw.SetItem(li_row, a_column, ls_filelist[li_index])
next 
li_row = a_dddw.InsertRow(0)
a_dddw.SetItem(li_row, a_column, ' ')


return 1


end function

public function integer of_get_video_list (datawindowchild a_dddw, string a_column, string a_dirpath);integer li_index, li_itemcount, li_row
string ls_filelist[], ls_tmp
a_dddw.Reset()

ls_tmp = is_videofile_path + a_dirpath + "*.*"
f_filter_double_char('\', ls_tmp)
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	ls_filelist[li_index] = space(80)
next
li_itemcount = fnDirList(ls_tmp, ls_filelist)
for li_index = 1 to li_itemcount
	li_row = a_dddw.InsertRow(0)
	a_dddw.SetItem(li_row, a_column, ls_filelist[li_index])
next 
//li_row = a_dddw.InsertRow(0)
//a_dddw.SetItem(li_row, a_column, ' ')
return 1
end function

on uo_filedir.create
end on

on uo_filedir.destroy
end on

event constructor;is_bitmap_path = ProfileString("Learning Helper.INI", "Resources", "bitmapfile", "")
is_wavefile_path = ProfileString("Learning Helper.INI", "Resources", "wavefile", "")
is_videofile_path = ProfileString("Learning Helper.INI", "Resources", "videofile", "")

end event

