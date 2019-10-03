$PBExportHeader$w_related_items.srw
forward
global type w_related_items from w_response
end type
type cb_2 from commandbutton within w_related_items
end type
type cb_1 from commandbutton within w_related_items
end type
type dw_1 from datawindow within w_related_items
end type
end forward

global type w_related_items from w_response
integer width = 2990
integer height = 1952
boolean titlebar = false
string title = ""
boolean controlmenu = false
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_related_items w_related_items

event open;call super::open;any la_parm
long ll_item[], ll_row
visible = false
ll_item[1] = 1
string ls_dataobject
gn_appman.of_get_parm("Argument List", la_parm)
ll_item = la_parm
gn_appman.of_get_parm("Dataobject",  la_parm)
ls_dataobject = la_parm
if ls_dataobject = "d_related_lesson" then
	dw_1.width = dw_1.width - 200
	width = width - 200
	cb_1.x = cb_1.x - 100
	cb_2.x = cb_2.x -100
end if
dw_1.DataObject = ls_dataobject
dw_1.SetTransObject(SQLCA)
if dw_1.Retrieve(ll_item) > 0 then
	visible = true
else
	post close(this)
end if
end event

on w_related_items.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_related_items.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_related_items
integer x = 1778
integer y = 1668
integer width = 347
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;closeWithReturn(parent, "0")
end event

type cb_1 from commandbutton within w_related_items
integer x = 736
integer y = 1668
integer width = 617
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continue &Deleting"
end type

event clicked;closeWithReturn(parent, "1")
end event

type dw_1 from datawindow within w_related_items
integer x = 50
integer y = 40
integer width = 2875
integer height = 1568
integer taborder = 10
string title = "none"
string dataobject = "d_related_lesson_content"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_paint pbm_paint
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

