$PBExportHeader$w_money_board.srw
forward
global type w_money_board from window
end type
type p_15 from picture within w_money_board
end type
type p_14 from picture within w_money_board
end type
type p_13 from picture within w_money_board
end type
type p_12 from picture within w_money_board
end type
type p_11 from picture within w_money_board
end type
type p_10 from picture within w_money_board
end type
type p_9 from picture within w_money_board
end type
type p_8 from picture within w_money_board
end type
type p_7 from picture within w_money_board
end type
type p_6 from picture within w_money_board
end type
type p_5 from picture within w_money_board
end type
type p_4 from picture within w_money_board
end type
type p_3 from picture within w_money_board
end type
type p_2 from picture within w_money_board
end type
type p_1 from picture within w_money_board
end type
type r_1 from rectangle within w_money_board
end type
type r_2 from rectangle within w_money_board
end type
type r_3 from rectangle within w_money_board
end type
type r_4 from rectangle within w_money_board
end type
type r_5 from rectangle within w_money_board
end type
type r_6 from rectangle within w_money_board
end type
type r_7 from rectangle within w_money_board
end type
type r_8 from rectangle within w_money_board
end type
type r_9 from rectangle within w_money_board
end type
type r_10 from rectangle within w_money_board
end type
type r_11 from rectangle within w_money_board
end type
type r_12 from rectangle within w_money_board
end type
type r_13 from rectangle within w_money_board
end type
type r_14 from rectangle within w_money_board
end type
type r_15 from rectangle within w_money_board
end type
end forward

global type w_money_board from window
string tag = "1701000"
integer width = 3543
integer height = 180
boolean enabled = false
windowtype windowtype = popup!
long backcolor = 16777215
p_15 p_15
p_14 p_14
p_13 p_13
p_12 p_12
p_11 p_11
p_10 p_10
p_9 p_9
p_8 p_8
p_7 p_7
p_6 p_6
p_5 p_5
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
r_6 r_6
r_7 r_7
r_8 r_8
r_9 r_9
r_10 r_10
r_11 r_11
r_12 r_12
r_13 r_13
r_14 r_14
r_15 r_15
end type
global w_money_board w_money_board

type variables
integer ii_current_index = 1
integer ii_total_tokens = 15
long il_width
nvo_reward_program invo_reward_program
picture ip_penny[15]
rectangle ir_back[15]
w_lesson iw_lesson
end variables

forward prototypes
public subroutine wf_refresh ()
public subroutine wf_add_credit ()
end prototypes

public subroutine wf_refresh ();integer li_index
invo_reward_program.of_init()
//ii_total_tokens = gi_token_num
visible = true
if ii_total_tokens < 1 or ii_total_tokens > 15 then
	ii_total_tokens = 10
end if
ii_current_index = 1
width = il_width - (15 - ii_total_tokens)*(p_2.x - p_1.x)
for li_index = 1 to upperbound(ip_penny)
	ip_penny[li_index].visible = false
	ir_back[li_index].visible = true
next
move(1, 1)

end subroutine

public subroutine wf_add_credit ();integer li_index
string ls_video_file
if not visible then return
ip_penny[ii_current_index].visible = true
ir_back[ii_current_index].visible = false
if ii_current_index = ii_total_tokens then
//	ls_video_file = gs_vedio_file
	iw_lesson.wf_play_video(ls_video_file)
//	this.BringToTop = true
	ii_current_index = 1
	for li_index = 1 to upperbound(ip_penny)
		ip_penny[li_index].visible = false
		ir_back[li_index].visible = true
	next
else
	ii_current_index = ii_current_index + 1
end if
end subroutine

on w_money_board.create
this.p_15=create p_15
this.p_14=create p_14
this.p_13=create p_13
this.p_12=create p_12
this.p_11=create p_11
this.p_10=create p_10
this.p_9=create p_9
this.p_8=create p_8
this.p_7=create p_7
this.p_6=create p_6
this.p_5=create p_5
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
this.r_6=create r_6
this.r_7=create r_7
this.r_8=create r_8
this.r_9=create r_9
this.r_10=create r_10
this.r_11=create r_11
this.r_12=create r_12
this.r_13=create r_13
this.r_14=create r_14
this.r_15=create r_15
this.Control[]={this.p_15,&
this.p_14,&
this.p_13,&
this.p_12,&
this.p_11,&
this.p_10,&
this.p_9,&
this.p_8,&
this.p_7,&
this.p_6,&
this.p_5,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.r_1,&
this.r_2,&
this.r_3,&
this.r_4,&
this.r_5,&
this.r_6,&
this.r_7,&
this.r_8,&
this.r_9,&
this.r_10,&
this.r_11,&
this.r_12,&
this.r_13,&
this.r_14,&
this.r_15}
end on

