$PBExportHeader$w_container_comparison.srw
forward
global type w_container_comparison from w_container
end type
end forward

global type w_container_comparison from w_container
integer width = 1481
integer height = 864
end type
global w_container_comparison w_container_comparison

type variables

end variables

on w_container_comparison.create
call super::create
end on

on w_container_comparison.destroy
call super::destroy
end on

event clicked;call super::clicked;ParentWindow().post dynamic wf_container_clicked(ii_id)

//str_msg msg
//long ll_hwn, li_i, li_msg_count = 0
//	ll_hwn = handle(this)
//	do while remove_message(msg, ll_hwn, 513, 513) > 0 
////		MessageBox("debug", string(msg.message))
//		li_msg_count++
//	loop
//	
//MessageBox("debug", string(li_msg_count))
end event

type p_1 from w_container`p_1 within w_container_comparison
integer x = 14
integer y = 12
integer width = 1445
integer height = 832
boolean enabled = true
string picturename = ".\color_silver.bmp"
end type

event p_1::clicked;call super::clicked;parent.post event clicked(0, 0, 0)
end event

