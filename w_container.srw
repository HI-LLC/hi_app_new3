$PBExportHeader$w_container.srw
forward
global type w_container from window
end type
type p_1 from picture within w_container
end type
end forward

global type w_container from window
boolean visible = false
integer x = 46
integer y = 52
integer width = 1861
integer height = 984
windowtype windowtype = child!
long backcolor = 16776960
event lbuttonup pbm_lbuttonup
event ue_paint pbm_paint
p_1 p_1
end type
global w_container w_container

type variables
uo_count ioval[]
long il_oval_color
string is_bean_picturename
string is_bean_dragicon
boolean ib_target = false, ib_source = false

str_mousepos i_mousepos
integer ii_bean_moving_type = 0 // 0 = not deleting source, 
integer ii_bean_count = 0, ii_answer_list[]
integer ii_id
boolean ib_drag = false
boolean ib_to_stop_movie = false
boolean ib_stopped = true
long x0, y0

// to position beans
long il_row, il_col, il_rows, il_cols
long il_dot_height, il_dot_width, il_x_interval, il_y_interval

// window flashing color
long il_flashing_color[2] = {1672215, 16711935} // white and Fuchsia (pink)
integer ii_flashing_color_index = 1
integer ii_flash_index_begin
integer ii_flash_index_end
integer ii_height, ii_width

uo_count iuo_count
end variables

forward prototypes
public subroutine wf_set_pos (long al_x, long al_y, long al_width, long al_height)
public subroutine wf_set_oval_color (long al_color)
public subroutine wf_set_size (real ar_ratio, long al_color)
public subroutine wf_set_timer (decimal adec_second)
public subroutine wf_init_draw_bean (integer ai_count, integer ai_style)
public subroutine wf_set_height (real ar_ratio, long al_color)
public function integer wf_get_bean_count ()
public subroutine wf_reset_count_size (integer ai_width, integer ai_height)
public subroutine wf_reset_backcolor ()
public subroutine wf_draw_number (integer ai_count_list[], integer ai_style, long al_color)
public subroutine wf_draw_alpha (string as_alpha[], integer ai_style, long al_color)
public subroutine wf_draw_a_bean ()
public subroutine wf_draw_alpha (string as_alpha, integer ai_style, long al_color)
public subroutine wf_draw_number (integer ai_count, integer ai_style, long al_color)
public subroutine wf_draw_number (integer ai_from, integer ai_to, integer ai_style, long al_color)
public subroutine wf_get_dimension (integer a_count, integer a_width, integer a_height, ref long a_rows, ref long a_cols, integer a_style)
public subroutine wf_set_count ()
public subroutine wf_set_count (integer ai_count, integer ai_style, long al_color)
public subroutine wf_set_height (integer ai_height, long al_color)
public subroutine wf_set_size (integer ai_size, long al_color)
end prototypes

public subroutine wf_set_pos (long al_x, long al_y, long al_width, long al_height);x = al_x
y = al_y
width = al_width
height = al_height
end subroutine

public subroutine wf_set_oval_color (long al_color);long ll_count, ll_i
ll_count = upperbound(ioval)
for ll_i = 1 to ll_count
	if isvalid(ioval[ll_i]) then
		ioval[ll_i].oval_1.fillcolor = al_color
		ioval[ll_i].oval_1.linecolor = al_color
		ioval[ll_i].backcolor = backcolor
	end if
next
		
end subroutine

public subroutine wf_set_size (real ar_ratio, long al_color);integer li_width, li_height, li_x, li_y
integer li_i, li_size
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

ioval[1] = create uo_count_comparison
ioval[1].iw_parent = this
ioval[1].width = width*ar_ratio
ioval[1].height = height*ar_ratio

ioval[1].p_1.PictureName = is_bean_picturename

ioval[1].ii_index = 1
li_x = (width - ioval[1].width)/2
li_y = (height - ioval[1].height)/2
openuserobject(ioval[1], li_x, li_y)
ioval[1].of_set_radius(ioval[1].height, ioval[1].width)
ioval[1].visible = true
ioval[1].BringToTop = true
ii_bean_count = 1

end subroutine

public subroutine wf_set_timer (decimal adec_second);timer(adec_second)
end subroutine

