$PBExportHeader$w_reading.srw
forward
global type w_reading from w_sheet
end type
type cb_reading from commandbutton within w_reading
end type
type cb_close from commandbutton within w_reading
end type
type tv_1 from treeview within w_reading
end type
type p_1 from picture within w_reading
end type
type str_tv_item from structure within w_reading
end type
end forward

type str_tv_item from structure
	long		data_id
	string		description
end type

global type w_reading from w_sheet
integer width = 3899
integer height = 1940
string title = "Reading"
long backcolor = 79741120
event ue_tab pbm_dwnkey
cb_reading cb_reading
cb_close cb_close
tv_1 tv_1
p_1 p_1
end type
global w_reading w_reading

type variables
long il_default_color
long il_hi_light_color
long il_st_index = 1

dec id_sound_lapse[]
uo_st iuo_st[]
string is_wave_file, is_bitmap_file
string is_subject

string is_wavefile_path
string is_list[]
integer ii_row_count

private:
str_tv_item istr_tv_item
TreeViewItem itvi_tmp

long il_current_handle
long il_retrieve_ind = 0

long il_current_chapter_id
datastore ids_content

end variables

forward prototypes
public subroutine wf_make_tv (string a_dw_object, long a_parent_handle, long a_argument, integer a_level, string a_id_column, string a_label_column)
public subroutine wf_init_text_list ()
end prototypes

public subroutine wf_make_tv (string a_dw_object, long a_parent_handle, long a_argument, integer a_level, string a_id_column, string a_label_column);long ll_rows, ll_i, ll_status
long ll_parent_handle, ll_pos, ll_tmp_type_id = 0
string ls_tmpa_label_column
datastore lds_tmp
lds_tmp = create datastore
lds_tmp.dataobject = a_dw_object
lds_tmp.SetTransObject(SQLCA)

treeviewitem ltvi_new 
if a_parent_handle= 0 then // root
	ll_rows = lds_tmp.Retrieve()
else
	ll_rows = lds_tmp.Retrieve(a_argument)
end if

ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_i = 1 to ll_rows
	istr_tv_item.data_id = lds_tmp.GetItemNumber(ll_i, a_id_column)
	istr_tv_item.description = lds_tmp.GetItemString(ll_i, a_label_column)							
	ltvi_new.label = istr_tv_item.description
	ltvi_new.data = istr_tv_item	
	ll_parent_handle = tv_1.InsertItemLast(a_parent_handle, ltvi_new)
	if a_level = 1 then
		wf_make_tv('d_chapter', ll_parent_handle, istr_tv_item.data_id, 2, 'chapter_id', 'description')
	end if
next
if ll_rows > 0 then
	tv_1.GetItem(a_parent_handle, itvi_tmp)
	itvi_tmp.children = true
	tv_1.SetItem(a_parent_handle, itvi_tmp)
end if
destroy lds_tmp

end subroutine

public subroutine wf_init_text_list ();integer li_i
long ll_min_x, ll_max_x, ll_min_y, ll_max_y
long ll_x, ll_y, ll_row

ii_row_count = ids_content.retrieve(il_current_chapter_id)
if ii_row_count = 0 then
	MessageBox("Error", "No text available in this chapter")
	return
end if
is_wave_file = ids_content.GetItemString(1, 'wave_file')
is_bitmap_file = ids_content.GetItemString(1, 'bitmap_file')
is_subject = ids_content.GetItemString(1, 'subject_description')

if not isnull(is_bitmap_file) and len(is_bitmap_file) > 0 then
	p_1.picturename = gn_appman.is_bitmap_path + is_subject + '\' + is_bitmap_file
end if

for li_i = 1 to upperbound(iuo_st)
	if isvalid(iuo_st[li_i]) then 
		closeuserobject(iuo_st[li_i])
		destroy iuo_st[li_i]
	end if
next	

ll_min_x = p_1.x + 100
ll_max_x = p_1.x + p_1.width - 100
ll_min_y = p_1.y + 100
ll_max_y = p_1.y + p_1.height - 100

