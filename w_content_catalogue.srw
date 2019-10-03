$PBExportHeader$w_content_catalogue.srw
forward
global type w_content_catalogue from w_response
end type
type st_1 from statictext within w_content_catalogue
end type
type cb_1 from commandbutton within w_content_catalogue
end type
type dw_1 from datawindow within w_content_catalogue
end type
end forward

global type w_content_catalogue from w_response
integer width = 2062
integer height = 820
boolean titlebar = false
string title = ""
boolean controlmenu = false
st_1 st_1
cb_1 cb_1
dw_1 dw_1
end type
global w_content_catalogue w_content_catalogue

event open;call super::open;long ll_content_id
ll_content_id = long(Message.StringParm)
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(ll_content_id)
end event

on w_content_catalogue.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_content_catalogue.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type st_1 from statictext within w_content_catalogue
integer x = 32
integer y = 16
integer width = 1902
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "The selected item belongs to the below material catalogue"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_content_catalogue
integer x = 1655
integer y = 680
integer width = 347
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_content_catalogue
integer x = 50
integer y = 108
integer width = 1947
integer height = 536
integer taborder = 10
string title = "none"
string dataobject = "d_subject_chapter_content"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

