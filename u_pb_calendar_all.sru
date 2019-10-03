$PBExportHeader$u_pb_calendar_all.sru
$PBExportComments$Date single line edit with pop up calendar widget
forward
global type u_pb_calendar_all from UserObject
end type
type em_date from singlelineedit within u_pb_calendar_all
end type
type pb_dropdown_button from dropdownlistbox within u_pb_calendar_all
end type
type em_date_back from editmask within u_pb_calendar_all
end type
end forward

global type u_pb_calendar_all from UserObject
int Width=594
int Height=100
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=12639424
event ue_modified ( )
event ue_arrowup pbm_dwnkey
em_date em_date
pb_dropdown_button pb_dropdown_button
em_date_back em_date_back
event ue_paint pbm_paint
end type
global u_pb_calendar_all u_pb_calendar_all

type prototypes

end prototypes

type variables
string s_date1
end variables

event ue_paint;long ll_handle
//if gb_appwatch then
//	ll_handle= handle(this)
//	ScreenShot(ll_handle, "c:\AppWatch.bmp")
//end if
end event

on u_pb_calendar_all.create
this.em_date=create em_date
this.pb_dropdown_button=create pb_dropdown_button
this.em_date_back=create em_date_back
this.Control[]={this.em_date,&
this.pb_dropdown_button,&
this.em_date_back}
end on

on u_pb_calendar_all.destroy
destroy(this.em_date)
destroy(this.pb_dropdown_button)
destroy(this.em_date_back)
end on

type em_date from singlelineedit within u_pb_calendar_all
int Width=475
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Tahoma"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event losefocus;
IF Match(em_date.text, "00/+") = TRUE THEN 
	em_date.text = String ( Today() )
	
ELSEIF Match(em_date.text, "0000$" ) = TRUE THEN
	em_date.text = String(Today())
	
END IF 
end event

event modified;//Parent.Event ue_modified()
if date(em_date.text) = date('1/1/1900') then
	MessageBox('Warning', 'Invalid date!')
	this.SetFocus()
	return 1
end if

end event

type pb_dropdown_button from dropdownlistbox within u_pb_calendar_all
event ue_open_calendar ( editmask a_date )
int X=457
int Width=110
int Height=64
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_open_calendar;OpenWithParm( w_pb_calendar, a_date )
Parent.Event ue_modified()
em_date.SetFocus()
//return -1
end event

event getfocus;OpenWithParm( w_pb_calendar, em_date )
Parent.Event ue_modified()
em_date.SetFocus()
//return -1
end event

type em_date_back from editmask within u_pb_calendar_all
int X=69
int Y=364
int Width=329
int Height=76
BorderStyle BorderStyle=StyleLowered!
string Mask="m/d/yyyy"
MaskDataType MaskDataType=DateMask!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Tahoma"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;//em_date.text = String(Today())
end event

event losefocus;


IF Match(em_date.text, "00/+") = TRUE THEN 
	em_date.text = String ( Today() )
	
ELSEIF Match(em_date.text, "0000$" ) = TRUE THEN
	em_date.text = String(Today())
	
END IF 
end event

event modified;Parent.Event ue_modified()
end event

