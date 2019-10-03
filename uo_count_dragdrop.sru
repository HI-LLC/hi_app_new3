$PBExportHeader$uo_count_dragdrop.sru
forward
global type uo_count_dragdrop from uo_count
end type
end forward

global type uo_count_dragdrop from uo_count
boolean dragauto = true
end type
global uo_count_dragdrop uo_count_dragdrop

on uo_count_dragdrop.create
call super::create
end on

on uo_count_dragdrop.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;if source.classname() = 'uo_count_dragdrop' then
	iw_parent.event dragdrop(source)
end if
end event

event mousemove;call super::mousemove;iw_parent.event mousemove(flags, xpos, ypos)
end event

type st_number from uo_count`st_number within uo_count_dragdrop
end type

type p_1 from uo_count`p_1 within uo_count_dragdrop
boolean dragauto = true
end type

event p_1::dragdrop;call super::dragdrop;if source.classname() = 'uo_count_dragdrop' then
	parent.event dragdrop(source)
end if
end event

event p_1::dragwithin;call super::dragwithin;long li_x, li_y
picture lpc_tmp
w_lesson_dragdrop_count lw_lesson_dragdrop_count
w_lesson_mw_cmmnd lw_lesson_mw_cmmnd, lw_tmp
str_mousepos i_mousepos

GetCursorPos(i_mousepos)

li_x = iw_parent.x + parent.x
li_y = iw_parent.y + parent.y
if iw_parent.classname() = 'w_container_twc' then
	lw_lesson_mw_cmmnd = iw_parent.ParentWindow()
	lw_lesson_mw_cmmnd.ii_x0 = li_x
	lw_lesson_mw_cmmnd.ii_y0 = li_y
	lpc_tmp = lw_lesson_mw_cmmnd.p_1
	if lw_lesson_mw_cmmnd.ii_trial_target = 2 then // random
		lw_lesson_mw_cmmnd.wf_set_new_item(ii_index)
	end if
else
	lw_lesson_dragdrop_count = iw_parent.ParentWindow()
	lw_lesson_dragdrop_count.ii_x0 = li_x
	lw_lesson_dragdrop_count.ii_y0 = li_y
	lpc_tmp = lw_lesson_dragdrop_count.p_1
end if	
if source.classname() = 'p_1' then
	drag(End!)
	lpc_tmp.x = li_x
	lpc_tmp.y = li_y
	lpc_tmp.PictureName = p_1.PictureName
	lpc_tmp.width = width
	lpc_tmp.height = height
	lpc_tmp.visible = true
	if iw_parent.classname() = 'w_container_twc' then
		lw_lesson_mw_cmmnd.ib_drag = true
	else
		lw_lesson_dragdrop_count.ib_drag = true
	end if	
	parent.width = 1
	parent.height = 1
	parent.drag(Begin!)
	parent.visible = false	
	lpc_tmp.BringToTop = true
end if
end event

event p_1::mousemove;call super::mousemove;parent.event mousemove(flags, xpos, ypos)
end event

type oval_1 from uo_count`oval_1 within uo_count_dragdrop
end type

