$PBExportHeader$w_timing_text.srw
forward
global type w_timing_text from w_response
end type
type cb_testing from commandbutton within w_timing_text
end type
type cb_4 from commandbutton within w_timing_text
end type
type r_1 from rectangle within w_timing_text
end type
type ln_1 from line within w_timing_text
end type
type ln_2 from line within w_timing_text
end type
type cb_stop from commandbutton within w_timing_text
end type
type cb_close from commandbutton within w_timing_text
end type
type cb_cancel from commandbutton within w_timing_text
end type
end forward

global type w_timing_text from w_response
integer width = 2642
integer height = 1856
string title = "TextTiming"
long backcolor = 79741120
event ue_tab pbm_dwnkey
cb_testing cb_testing
cb_4 cb_4
r_1 r_1
ln_1 ln_1
ln_2 ln_2
cb_stop cb_stop
cb_close cb_close
cb_cancel cb_cancel
end type
global w_timing_text w_timing_text

type variables
long il_default_color
long il_hi_light_color
long il_st_index = 1

dec id_sound_lapse[]
uo_st iuo_st[]
string is_wave_file

long il_letter_width = 45.5
long il_letter_height = 80
string is_wavefile_path, is_subject
string is_details
string is_list[]

boolean ib_start_timing = false
w_materials iw_window
end variables

forward prototypes
public subroutine wf_init_text_list ()
end prototypes

event ue_tab;MessageBox("test","key in")
if key = keytab! and ib_start_timing and il_st_index < upperbound(iuo_st) then
	il_st_index++
	iuo_st[il_st_index - 1].backcolor = iuo_st[il_st_index - 1].il_default_color
	iuo_st[il_st_index].backcolor = iuo_st[il_st_index - 1].il_hi_light_color
	iuo_st[il_st_index].cpu_time = dec(cpu())/1000.0
end if
	
	
end event

public subroutine wf_init_text_list ();integer li_i
long ll_min_x, ll_max_x, ll_min_y, ll_max_y
long ll_x, ll_y
if not isnull(is_details) and len(is_details) > 0 then
	gf_make_content_list(is_details, is_list)
else
	return
end if

ll_min_x = r_1.x + 100
ll_max_x = r_1.x + r_1.width - 100
ll_min_y = r_1.y + 100
ll_max_y = r_1.y + r_1.height - 100

ll_x = ll_min_x
ll_y = ll_min_y
for li_i = 1 to upperbound(is_list)
	iuo_st[li_i] = create uo_st
	iuo_st[li_i].text = is_list[li_i]
	iuo_st[li_i].width= long(45.5*real(len(is_list[li_i])))
	iuo_st[li_i].il_hi_light_color = il_hi_light_color

	if ll_x + iuo_st[li_i].width  > ll_max_x then
		ll_x = ll_min_x 
		ll_y = ll_y + 80
		OpenUserObject(iuo_st[li_i], ll_x, ll_y)	
	else
		OpenUserObject(iuo_st[li_i], ll_x, ll_y)	
	end if	
	ll_x = ll_x + iuo_st[li_i].width + 45.5
next

end subroutine

on w_timing_text.create
int iCurrent
call super::create
this.cb_testing=create cb_testing
this.cb_4=create cb_4
this.r_1=create r_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.cb_stop=create cb_stop
this.cb_close=create cb_close
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_testing
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.r_1
this.Control[iCurrent+4]=this.ln_1
this.Control[iCurrent+5]=this.ln_2
this.Control[iCurrent+6]=this.cb_stop
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_cancel
end on

on w_timing_text.destroy
call super::destroy
destroy(this.cb_testing)
destroy(this.cb_4)
destroy(this.r_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.cb_stop)
destroy(this.cb_close)
destroy(this.cb_cancel)
end on

event open;long ll_chapter_id

iw_window = Message.PowerObjectParm
//ll_chapter_id = iw_window.wf_get_chapter_id()

//ll_chapter_id = long(Message.StringParm)
il_hi_light_color = RGB(255, 128, 255)
//is_wavefile_path = ProfileString("Learning Helper.INI", "Resources", "wavefile", "")

Select C.details, C.wave_file, S.description into :is_details, :is_wave_file, :is_subject
From Chapter C, Subject S
Where C.chapter_id = :ll_chapter_id and C.subject_id = S.subject_id;

wf_init_text_list()
end event

event timer;il_st_index++
iuo_st[il_st_index].backcolor = il_hi_light_color
iuo_st[il_st_index - 1].backcolor = iuo_st[il_st_index - 1].il_default_color
timer(id_sound_lapse[il_st_index])

end event

event close;integer li_i
for li_i = 1 to upperbound(iuo_st)
	closeuserobject(iuo_st[li_i])
	destroy iuo_st[li_i]
next
end event

event clicked;//il_st_index++
//id_sound_lapse[il_st_index] = CPU()
end event

type cb_testing from commandbutton within w_timing_text
integer x = 1179
integer y = 40
integer width = 320
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Test "
end type

event clicked;sndPlaySoundA(gn_appman.is_wavefile_path + is_subject + '\' + is_wave_file, 1)
yield()
il_st_index = 1
iuo_st[il_st_index].backcolor = il_hi_light_color
timer(id_sound_lapse[il_st_index])

end event

type cb_4 from commandbutton within w_timing_text
event ue_tab pbm_keydown
integer x = 50
integer y = 40
integer width = 503
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Start Timing"
end type

event ue_tab;if key = keyenter! and ib_start_timing and il_st_index < upperbound(iuo_st) then
	il_st_index++
	iuo_st[il_st_index - 1].backcolor = iuo_st[il_st_index - 1].il_default_color
	iuo_st[il_st_index].backcolor = iuo_st[il_st_index - 1].il_hi_light_color
	iuo_st[il_st_index].cpu_time = dec(cpu())/1000.0
end if
end event

event clicked;ib_start_timing = true
sndPlaySoundA(gn_appman.is_wavefile_path + is_subject + '\' + is_wave_file, 1)
yield()
iuo_st[1].SetFocus()
il_st_index = 1
iuo_st[1].backcolor = il_hi_light_color
iuo_st[il_st_index].cpu_time = dec(cpu())/1000.0
end event

type r_1 from rectangle within w_timing_text
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 15780518
integer x = 50
integer y = 200
integer width = 2501
integer height = 1500
end type

type ln_1 from line within w_timing_text
integer linethickness = 4
integer beginx = 50
integer beginy = 200
integer endx = 2551
integer endy = 200
end type

type ln_2 from line within w_timing_text
integer linethickness = 4
integer beginx = 50
integer beginy = 200
integer endx = 50
integer endy = 1700
end type

type cb_stop from commandbutton within w_timing_text
integer x = 608
integer y = 40
integer width = 503
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "St&op Timing"
end type

event clicked;integer li_i
ib_start_timing = false
for li_i = 1 to upperbound(iuo_st)
	iuo_st[li_i].backcolor = iuo_st[li_i].il_default_color
next

for li_i = 1 to upperbound(iuo_st) - 1
	id_sound_lapse[li_i] = iuo_st[li_i+1].cpu_time - iuo_st[li_i].cpu_time - 0.025
next
id_sound_lapse[li_i] = 0
end event

type cb_close from commandbutton within w_timing_text
integer x = 2007
integer y = 40
integer width = 567
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Done and Close"
end type

event clicked;//iw_window.wf_set_wave_time(id_sound_lapse)
close(parent)
end event

type cb_cancel from commandbutton within w_timing_text
integer x = 1687
integer y = 40
integer width = 306
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cancel"
end type

event clicked;close(parent)
end event

