$PBExportHeader$w_container_reading.srw
forward
global type w_container_reading from w_container
end type
type cb_play from u_commandbutton within w_container_reading
end type
type p_2 from p_1 within w_container_reading
end type
end forward

global type w_container_reading from w_container
integer width = 4347
integer height = 1472
cb_play cb_play
p_2 p_2
end type
global w_container_reading w_container_reading

type variables
string is_reading_content, is_reading_phrases[]
string is_reading_sounds[], is_reading_bitmaps[], is_hint
boolean ib_picture_on = false, ib_movie_on=false, ib_text_on = true, ib_hint = false

uo_st_reading iuo_st[]


end variables
forward prototypes
public function integer wf_make_word_list (integer ai_window_width, integer ai_char_height, string as_input_words, ref string as_output_word_list[], ref str_string_array as_output_layout_list[])
public function integer wf_display_word_list ()
public function integer wf_set_hint (string as_hint)
end prototypes

public function integer wf_make_word_list (integer ai_window_width, integer ai_char_height, string as_input_words, ref string as_output_word_list[], ref str_string_array as_output_layout_list[]);integer li_row = 1, li_i,li_j=0, li_count, li_width = 0, li_pos, li_last_space_pos, li_over_pass_chars
long li_dc, li_sum_width = 0, li_max_width = 0
string ls_tmp_word_list[], ls_tmp_words, ls_empty[]
real lr_xy_ratio, lr_height_ratio
boolean ib_empty[]
str_string_array layout_list_empty[]
str_size lstr_str_size

SetRedraw(false)	
// close previous display objects
for li_i = 1 to upperbound(iuo_st)
	if isvalid(iuo_st[li_i]) then 
		closeuserobject(iuo_st[li_i])
		destroy iuo_st[li_i]
	end if
next	

as_output_word_list = ls_empty
as_output_layout_list = layout_list_empty
li_i = 1
for li_row = 1 to upperbound(is_reading_phrases)
	ls_tmp_words = trim(is_reading_phrases[li_row])
	do
		li_pos = pos(ls_tmp_words, ' ')
		if li_pos > 0 then
			if trim(left(ls_tmp_words, li_pos - 1)) <> '' then
				iuo_st[li_i] = create uo_st_reading
				iuo_st[li_i].ii_index = li_row
				ls_tmp_word_list[li_i] = trim(left(ls_tmp_words, li_pos - 1)) + ' '	
				li_i++
			end if
			ls_tmp_words = trim(right(ls_tmp_words, len(ls_tmp_words) - li_pos))	
		end if	
	loop while li_pos > 0
	if trim(ls_tmp_words) <> '' then
		iuo_st[li_i] = create uo_st_reading
		iuo_st[li_i].ii_index = li_row
		ls_tmp_word_list[li_i] = trim(ls_tmp_words) + ' '
		li_i++
	end if
next
as_output_word_list[1] =  ls_tmp_word_list[1]
li_j = 1
li_dc = GetDc(handle(this))
lr_xy_ratio = PixelsToUnits(1000, XPixelsToUnits!)/PixelsToUnits(1000, YPixelsToUnits!)
as_output_layout_list[1].array[1] =  ls_tmp_word_list[1]
li_row = 1
for li_i = 2 to upperbound(ls_tmp_word_list)
	GetTextExtentPoint32A(li_dc, ls_tmp_word_list[li_i], len(ls_tmp_word_list[li_i]), lstr_str_size)
	lr_height_ratio = ai_char_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)
	li_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
	li_width =  li_width*lr_xy_ratio*lr_height_ratio
	li_sum_width = li_sum_width + li_width 
	if li_sum_width < ai_window_width then
		as_output_word_list[li_row] = as_output_word_list[li_row] + ls_tmp_word_list[li_i]
		li_j++
		as_output_layout_list[li_row].array[li_j] = ls_tmp_word_list[li_i]
	else
		if (li_sum_width - li_width) > li_max_width then li_max_width = (li_sum_width - li_width)
		li_sum_width = 0
		li_row = li_row + 1
		as_output_word_list[li_row] = ls_tmp_word_list[li_i]
		li_j = 1
		as_output_layout_list[li_row].array[li_j] = ls_tmp_word_list[li_i]
	end if
next

return li_max_width
end function

public function integer wf_display_word_list ();integer li_row,li_col, li_row_count, li_i = 1, li_count, li_x, li_y, li_width, li_height, li_allowed_height
integer li_adjusted_height = 0, li_max_width
string ls_process_words, ls_word_list[]
string ls_selected_item, ls_tmp
str_string_array ls_layout_list[]
long ll_x, ll_y, ll_i, ll_width
integer li_dummy[], li_j, li_lpDx
ulong li_dc
real lr_height_ratio, lr_xy_ratio
str_size lstr_str_size
str_rect lstr_rect

li_dc = GetDC(handle(this))


li_height = 80

// Since we use none-fixed height font, all string's widths need to be measured
li_max_width = wf_make_word_list(this.p_1.width*3/4, li_height, is_reading_content, ls_word_list, ls_layout_list)

li_allowed_height = (this.height - li_adjusted_height - this.height/20 )  // height for blocks on which to be dropped
li_y = li_adjusted_height + li_allowed_height/(upperbound(ls_word_list) + 1) - (li_height/2)
li_row_count =  upperbound(ls_layout_list) 
lr_xy_ratio = PixelsToUnits(1000, XPixelsToUnits!)/PixelsToUnits(1000, YPixelsToUnits!)

