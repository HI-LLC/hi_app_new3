$PBExportHeader$w_container_money_board.srw
forward
global type w_container_money_board from w_container
end type
end forward

global type w_container_money_board from w_container
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 8388608
end type
global w_container_money_board w_container_money_board

forward prototypes
public subroutine wf_add_coin ()
end prototypes

public subroutine wf_add_coin ();integer li_i
			ii_bean_count++
			li_i = ii_bean_count
//			is_bean_picturename = ls_dragobject_name
			wf_draw_a_bean()

end subroutine

on w_container_money_board.create
call super::create
end on

on w_container_money_board.destroy
call super::destroy
end on

event dragdrop;call super::dragdrop;string ls_dragobject_name, ls_dragicon
w_lesson_dragdrop_count lw_lesson_dragdrop_count
w_lesson_numbermatch_count lw_lesson_numbermatch_count
integer li_count
long li_y
long li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
lx = source.x 
ly = source.y 

uo_count iuo_tmp
iuo_tmp = source
if source.classname() = 'uo_count_dragdrop' then
	lw_lesson_dragdrop_count = ParentWindow()
	lw_lesson_dragdrop_count.p_1.visible = false
	lw_lesson_dragdrop_count.ib_drag = false
	GetCursorPos(i_mousepos)
	li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
	li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
	li_x = li_x - ParentWindow().x - this.workspacex() - ParentWindow().WorkSpaceX() //- lw_lesson_dragdrop_count.p_1.width
	li_y = li_y - ParentWindow().y - this.workspacey() - ParentWindow().WorkSpaceY() //+ (lw_lesson_dragdrop_count.p_1.height/2)
	if iuo_tmp.iw_parent <> this then // from other bucket
		if ib_target then
			if isvalid(iuo_tmp) then
				ls_dragobject_name = iuo_tmp.P_1.PictureName
				ls_dragicon = iuo_tmp.DragIcon
				li_width_source = iuo_tmp.ii_width
				li_height_source = iuo_tmp.ii_height
				if ii_bean_moving_type <> 0 then					
					destroy iuo_tmp
				end if
			end if
			ii_bean_count++
			li_i = ii_bean_count
			is_bean_picturename = ls_dragobject_name
			wf_draw_a_bean()
			li_count = wf_get_bean_count()
			if lw_lesson_dragdrop_count.dynamic wf_check_number(li_count) then
				lw_lesson_dragdrop_count.st_1.text = string(li_count)
				lw_lesson_dragdrop_count.st_1.visible = true
				MessageBox("Good Job.", "It is " + string(li_count) + ".")
				lw_lesson_dragdrop_count.wf_response()
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
end if
if source.classname() = 'uo_count_number' then
	lw_lesson_numbermatch_count = ParentWindow()
	lw_lesson_numbermatch_count.p_1.visible = false
	lw_lesson_numbermatch_count.ib_drag = false
	iuo_tmp.visible = true
	iuo_tmp.width = iuo_tmp.ii_width
	iuo_tmp.height = iuo_tmp.ii_height		
	iuo_tmp.drag(end!)
end if


end event

event dragwithin;call super::dragwithin;w_lesson_dragdrop_count lw_dragdrop
w_lesson_numbermatch_count lw_number_match
long li_x, li_y
GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_x = li_x - ParentWindow().x - ParentWindow().WorkSpaceX() - 100
li_y = li_y - ParentWindow().y - ParentWindow().WorkSpaceY() - 100
if source.classname() = 'uo_count_dragdrop' then
	lw_dragdrop = ParentWindow()
	lw_dragdrop.wf_mousemove(li_x, li_y)
else
	lw_number_match = ParentWindow()
	lw_number_match.wf_mousemove(li_x, li_y)	
end if

end event

type p_1 from w_container`p_1 within w_container_money_board
string picturename = ""
end type