public subroutine wf_init_draw_bean (integer ai_count, integer ai_style);long ll_x_interval, ll_y_interval
long ll_x_ratio, ll_y_ratio
long ll_x, ll_y
integer li_i
ll_x_ratio = 5
ll_y_ratio = 4
if ai_count < 1 then return
wf_get_dimension(ai_count, width, height, il_rows, il_cols, ai_style)

il_x_interval = width/il_cols
il_y_interval = height/il_rows

if il_x_interval*ll_y_ratio > il_y_interval*ll_y_ratio then // x > Y
	il_dot_width = (il_y_interval*ll_x_ratio*2)/(ll_y_ratio*3)
	il_dot_height = il_y_interval*2/3
else
	il_dot_width = (il_x_interval*2/3)
	il_dot_height = (il_x_interval*ll_y_ratio*2)/(ll_x_ratio*3)
end if

il_row = 1
il_col = 1
end subroutine

public subroutine wf_set_height (real ar_ratio, long al_color);integer li_width, li_height, li_x, li_y
integer li_i, li_size

for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

ioval[1] = create uo_count_comparison
ioval[1].iw_parent = this
ioval[1].p_1.PictureName = is_bean_picturename
ioval[1].ii_index = 1
li_width = ioval[1].width
ioval[1].height = p_1.height*ar_ratio
li_height = ioval[1].height 
li_x = (width - li_width)/2
li_y = height - li_height - (height - p_1.height)/2
openuserobject(ioval[1], li_x, li_y)
ioval[1].of_set_radius(li_height, li_width)
ioval[1].visible = true
ioval[1].BringToTop = true
ii_bean_count = 1
end subroutine

public function integer wf_get_bean_count ();integer li_i, li_count = 0
for li_i = 1 to upperbound(ioval)
	if isvalid(ioval[li_i]) then
		li_count++
	end if
next

return li_count

end function

public subroutine wf_reset_count_size (integer ai_width, integer ai_height);long ll_width_diff, ll_height_diff
long ll_x, ll_y
integer li_i

ll_width_diff = ioval[1].width - ai_width
ll_height_diff = ioval[1].height - ai_height

for li_i = 1 to upperbound(ioval)
	ioval[li_i].x = ioval[li_i].x + (ll_width_diff/2)
	ioval[li_i].y = ioval[li_i].y + (ll_height_diff/2)
	ioval[li_i].height = ioval[li_i].height - ll_height_diff
	ioval[li_i].width = ioval[li_i].width - ll_width_diff
next


end subroutine

public subroutine wf_reset_backcolor ();if isvalid(iuo_count) then
	iuo_count.backcolor = iuo_count.il_backcolor
end if
end subroutine

public subroutine wf_draw_number (integer ai_count_list[], integer ai_style, long al_color);long ll_rows, ll_cols, ll_row, ll_col, ll_x_interval, ll_y_interval
long ll_dot_width, ll_dot_height, ll_x_ratio, ll_y_ratio
long ll_x, ll_y
integer li_i, li_count
ll_x_ratio = 5
ll_y_ratio = 4
if upperbound(ai_count_list) = 0 then return
wf_get_dimension(upperbound(ai_count_list), width, height, ll_rows, ll_cols, ai_style)

ll_x_interval = width/ll_cols
ll_y_interval = height/ll_rows

if ll_x_interval*ll_y_ratio > ll_y_interval*ll_y_ratio then // x > Y
	ll_dot_width = (ll_y_interval*ll_x_ratio*2)/(ll_y_ratio*3)
	ll_dot_height = ll_y_interval*2/3
else
	ll_dot_width = (ll_x_interval*2/3)
	ll_dot_height = (ll_x_interval*ll_y_ratio*2)/(ll_x_ratio*3)
end if

ll_row = 1
ll_col = 1
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

for li_i = 1 to upperbound(ai_count_list)
	li_count = ai_count_list[li_i]
	ioval[li_i] = create uo_count_number
	ioval[li_i].iw_parent = this
	ioval[li_i].DragIcon = is_bean_dragicon
	ioval[li_i].ii_index = li_i
	ioval[li_i].iw_parent = this	
	ll_x = (ll_col - 1)*ll_x_interval + (ll_x_interval - ll_dot_width)/2
	ll_y = (ll_row - 1)*ll_y_interval + (ll_y_interval - ll_dot_height)/2
	openuserobject(ioval[li_i], ll_x, ll_y)
	ioval[li_i].ii_x = ioval[li_i].x
	ioval[li_i].ii_y = ioval[li_i].y
	ioval[li_i].p_1.visible = false
	ioval[li_i].dynamic of_write_number(li_count)
	ioval[li_i].visible = true
	ioval[li_i].BringToTop = true
	if mod(li_i, ll_cols) = 0 then
		ll_row++
		ll_col = 1
	else
		ll_col++
	end if
