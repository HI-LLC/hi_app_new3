$PBExportHeader$w_mt_tables.srw
forward
global type w_mt_tables from w_generic_update
end type
type tv_1 from u_treeview within w_mt_tables
end type
type cb_1 from commandbutton within w_mt_tables
end type
type cb_load_resource from commandbutton within w_mt_tables
end type
type str_mt_table from structure within w_mt_tables
end type
end forward

type str_mt_table from structure
	string		dw_name
	string		dw_description
	string		sq_name
	string		key_column
	long		message_no
end type

global type w_mt_tables from w_generic_update
integer width = 3602
integer height = 1944
string title = "Tables Maintenance "
event ue_populate_tv ( )
tv_1 tv_1
cb_1 cb_1
cb_load_resource cb_load_resource
end type
global w_mt_tables w_mt_tables

type variables
private:
str_mt_table istr_mt_table
nvo_filedir invo_filedir
string is_picture_path = ""
string is_sound_path = ""
string is_location
end variables

forward prototypes
public subroutine wf_update_bmp_wave_ind ()
public subroutine wf_broadcast_changes ()
end prototypes

event ue_populate_tv;long ll_rows, ll_i, ll_status
long ll_parent_handle, ll_pos, ll_tmp_type_id = 0
string ls_tmp
treeviewitem ltvi_new 
datastore lds_mt_module
lds_mt_module = create datastore
lds_mt_module.dataobject = 'd_module'
ll_status = lds_mt_module.SetTransObject(SQLCA)
ll_rows = lds_mt_module.Retrieve()

ltvi_new.label = "Maintenance Tables"
ltvi_new.children = true
ltvi_new.PictureIndex = 2
ltvi_new.SelectedPictureIndex = 2

ll_parent_handle = tv_1.InsertItemLast(0, ltvi_new)
ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_i = 1 to ll_rows
	istr_mt_table.dw_name = lds_mt_module.GetItemString(ll_i, 'dw_name')	
	istr_mt_table.dw_description = lds_mt_module.GetItemString(ll_i, 'module_desc')
	istr_mt_table.message_no = lds_mt_module.GetItemNumber(ll_i, 'message_no')
	istr_mt_table.sq_name = ""	
	ltvi_new.label = istr_mt_table.dw_description	
	ltvi_new.data = istr_mt_table	
	tv_1.InsertItemLast(ll_parent_handle, ltvi_new)
next


ll_parent_handle = tv_1.FindItem(RootTreeItem!, 0)
do while ll_parent_handle <> -1
	tv_1.ExpandAll(ll_parent_handle)
	ll_parent_handle = tv_1.FindItem(NextTreeItem!, ll_parent_handle)
loop

destroy lds_mt_module
end event

public subroutine wf_update_bmp_wave_ind ();string ls_filename, ls_word, ls_indicator, ls_file_indicator
long ll_row, ll_rowcount

ll_rowcount = dw_1.rowcount()

for ll_row = 1 to ll_rowcount
	ls_word = dw_1.getitemstring(ll_row, 'word')
	ls_indicator = dw_1.getitemstring(ll_row, 'bitmap_ind')
	if isnull(ls_indicator) then ls_indicator = '0'
	ls_filename = gn_appman.is_app_path + 'Static Table\bitmap\dictionary\' + ls_word + '.bmp'
	if FileExists(ls_filename) then 
		ls_file_indicator = '1'
	else
		ls_file_indicator = '0'
	end if
	if ls_indicator <> ls_file_indicator then
		dw_1.setitem(ll_row, 'bitmap_ind', ls_file_indicator)
	end if
	ls_indicator = dw_1.getitemstring(ll_row, 'wave_ind')
	if isnull(ls_indicator) then ls_indicator = '0'
	ls_filename = gn_appman.is_app_path + 'Static Table\wave\dictionary\' + ls_word + '.wav'
	if FileExists(ls_filename) then 
		ls_file_indicator = '1'
	else
		ls_file_indicator = '0'
	end if
	if ls_indicator <> ls_file_indicator then
		dw_1.setitem(ll_row, 'wave_ind', ls_file_indicator)
	end if		
next
end subroutine

public subroutine wf_broadcast_changes ();// broadcast saved table
long ll_i
for ll_i = 1 to upperbound(gstr_mt_dddw)
	if gstr_mt_dddw[ll_i].message_no = istr_mt_table.message_no then
		send(gstr_mt_dddw[ll_i].handle, gstr_mt_dddw[ll_i].message_no, 0, 0)
	end if
next
end subroutine

on w_mt_tables.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.cb_1=create cb_1
this.cb_load_resource=create cb_load_resource
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_load_resource
end on

on w_mt_tables.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.cb_1)
destroy(this.cb_load_resource)
end on

