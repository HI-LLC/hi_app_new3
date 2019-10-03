$PBExportHeader$w_basic.srw
forward
global type w_basic from window
end type
end forward

global type w_basic from window
integer x = 1038
integer y = 524
integer width = 1810
integer height = 1356
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = ".\LearningHelper.ico"
event ue_syscmnd pbm_syscommand
event ue_ncldblclck pbm_nclbuttondblclk
event ue_search ( )
event ue_paint pbm_paint
end type
global w_basic w_basic

type variables
string is_garbage_file_list[]

end variables

event ue_paint;long ll_handle
//if gb_appwatch then
//	ll_handle= handle(this)
//	ScreenShot(ll_handle, "c:\AppWatch.bmp")
//end if
end event

on w_basic.create
end on

on w_basic.destroy
end on

event other;//gnvo_is.iw_status.BringToTop = True
end event

event close;integer li_i
for li_i = 1 to upperbound(is_garbage_file_list) 
	if FileExists(is_garbage_file_list[li_i]) then
//		FileDelete(is_garbage_file_list[li_i])
	end if
next
end event