next
ii_bean_count =  upperbound(ai_count_list)
//wf_set_oval_color(al_color)
end subroutine

public subroutine wf_draw_alpha (string as_alpha[], integer ai_style, long al_color);integer li_i, li_j, li_count, li_sum_width, li_width, li_net_width, li_row, li_col, li_height = 125
long li_row_count, li_width_list[], li_x_interval, li_y_interval, li_x, li_y
ulong li_dc
string ls_tmp
str_string_array ls_layout_list[]
real lr_height_ratio, lr_xy_ratio
str_size lstr_str_size
uo_count_alpha luo_count_alpha
li_count = upperbound(as_alpha)
if pos(ParentWindow().ClassName(), 'w_lesson_unscramble') = 0 then return
if li_count < 1 then return
li_row = 1
li_j = 0
li_dc = GetDc(handle(this))
lr_xy_ratio = PixelsToUnits(1000, XPixelsToUnits!)/PixelsToUnits(1000, YPixelsToUnits!)
li_sum_width = 0
li_i = 1
li_width_list[1] = 0
for li_i = 1 to upperbound(as_alpha)
	GetTextExtentPoint32A(li_dc, as_alpha[li_i] /*+ '    '*/, len(as_alpha[li_i]) + 2, lstr_str_size)
	lr_height_ratio = li_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)
	li_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
	li_width =  li_width*lr_xy_ratio*lr_height_ratio
	li_sum_width = li_sum_width + li_width
	if li_sum_width < (this.width*8)/10 then
		li_j++
		GetTextExtentPoint32A(li_dc, as_alpha[li_i], len(as_alpha[li_i]), lstr_str_size)
		li_net_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
		li_net_width =  li_net_width*lr_xy_ratio*lr_height_ratio
		li_width_list[li_row] = li_width_list[li_row] + li_net_width		
		ls_layout_list[li_row].array[li_j] = as_alpha[li_i]
	else
		li_sum_width = li_width
		li_row = li_row + 1
		li_j = 1
		ls_layout_list[li_row].array[li_j] = as_alpha[li_i]
		li_width_list[li_row] = li_width
	end if
next
li_row_count = upperbound(ls_layout_list)
li_y_interval = height/(li_row_count + 1)
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

li_i = 0
li_y = li_y_interval - (li_height/2)
for li_row = 1 to li_row_count
	li_x_interval = (this.width - li_width_list[li_row])/(upperbound(ls_layout_list[li_row].array) + 1)
	li_x = li_x_interval
	for li_col = 1 to upperbound(ls_layout_list[li_row].array)
		li_i++
		ioval[li_i] = create uo_count_alpha
		ioval[li_i].iw_parent = this
		ioval[li_i].DragIcon = is_bean_dragicon
		ioval[li_i].ii_index = li_i
		ioval[li_i].iw_parent = this
		ls_tmp = ls_layout_list[li_row].array[li_col]
		GetTextExtentPoint32A(li_dc, ls_tmp, len(ls_tmp), lstr_str_size)
		lr_height_ratio = li_height/PixelsToUnits(lstr_str_size.cy, YPixelsToUnits!)		
		li_width = PixelsToUnits(lstr_str_size.cx, XPixelsToUnits!)
		li_width =  li_width*lr_xy_ratio*lr_height_ratio	
		openuserobject(ioval[li_i], li_x, li_y)
		ioval[li_i].x = li_x
		ioval[li_i].y = li_y
		ioval[li_i].p_1.visible = false
		ioval[li_i].visible = true
		ioval[li_i].BringToTop = true
		ioval[li_i].ii_x = ioval[li_i].x
		ioval[li_i].ii_y = ioval[li_i].y
		ioval[li_i].ii_width = li_width
		ioval[li_i].ii_height = li_height
		ioval[li_i].width = li_width
		ioval[li_i].height = li_height	
		luo_count_alpha = ioval[li_i]
		luo_count_alpha.width = li_width + 16
		luo_count_alpha.height = li_height + 5
		luo_count_alpha.st_number.textsize = 32
		luo_count_alpha.st_number.text = ls_tmp
		luo_count_alpha.st_number.visible = true
		luo_count_alpha.st_number.width = li_width
		luo_count_alpha.st_number.height = li_height		
		li_x = li_x + li_width + li_x_interval
	next
	li_y = li_y + li_y_interval
