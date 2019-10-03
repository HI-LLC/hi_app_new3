$PBExportHeader$w_student_lesson_list.srw
forward
global type w_student_lesson_list from w_sheet
end type
type p_1 from picture within w_student_lesson_list
end type
end forward

global type w_student_lesson_list from w_sheet
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
global w_student_lesson_list w_student_lesson_list

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

nvo_datastore ids_student_lesson

end variables

forward prototypes
public subroutine wf_set_pos (long al_x, long al_y, long al_width, long al_height)
public subroutine wf_init_draw_bean (integer ai_count, integer ai_style)
public subroutine wf_get_dimension (integer a_count, integer a_width, integer a_height, ref long a_rows, ref long a_cols, integer a_style)
public subroutine wf_set_count (integer ai_count, integer ai_style, long al_color)
public subroutine wf_play_lesson (long al_method_id, string as_lesson_file)
public subroutine wf_load_and_play_lesson (integer ai_row)
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

public subroutine wf_play_lesson (long al_method_id, string as_lesson_file);long ll_winhandle
ll_winhandle = handle(this)
gn_appman.of_set_parm("Method ID", al_method_id)
ShowWindow(ll_winhandle, 6)
choose case al_method_id
	case 2 // Object Identification
		post OpenWithParm(w_lesson_discrete_trial, as_lesson_file)
	case 3 to 13 // Scale Comparison
		post OpenWithParm(w_lesson_comp_scale, as_lesson_file)
	case 14 // Counting - Number (Symbol) Match
		post OpenWithParm(w_lesson_numbermatch_count, as_lesson_file)
	case 15 // Counting - Drag-drop
		post OpenWithParm(w_lesson_dragdrop_count, as_lesson_file)
	case 16 // Object  Grouping
		post OpenWithParm(w_lesson_mw_cmmnd, as_lesson_file)
	case 17 to 19 // Object Comparison
		post OpenWithParm(w_lesson_comp_object, as_lesson_file)
	case 21 // Unscramble Words
		post OpenWithParm(w_lesson_unscramble_word, as_lesson_file)
	case 22 // Unscramble Sentences
		post OpenWithParm(w_lesson_unscramble_sentence, as_lesson_file)
	case 23 // Addition
		post OpenWithParm(w_lesson_addition, as_lesson_file)
	case 24 // Subtraction
		post OpenWithParm(w_lesson_subtraction, as_lesson_file)
	case 25 // Matching
		post OpenWithParm(w_lesson_matching, as_lesson_file)
end choose
end subroutine

public subroutine wf_load_and_play_lesson (integer ai_row);
string ls_remote_file_path, ls_lesson_file_name, ls_lesson_name, ls_lesson_subpath, ls_local_file, ls_local_file_con
long ll_method_id, ll_lesson_id, ll_count
ll_method_id = ids_student_lesson.GetItemNumber(ai_row, "method_id")
ll_lesson_id = ids_student_lesson.GetItemNumber(ai_row, "lesson_id")
ls_lesson_name = ids_student_lesson.GetItemString(ai_row, "lesson_name")
ls_lesson_subpath = ids_student_lesson.GetItemString(ai_row, "lesson_subpath")
ls_lesson_file_name = string(ll_method_id, "00") + ls_lesson_name + string(ll_lesson_id, "0000000000") + ".txt"
ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + ls_lesson_file_name

f_getonlinefile(ls_remote_file_path, ls_local_file)
//MessageBox(ls_local_file, ls_remote_file_path)
gn_appman.ids_lesson[1] = create datastore
gn_appman.ids_lesson[1].dataobject = 'd_lesson'
ll_count = gn_appman.ids_lesson[1].ImportFile(ls_lesson_file_name)
//FileDelete(LocalFileName)
if gn_appman.ids_lesson[1].RowCount() < 1 then
	MessageBox("Error", "No Lesson Content Loaded!")
	return
end if
if ll_method_id = 15 or ll_method_id = 16 then
	if upperbound(gn_appman.ids_lesson) > 1 then
		if isvalid(gn_appman.ids_lesson[2]) then
			destroy gn_appman.ids_lesson[2]
		end if
	end if
	ls_lesson_file_name = string(ll_method_id, "00") + ls_lesson_name + string(ll_lesson_id, "0000000000") + "_con.txt"
	ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_lessons/" + ls_lesson_subpath + "/" + ls_lesson_file_name
	f_getonlinefile(ls_remote_file_path, ls_local_file)
	gn_appman.ids_lesson[2] = create datastore
	gn_appman.ids_lesson[2].dataobject = 'd_lesson_container'
	ll_count = gn_appman.ids_lesson[2].ImportFile(ls_local_file)
//	FileDelete(LocalFileName)
end if

wf_play_lesson(ll_method_id, ls_local_file)










wf_play_lesson(ll_method_id, ls_local_file)
end subroutine

on w_student_lesson_list.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_student_lesson_list.destroy
call super::destroy
destroy(this.p_1)
end on

event open;long ll_rowcount, ll_row, ll_i, ll_p_i
string ls_student, ls_lesson_name
integer li_row, li_i
string ls_local_file, ls_remote_file_path, ls_remote_file_prefix, ls_remote_file, ls_file_extension
string ls_null

ls_remote_file_path = gn_appman.is_remote_site_path + "/LH_resources/static table/bitmap/student"
setnull(ls_null)
ids_student_lesson = create nvo_datastore
ids_student_lesson.dataobject = "d_student_lesson"

ids_student_lesson.is_database_table = "StudentLesson"
ids_student_lesson.is_select_sql = "select l.method_id as method_id, l.lesson_id as lesson_id,l.lesson_name as lesson_name, m.Lesson_subpath as Lesson_subpath, " + &
											" m.Method_cat_desc as Method_cat_desc, l.photo as photo From Lesson as l, StudentLesson as sl, Method As m Where l.lesson_id eq sl.lesson_id " + &
											" and l.account_id eq sl.account_id and l.method_id eq m.method_id " + & 
											" and sl.account_id eq " + string(gn_appman.il_account_id) + "and sl.student_id eq " + string(gn_appman.il_student_id)

ids_student_lesson.data_retrieve()
ll_rowcount = ids_student_lesson.RowCount()
if ll_rowcount > 0 then
	wf_set_count(ll_rowcount, 0, 0)
end if
for ll_row = 1 to ids_student_lesson.RowCount()
	ls_lesson_name = ids_student_lesson.GetItemString(ll_row, "Lesson_name")
	if isnull(ls_lesson_name) then ls_lesson_name = ""
	ioval[ll_row].object_label.text = ls_lesson_name
	if isnull(ids_student_lesson.GetItemString(ll_row, "photo")) then continue
	if trim(ids_student_lesson.GetItemString(ll_row, "photo")) = "" then continue
	ls_remote_file_prefix = string(ids_student_lesson.GetItemNumber(ll_row, "account_id"), "000000")
	ls_remote_file_prefix = ls_remote_file_prefix + string(ids_student_lesson.GetItemNumber(ll_row, "lesson_id"), "000000")	
	ls_file_extension = trim(ids_student_lesson.GetItemString(ll_row, "photo"))
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
destroy ids_student_lesson

close(this)
end event

type p_1 from picture within w_student_lesson_list
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

