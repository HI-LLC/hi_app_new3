$PBExportHeader$uo_lv_item.sru
forward
global type uo_lv_item from userobject
end type
type object_label from statictext within uo_lv_item
end type
type p_1 from picture within uo_lv_item
end type
end forward

global type uo_lv_item from userobject
integer width = 667
integer height = 612
long backcolor = 79741120
event mousemove pbm_mousemove
event key pbm_keydown
object_label object_label
p_1 p_1
end type
global uo_lv_item uo_lv_item

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

public subroutine of_set_radius (integer ai_height, integer ai_width);height = ai_height
width = ai_width 
p_1.height = ai_height
p_1.width = ai_width
ii_height = ai_height
ii_width = ai_width
p_1.visible = true
end subroutine

public subroutine wf_object_zoom (real ar_ratio);height = height*ar_ratio
width = width*ar_ratio
p_1.height = p_1.height*ar_ratio
object_label.height = object_label.height*ar_ratio
p_1.width = p_1.width*ar_ratio
object_label.width = object_label.width*ar_ratio

ii_height = height
ii_width = width


end subroutine

on uo_lv_item.create
this.object_label=create object_label
this.p_1=create p_1
this.Control[]={this.object_label,&
this.p_1}
end on

on uo_lv_item.destroy
destroy(this.object_label)
destroy(this.p_1)
end on

event constructor;p_1.visible = true
ii_height = height
ii_width = width
//p_1.height = height
//p_1.width= width
il_backcolor = backcolor
end event

type object_label from statictext within uo_lv_item
integer y = 520
integer width = 667
integer height = 92
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Object Label"
alignment alignment = center!
boolean border = true
long bordercolor = 8388608
boolean focusrectangle = false
end type

event doubleclicked;MessageBox("ii_index", ii_index)
end event

type p_1 from picture within uo_lv_item
event mousemove pbm_mousemove
event key pbm_keydown
integer width = 667
integer height = 516
boolean focusrectangle = false
end type

event doubleclicked;long ll_student_id
w_student_list_for_lesson_play lw_slp
w_student_lesson_list lw_sll
if iw_parent.ClassName() = "w_student_list_for_lesson_play" then
	lw_slp = iw_parent
	gn_appman.il_student_id = lw_slp.ids_group_student.GetItemNumber(ii_index, "student_id")
	OpenSheetWithParm(w_student_lesson_list, "", gn_appman.iw_frame, 0, original!)
end if	

if iw_parent.ClassName() = "w_student_lesson_list" then
	lw_sll = iw_parent
	w_student_lesson_list.wf_load_and_play_lesson(ii_index)
end if
end event