next
ii_bean_count = li_count

end subroutine

public subroutine wf_draw_a_bean ();integer li_i
long ll_x, ll_y
li_i = wf_get_bean_count() + 1
if ParentWindow().ClassName() = 'w_lesson_dragdrop_count' or ParentWindow().ClassName() = 'w_lesson_mw_cmmnd' then
	ioval[li_i] = create uo_count_dragdrop
elseif ParentWindow().ClassName() = 'w_lesson_comp_scale' then
	ioval[li_i] = create uo_count_comparison
else
	MessageBox('Error', 'Wrong Parent in calling the container')
end if
ioval[li_i].iw_parent = this
ioval[li_i].p_1.PictureName = is_bean_picturename
ioval[li_i].DragIcon = is_bean_dragicon
ioval[li_i].ii_index = li_i
ioval[li_i].iw_parent = this
ll_x = (il_col - 1)*il_x_interval + (il_x_interval - il_dot_width)/2
ll_y = height - ((il_row - 1)*il_y_interval + (il_y_interval - il_dot_height)/2) - 100
openuserobject(ioval[li_i], ll_x, ll_y)
ioval[li_i].visible = true
ioval[li_i].BringToTop = true
if mod(li_i, il_cols) = 0 then
	il_row++
	il_col = 1
else
	il_col++
end if

end subroutine

public subroutine wf_draw_alpha (string as_alpha, integer ai_style, long al_color);long ll_rows, ll_cols, ll_row, ll_col, ll_x_interval, ll_y_interval
long ll_dot_width, ll_dot_height, ll_x_ratio, ll_y_ratio
long ll_x, ll_y
integer li_i, li_count
ll_x_ratio = 5
ll_y_ratio = 4
li_count = len(as_alpha)
if pos(ParentWindow().ClassName(), 'w_lesson_unscramble') = 0 then return
if li_count < 1 then return
wf_get_dimension(li_count, width, height, ll_rows, ll_cols, ai_style)

ll_x_interval = width/ll_cols
ll_y_interval = height/ll_rows

if ll_x_interval*ll_y_ratio > ll_y_interval*ll_y_ratio then // x > Y
	ll_dot_width = (ll_y_interval*ll_x_ratio*2)/(ll_y_ratio*3)
	ll_dot_height = ll_y_interval*2/3
else
	ll_dot_width = (ll_x_interval*2/3)
	ll_dot_height = (ll_x_interval*ll_y_ratio*2)/(ll_x_ratio*3)
end if

ll_row = 1
ll_col = 1
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

for li_i = 1 to li_count
	ioval[li_i] = create uo_count_alpha
	ioval[li_i].iw_parent = this
	ioval[li_i].DragIcon = is_bean_dragicon
	ioval[li_i].ii_index = li_i
	ioval[li_i].iw_parent = this
	ll_x = (ll_col - 1)*ll_x_interval + (ll_x_interval - ll_dot_width)/2
	ll_y = (ll_row - 1)*ll_y_interval + (ll_y_interval - ll_dot_height)/2
	openuserobject(ioval[li_i], ll_x, ll_y)
	ioval[li_i].p_1.visible = false
	ioval[li_i].p_1.BringToTop = false
	ioval[li_i].p_1.width = 1
	ioval[li_i].p_1.height = 1
	ioval[li_i].visible = true
	ioval[li_i].BringToTop = true
	ioval[li_i].ii_x = ioval[li_i].x
	ioval[li_i].ii_y = ioval[li_i].y
	ioval[li_i].dynamic of_write_alpha(mid(as_alpha, li_i, 1))
	ioval[li_i].st_number.BringToTop = true
	if mod(li_i, ll_cols) = 0 then
		ll_row++
		ll_col = 1
	else
		ll_col++
	end if
next
ii_bean_count = li_count

end subroutine

