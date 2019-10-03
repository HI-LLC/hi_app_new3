$PBExportHeader$w_reading_multi_pages.srw
forward
global type w_reading_multi_pages from w_sheet
end type
type p_dimension_test from picture within w_reading_multi_pages
end type
type cbx_fixed_size from checkbox within w_reading_multi_pages
end type
type cb_reading from commandbutton within w_reading_multi_pages
end type
type cb_close from commandbutton within w_reading_multi_pages
end type
type tv_1 from treeview within w_reading_multi_pages
end type
type rb_1 from radiobutton within w_reading_multi_pages
end type
type rb_2 from radiobutton within w_reading_multi_pages
end type
type p_2 from picture within w_reading_multi_pages
end type
type p_1 from picture within w_reading_multi_pages
end type
type str_tv_item from structure within w_reading_multi_pages
end type
end forward

type str_tv_item from structure
	long		data_id
	string		description
end type

global type w_reading_multi_pages from w_sheet
integer x = 0
integer y = 0
integer width = 3602
integer height = 2236
string title = "Reading"
long backcolor = 79741120
event ue_tab pbm_dwnkey
event ue_text_clicked pbm_custom01
p_dimension_test p_dimension_test
cbx_fixed_size cbx_fixed_size
cb_reading cb_reading
cb_close cb_close
tv_1 tv_1
rb_1 rb_1
rb_2 rb_2
p_2 p_2
p_1 p_1
end type
global w_reading_multi_pages w_reading_multi_pages

type variables
long il_default_color
long il_hi_light_color
long il_st_index = 1
long li_width[], li_height[]

dec id_sound_lapse[]
uo_st iuo_st[]
string is_wave_file, is_bitmap_file
string is_subject, is_chapter

string is_wavefile_path
string is_list[]
integer ii_row_count

private:
str_tv_item istr_tv_item
TreeViewItem itvi_tmp

long il_p2_width, il_p2_height
long il_current_handle
long il_retrieve_ind = 0

long il_current_chapter_id
datastore ids_content

public:
integer ii_current_index = 1
integer ii_old_index = 1
end variables

forward prototypes
public subroutine wf_make_tv (string a_dw_object, long a_parent_handle, long a_argument, integer a_level, string a_id_column, string a_label_column)
public subroutine wf_init_text_list ()
public subroutine wf_demo_tail ()
public subroutine wf_demo ()
public subroutine wf_resize_picture (ref picture ap_picture, string as_filename)
end prototypes

event ue_text_clicked;iuo_st[ii_old_index].backcolor = iuo_st[ii_old_index].il_default_color
iuo_st[ii_current_index].backcolor = iuo_st[ii_old_index].il_hi_light_color

if not isnull(iuo_st[ii_current_index].is_picture) and len(iuo_st[ii_current_index].is_picture) > 0 then
	p_2.picturename = iuo_st[ii_current_index].is_picture
end if

end event

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
is_chapter = ids_content.GetItemString(1, 'chapter_description')
if not isnull(is_bitmap_file) and len(is_bitmap_file) > 0 then
	p_1.picturename = gn_appman.is_bitmap_path + is_subject + '\' + is_bitmap_file
end if

for li_i = 1 to upperbound(iuo_st)
	if isvalid(iuo_st[li_i]) then 
		closeuserobject(iuo_st[li_i])
		destroy iuo_st[li_i]
	end if
next	

ll_min_x = p_1.x + 50
ll_max_x = p_1.x + p_1.width - 30
ll_min_y = p_1.y + 30
ll_max_y = p_1.y + p_1.height - 30

ll_x = ll_min_x
ll_y = ll_min_y
for li_i = 1 to ii_row_count
	iuo_st[li_i] = create uo_st
	iuo_st[li_i].ii_index = li_i
	iuo_st[li_i].iw_parent = this	
	iuo_st[li_i].text = ids_content.GetItemString(li_i, 'content_description')
	iuo_st[li_i].is_picture = gn_appman.is_bitmap_path + is_subject + '\' + is_chapter + '\' + &
			ids_content.GetItemString(li_i, 'content_bitmap_file')	
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