event open;
wf_set_resize(true)
super::event open()
//
this.event ue_populate_tv()
cb_1.visible = false	
invo_filedir = create nvo_filedir
openuserobject(invo_filedir, 1, 1)
invo_filedir.visible = false

end event

event close;call super::close;destroy invo_filedir 
end event

type dw_1 from w_generic_update`dw_1 within w_mt_tables
integer x = 1019
integer y = 56
integer width = 2487
integer height = 1560
integer taborder = 20
string dataobject = "d_background"
end type

event dw_1::itemchanged;call super::itemchanged;//string ls_data, ls_column, ls_first_column, ls_find
//ls_column = GetColumnName()
//ls_first_column = describe("#1.Name")
//if len(istr_mt_table.sq_name) = 0 and ls_column = ls_first_column and  row > 1 then
//	ls_data = GetText()
//	ls_find = ls_column + " = '" + ls_data + "'"
//	if Find(ls_find, 1, row -1) > 0 then
//		MessageBox("Error", "Duplicate field, cannot proceed.")
//		return 1
//	end if
//end if
end event

event dw_1::doubleclicked;string ls_file_name
if dwo.name = "wave_file" then
	ls_file_name = this.GetItemString(row, "wave_file")
	if not isnull(ls_file_name) and len(ls_file_name) > 0 then
		sndPlaySoundA (".\wave\" + ls_file_name, 0)
	end if
end if
end event

type cb_add from w_generic_update`cb_add within w_mt_tables
integer x = 1810
integer y = 1668
integer height = 112
integer taborder = 30
string text = "&New"
end type

event cb_add::clicked;call super::clicked;string ls_column
dw_1.SetFocus()
if len(istr_mt_table.sq_name) = 0 then
	ls_column = dw_1.describe("#1.Name")
	dw_1.SetColumn(ls_column)
end if
end event

type cb_delete from w_generic_update`cb_delete within w_mt_tables
integer x = 2144
integer y = 1668
integer height = 112
integer taborder = 40
end type

event cb_delete::clicked;call super::clicked;wf_broadcast_changes()
end event

type cb_save from w_generic_update`cb_save within w_mt_tables
integer x = 2821
integer y = 1668
integer height = 112
end type

event cb_save::clicked;string ls_data, ls_column, ls_first_column, ls_find
long ll_row, ll_row_count, ll_row_found, ll_return
ll_row_count = dw_1.RowCount()
//
//if len(istr_mt_table.sq_name) = 0 then
//	ls_column = dw_1.describe("#1.Name")
//	for ll_row = 1 to ll_row_count - 1
//		ls_data = dw_1.GetItemString(ll_row, ls_column)	
//		ls_find = ls_column + " = '" + ls_data + "'"
//		ll_row_found = dw_1.Find(ls_find, 1, ll_row_count) 
//		if ll_row_found <> ll_row then // duplicate row
//			MessageBox("Error", f_get_error_message(50015))
//			return 1
//		else
//			ll_row_found = dw_1.Find(ls_find, ll_row_found + 1, ll_row_count) 
//			if ll_row_found > 0 then
//				MessageBox("Error", f_get_error_message(50015))
//				return 1
//			end if
//		end if
//	next
//end if

string ls_word, ls_filename
if istr_mt_table.dw_name = 'd_dictionary' then
	for ll_row = 1 to ll_row_count
		if dw_1.GetItemStatus(ll_row, 'word', Primary!) <> NotModified! then
			ls_word = dw_1.getitemstring(ll_row, 'word')
			ls_filename = gn_appman.is_app_path + 'dictionary\bitmap\' + ls_word + '.bmp'
			if FileExists(ls_filename) then 
				dw_1.setitem(ll_row, 'bitmap_id', '1')
			else
				dw_1.setitem(ll_row, 'bitmap_id', '0')
			end if
			ls_filename = gn_appman.is_app_path + 'dictionary\wave\' + ls_word + '.wav'
			if FileExists(ls_filename) then 
				dw_1.setitem(ll_row, 'wave_id', '1')
			else
				dw_1.setitem(ll_row, 'wave_id', '0')
			end if
		end if	
	next
end if

ll_return = super::event clicked()
if ll_return = 1 then
	return 1
end if
wf_broadcast_changes()
return 0
end event

type cb_close from w_generic_update`cb_close within w_mt_tables
integer x = 3154
integer y = 1668
integer height = 112
integer taborder = 70
end type

type cb_cancel from w_generic_update`cb_cancel within w_mt_tables
integer x = 2482
integer y = 1668
integer height = 112
end type

type tv_1 from u_treeview within w_mt_tables
integer x = 23
integer y = 60
integer width = 974
integer height = 1556
boolean bringtotop = true
integer textsize = -8
string facename = "MS Sans Serif"
long backcolor = 1090519039
boolean linesatroot = true
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 553648127
end type

