$PBExportHeader$uo_fram_control_tabpage.sru
forward
global type uo_fram_control_tabpage from userobject
end type
end forward

global type uo_fram_control_tabpage from userobject
integer width = 2313
integer height = 1380
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_paint pbm_paint
end type
global uo_fram_control_tabpage uo_fram_control_tabpage

type variables
window iw_window
long il_handle
end variables

event ue_paint;long ll_handle
//if gb_appwatch then
//	ll_handle= handle(this)
//	ScreenShot(ll_handle, "c:\AppWatch.bmp")
//end if
end event

on uo_fram_control_tabpage.create
end on

on uo_fram_control_tabpage.destroy
end on

