$PBExportHeader$w_container_twc.srw
forward
global type w_container_twc from w_container
end type
end forward

global type w_container_twc from w_container
integer width = 1742
integer height = 872
long backcolor = 8388608
end type
global w_container_twc w_container_twc

on w_container_twc.create
call super::create
end on

on w_container_twc.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;w_lesson_mw_cmmnd lw_lesson_mw_cmmnd
string ls_picturename
integer li_count
long li_y
long li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
lx = source.x 
ly = source.y 

uo_count iuo_tmp
iuo_tmp = source
if source.classname() = 'uo_count_dragdrop' then
	lw_lesson_mw_cmmnd = ParentWindow()
	lw_lesson_mw_cmmnd.p_1.visible = false
	lw_lesson_mw_cmmnd.ib_drag = false
	GetCursorPos(i_mousepos)
	li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
	li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
	li_x = li_x - ParentWindow().x - this.workspacex() - ParentWindow().WorkSpaceX() //- lw_lesson_counting.p_1.width
	li_y = li_y - ParentWindow().y - this.workspacey() - ParentWindow().WorkSpaceY() //+ (lw_lesson_counting.p_1.height/2)
	if lw_lesson_mw_cmmnd.ii_trial_target = 1 then // sequential
		if iuo_tmp.iw_parent <> this then // from other bucket
			if ib_target then
				ls_picturename = iuo_tmp.p_1.picturename
				li_width_source = iuo_tmp.ii_width
				li_height_source = iuo_tmp.ii_height
				if lw_lesson_mw_cmmnd.wf_check_number(iuo_tmp.ii_index) then
					ii_bean_count++
					wf_draw_a_bean()
					ioval[ii_bean_count].p_1.picturename = ls_picturename
					ioval[ii_bean_count].wf_object_zoom(1.5)	
					ioval[ii_bean_count].y = ioval[ii_bean_count].y - 100
					lw_lesson_mw_cmmnd.wf_response(true)
					destroy iuo_tmp
				else
					lw_lesson_mw_cmmnd.wf_response(false)
					iuo_tmp.visible = true
					iuo_tmp.BringToTop = true
					iuo_tmp.width = iuo_tmp.ii_width
					iuo_tmp.height = iuo_tmp.ii_height
					iuo_tmp.drag(end!)				
				end if
			else
				iuo_tmp.visible = true
				iuo_tmp.BringToTop = true
				iuo_tmp.width = iuo_tmp.ii_width
				iuo_tmp.height = iuo_tmp.ii_height
				iuo_tmp.drag(end!)
			end if
		else
			iuo_tmp.visible = true
			iuo_tmp.width = iuo_tmp.ii_width
			iuo_tmp.height = iuo_tmp.ii_height		
			iuo_tmp.drag(end!)
		end if
	else // random
		if iuo_tmp.iw_parent <> this then // from other bucket
			if ib_target then
				ls_picturename = iuo_tmp.p_1.picturename
				li_width_source = iuo_tmp.ii_width
				li_height_source = iuo_tmp.ii_height
				if lw_lesson_mw_cmmnd.wf_check_number(iuo_tmp.ii_index) then
					ii_bean_count++
					wf_draw_a_bean()
					ioval[ii_bean_count].p_1.picturename = ls_picturename
					ioval[ii_bean_count].wf_object_zoom(1.5)	
					ioval[ii_bean_count].y = ioval[ii_bean_count].y - 100
					lw_lesson_mw_cmmnd.wf_response(true)
					destroy iuo_tmp
				end if
			else
				lw_lesson_mw_cmmnd.wf_response(false)
				iuo_tmp.visible = true
				iuo_tmp.BringToTop = true
				iuo_tmp.width = iuo_tmp.ii_width
				iuo_tmp.height = iuo_tmp.ii_height
				iuo_tmp.drag(end!)				
//				iuo_tmp.visible = true
//				iuo_tmp.BringToTop = true
//				iuo_tmp.width = iuo_tmp.ii_width
//				iuo_tmp.height = iuo_tmp.ii_height
//				iuo_tmp.drag(end!)
			end if
		else
			iuo_tmp.visible = true
			iuo_tmp.width = iuo_tmp.ii_width
			iuo_tmp.height = iuo_tmp.ii_height		
			iuo_tmp.drag(end!)
		end if
	end if
end if



end event

event dragwithin;call super::dragwithin;w_lesson_mw_cmmnd lw_twc
long li_x, li_y
GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_x = li_x - ParentWindow().x - ParentWindow().WorkSpaceX() - 100
li_y = li_y - ParentWindow().y - ParentWindow().WorkSpaceY() - 100
lw_twc = ParentWindow()
lw_twc.wf_mousemove(li_x, li_y)


end event

type p_1 from w_container`p_1 within w_container_twc
event ue_key pbm_dwnkey
integer x = 0
integer y = 0
string picturename = ".\color_silver.bmp"
end type

event p_1::ue_key;return parent.event key(key, keyflags)
end event