public subroutine wf_draw_number (integer ai_count, integer ai_style, long al_color);long ll_rows, ll_cols, ll_row, ll_col, ll_x_interval, ll_y_interval
long ll_dot_width, ll_dot_height, ll_x_ratio, ll_y_ratio
long ll_x, ll_y
integer li_i
ll_x_ratio = 5
ll_y_ratio = 4
if ParentWindow().ClassName() <> 'w_lesson_numbermatch_count' and &
	ParentWindow().ClassName() <> 'w_lesson_addition' and &
	ParentWindow().ClassName() <> 'w_lesson_subtraction' then return
if ai_count < 1 then return
wf_get_dimension(ai_count + 1, width, height, ll_rows, ll_cols, ai_style)

ll_x_interval = width/ll_cols
ll_y_interval = height/ll_rows

if ll_x_interval*ll_y_ratio > ll_y_interval*ll_y_ratio then // x > Y
	ll_dot_width = (ll_y_interval*ll_x_ratio*2)/(ll_y_ratio*3)
	ll_dot_height = ll_y_interval*2/3
else
	ll_dot_width = (ll_x_interval*2/3)
	ll_dot_height = (ll_x_interval*ll_y_ratio*2)/(ll_x_ratio*3)
end if

ll_row = 1
ll_col = 1
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next
for li_i = 1 to ai_count + 1
	ioval[li_i] = create uo_count_number
	ioval[li_i].iw_parent = this
	ioval[li_i].DragIcon = is_bean_dragicon
	ioval[li_i].ii_index = li_i
	ioval[li_i].iw_parent = this	
	ll_x = (ll_col - 1)*ll_x_interval + (ll_x_interval - ll_dot_width)/2
	ll_y = (ll_row - 1)*ll_y_interval + (ll_y_interval - ll_dot_height)/2
	openuserobject(ioval[li_i], ll_x, ll_y)
	ioval[li_i].visible = true
	ioval[li_i].BringToTop = true
	ioval[li_i].ii_x = ioval[li_i].x
	ioval[li_i].ii_y = ioval[li_i].y
	ioval[li_i].dynamic of_write_number(li_i - 1)
	if mod(li_i, ll_cols) = 0 then
		ll_row++
		ll_col = 1
	else
		ll_col++
	end if
next
ii_bean_count = ai_count + 1

end subroutine

public subroutine wf_draw_number (integer ai_from, integer ai_to, integer ai_style, long al_color);long ll_rows, ll_cols, ll_row, ll_col, ll_x_interval, ll_y_interval
long ll_dot_width, ll_dot_height, ll_x_ratio, ll_y_ratio
long ll_x, ll_y
integer li_i, li_count
ll_x_ratio = 5
ll_y_ratio = 4
if ai_to < ai_from then return
wf_get_dimension(ai_to - ai_from + 1, width, height, ll_rows, ll_cols, ai_style)

ll_x_interval = width/ll_cols
ll_y_interval = height/ll_rows

if ll_x_interval*ll_y_ratio > ll_y_interval*ll_y_ratio then // x > Y
	ll_dot_width = (ll_y_interval*ll_x_ratio*2)/(ll_y_ratio*3)
	ll_dot_height = ll_y_interval*2/3
else
	ll_dot_width = (ll_x_interval*2/3)
	ll_dot_height = (ll_x_interval*ll_y_ratio*2)/(ll_x_ratio*3)
end if

ll_row = 1
ll_col = 1
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

for li_i = 1 to ai_to - ai_from + 1
	li_count = ai_from + li_i - 1
	ioval[li_i] = create uo_count_number
	ioval[li_i].iw_parent = this
	ioval[li_i].DragIcon = is_bean_dragicon
	ioval[li_i].ii_index = li_i
	ioval[li_i].iw_parent = this	
	ll_x = (ll_col - 1)*ll_x_interval + (ll_x_interval - ll_dot_width)/2
	ll_y = (ll_row - 1)*ll_y_interval + (ll_y_interval - ll_dot_height)/2
	openuserobject(ioval[li_i], ll_x, ll_y)
	ioval[li_i].ii_x = ioval[li_i].x
	ioval[li_i].ii_y = ioval[li_i].y
	ioval[li_i].dynamic of_write_number(li_count)
	ioval[li_i].visible = true
	ioval[li_i].BringToTop = true
	if mod(li_i, ll_cols) = 0 then
		ll_row++
		ll_col = 1
	else
		ll_col++
	end if