on w_money_board.destroy
destroy(this.p_15)
destroy(this.p_14)
destroy(this.p_13)
destroy(this.p_12)
destroy(this.p_11)
destroy(this.p_10)
destroy(this.p_9)
destroy(this.p_8)
destroy(this.p_7)
destroy(this.p_6)
destroy(this.p_5)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.r_6)
destroy(this.r_7)
destroy(this.r_8)
destroy(this.r_9)
destroy(this.r_10)
destroy(this.r_11)
destroy(this.r_12)
destroy(this.r_13)
destroy(this.r_14)
destroy(this.r_15)
end on

event open;invo_reward_program = create nvo_reward_program
ip_penny[1] = p_1
ip_penny[2] = p_2
ip_penny[3] = p_3
ip_penny[4] = p_4
ip_penny[5] = p_5
ip_penny[6] = p_6
ip_penny[7] = p_7
ip_penny[8] = p_8
ip_penny[9] = p_9
ip_penny[10] = p_10
ip_penny[11] = p_11
ip_penny[12] = p_12
ip_penny[13] = p_13
ip_penny[14] = p_14
ip_penny[15] = p_15
ir_back[1] = r_1
ir_back[2] = r_2
ir_back[3] = r_3
ir_back[4] = r_4
ir_back[5] = r_5
ir_back[6] = r_6
ir_back[7] = r_7
ir_back[8] = r_8
ir_back[9] = r_9
ir_back[10] = r_10
ir_back[11] = r_11
ir_back[12] = r_12
ir_back[13] = r_13
ir_back[14] = r_14
ir_back[15] = r_15
//border =  true
visible = false
il_width = width
wf_refresh()

end event

event close;if isvalid(invo_reward_program) then
	destroy invo_reward_program
end if
end event

event closequery;//if isvalid(invo_reward_program) then
//	destroy invo_reward_program
//end if
end event

type p_15 from picture within w_money_board
integer x = 3342
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_14 from picture within w_money_board
integer x = 3104
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_13 from picture within w_money_board
integer x = 2866
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_12 from picture within w_money_board
integer x = 2629
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_11 from picture within w_money_board
integer x = 2391
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_10 from picture within w_money_board
integer x = 2153
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_9 from picture within w_money_board
integer x = 1915
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_8 from picture within w_money_board
integer x = 1678
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_7 from picture within w_money_board
integer x = 1440
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_6 from picture within w_money_board
integer x = 1202
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_5 from picture within w_money_board
integer x = 965
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_4 from picture within w_money_board
integer x = 727
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_3 from picture within w_money_board
integer x = 489
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_money_board
integer x = 251
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_money_board
integer x = 14
integer y = 4
integer width = 187
integer height = 164
string picturename = ".\penny.bmp"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 14
integer y = 4
integer width = 187
integer height = 164
end type

type r_2 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 251
integer y = 4
integer width = 187
integer height = 164
end type

type r_3 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 489
integer y = 4
integer width = 187
integer height = 164
end type

type r_4 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 727
integer y = 4
integer width = 187
integer height = 164
end type

type r_5 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 965
integer y = 4
integer width = 187
integer height = 164
end type

type r_6 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 1202
integer y = 4
integer width = 187
integer height = 164
end type

type r_7 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 1440
integer y = 4
integer width = 187
integer height = 164
end type

type r_8 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 1678
integer y = 4
integer width = 187
integer height = 164
end type

type r_9 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 1915
integer y = 4
integer width = 187
integer height = 164
end type

type r_10 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 2153
integer y = 4
integer width = 187
integer height = 164
end type

type r_11 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 2391
integer y = 4
integer width = 187
integer height = 164
end type

type r_12 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 2629
integer y = 4
integer width = 187
integer height = 164
end type

type r_13 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 2866
integer y = 4
integer width = 187
integer height = 164
end type

type r_14 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 3104
integer y = 4
integer width = 187
integer height = 164
end type

type r_15 from rectangle within w_money_board
integer linethickness = 1
long fillcolor = 16776960
integer x = 3342
integer y = 4
integer width = 187
integer height = 164
end type

