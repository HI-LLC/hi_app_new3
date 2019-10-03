$PBExportHeader$w_container_discrete_trial.srw
forward
global type w_container_discrete_trial from w_container
end type
type pb_1 from picturebutton within w_container_discrete_trial
end type
type ole_1 from olecustomcontrol within w_container_discrete_trial
end type
end forward

shared variables
boolean sb_clicked = false
end variables

global type w_container_discrete_trial from w_container
integer width = 1202
integer height = 816
pb_1 pb_1
ole_1 ole_1
end type
global w_container_discrete_trial w_container_discrete_trial

type variables
string is_path
end variables

forward prototypes
public subroutine wf_set_clicked (boolean as_clicked)
end prototypes

public subroutine wf_set_clicked (boolean as_clicked);sb_clicked = as_clicked
end subroutine

on w_container_discrete_trial.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.ole_1
end on

on w_container_discrete_trial.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.ole_1)
end on

event clicked;call super::clicked;ParentWindow().post dynamic wf_container_clicked(ii_id)
end event

event close;if not ib_stopped then
	ole_1.object.Stop()
end if
destroy ole_1
//MessageBox("container", "to be closed")
end event

event mousemove;call super::mousemove;w_lesson_dragdrop_count lw_dragdrop
w_lesson_matching lw_number_match
long li_x, li_y
GetCursorPos(i_mousepos)

if ParentWindow().ClassName() = "w_lesson_matching" then
	lw_number_match = ParentWindow()
	if lw_number_match.ib_drag then
		lw_number_match.event mousemove(flags, xpos + x, ypos + y)
	end if
end if

end event

type p_1 from w_container`p_1 within w_container_discrete_trial
boolean visible = false
string picturename = ""
boolean border = false
end type

type pb_1 from picturebutton within w_container_discrete_trial
event ue_key pbm_dwnkey
event mousemove pbm_mousemove
integer x = 14
integer y = 12
integer width = 1166
integer height = 784
integer taborder = 10
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
vtextalign vtextalign = multiline!
end type

event ue_key;return parent.event key(key, keyflags)
end event

event clicked;//if not sb_clicked then
//	sb_clicked = true
	parent.post event clicked(0, 0, 0)
//	sb_clicked = false
//end if
end event

type ole_1 from olecustomcontrol within w_container_discrete_trial
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
integer x = 14
integer y = 12
integer width = 1161
integer height = 776
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_container_discrete_trial.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event statechange;if oldstate = 2 and (newstate = 0 ) then
	if not ib_to_stop_movie then
//		ib_to_stop_movie = false
//		ib_stopped = true
		object.Run()
	end if
end if

end event

event positionchange;//if oldposition = newposition then
//	if not ib_stopped and ib_to_stop_movie then
//		ib_stopped = true
//		object.Stop()
//	end if
//end if
end event

event opencomplete;double ld_duration
long ll_height, ll_width
ll_height = object.ImageSourceHeight
ll_width = object.ImageSourceWidth
ib_to_stop_movie = false
ib_stopped = false

object.AutoReWind = 1
//object.PlayCount = 999
parent.width = 2*x + PixelsToUnits(ll_width, XPixelsToUnits!) + 30
parent.height = 2*y + PixelsToUnits(ll_height, YPixelsToUnits!) + 30
parent.visible = true
object.run()
end event

event clicked;if not ib_stopped then
	ib_stopped = true
	object.Stop()
end if
parent.post event clicked(0, 0, 0)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_container_discrete_trial.bin 3076 
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000300000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000002fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000003000000000000000000000000000000000000000000000000000000000020cd6001c506ee00000004000000800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a00000002000000010000000405589fa111cec356aa0001bf5a595500000000000020cd6001c506ee0020cd6001c506ee000000000000000000000000006f00430074006e006f00720053006c007600610053006500720074006100650000006d0000000000000000000000000000000000000000000000000000000001020024ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000007c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff
20ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234432100000008000038040000211305589fa0000000010000ffffffff0000ffffffffffffffffffffffff0000ffff0000000000000000ffffffffffffffff0000000000000001000000000000000000000000bff0000000000001000000010000000000000000ffffffff000000ffffff0000000000003ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_container_discrete_trial.bin 3076 
End of PowerBuilder Binary Data Section : No Source Expected After This Point