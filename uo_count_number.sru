$PBExportHeader$uo_count_number.sru
forward
global type uo_count_number from uo_count
end type
end forward

global type uo_count_number from uo_count
integer height = 168
boolean dragauto = true
event lbuttonup pbm_lbuttonup
end type
global uo_count_number uo_count_number

forward prototypes
public subroutine of_write_number (integer ai_number)
end prototypes

event lbuttonup;//w_lesson_numbermatch_count lw_tmp
//lw_tmp = iw_parent.ParentWindow()
//lw_tmp.st_1.BringToTop = false

end event

public subroutine of_write_number (integer ai_number);st_number.text = string(ai_number)
st_number.BringToTop = True
//MessageBox(this.ClassName(), string(ai_number))
end subroutine

on uo_count_number.create
call super::create
end on

on uo_count_number.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;//MessageBox("uo_count_number dragdrop: source.classname() ", source.classname())
if source.classname() = 'uo_count_number' then
	iw_parent.event dragdrop(source)
	return
end if
//if source.classname() = 'st_number'then
//	iw_parent.event dragdrop(Parent)
//	return
//end if
end event

event mousemove;//MessageBox("uo_count_number mousemove: DraggedObject().classname() ", DraggedObject().classname())
//
//DraggedObject().classname()
iw_parent.event mousemove(flags, xpos, ypos)
end event

type st_number from uo_count`st_number within uo_count_number
event mousemove pbm_mousemove
event key pbm_keydown
boolean visible = true
integer x = 9
integer y = 8
integer width = 192
integer height = 152
boolean dragauto = true
integer textsize = -26
integer weight = 700
fontpitch fontpitch = fixed!
long textcolor = 255
long backcolor = 65535
boolean enabled = true
string text = "88"
end type

event st_number::mousemove;w_lesson lw_tmp
str_mousepos i_mousepos
integer li_x, li_y
lw_tmp = iw_parent.ParentWindow()
//MessageBox("uo_count_number mousemove: DraggedObject().classname()", DraggedObject().classname())
if not isvalid(DraggedObject()) then return
if DraggedObject().classname() = 'st_number' and lw_tmp.ib_drag = false then
	GetCursorPos(i_mousepos)
	li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) - lw_tmp.WorkSpaceX()// - parent.width/2
	li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) - lw_tmp.WorkSpaceY()// - parent.height/2
	drag(End!)
//	MessageBox("debug classname B", lw_tmp.ClassName())
	lw_tmp.st_1.x = li_x - PointerX()
	lw_tmp.st_1.y = li_y - PointerY()
	lw_tmp.ii_x0 = li_x
	lw_tmp.ii_y0 = li_y
	lw_tmp.st_1.text = st_number.text
	lw_tmp.st_1.width = width
	lw_tmp.st_1.height = height
	lw_tmp.st_1.visible = true
	lw_tmp.st_1.BringToTop = true
	lw_tmp.ib_drag = true
	parent.width = 1
	parent.height = 1
	parent.drag(Begin!)
	parent.visible = false	
	lw_tmp.st_1.BringToTop = true
else
	parent.event mousemove(flags, xpos, ypos)
end if

end event

event st_number::key;MessageBox("uo_count", "key")
return parent.event key(key, keyflags)
end event

event st_number::dragdrop;call super::dragdrop;//MessageBox("uo_count_number dragdrop: source.classname()", source.classname())

if source.classname() = 'uo_count_number' then
	parent.event dragdrop(source)
	return
end if

//if source.classname() = 'st_number' then
//	parent.event dragdrop(parent)
//end if
end event

event st_number::dragwithin;call super::dragwithin;w_lesson lw_tmp
str_mousepos i_mousepos
integer li_x, li_y
lw_tmp = iw_parent.ParentWindow()
//MessageBox("uo_count_number mousemove: DraggedObject().classname()", DraggedObject().classname())
if not isvalid(source) then return
if source.classname() = 'st_number' and lw_tmp.ib_drag = false then
	GetCursorPos(i_mousepos)
	li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) - lw_tmp.WorkSpaceX()// - parent.width/2
	li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) - lw_tmp.WorkSpaceY()// - parent.height/2
	drag(End!)
//	MessageBox("debug classname B", lw_tmp.ClassName())
	lw_tmp.st_1.x = li_x - PointerX()
	lw_tmp.st_1.y = li_y - PointerY()
	lw_tmp.ii_x0 = li_x
	lw_tmp.ii_y0 = li_y
	lw_tmp.st_1.text = st_number.text
	lw_tmp.st_1.width = width
	lw_tmp.st_1.height = height
	lw_tmp.st_1.visible = true
	lw_tmp.st_1.BringToTop = true
	lw_tmp.ib_drag = true
	parent.width = 1
	parent.height = 1
	parent.drag(Begin!)
	parent.visible = false	
	lw_tmp.st_1.BringToTop = true
end if


end event

type p_1 from uo_count`p_1 within uo_count_number
boolean visible = false
boolean enabled = false
end type

type oval_1 from uo_count`oval_1 within uo_count_number
end type

