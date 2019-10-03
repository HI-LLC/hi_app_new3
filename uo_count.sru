$PBExportHeader$uo_count.sru
forward
global type uo_count from userobject
end type
type st_number from statictext within uo_count
end type
type p_1 from picture within uo_count
end type
type oval_1 from oval within uo_count
end type
end forward

global type uo_count from userobject
integer width = 215
integer height = 164
long backcolor = 79741120
event mousemove pbm_mousemove
event key pbm_keydown
st_number st_number
p_1 p_1
oval_1 oval_1
end type
global uo_count uo_count

type variables
integer ii_index, ii_width, ii_height, ii_x, ii_y
long il_backcolor
window iw_parent, iw_dragwithin
string is_bean_DragIcon
end variables

forward prototypes
public subroutine of_set_radius (integer ai_height, integer ai_width)
public subroutine wf_object_zoom (real ar_ratio)
end prototypes

event key;w_container lw_parent
lw_parent = GetParent()
return lw_parent.event key(key, keyflags)
end event

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

public subroutine wf_object_zoom (real ar_ratio);height = height*ar_ratio
width = width*ar_ratio
p_1.height = p_1.height*ar_ratio
st_number.height = st_number.height*ar_ratio
p_1.width = p_1.width*ar_ratio
st_number.width = st_number.width*ar_ratio

ii_height = height
ii_width = width


end subroutine

on uo_count.create
this.st_number=create st_number
this.p_1=create p_1
this.oval_1=create oval_1
this.Control[]={this.st_number,&
this.p_1,&
this.oval_1}
end on

on uo_count.destroy
destroy(this.st_number)
destroy(this.p_1)
destroy(this.oval_1)
end on

event constructor;p_1.visible = true
ii_height = height
ii_width = width
p_1.height = height
p_1.width= width
il_backcolor = backcolor
end event

type st_number from statictext within uo_count
boolean visible = false
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type p_1 from picture within uo_count
event mousemove pbm_mousemove
event key pbm_keydown
integer width = 270
integer height = 200
boolean focusrectangle = false
end type

event key;return parent.event key(key, keyflags)
end event

type oval_1 from oval within uo_count
boolean visible = false
long linecolor = 33554431
integer linethickness = 4
long fillcolor = 33554432
integer width = 133
integer height = 116
end type

