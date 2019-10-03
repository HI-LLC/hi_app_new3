$PBExportHeader$w_container_unscramble_word.srw
forward
global type w_container_unscramble_word from w_container
end type
type st_1 from statictext within w_container_unscramble_word
end type
end forward

global type w_container_unscramble_word from w_container
boolean visible = true
integer width = 2533
integer height = 1060
st_1 st_1
end type
global w_container_unscramble_word w_container_unscramble_word

type variables
//uo_count_alpha iuo_count
end variables

on w_container_unscramble_word.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_container_unscramble_word.destroy
call super::destroy
destroy(this.st_1)
end on

event dragdrop;call super::dragdrop;string ls_dragobject_name, ls_dragicon
w_lesson lw_tmp
w_lesson_unscramble_sentence lw_lesson_unscramble_sentence
integer li_count
long li_y
long li_i, li_x, lx, ly, ll_len, li_width_source, li_height_source
uo_count_alpha iuo_tmp
lw_tmp = ParentWindow()
if source.classname() = 'uo_count_alpha' then
	iuo_tmp = source
	lx = source.x 
	ly = source.y 
	iuo_tmp.visible = true
	iuo_tmp.BringToTop = true
	iuo_tmp.width = iuo_tmp.ii_width
	iuo_tmp.height = iuo_tmp.ii_height		
	iuo_tmp.Drag(End!)
	lw_tmp.st_1.visible = false // virtual drag object
	lw_tmp.ib_drag = false
//	if lw_tmp.ClassName() = "w_lesson_unscramble_word" then
//		if iuo_tmp.iw_parent <> this then // from other bucket
//			if ib_target then
//				if iuo_tmp.st_number.text = this.st_1.text then
//					this.st_1.visible = true
//					this.st_1.width = width
//					this.st_1.height = height
//					iuo_tmp.enabled = false
//					iuo_tmp.visible = false
//					if lw_tmp.dynamic wf_check_alpha() then
//						lw_tmp.dynamic wf_response(true)
//					else
//						lw_tmp.dynamic wf_next_dest()
//					end if
//				else
//					lw_tmp.ib_misspelled = true
//				end if
//			end if
//		end if
//	else
//		lw_lesson_unscramble_sentence = lw_tmp
		lw_tmp.wf_dragdrop(source)
//	end if
end if
end event

event dragwithin;call super::dragwithin;w_lesson lw_tmp
long li_x, li_y
GetCursorPos(i_mousepos)
lw_tmp = ParentWindow()
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_x = li_x - ParentWindow().x - ParentWindow().WorkSpaceX() - 100
li_y = li_y - ParentWindow().y - ParentWindow().WorkSpaceY() - 100
lw_tmp.dynamic wf_mousemove(li_x, li_y)

end event

event open;call super::open;visible = false
end event

type p_1 from w_container`p_1 within w_container_unscramble_word
event ue_key pbm_dwnkey
integer x = 0
integer y = 0
integer width = 2528
integer height = 1052
boolean enabled = true
string picturename = "color_orange.bmp"
boolean border = false
end type

event p_1::ue_key;return parent.event key(key, keyflags)
end event

event p_1::dragdrop;call super::dragdrop;parent.event dragdrop(source)
end event

event p_1::dragwithin;call super::dragwithin;parent.event dragwithin(source)
end event

type st_1 from statictext within w_container_unscramble_word
boolean visible = false
integer width = 251
integer height = 248
boolean bringtotop = true
integer textsize = -36
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 8388608
alignment alignment = center!
boolean focusrectangle = false
end type

event dragdrop;parent.event dragdrop(source)
end event

event dragwithin;parent.event dragwithin(source)
end event