next
ii_bean_count = ai_to - ai_from + 1
//wf_set_oval_color(al_color)
end subroutine

public subroutine wf_get_dimension (integer a_count, integer a_width, integer a_height, ref long a_rows, ref long a_cols, integer a_style);long ll_rows, ll_cols
double lr_rows, lr_cols, lr_height, lr_width, lr_count
double lr_ratio, lr_ratio_row_plus, lr_ratio_col_plus
lr_height = double(a_height)
lr_width = double(a_width)
lr_count = double(a_count)
lr_ratio = lr_width*4/(lr_height*5)
if a_style = 0 then
	ll_rows = integer(sqrt(double(a_count)))
	ll_cols = ll_rows
	if ll_cols * ll_rows < a_count then
		ll_cols++
		if ll_cols * ll_rows < a_count then
			ll_rows++
		end if
	end if	
else
	lr_rows = truncate(sqrt(lr_count/lr_ratio), 0)
	if lr_rows = 0.0 then lr_rows = 1.0
	lr_cols = truncate(lr_count/lr_rows, 0)
	if lr_cols * lr_rows < lr_count then
		lr_ratio_row_plus = (lr_cols)/(lr_rows + 1)
		lr_ratio_col_plus = (lr_cols + 1)/lr_rows
		if abs(lr_ratio - lr_ratio_col_plus) < abs(lr_ratio - lr_ratio_row_plus) then
			lr_cols = lr_cols + 1
			if lr_cols * lr_rows < lr_count then
				lr_rows = lr_rows + 1
			end if
		else
			lr_rows = lr_rows + 1
			if lr_cols * lr_rows < lr_count then
				lr_cols = lr_cols + 1
			end if			
		end if
	end if	
	ll_rows = long(lr_rows)
	ll_cols = long(lr_cols)
end if

a_rows = ll_rows
a_cols = ll_cols

end subroutine

public subroutine wf_set_count ();integer li_width, li_height, li_x, li_y
integer li_i
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

ioval[1] = create uo_count_comparison
ioval[1].iw_parent = this
ioval[1].p_1.PictureName = is_bean_picturename
ioval[1].ii_index = 1
li_width = ioval[1].width * 2
li_height = ioval[1].height * 2
li_x = (width - li_width)/2
li_y = (height - li_height)/2
openuserobject(ioval[1], li_x, li_y)
ioval[1].width = li_width
ioval[1].height = li_height
ioval[1].p_1.width = li_width
ioval[1].p_1.height = li_height
ioval[1].visible = true
ioval[1].BringToTop = true
ii_bean_count = 1

end subroutine

public subroutine wf_set_count (integer ai_count, integer ai_style, long al_color);long ll_rows, ll_cols, ll_row, ll_col, ll_x_interval, ll_y_interval
long ll_dot_width, ll_dot_height, ll_x_ratio, ll_y_ratio
long ll_x, ll_y
integer li_i
ll_x_ratio = 5
ll_y_ratio = 4
if ai_count < 1 then return
wf_get_dimension(ai_count, width, height, ll_rows, ll_cols, ai_style)

ll_x_interval = width/ll_cols
ll_y_interval = height/ll_rows

if ll_x_interval*ll_y_ratio > ll_y_interval*ll_y_ratio then // x > Y
	ll_dot_width = (ll_y_interval*ll_x_ratio*2)/(ll_y_ratio*3)
	ll_dot_height = ll_y_interval*2/3
else
	ll_dot_width = (ll_x_interval*2/3)
	ll_dot_height = (ll_x_interval*ll_y_ratio*2)/(ll_x_ratio*3)
end if

ll_row = 1
ll_col = 1
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
	end if
next


