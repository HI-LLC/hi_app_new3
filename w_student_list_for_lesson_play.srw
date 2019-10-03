$PBExportHeader$w_student_list_for_lesson_play.srw
forward
global type w_student_list_for_lesson_play from w_sheet
end type
type p_1 from picture within w_student_list_for_lesson_play
end type
end forward

global type w_student_list_for_lesson_play from w_sheet
boolean visible = false
integer x = 46
integer y = 52
integer width = 3808
integer height = 1924
long backcolor = 67108864
event lbuttonup pbm_lbuttonup
event ue_paint pbm_paint
p_1 p_1
end type
global w_student_list_for_lesson_play w_student_list_for_lesson_play

type variables
uo_lv_item ioval[]
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
nvo_datastore ids_group_student

end variables

forward prototypes
public subroutine wf_set_pos (long al_x, long al_y, long al_width, long al_height)
public subroutine wf_init_draw_bean (integer ai_count, integer ai_style)
public subroutine wf_get_dimension (integer a_count, integer a_width, integer a_height, ref long a_rows, ref long a_cols, integer a_style)
public subroutine wf_set_count (integer ai_count, integer ai_style, long al_color)
end prototypes

public subroutine wf_set_pos (long al_x, long al_y, long al_width, long al_height);x = al_x
y = al_y
width = al_width
height = al_height
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
	ioval[li_i] = create uo_lv_item
	ioval[li_i].iw_parent = this
	openuserobject(ioval[li_i], ll_x, ll_y)
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

end subroutine

on w_student_list_for_lesson_play.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_student_list_for_lesson_play.destroy
call super::destroy
destroy(this.p_1)
end on

event open;long ll_rowcount, ll_row, ll_i, ll_p_i
string ls_student, ls_first_name, ls_last_name
integer li_row, li_i
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null


ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
ids_group_student = create nvo_datastore
ids_group_student.dataobject = "d_group_student"

gn_appman.il_student_group_id = 0
ids_group_student.is_database_table = "GroupStudent"
if gn_appman.il_student_group_id > 0 then											
ids_group_student.is_select_sql = "Select g.account_id as account_id, g.group_id as group_id, g.student_id as student_id, " + &
											"s.last_name as last_name, s.first_name as first_name, s.photo as photo from GroupStudent As g left " + &
											"outer join Student As s on g.account_id eq s.account_id and " + &
											"g.student_id eq s.student_id where g.account_id eq " + string(gn_appman.il_account_id)
	ids_group_student.is_select_sql = ids_group_student.is_select_sql + &
											" and g.group_id eq " + string(gn_appman.il_student_group_id)
else
	ids_group_student.is_select_sql = ""
ids_group_student.is_select_sql = "Select account_id, student_id, last_name, first_name, " + &
											"photo from Student where account_id eq " + string(gn_appman.il_account_id)
end if

ids_group_student.data_retrieve()
ll_rowcount = ids_group_student.RowCount()
if ll_rowcount > 0 then
	wf_set_count(ll_rowcount, 0, 0)
end if
for ll_row = 1 to ids_group_student.RowCount()
	ls_last_name = ids_group_student.GetItemString(ll_row, "last_name")
	ls_first_name = ids_group_student.GetItemString(ll_row, "first_name")
	if isnull(ls_last_name) then ls_last_name = ""
	if isnull(ls_first_name) then ls_first_name = ""
	ls_last_name = trim(ls_last_name)
	ls_first_name = trim(ls_first_name)
	if len(ls_last_name) > 0 and len(ls_first_name) > 0 then
		ls_student = ls_last_name + ", " + ls_first_name
	else
		ls_student = ls_last_name + ls_first_name
	end if
	if not isnull(ls_student) and isvalid(ioval[ll_row].object_label) then
		ioval[ll_row].object_label.text = ls_student
	end if
	if isnull(ids_group_student.GetItemString(ll_row, "photo")) then continue
	if trim(ids_group_student.GetItemString(ll_row, "photo")) = "" then continue
	ls_remote_file_prefix = string(ids_group_student.GetItemNumber(ll_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + string(ids_group_student.GetItemNumber(ll_row, "student_id"), "000000")	
	ls_file_extension = trim(ids_group_student.GetItemString(ll_row, "photo"))
	ls_remote_file = ls_remote_file_path + "/" + ls_remote_file_prefix + "." + ls_file_extension
	ls_local_file = ls_remote_file_prefix + "." + ls_file_extension
	extGetBinaryFile(ls_local_file, ls_remote_file)
	is_garbage_file_list[upperbound(is_garbage_file_list) + 1] = ls_local_file	
	ioval[ll_row].p_1.picturename = ls_local_file
	//ioval[li_i].wf_object_zoom(1.5)
	ioval[ll_row].p_1.BringToTop = true				
next

end event

event close;integer ii_i

for ii_i = 1 to upperbound(ioval)
	if isvalid(ioval[ii_i]) then
		destroy ioval[ii_i]
	end if
next	
destroy ids_group_student

close(this)
end event

type p_1 from picture within w_student_list_for_lesson_play
event ue_paint pbm_paint
integer x = 18
integer y = 20
integer width = 3721
integer height = 1768
boolean enabled = false
string picturename = "C:\Han\PB Apps\Light End - Internet\color_orange.BMP"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

