$PBExportHeader$w_export_selection.srw
forward
global type w_export_selection from w_response
end type
type cb_cancel from u_commandbutton within w_export_selection
end type
type cb_ok from u_commandbutton within w_export_selection
end type
type st_3 from statictext within w_export_selection
end type
type st_2 from statictext within w_export_selection
end type
type st_1 from statictext within w_export_selection
end type
type rb_2 from u_radiobutton within w_export_selection
end type
type rb_3 from u_radiobutton within w_export_selection
end type
type rb_1 from u_radiobutton within w_export_selection
end type
type gb_1 from u_groupbox within w_export_selection
end type
end forward

global type w_export_selection from w_response
integer width = 1714
integer height = 936
string title = "Material Exporting Selection"
cb_cancel cb_cancel
cb_ok cb_ok
st_3 st_3
st_2 st_2
st_1 st_1
rb_2 rb_2
rb_3 rb_3
rb_1 rb_1
gb_1 gb_1
end type
global w_export_selection w_export_selection

on w_export_selection.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_1=create rb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_export_selection.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_1)
destroy(this.gb_1)
end on

type cb_cancel from u_commandbutton within w_export_selection
integer x = 1280
integer y = 728
integer width = 384
integer height = 84
integer weight = 700
string text = "&Cancel"
end type

event clicked;call super::clicked;string ls_return
ls_return = "CANCEL"
post CloseWithReturn(parent, ls_return)
end event

type cb_ok from u_commandbutton within w_export_selection
integer x = 805
integer y = 728
integer width = 384
integer height = 84
integer weight = 700
string text = "&OK"
end type

event clicked;call super::clicked;string ls_return
ls_return = ""
if rb_1.checked then	ls_return = "SUBJECT"
if rb_2.checked then	ls_return = "CHAPTER"
if rb_3.checked then	ls_return = "CONTENT"
post CloseWithReturn(parent, ls_return)
end event

type st_3 from statictext within w_export_selection
integer x = 155
integer y = 588
integer width = 1097
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "subjet that the contents belong to"
boolean focusrectangle = false
end type

type st_2 from statictext within w_export_selection
integer x = 155
integer y = 388
integer width = 1431
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "the chapters and the subject that the chapters belong to"
boolean focusrectangle = false
end type

type st_1 from statictext within w_export_selection
integer x = 155
integer y = 180
integer width = 1093
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "contents underneath the subjects"
boolean focusrectangle = false
end type

type rb_2 from u_radiobutton within w_export_selection
integer x = 73
integer y = 332
integer width = 1536
integer textsize = -8
integer weight = 700
string text = "Export selected chapters with contents underneath "
boolean lefttext = false
end type

type rb_3 from u_radiobutton within w_export_selection
integer x = 73
integer y = 532
integer width = 1536
integer textsize = -8
integer weight = 700
string text = "Export selected contents with the chapter and "
boolean lefttext = false
end type

type rb_1 from u_radiobutton within w_export_selection
integer x = 73
integer y = 124
integer width = 1536
integer textsize = -8
integer weight = 700
string text = "Export selected subjects with all chapters and "
boolean checked = true
boolean lefttext = false
end type

type gb_1 from u_groupbox within w_export_selection
integer x = 32
integer y = 28
integer width = 1637
integer height = 672
integer textsize = -9
string text = "Exporting Selection"
end type

