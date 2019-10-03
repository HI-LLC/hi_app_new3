$PBExportHeader$w_picture.srw
forward
global type w_picture from w_response
end type
type p_bitmap from picture within w_picture
end type
type cb_close from u_commandbutton within w_picture
end type
end forward

global type w_picture from w_response
integer width = 3392
integer height = 1884
string title = "Picture"
long backcolor = 79741120
p_bitmap p_bitmap
cb_close cb_close
end type
global w_picture w_picture

forward prototypes
public subroutine wf_set_dimension ()
end prototypes

public subroutine wf_set_dimension ();width = 3*p_bitmap.x + p_bitmap.width
height = 2*p_bitmap.y + p_bitmap.height + 2*cb_close.height
cb_close.x = p_bitmap.x + p_bitmap.width - cb_close.width
cb_close.y = height - 2*cb_close.height

end subroutine

event open;string as_file_name

as_file_name = Message.StringParm
//MessageBox("Debug", as_file_name)

p_bitmap.PictureName = as_file_name

post wf_set_dimension()

end event

on w_picture.create
int iCurrent
call super::create
this.p_bitmap=create p_bitmap
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_bitmap
this.Control[iCurrent+2]=this.cb_close
end on

on w_picture.destroy
call super::destroy
destroy(this.p_bitmap)
destroy(this.cb_close)
end on

type p_bitmap from picture within w_picture
event ue_paint pbm_paint
integer x = 27
integer y = 24
integer width = 3328
integer height = 1624
boolean bringtotop = true
boolean originalsize = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

type cb_close from u_commandbutton within w_picture
integer x = 2935
integer y = 1672
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string text = "&Close"
end type

event clicked;close(parent)
end event