ll_x = ll_min_x
ll_y = ll_min_y
for li_i = 1 to ii_row_count
	iuo_st[li_i] = create uo_st
	iuo_st[li_i].text = ids_content.GetItemString(li_i, 'content_description')
	iuo_st[li_i].width= long(45.5*real(len(iuo_st[li_i].text)))
	iuo_st[li_i].il_hi_light_color = il_hi_light_color	
	if ll_x + iuo_st[li_i].width  > ll_max_x then
		ll_x = ll_min_x 
		ll_y = ll_y + 80
		OpenUserObject(iuo_st[li_i], ll_x, ll_y)	
	else
		OpenUserObject(iuo_st[li_i], ll_x, ll_y)	
	end if	
	iuo_st[li_i].visible = true
	ll_x = ll_x + iuo_st[li_i].width + 45.5
	id_sound_lapse[li_i] = ids_content.GetItemNumber(li_i, 'wave_time')
next

end subroutine

on w_reading.create
int iCurrent
call super::create
this.cb_reading=create cb_reading
this.cb_close=create cb_close
this.tv_1=create tv_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reading
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.tv_1
this.Control[iCurrent+4]=this.p_1
end on

on w_reading.destroy
call super::destroy
destroy(this.cb_reading)
destroy(this.cb_close)
destroy(this.tv_1)
destroy(this.p_1)
end on

event open;call super::open;long ll_chapter_id



//ll_chapter_id = long(Message.StringParm)
il_hi_light_color = RGB(255, 128, 255)
is_wavefile_path = ProfileString("Learning Helper.INI", "Resources", "wavefile", "")

ids_content = create datastore
ids_content.dataobject = 'd_reading'
ids_content.SetTransObject(SQLCA)

tv_1.SetReDraw(false)
wf_make_tv('d_subject_text', 0, 0, 1, 'subject_id', 'description')
tv_1.SetReDraw(true)

end event

event timer;il_st_index++
iuo_st[il_st_index].backcolor = il_hi_light_color
iuo_st[il_st_index - 1].backcolor = iuo_st[il_st_index - 1].il_default_color
if il_st_index > ii_row_count then
	timer(0)
else
	timer(id_sound_lapse[il_st_index])
end if

end event

event close;call super::close;integer li_i
for li_i = 1 to upperbound(iuo_st)
	closeuserobject(iuo_st[li_i])
	destroy iuo_st[li_i]
next

destroy ids_content
end event

type cb_reading from commandbutton within w_reading
integer x = 2857
integer y = 68
integer width = 526
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Start Reading"
end type

event clicked;if ii_row_count = 0 then
	MessageBox("Error", "No text available in this chapter")
end if
iuo_st[ii_row_count].backcolor = iuo_st[ii_row_count].il_default_color
SetPointer(HourGlass!)
sndPlaySoundA(gn_appman.is_wavefile_path + is_subject + '\' + is_wave_file, 1)
yield()
il_st_index = 1
iuo_st[il_st_index].backcolor = il_hi_light_color
timer(id_sound_lapse[il_st_index])



end event

type cb_close from commandbutton within w_reading
integer x = 3461
integer y = 68
integer width = 334
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;close(parent)
end event

type tv_1 from treeview within w_reading
integer x = 69
integer y = 68
integer width = 1166
integer height = 1660
integer taborder = 30
boolean dragauto = true
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 553648127
end type

event selectionchanged;long ll_old_chapter_id
TreeViewItem ltv_tmp
	
GetItem(newhandle, ltv_tmp)

if ltv_tmp.level = 2 then
	istr_tv_item = ltv_tmp.data
	ll_old_chapter_id = il_current_chapter_id
	il_current_chapter_id = istr_tv_item.data_id
	if ll_old_chapter_id <> il_current_chapter_id then
		wf_init_text_list()
	end if
end if

end event

type p_1 from picture within w_reading
integer x = 1312
integer y = 216
integer width = 2469
integer height = 1484
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