public subroutine wf_demo_tail ();integer li_row
long ll_x, ll_y, ll_i
integer li_dummy[]
li_dummy = {0, 13}	

gnvo_is.of_reset_parms()
ll_x = cb_close.x + cb_close.width/2 + WorkSpaceX()
ll_y = cb_close.y + cb_close.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To Close Button', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, "Click On Close Button", false, li_dummy,handle(gnvo_is.iw_status),1027)

gnvo_is.ib_demo_selection_on = true
gnvo_is.of_set_index(1)
gnvo_is.start(4)	

end subroutine

public subroutine wf_demo ();integer li_row
long ll_x, ll_y, ll_i
integer li_dummy[]
li_dummy = {0, 13}	

gnvo_is.of_reset_parms()
ll_x = tv_1.x + 50 + WorkSpaceX()
ll_y = tv_1.y + 50 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To Treeview', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, "Click Treeview", false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0, ll_x + 40,  ll_y + 15, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To Treeview', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, "Click Treeview", false, li_dummy,0,0)

ll_x = cb_reading.x + cb_reading.width/3 + WorkSpaceX()
ll_y = cb_reading.y + cb_reading.height/3 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)
gnvo_is.of_set_parms(0, 0, ll_x,  ll_y, 10, 50, true, false, false, false, false, false, true, false, "", 1.0, 'Move Mouse Pointer To Start Button', false, li_dummy,0,0)
gnvo_is.of_set_parms(0, 0,   0,   0,  1, 2, false, false, true, true, false, false, false, false, "", 2.0, "Click Start Button", false, li_dummy,0,0)
gnvo_is.of_set_index(1)
gnvo_is.start(4)	

end subroutine

public subroutine wf_resize_picture (ref picture ap_picture, string as_filename);decimal ldc_ratio
//ap_picture.visible = false
ap_picture.OriginalSize = true
ap_picture.PictureName = as_filename
ldc_ratio = ap_picture.height/ap_picture.width
//MessageBox("ldc_ratio", string(ldc_ratio))
////ap_picture.OriginalSize = false
//if ldc_ratio > 0 then //portrait
//	ap_picture.width = il_p2_width/ldc_ratio
//else						//landscape
//	ap_picture.height = il_p2_height*ldc_ratio
//end if
//ap_picture.OriginalSize = false
//ap_picture.PictureName = as_filename
//ap_picture.visible = true
//ldc_ratio
//ap_picture
//as_filename
end subroutine

on w_reading_multi_pages.create
int iCurrent
call super::create
this.p_dimension_test=create p_dimension_test
this.cbx_fixed_size=create cbx_fixed_size
this.cb_reading=create cb_reading
this.cb_close=create cb_close
this.tv_1=create tv_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.p_2=create p_2
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_dimension_test
this.Control[iCurrent+2]=this.cbx_fixed_size
this.Control[iCurrent+3]=this.cb_reading
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.tv_1
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.p_1
end on

on w_reading_multi_pages.destroy
call super::destroy
destroy(this.p_dimension_test)
destroy(this.cbx_fixed_size)
destroy(this.cb_reading)
destroy(this.cb_close)
destroy(this.tv_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.p_2)
destroy(this.p_1)
end on

event open;long ll_chapter_id

//ll_chapter_id = long(Message.StringParm)
il_hi_light_color = RGB(255, 128, 255)
is_wavefile_path = ProfileString("Learning Helper.INI", "Resources", "wavefile", "")

il_p2_width = p_2.width
il_p2_height = p_2.height

ids_content = create datastore
ids_content.dataobject = 'd_reading'
ids_content.SetTransObject(SQLCA)

tv_1.SetReDraw(false)
wf_make_tv('d_subject_text', 0, 0, 1, 'subject_id', 'description')
tv_1.SetReDraw(true)