for li_i = 1 to ai_count
	ll_x = (ll_col - 1)*ll_x_interval + (ll_x_interval - ll_dot_width)/2
	ll_y = (ll_row - 1)*ll_y_interval + (ll_y_interval - ll_dot_height)/2
	if li_i > upperbound(ioval) then 
		choose case ParentWindow().ClassName()
			case 'w_lesson_dragdrop_count', 'w_lesson_mw_cmmnd'
				ioval[li_i] = create uo_count_dragdrop
			case 'w_lesson_comp_scale'
				ioval[li_i] = create uo_count_comparison
			case 'w_lesson_numbermatch_count'
				ioval[li_i] = create uo_count_comparison
			case 'w_lesson_addition', 'w_lesson_subtraction'
				ioval[li_i] = create uo_count_comparison
				ioval[li_i].height = ll_dot_height
				ioval[li_i].width = ll_dot_width
			case else
				MessageBox('Error', 'Wrong Parent in calling the container')
		end choose
		openuserobject(ioval[li_i], ll_x, ll_y)
	else
		ioval[li_i].x = ll_x
		ioval[li_i].y = ll_y
		if ParentWindow().ClassName() = 'w_lesson_addition' or ParentWindow().ClassName() = 'w_lesson_subtraction' then
			ioval[li_i].height = ll_dot_height
			ioval[li_i].width = ll_dot_width
		end if			
	end if
	ioval[li_i].iw_parent = this
	ioval[li_i].p_1.PictureName = is_bean_picturename
	ioval[li_i].DragIcon = is_bean_dragicon
	ioval[li_i].ii_index = li_i
	ioval[li_i].iw_parent = this
	ioval[li_i].visible = true
	ioval[li_i].BringToTop = true
	if mod(li_i, ll_cols) = 0 then
		ll_row++
		ll_col = 1
	else
		ll_col++
	end if
next
ii_bean_count = ai_count
wf_set_oval_color(al_color)



end subroutine

public subroutine wf_set_height (integer ai_height, long al_color);integer li_width, li_height, li_x, li_y
integer li_i, li_size
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

ioval[1] = create uo_count_comparison
ioval[1].iw_parent = this
ioval[1].p_1.PictureName = is_bean_picturename
ioval[1].ii_index = 1
li_width = ioval[1].width
li_height = ioval[1].height * ai_height
li_x = (width - li_width)/2
li_y = height - li_height - 50
openuserobject(ioval[1], li_x, li_y)
ioval[1].of_set_radius(li_height, li_width)
ioval[1].visible = true
ioval[1].BringToTop = true
ii_bean_count = 1

end subroutine

public subroutine wf_set_size (integer ai_size, long al_color);integer li_width, li_height, li_x, li_y
integer li_i, li_size
li_size = ai_size
for li_i = 1 to upperbound(ioval)
	if isvalid (ioval[li_i]) then
		ioval[li_i].visible = false
		destroy ioval[li_i]
	end if
next

ioval[1] = create uo_count_comparison
ioval[1].iw_parent = this
ioval[1].p_1.PictureName = is_bean_picturename
ioval[1].ii_index = 1
li_width = ioval[1].width * li_size
li_height = ioval[1].height * li_size
li_x = (width - li_width)/2

li_y = (height - li_height)/2
openuserobject(ioval[1], li_x, li_y)
ioval[1].of_set_radius(li_height, li_width)
ioval[1].visible = true
ioval[1].BringToTop = true
ii_bean_count = 1

end subroutine

on w_container.create
this.p_1=create p_1
this.Control[]={this.p_1}
end on

on w_container.destroy
destroy(this.p_1)
end on

event open;ii_width = width
ii_height = height

p_1.BringToTop = false

end event

event close;integer ii_i

for ii_i = 1 to upperbound(ioval)
	if isvalid(ioval[ii_i]) then
		destroy ioval[ii_i]
	end if
next	

close(this)
end event

event key;
return ParentWindow().event key(key, keyflags)
end event

event timer;ii_flashing_color_index = Mod(ii_flashing_color_index, 2) + 1
if isvalid(iuo_count) then
	iuo_count.BackColor = il_flashing_color[ii_flashing_color_index]
else
	BackColor = il_flashing_color[ii_flashing_color_index]
end if

end event

event dragwithin;w_lesson lw_lesson
long li_x, li_y
GetCursorPos(i_mousepos)
li_x = PixelsToUnits(i_mousepos.xpos, XPixelsToUnits!)
li_y = PixelsToUnits(i_mousepos.ypos, YPixelsToUnits!)
li_x = li_x - ParentWindow().x - ParentWindow().WorkSpaceX() - 100
li_y = li_y - ParentWindow().y - ParentWindow().WorkSpaceY() - 100
lw_lesson = ParentWindow()
lw_lesson.wf_mousemove(li_x, li_y)

end event

type p_1 from picture within w_container
event ue_paint pbm_paint
integer x = 18
integer y = 20
integer width = 1733
integer height = 864
boolean enabled = false
string picturename = ".\color_blue.JPG"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

