$PBExportHeader$uo_music_sheet.sru
forward
global type uo_music_sheet from userobject
end type
type p_1 from picture within uo_music_sheet
end type
type st_2 from statictext within uo_music_sheet
end type
type st_3 from statictext within uo_music_sheet
end type
type st_4 from statictext within uo_music_sheet
end type
type st_11 from statictext within uo_music_sheet
end type
type st_start from statictext within uo_music_sheet
end type
type st_end from statictext within uo_music_sheet
end type
end forward

global type uo_music_sheet from userobject
integer width = 3337
integer height = 2344
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 553648127
event ue_mousemove pbm_mousemove
p_1 p_1
st_2 st_2
st_3 st_3
st_4 st_4
st_11 st_11
st_start st_start
st_end st_end
end type
global uo_music_sheet uo_music_sheet

type variables
string is_picture_name = ""
long il_width = 0, il_height = 0
w_lesson_music iw_parent

end variables

event ue_mousemove;iw_parent.closepopupmenu()
end event

on uo_music_sheet.create
this.p_1=create p_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_11=create st_11
this.st_start=create st_start
this.st_end=create st_end
this.Control[]={this.p_1,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_11,&
this.st_start,&
this.st_end}
end on

on uo_music_sheet.destroy
destroy(this.p_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_11)
destroy(this.st_start)
destroy(this.st_end)
end on

type p_1 from picture within uo_music_sheet
event ue_mouseover ( )
event ue_paint pbm_paint
integer width = 3301
integer height = 2288
boolean originalsize = true
boolean focusrectangle = false
end type

event ue_mouseover();iw_parent.closepopupmenu()
end event

event ue_paint;//DrawGraph(long hDC,  char *FileName, RECT& rect,long SourceX,long SourceY,long StretchInd,long TransparentColor)
long ll_handle, ll_dc, ll_width, ll_height
string ls_local_filename
return
str_rect_long rect
ll_handle = handle(this)
ll_dc = GetDC(ll_handle)
PictureName = "color_white.bmp"
if pos(lower(is_picture_name),".jpg") > 0 or &
	pos(lower(is_picture_name),".bmp") > 0 or &
	pos(lower(is_picture_name),".gif") > 0 or &
	pos(lower(is_picture_name),".png") > 0 or &
	pos(lower(is_picture_name),".tif") > 0 then
	ls_local_filename = gn_appman.is_sys_temp + "\music_sheet" + String(Today(), "yymd") + right(is_picture_name, 4)
	if not FileExists(ls_local_filename) then
		f_GetCacheResourceFile(is_picture_name, ls_local_filename)
	end if
	GetGraphDim(ls_local_filename, ll_width, ll_height)
	il_width = PixelsToUnits(ll_width, XPixelsToUnits!)
	il_height = PixelsToUnits(ll_height, YPixelsToUnits!)
	rect.left = 0
	rect.top = 0
	rect.right = ll_width - 1
	rect.bottom = ll_height - 1
	DrawGraph(ll_dc,  ls_local_filename, rect,0,0,0,255)
//	st_11.visible = true
//	st_2.visible = true
//	st_3.visible = true
//	st_4.visible = true
//	st_11.BringToTop = true
//	st_2.BringToTop = true
//	st_3.BringToTop = true
//	st_4.BringToTop = true
end if	


end event

event dragdrop;integer li_x, li_y, li_current_begin_note, li_i = 0

li_x = PointerX() + p_1.x
li_y = PointerY() + p_1.y

iw_parent.ib_busy_token = true

if source = st_start then
	li_current_begin_note = iw_parent.ii_begin_note
		extPostThreadMessage(iw_parent.il_thread_id, 1031, 0, 0)
	if iw_parent.wf_set_measure_range(1, li_x, li_y) = 1 then
		extPostThreadMessage(iw_parent.il_thread_id, 1031, 0, 0)
	end if
	iw_parent.ib_busy_token = false
	st_start.BringToTop = true
end if	
if source = st_end then
	iw_parent.wf_set_measure_range(2, li_x, li_y)
	st_end.BringToTop = true
end if
sleeping(200)
iw_parent.post wf_set_token(false)

end event

event constructor;//PictureName = "color_white.bmp"
end event

event clicked;integer li_x, li_y
str_mousepos i_mousepos

GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) - iw_parent.uo_1.x - iw_parent.uo_1.uo_1.x - iw_parent.WorkSpaceX()
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) - iw_parent.uo_1.y - iw_parent.uo_1.uo_1.y - iw_parent.WorkSpaceY()

if KeyDown(KeyControl!) then // adjust begin bar
		MessageBox("debug", "Ctrl Key li_x=" + string(li_x) + " li_x=" + string(li_x) + " li_y=" + string(li_y) + " st_end.x=" + string(st_end.x) + " st_end.y=" + string(st_end.y))
	if li_x < st_end.x and li_y < st_end.y then 
		MessageBox("debug", "Ctrl Key  li_x < st_end.x and li_y < st_end.y")
				
		iw_parent.wf_set_measure_range(1, li_x, li_y)
	end if
end if
if KeyDown(KeyAlt!) then
//	MessageBox("debug", "Alt Key")
	if li_x > st_start.x and li_y > st_start.y then // adjust end bar 
		iw_parent.wf_set_measure_range(2, li_x, li_y)
	end if
end if


end event

event doubleclicked;integer li_x, li_y
str_mousepos i_mousepos
GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) - x - iw_parent.uo_1.x - iw_parent.uo_1.uo_1.x - iw_parent.WorkSpaceX()
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) - y - iw_parent.uo_1.y - iw_parent.uo_1.uo_1.y - iw_parent.WorkSpaceY()

iw_parent.wf_goto_rec(li_x, li_y)


end event

type st_2 from statictext within uo_music_sheet
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

type st_3 from statictext within uo_music_sheet
integer x = 2235
integer y = 140
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

type st_4 from statictext within uo_music_sheet
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

type st_11 from statictext within uo_music_sheet
integer x = 2354
integer y = 156
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

type st_start from statictext within uo_music_sheet
integer x = 2578
integer width = 41
integer height = 76
string dragicon = "Information!"
boolean dragauto = true
string pointer = "HyperLink!"
long backcolor = 65280
borderstyle borderstyle = styleraised!
end type

type st_end from statictext within uo_music_sheet
integer x = 2647
integer width = 41
integer height = 60
string dragicon = "Hand!"
boolean dragauto = true
string pointer = "HyperLink!"
long backcolor = 255
borderstyle borderstyle = styleraised!
end type

