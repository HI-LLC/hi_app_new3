$PBExportHeader$w_lesson_selection_lv.srw
forward
global type w_lesson_selection_lv from w_lesson_selection
end type
type lv_1 from listview within w_lesson_selection_lv
end type
type p_1 from picture within w_lesson_selection_lv
end type
end forward

global type w_lesson_selection_lv from w_lesson_selection
integer width = 3323
integer height = 1912
lv_1 lv_1
p_1 p_1
end type
global w_lesson_selection_lv w_lesson_selection_lv

on w_lesson_selection_lv.create
int iCurrent
call super::create
this.lv_1=create lv_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_1
this.Control[iCurrent+2]=this.p_1
end on

on w_lesson_selection_lv.destroy
call super::destroy
destroy(this.lv_1)
destroy(this.p_1)
end on

event open;call super::open;long ll_parent_handle
ll_parent_handle = lv_1.AddItem("Object Identification", 1)
ll_parent_handle = lv_1.AddItem("Object Matching", 2)
ll_parent_handle = lv_1.AddItem("Object Grouping", 3)
ll_parent_handle = lv_1.AddItem("Object Comparison", 9)
ll_parent_handle = lv_1.AddItem("Spelling", 4)
ll_parent_handle = lv_1.AddItem("Sentence Composing", 5)
ll_parent_handle = lv_1.AddItem("Counting", 6)
ll_parent_handle = lv_1.AddItem("Addition", 7)
ll_parent_handle = lv_1.AddItem("Subtraction", 8)
end event

type cb_close from w_lesson_selection`cb_close within w_lesson_selection_lv
integer x = 2862
integer y = 1700
end type

type dw_1 from w_lesson_selection`dw_1 within w_lesson_selection_lv
integer width = 128
integer height = 64
end type

type lv_1 from listview within w_lesson_selection_lv
integer x = 5
integer y = 12
integer width = 3264
integer height = 1676
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string largepicturename[] = {".\Object ID.bmp",".\Matching.bmp",".\Grouping.bmp",".\Spelling2.bmp",".\Sentence Composing2.bmp",".\Counting.bmp",".\Addition.bmp",".\Subtraction.bmp",".\Scale Comparison.bmp",""}
long largepicturemaskcolor = 536870912
string smallpicturename[] = {""}
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event clicked;dwobject ldwo
choose case index
	case 1 // Object ID
		dw_1.event buttonclicked(1, 0, ldwo)
	case 2 // Object Mathcing
		dw_1.event buttonclicked(4, 0, ldwo)
	case 3 // Object Grouping
		dw_1.event buttonclicked(5, 0, ldwo)
	case 4 // Object Comparison
		dw_1.event buttonclicked(2, 0, ldwo)
	case 5 // Spelling
		dw_1.event buttonclicked(10, 0, ldwo)
	case 6 // Sentence
		dw_1.event buttonclicked(11, 0, ldwo)
	case 7 // Counting
		dw_1.event buttonclicked(7, 0, ldwo)
	case 8 // Addition
		dw_1.event buttonclicked(8, 0, ldwo)
	case 9 // Subtraction
		dw_1.event buttonclicked(9, 0, ldwo)
end choose

//long il_method_id_list_from[] = {2, 3, 17, 25, 16, 15, 14, 23, 24, 21, 22}
//long il_method_id_list_to[] = {2, 13, 19, 25, 16, 15, 14, 23, 24, 21, 22}
//string is_method_description_list[] = {"Object Identification", "Object Comparison", "Scale Comparison", "Object Matching", &
//		"Object Grouping", "Drag-drop Counting", "Number-mathcing Counting", "Addition", "Subtraction", &
//		"Unscramble Words (spellig)", "Unscramble Sentences (sentence composing)"}


end event

type p_1 from picture within w_lesson_selection_lv
integer x = 2418
integer y = 1104
integer width = 795
integer height = 548
boolean bringtotop = true
string picturename = "C:\PB Apps\Learning Helper\Light Ends\LogoAnim.gif"
boolean focusrectangle = false
end type