cbx_fixed_size.visible = false
p_2.visible = false
rb_2.post event clicked()

if gnvo_is.ib_demo_is_going then
	post wf_demo()
end if
end event

event timer;il_st_index++
ii_current_index = il_st_index
iuo_st[il_st_index].backcolor = il_hi_light_color
iuo_st[il_st_index - 1].backcolor = iuo_st[il_st_index - 1].il_default_color
if il_st_index > ii_row_count then
	timer(0)
	if gnvo_is.ib_demo_is_going then
		post wf_demo_tail()
	end if
	return
else
	if id_sound_lapse[il_st_index] = 0 then
		if gnvo_is.ib_demo_is_going then
			post wf_demo_tail()
		end if
	end if
	timer(id_sound_lapse[il_st_index])
end if
if not isnull(iuo_st[il_st_index].is_picture) and len(iuo_st[il_st_index].is_picture) > 0 then
	if cbx_fixed_size.checked then
		p_2.OriginalSize = false
		p_2.picturename = iuo_st[il_st_index].is_picture
	else
		wf_resize_picture(p_2, iuo_st[il_st_index].is_picture)
	end if
end if

end event

event close;call super::close;integer li_i
for li_i = 1 to upperbound(iuo_st)
	closeuserobject(iuo_st[li_i])
	destroy iuo_st[li_i]
next

destroy ids_content
end event

type p_dimension_test from picture within w_reading_multi_pages
integer x = 3323
integer y = 2384
integer width = 165
integer height = 36
boolean originalsize = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cbx_fixed_size from checkbox within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 1605
integer y = 20
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fixed"
boolean checked = true
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

type cb_reading from commandbutton within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 1033
integer y = 8
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

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event clicked;call super::clicked;if ii_row_count = 0 then
	MessageBox("Error", "No text available in this chapter")
	return
end if
iuo_st[ii_row_count].backcolor = iuo_st[ii_row_count].il_default_color
if (not isnull(ii_current_index)) and &
	ii_current_index > 0 and ii_current_index <= ii_row_count then
	iuo_st[ii_current_index].backcolor = iuo_st[ii_current_index].il_default_color
end if
SetPointer(HourGlass!)
sndPlaySoundA(gn_appman.is_wavefile_path + is_subject + '\' + is_wave_file, 1)
yield()
il_st_index = 1
iuo_st[il_st_index].backcolor = il_hi_light_color
if not isnull(iuo_st[il_st_index].is_picture) and len(iuo_st[il_st_index].is_picture) > 0 then
	if cbx_fixed_size.checked then
		p_2.OriginalSize = false
		p_2.picturename = iuo_st[il_st_index].is_picture
	else
		wf_resize_picture(p_2, iuo_st[il_st_index].is_picture)
	end if
end if
timer(id_sound_lapse[il_st_index])

end event

type cb_close from commandbutton within w_reading_multi_pages
integer x = 3182
integer y = 8
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

type tv_1 from treeview within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 18
integer y = 44
integer width = 955
integer height = 2040
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

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

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

type rb_1 from radiobutton within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 2423
integer y = 16
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Single Picture"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event clicked;rb_2.checked = false
p_2.visible = false
p_1.height = 1916
//cbx_fixed_size.visible = false

end event

type rb_2 from radiobutton within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 2121
integer y = 16
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Slides"
boolean checked = true
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event clicked;rb_2.checked = true
rb_1.checked = false
p_2.visible = true
p_1.height = 780
p_1.PictureName = gn_appman.is_bitmap_path + "color_reading_background.bmp"
//cbx_fixed_size.visible = true

end event

type p_2 from picture within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 1088
integer y = 920
integer width = 2373
integer height = 1152
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

type p_1 from picture within w_reading_multi_pages
event ue_paint pbm_paint
integer x = 1033
integer y = 136
integer width = 2482
integer height = 732
boolean enabled = false
string picturename = ".\color_reading_background.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

