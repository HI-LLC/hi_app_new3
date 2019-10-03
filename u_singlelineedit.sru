$PBExportHeader$u_singlelineedit.sru
forward
global type u_singlelineedit from singlelineedit
end type
end forward

global type u_singlelineedit from singlelineedit
int Width=197
int Height=74
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_enterkey pbm_keydown
end type
global u_singlelineedit u_singlelineedit

event ue_enterkey;if key=keyEnter! then event modified()
end event

