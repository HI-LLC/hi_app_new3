$PBExportHeader$w_play_avi.srw
forward
global type w_play_avi from window
end type
type ole_1 from olecustomcontrol within w_play_avi
end type
end forward

global type w_play_avi from window
boolean visible = false
integer width = 2565
integer height = 1624
windowtype windowtype = response!
string icon = ".\LearningHelper.ico"
ole_1 ole_1
end type
global w_play_avi w_play_avi

type variables
string is_path
boolean MoviePlaying = false
long il_counter = 0
window iw_parent
end variables

on w_play_avi.create
this.ole_1=create ole_1
this.Control[]={this.ole_1}
end on

on w_play_avi.destroy
destroy(this.ole_1)
end on

event open;string ls_videofile
ls_videofile = Message.StringParm
is_path = gn_appman.is_videofile_path + ls_videofile

iw_parent = ParentWindow()

if not FileExists (is_path) then
	MessageBox("Error", "The video file, " + is_path + ", does not exist!")
	post close(this)
else
	ole_1.object.FileName = is_path
	timer(2, this)
	MoviePlaying = true
end if


end event

event timer;long ll_x, ll_y
long ll_cur_x, ll_cur_y
real ir_x_ratio, ir_y_ratio 
environment env
GetEnvironment (env)

ir_x_ratio = 65535/env.ScreenWidth
ir_y_ratio = 65535/env.ScreenHeight

ll_x = ole_1.x + ole_1.width/2 + WorkspaceX()
ll_y = ole_1.y + ole_1.height/2 + WorkSpaceY()
ll_x = UnitsToPixels(ll_x, XUnitsToPixels!)
ll_y = UnitsToPixels(ll_y, YUnitsToPixels!)

if MoviePlaying = false then
	keybd_event(13, 0, 0, 0)	
	timer(0, this)
//else
//	timer(2, this)
//	il_counter++
//	if il_counter = 8 then
//		ole_1.object.pause()
//		ole_1.object.play()
//	end if	
//	if il_counter = 12 then
//		mouse_event(32769, ll_x*ir_x_ratio, ll_y*ir_y_ratio, 0, 0)
//		mouse_event(2, 0, 0, 0, 0)
//	end if
end if




end event

type ole_1 from olecustomcontrol within w_play_avi
event statechange ( long oldstate,  long newstate )
event positionchange ( double oldposition,  double newposition )
event timer ( )
event opencomplete ( )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event ocx_error ( integer scode,  string description,  string source,  boolean canceldisplay )
event displaymodechange ( )
event readystatechange ( integer readystate )
event scriptcommand ( string bstrtype,  string bstrtext )
integer width = 2478
integer height = 1280
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_play_avi.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event statechange(long oldstate, long newstate);call super::statechange;if oldstate = 2 and (newstate = 0 ) then
	MoviePlaying = false
	BringToTop = false
	object.stop()
	object.FileName = ""
	parent.width = 1
	parent.height = 1
	timer(0.5, parent)
	MessageBox("Information", "Continue...")
	post close(parent)
end if

end event

event positionchange;if oldposition = newposition then
	MessageBox("w_play", "done")
end if
end event

event opencomplete();double ld_duration
long ll_height, ll_width
ll_height = object.ImageSourceHeight
ll_width = object.ImageSourceWidth
parent.width = PixelsToUnits(ll_width, XPixelsToUnits!) + 30
parent.height = PixelsToUnits(ll_height, YPixelsToUnits!) + 30
parent.x = (iw_parent.width - parent.width)/2
if pos(is_path, "Static Table") > 0 then // instruction or response
	parent.y = 0
else
	parent.y = (iw_parent.height - parent.height)/2
end if
parent.visible = true
object.run()
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
02w_play_avi.bin 3992 
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000300000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000002fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000ba80442001c36b8000000004000000800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a00000002000000010000000405589fa111cec356aa0001bf5a59550000000000ba80442001c36b80ba80442001c36b80000000000000000000000000006f00430074006e006f00720053006c007600610053006500720074006100650000006d0000000000000000000000000000000000000000000000000000000001020024ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000007c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff
20ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234432100000008000038040000211305589fa0000000010000ffffffff0000ffffffffffffffffffffffff0000ffff0000000000000000ffffffffffffffff0000000000000001000000000000000000000000bff0000000000001000000010000000000000000ffffffff000000ffffff0000000000003ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12w_play_avi.bin 3992 
End of PowerBuilder Binary Data Section : No Source Expected After This Point