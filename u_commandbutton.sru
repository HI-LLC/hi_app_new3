$PBExportHeader$u_commandbutton.sru
forward
global type u_commandbutton from commandbutton
end type
end forward

global type u_commandbutton from commandbutton
int Width=416
int Height=108
int TabOrder=10
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_paint pbm_paint
end type
global u_commandbutton u_commandbutton

event ue_paint;long ll_handle
//if gb_appwatch then
//	ll_handle= handle(this)
//	ScreenShot(ll_handle, "c:\AppWatch.bmp")
//end if
end event

