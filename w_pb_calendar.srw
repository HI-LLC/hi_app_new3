$PBExportHeader$w_pb_calendar.srw
$PBExportComments$pop-up calendar window; all powerbuilder (not OLE)
forward
global type w_pb_calendar from Window
end type
type st_1 from statictext within w_pb_calendar
end type
type uo_1 from u_pb_calendar within w_pb_calendar
end type
type ln_1 from line within w_pb_calendar
end type
end forward

type mousepos from structure
	long		xpos
	long		ypos
end type

global type w_pb_calendar from Window
int X=834
int Y=362
int Width=2717
int Height=1238
long BackColor=79741120
WindowType WindowType=response!
st_1 st_1
uo_1 uo_1
ln_1 ln_1
end type
global w_pb_calendar w_pb_calendar

type prototypes
FUNCTION boolean GetCursorPos(ref structure mousepos) LIBRARY "user32.dll"
end prototypes

type variables
private:
mousepos i_mousepos



end variables

event open;/*
Coded By:	Marc J. Mataya (many alterations from PowerBuilder Shipped Examples)
				July 18, 1997
				mmataya@webcreations.com, (704)388-5315
				NationsBank; Charlotte, NC
				
				Rand Borton; Modified key control over calendar scrolling
				Chiron

Input Parameter:  message.powerobjectparm
The uo_1 constructor event will get hit first.  This is where we will
determine the object type (dw,mle,sle,st,etc.) then extract the current
date from the object, then pop open this window with that date using today()
as the default date.  
Also, we want to position this window to appear where the mouse resides, 
similar to the popup menu method.  It will account for the bottom of the screen
and a start menu toolbar + an office toolbar menu being on the bottom.
Potential Pitfall:
If the user keeps the Win95 Start Bar on the right side, it will get cut off.
	 This will align itself up against the right side of the screen.

The input parm is being sent by the following code:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
COPY THE FOLLOWING CODE TO THE RBUTTONDOWN OR DOUBLECLICK
EVENT OF ANY OBJECT THAT ASKS FOR A DATE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For text type objects like sle, mle, em, st, etc., use:
//this.setfocus()  // not necessary but you may want to use this since rightclicking will not set focus
OpenWithParm(w_pb_calendar,this)
Return 1  // disables the PB system popup with Cut, Paste, etc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OR for DataWindows use:
String ls
if dwo.name = 'date_began' or dwo.name = '<field name>' then
	AcceptText()
	OpenWithParm(w_pb_calendar,dwo)
	ls = dwo.name
	// The DWO gets filled by this user object automatically, however,
	//    returning the date as a string 'mm/dd/yyyy' gives you more control of
	//    how it should be formatted or converted to fit in a date dwo, string dwo, etc.
	This.SetItem(row,ls,date(message.stringparm))
	AcceptText()
	Return 1  // disables the PB system popup with Cut, Paste, etc.
end if
*/

string ls
integer i

this.width = uo_1.width
this.height = uo_1.height

// Allows the user object to reference this window without hard coding
//		a window name (can't use PARENT in the uo_1 code because it has none).
//    The UO will CloseWithReturn(i_window,dateparm).
uo_1.i_window = this

// Get the pointer position using the LOCAL External Function...
GetCursorPos(i_mousepos)
// Now check to see if it will pop it up off of the screen
environment l_env
GetEnvironment(l_env)
// if the window will get cut off on the right make it bump up against the edge
if (i_mousepos.xpos + UnitsToPixels(this.width,XUnitsToPixels!)) > l_env.screenwidth then
	this.x = PixelsToUnits(l_env.screenwidth,XPixelsToUnits!) - this.width
else
	this.x = PixelsToUnits(i_mousepos.xpos,XPixelsToUnits!)
end if
// if the window will get chopped off at the bottom, make the bottom left edge be where the pointer is sitting.
// NOTE:  This object assumes that the user has the start bar and an office toolbar sitting at the bottom
if (i_mousepos.ypos + UnitsToPixels(this.height,yUnitsToPixels!)) + 50 > l_env.screenheight then
	//this.y = PixelsToUnits(l_env.screenheight,yPixelsToUnits!) - this.height 
	this.y = PixelsToUnits(i_mousepos.ypos,yPixelsToUnits!) - this.height
else
	this.y = PixelsToUnits(i_mousepos.ypos,yPixelsToUnits!)
end if

end event

on w_pb_calendar.create
this.st_1=create st_1
this.uo_1=create uo_1
this.ln_1=create ln_1
this.Control[]={this.st_1,&
this.uo_1,&
this.ln_1}
end on

on w_pb_calendar.destroy
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.ln_1)
end on

event key;// Allows user to get out without clicking anything
if key = KeyEscape! then
	uo_1.post event ue_close()
//	closewithreturn(this, uo_1.dateparm)
end if

end event

type st_1 from statictext within w_pb_calendar
int X=22
int Y=1069
int Width=1605
int Height=77
boolean Enabled=false
string Text="Rightclick over here for w_calendar window script ==>"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from u_pb_calendar within w_pb_calendar
int X=0
int Y=0
int Height=1037
int TabOrder=1
long BackColor=12632256
end type

on uo_1.destroy
call u_pb_calendar::destroy
end on

type ln_1 from line within w_pb_calendar
boolean Enabled=false
int BeginX=29
int BeginY=1050
int EndX=2531
int EndY=1050
int LineThickness=6
long LineColor=16777215
end type

