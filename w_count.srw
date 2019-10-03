$PBExportHeader$w_count.srw
forward
global type w_count from w_child
end type
type p_1 from picture within w_count
end type
type oval_1 from oval within w_count
end type
end forward

global type w_count from w_child
integer width = 581
integer height = 516
long backcolor = 79741120
event mousemove pbm_mousemove
p_1 p_1
oval_1 oval_1
end type
global w_count w_count

type variables
integer ii_index, ii_width, ii_height
window iw_parent, iw_dragwithin
string is_bean_DragIcon

end variables

forward prototypes
public subroutine of_set_radius (integer ai_height, integer ai_width)
end prototypes

public subroutine of_set_radius (integer ai_height, integer ai_width);height = ai_height
width = ai_width 
oval_1.height = ai_height
oval_1.width = ai_width
p_1.height = ai_height
p_1.width = ai_width
ii_height = ai_height
ii_width = ai_width
p_1.visible = true
end subroutine

on w_count.create
int iCurrent
call super::create
this.p_1=create p_1
this.oval_1=create oval_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.oval_1
end on

on w_count.destroy
call super::destroy
destroy(this.p_1)
destroy(this.oval_1)
end on

event constructor;p_1.visible = true
ii_height = height
ii_width = width
p_1.height = height
p_1.width= width
end event

type p_1 from picture within w_count
event mousemove pbm_mousemove
integer width = 270
integer height = 200
string dragicon = ".\Basketball_new4.ico"
boolean focusrectangle = false
end type

type oval_1 from oval within w_count
boolean visible = false
long linecolor = 33554431
integer linethickness = 4
long fillcolor = 33554432
integer width = 133
integer height = 116
end type

