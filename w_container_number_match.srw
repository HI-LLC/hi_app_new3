$PBExportHeader$w_container_number_match.srw
forward
global type w_container_number_match from w_container
end type
type st_1 from statictext within w_container_number_match
end type
end forward

global type w_container_number_match from w_container
integer width = 1733
integer height = 868
long backcolor = 8388608
st_1 st_1
end type
global w_container_number_match w_container_number_match

type variables

end variables

on w_container_number_match.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_container_number_match.destroy
call super::destroy
destroy(this.st_1)
end on

event dragdrop;call super::dragdrop;string ls_dragobject_name, ls_dragicon
//w_lesson_numbermatch_count lw_tmp
w_lesson lw_tmp
integer li_count
long li_y
long li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
uo_count_number iuo_tmp
lw_tmp = ParentWindow()
if source.classname() = 'uo_count_number' or source.classname() = 'st_number' then
	if source.classname() = 'uo_count_number' then
		iuo_tmp = source
	else
		iuo_tmp = source.GetParent()
	end if
	lx = source.x 
	ly = source.y 
	iuo_tmp.visible = true
	iuo_tmp.BringToTop = true
	iuo_tmp.width = iuo_tmp.ii_width
	iuo_tmp.height = iuo_tmp.ii_height		
	iuo_tmp.Drag(End!)
	lw_tmp.st_1.visible = false // virtual drag object
	lw_tmp.ib_drag = false
//	if iuo_tmp.iw_parent <> this then // from other bucket
//		if ib_target then
//			li_count = long(iuo_tmp.st_number.text)
//			MessageBox("li_count", string(li_count))
//			if lw_tmp.dynamic wf_check_number(li_count) then
//				this.st_1.text = string(li_count)
//				this.st_1.visible = true
//				lw_tmp.wf_response(true)
//			else
//				lw_tmp.wf_response(false)
//			end if
//		end if
//	end if
	lw_tmp.wf_dragdrop(source)
end if

end event

event dragwithin;call super::dragwithin;w_lesson lw_tmp
long li_x, li_y
GetCursorPos(i_mousepos)
lw_tmp = ParentWindow()
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
//li_x = li_x - ParentWindow().x - ParentWindow().WorkSpaceX() - 100
//li_y = li_y - ParentWindow().y - ParentWindow().WorkSpaceY() - 100
li_x = li_x - ParentWindow().WorkSpaceX() 
li_y = li_y -  ParentWindow().WorkSpaceY() 
lw_tmp.wf_mousemove(li_x, li_y)

end event

type p_1 from w_container`p_1 within w_container_number_match
event ue_key pbm_dwnkey
integer x = 0
integer y = 0
string picturename = ""
end type

event p_1::ue_key;return parent.event key(key, keyflags)
end event

type st_1 from statictext within w_container_number_match
boolean visible = false
integer x = 23
integer y = 48
integer width = 366
integer height = 336
boolean bringtotop = true
integer textsize = -48
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 8388608
string text = "?"
alignment alignment = center!
boolean focusrectangle = false
end type

event dragdrop;parent.event dragdrop(source)
end event

event dragwithin;parent.event dragwithin(source)
end event