event constructor;
This.PictureHeight = 15
This.PictureWidth = 16
//
//This.AddPicture ( "emp1.bmp" )
//This.AddPicture ( "group.bmp" )
//This.AddPicture ( "role.bmp" )
//This.AddPicture ( "globe3.ICO" )
//This.AddPicture ( "custom050!" )
//This.AddPicture ( "custom039!" )
end event

event selectionchanged;call super::selectionchanged;treeviewitem ltvi_new 

tv_1.GetItem(newhandle, ltvi_new)
if ltvi_new.level <> 2 then
	return
end if
ib_edit_mode = false
istr_mt_table = ltvi_new.data
is_location = ltvi_new.label
parent.wf_set_sequence_use(false)	
dw_1.dataobject = string(istr_mt_table.dw_name)
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()
dw_1.of_build_validation_from_tag()
datawindowchild lddc_tmp
is_picture_path = ''
is_sound_path = ''
choose case istr_mt_table.dw_name
	case 'd_container'
		is_picture_path =  gn_appman.is_app_path + "Static Table\bitmap\Container"
	case 'd_bean'
		is_picture_path =  gn_appman.is_app_path + "Static Table\bitmap\Bean"
end choose
if len(is_picture_path) > 0 then
	dw_1.GetChild('bitmap_file', lddc_tmp)
	if invo_filedir.of_get_bitmap_list(lddc_tmp, 'filename', is_picture_path + "\") = -1 then
		MessageBox("Error", "Cannot retrieve picture files!")
	end if
end if
choose case istr_mt_table.dw_name
	case 'd_response_right'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Response To Right"
	case 'd_response_wrong'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Response To Wrong"
	case 'd_bean'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Bean"
	case 'd_container'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Container"
	case 'd_preposition'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Preposition"
	case 'd_instruction'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Instruction"
	case 'd_prompt'
		is_sound_path =  gn_appman.is_app_path + "Static Table\wave\Prompt"
end choose
if len(is_sound_path) > 0 then
	dw_1.GetChild('wave_file', lddc_tmp)
	if invo_filedir.of_get_wave_list(lddc_tmp, 'filename', is_sound_path + "\") = -1 then
		MessageBox("Error", "Cannot retrieve wave files!")
	end if
end if

if istr_mt_table.dw_name = 'd_dictionary' then
	cb_1.visible = true
else
	cb_1.visible = false	
end if
cb_load_resource.enabled = len(is_picture_path) > 0 or len(is_sound_path) > 0

end event

event selectionchanging;treeviewitem ltvi_old, ltvi_new
GetItem(oldhandle, ltvi_old)
GetItem(newhandle, ltvi_new)
if (ltvi_old.level = ltvi_new.level) and (ltvi_old.level= 2) then
	return wf_confirmation()
end if
end event

event itemcollapsing;boolean ib_tmp
ib_tmp = wf_get_edit_mode()
return wf_confirmation() 


end event

event itemcollapsed;dw_1.dataobject = 'd_background'
treeviewitem ltvi_new 
tv_1.GetItem(handle, ltvi_new)
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 1
tv_1.SetItem(handle, ltvi_new)

end event

event itemexpanded;treeviewitem ltvi_new 
tv_1.GetItem(handle, ltvi_new)
ltvi_new.PictureIndex = 2
ltvi_new.SelectedPictureIndex = 2
tv_1.SetItem(handle, ltvi_new)

end event

type cb_1 from commandbutton within w_mt_tables
integer x = 1202
integer y = 1672
integer width = 416
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Refresh Indicator"
end type

event clicked;wf_update_bmp_wave_ind()
end event

type cb_load_resource from commandbutton within w_mt_tables
integer x = 567
integer y = 1672
integer width = 416
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Load Resources"
end type

event clicked;string ls_win_title, ls_filetype, ls_filepath

if len(is_picture_path) > 0 and len(is_sound_path) > 0 then
	if MessageBox("Selection", "Load Picture (Yes) or Sound (No) Files?", Question!, YesNo!) = 1 then
		ls_win_title = "Load Picture To Static Table"
		ls_filepath = is_picture_path
	else
		ls_win_title = "Load Sound To Static Table"
		ls_filepath = is_sound_path		
	end if
elseif len(is_picture_path) > 0 then
		ls_win_title = "Load Picture To Static Table"
		ls_filepath = is_picture_path	
else
		ls_win_title = "Load Sound To Static Table"
		ls_filepath = is_sound_path			
end if
ls_filetype = "*.*"
gn_appman.of_set_parm("Win Title", ls_win_title)
gn_appman.of_set_parm("File Path",  ls_filepath)
gn_appman.of_set_parm("File Type",  ls_filetype)
gn_appman.of_set_parm("Location",  is_location)
Open(w_resource_loading)
end event

