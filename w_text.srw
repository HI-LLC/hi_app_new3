$PBExportHeader$w_text.srw
forward
global type w_text from w_lm_ancestor
end type
type mle_1 from multilineedit within w_text
end type
type cb_save from commandbutton within w_text
end type
type cb_cancel from commandbutton within w_text
end type
end forward

global type w_text from w_lm_ancestor
int Width=2482
int Height=1680
WindowType WindowType=response!
boolean TitleBar=true
string Title="Chapter Details"
long BackColor=79741120
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
mle_1 mle_1
cb_save cb_save
cb_cancel cb_cancel
end type
global w_text w_text

type variables
string is_original_text
end variables

event open;is_original_text = Message.StringParm
mle_1.text = is_original_text

end event

on w_text.create
int iCurrent
call super::create
this.mle_1=create mle_1
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_text.destroy
call super::destroy
destroy(this.mle_1)
destroy(this.cb_save)
destroy(this.cb_cancel)
end on

type mle_1 from multilineedit within w_text
int X=82
int Y=48
int Width=2304
int Height=1376
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_save from commandbutton within w_text
int X=1678
int Y=1464
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="&Save"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, mle_1.text)
end event

type cb_cancel from commandbutton within w_text
int X=2098
int Y=1464
int Width=279
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, is_original_text)
end event