//for li_row = 1 to upperbound(is_reading_phrases)
//	MessageBox(string(li_row), is_reading_phrases[li_row])
//next 

for li_row = 1 to li_row_count
	GetTextExtentPoint32A(li_dc, ls_word_list[li_row], len(ls_word_list[li_row]), lstr_str_size)
	ll_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
	lr_height_ratio = li_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)
//	li_x = (this.width - ll_width*lr_height_ratio*lr_xy_ratio)/2
	li_x = (this.p_1.width*3/4 - li_max_width)/2 + 20
	for li_col = 1 to upperbound(ls_layout_list[li_row].array)
//		iuo_st[li_i].textsize = 25
		ls_tmp = ls_layout_list[li_row].array[li_col]
		GetTextExtentPoint32A(li_dc, ls_tmp, len(ls_tmp), lstr_str_size)
		lr_height_ratio = li_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)		
		ll_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
		ll_width =  ll_width*lr_xy_ratio*lr_height_ratio
		OpenUserObject(iuo_st[li_i], ll_x, ll_y)	
//		lw_tmp.width = ll_width + 10
		iuo_st[li_i].width = ll_width
		iuo_st[li_i].height = li_height
		iuo_st[li_i].x = li_x
		iuo_st[li_i].y = li_y
		iuo_st[li_i].visible = true
		iuo_st[li_i].text = ls_layout_list[li_row].array[li_col]
		iuo_st[li_i].BringToTop = true	
//		MessageBox(string(li_row) + ":" + string(li_col), iuo_st[li_i].text)
		li_x =  li_x + ll_width /*len(ls_layout_list[li_row].array[li_col])*/	
		li_i++
	next
	li_y = li_y + (li_allowed_height/(upperbound(ls_word_list) + 1))
next

SetRedraw(true)	
return 1
end function

public function integer wf_set_hint (string as_hint);integer li_i, li_j

for li_i = 1 to upperbound(iuo_st)
	iuo_st[li_i].backcolor = iuo_st[li_i].il_default_color
next
//MessageBox("wf_set_hint", "A")
for li_i = 1 to upperbound(is_reading_phrases)
	if as_hint = is_reading_phrases[li_i] then
		if fileexists(is_reading_bitmaps[li_i]) then
			p_2.PictureName = is_reading_bitmaps[li_i]
		end if		
		for li_j  = 1 to upperbound(iuo_st)
			if iuo_st[li_j].ii_index = li_i then
				iuo_st[li_j].backcolor = iuo_st[li_j].il_hi_light_color
			end if
		next
	end if
next
	
return 0
end function

on w_container_reading.create
int iCurrent
call super::create
this.cb_play=create cb_play
this.p_2=create p_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_play
this.Control[iCurrent+2]=this.p_2
end on

on w_container_reading.destroy
call super::destroy
destroy(this.cb_play)
destroy(this.p_2)
end on

event clicked;call super::clicked;//ParentWindow().post dynamic wf_container_clicked(ii_id)

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

type p_dimension_test from w_container`p_dimension_test within w_container_reading
end type

type p_1 from w_container`p_1 within w_container_reading
integer x = 5
integer y = 0
integer width = 2153
integer height = 1380
boolean enabled = true
string picturename = ".\color_silver.bmp"
end type

event p_1::clicked;call super::clicked;//parent.post event clicked(0, 0, 0)
end event

type cb_play from u_commandbutton within w_container_reading
integer x = 3776
integer y = 1388
integer width = 558
integer height = 76
boolean bringtotop = true
string text = "Read For Me Again"
end type

event clicked;call super::clicked;integer li_i, li_j
string ls_local_file

for li_i = 1 to upperbound(is_reading_phrases)
	for li_j = 1 to upperbound(iuo_st)
		iuo_st[li_j].backcolor = iuo_st[li_j].il_default_color
	next
	for li_j  = 1 to upperbound(iuo_st)
		if iuo_st[li_j].ii_index = li_i then
			iuo_st[li_j].backcolor = iuo_st[li_j].il_hi_light_color
		end if
	next
	
	ls_local_file = "phrase" + string(li_i) + right(is_reading_bitmaps[li_i], 4)
	if f_getcacheresourcefile(is_reading_bitmaps[li_i], ls_local_file) = 1 then
		p_2.PictureName = ls_local_file
		f_set_garbage_file(ls_local_file)	
	end if			
	ls_local_file = "phrase" + right(is_reading_sounds[li_i], 4)
	if f_getcacheresourcefile(is_reading_sounds[li_i], ls_local_file) = 1 then
		f_set_garbage_file(ls_local_file)	
		sndPlaySoundA(ls_local_file, 0)
	end if
next
for li_j  = 1 to upperbound(iuo_st)
	if iuo_st[li_j].ii_index = li_i then
		iuo_st[li_j].backcolor = iuo_st[li_j].il_default_color
	end if
next
if ib_hint then
	wf_set_hint( is_hint )
end if

end event

type p_2 from p_1 within w_container_reading
integer x = 2185
integer y = 4
integer width = 2149
boolean bringtotop = true
end type

