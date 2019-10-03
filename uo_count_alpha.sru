$PBExportHeader$uo_count_alpha.sru
forward
global type uo_count_alpha from uo_count
end type
end forward

global type uo_count_alpha from uo_count
integer width = 192
integer height = 184
boolean dragauto = true
end type
global uo_count_alpha uo_count_alpha

forward prototypes
public subroutine of_write_alpha (string as_alpha)
end prototypes

public subroutine of_write_alpha (string as_alpha);st_number.text = as_alpha
st_number.BringToTop = True
end subroutine

on uo_count_alpha.create
call super::create
end on

on uo_count_alpha.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;if source.classname() = 'uo_count_alpha' then
	iw_parent.event dragdrop(source)
end if
end event

event mousemove;iw_parent.event mousemove(flags, xpos, ypos)
end event

type st_number from uo_count`st_number within uo_count_alpha
event mousemove pbm_mousemove
event key pbm_keydown
boolean visible = true
integer x = 9
integer y = 4
integer width = 174
integer height = 172
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

if not isvalid(DraggedObject()) then return
if DraggedObject().classname() = 'st_number' and lw_tmp.ib_drag = false then
	GetCursorPos(i_mousepos)
	li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!) - lw_tmp.WorkSpaceX()
	li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!) - lw_tmp.WorkSpaceY()
	drag(End!)
	lw_tmp.st_1.x = li_x
	lw_tmp.st_1.y = li_y
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

event st_number::key;return GetParent().dynamic event key(key, keyflags)
end event

event st_number::dragdrop;call super::dragdrop;if source.classname() = 'uo_count_alpha' then
	parent.event dragdrop(source)
end if
end event

type p_1 from uo_count`p_1 within uo_count_alpha
boolean visible = false
boolean enabled = false
end type

type oval_1 from uo_count`oval_1 within uo_count_alpha
end type

