$PBExportHeader$w_text_file_field_selection.srw
forward
global type w_text_file_field_selection from w_response
end type
type cb_ok from u_commandbutton within w_text_file_field_selection
end type
type cb_cancel from u_commandbutton within w_text_file_field_selection
end type
type cbx_content_details from checkbox within w_text_file_field_selection
end type
type cbx_content_desc from checkbox within w_text_file_field_selection
end type
type cbx_chapter_details from checkbox within w_text_file_field_selection
end type
type cbx_chapter_desc from checkbox within w_text_file_field_selection
end type
type gb_1 from groupbox within w_text_file_field_selection
end type
type gb_2 from groupbox within w_text_file_field_selection
end type
end forward

global type w_text_file_field_selection from w_response
integer width = 1138
integer height = 676
string title = "Text File Field Selection"
cb_ok cb_ok
cb_cancel cb_cancel
cbx_content_details cbx_content_details
cbx_content_desc cbx_content_desc
cbx_chapter_details cbx_chapter_details
cbx_chapter_desc cbx_chapter_desc
gb_1 gb_1
gb_2 gb_2
end type
global w_text_file_field_selection w_text_file_field_selection

on w_text_file_field_selection.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cbx_content_details=create cbx_content_details
this.cbx_content_desc=create cbx_content_desc
this.cbx_chapter_details=create cbx_chapter_details
this.cbx_chapter_desc=create cbx_chapter_desc
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cbx_content_details
this.Control[iCurrent+4]=this.cbx_content_desc
this.Control[iCurrent+5]=this.cbx_chapter_details
this.Control[iCurrent+6]=this.cbx_chapter_desc
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
end on

on w_text_file_field_selection.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cbx_content_details)
destroy(this.cbx_content_desc)
destroy(this.cbx_chapter_details)
destroy(this.cbx_chapter_desc)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type cb_ok from u_commandbutton within w_text_file_field_selection
integer x = 206
integer y = 468
integer width = 384
integer height = 84
integer taborder = 20
integer weight = 700
string text = "&OK"
end type

event clicked;call super::clicked;string ls_return, ls_chapter_desc, ls_chapter_details, ls_content_desc, ls_content_details 
ls_return = ""
if cbx_chapter_desc.checked then
	ls_chapter_desc = "1"
else
	ls_chapter_desc = "0"
end if
if cbx_chapter_details.checked then
	ls_chapter_details = "1"
else
	ls_chapter_details = "0"
end if
if cbx_content_desc.checked then
	ls_content_desc = "1"
else
	ls_content_desc = "0"
end if
if cbx_content_details.checked then
	ls_content_details = "1"
else
	ls_content_details = "0"
end if
ls_return = ls_chapter_desc + ls_chapter_details + ls_content_desc + ls_content_details 
if left(ls_return, 2) = "00" then
	MessageBox("Error", "No Field(s) Selected For Chapter!")
	return
end if
if right(ls_return, 2) = "00" then
	MessageBox("Error", "No Field(s) Selected For Content!")
	return
end if
post CloseWithReturn(parent, ls_return)
end event

type cb_cancel from u_commandbutton within w_text_file_field_selection
integer x = 681
integer y = 468
integer width = 384
integer height = 84
integer taborder = 20
integer weight = 700
string text = "&Cancel"
end type

event clicked;call super::clicked;string ls_return
ls_return = "CANCEL"
post CloseWithReturn(parent, ls_return)
end event

type cbx_content_details from checkbox within w_text_file_field_selection
integer x = 581
integer y = 304
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Details"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cbx_content_desc from checkbox within w_text_file_field_selection
integer x = 133
integer y = 304
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Description"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cbx_chapter_details from checkbox within w_text_file_field_selection
integer x = 581
integer y = 88
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Details"
borderstyle borderstyle = stylelowered!
end type

type cbx_chapter_desc from checkbox within w_text_file_field_selection
integer x = 133
integer y = 88
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Description"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_text_file_field_selection
integer x = 41
integer y = 24
integer width = 1033
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Chapter"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_text_file_field_selection
integer x = 41
integer y = 236
integer width = 1033
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Content"
borderstyle borderstyle = stylelowered!
end type

