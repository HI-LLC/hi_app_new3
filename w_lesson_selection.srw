$PBExportHeader$w_lesson_selection.srw
forward
global type w_lesson_selection from window
end type
type cb_demo from commandbutton within w_lesson_selection
end type
type cb_website from commandbutton within w_lesson_selection
end type
type cb_close from commandbutton within w_lesson_selection
end type
type dw_1 from datawindow within w_lesson_selection
end type
end forward

global type w_lesson_selection from window
integer width = 3429
integer height = 1856
boolean titlebar = true
string title = "Learning Helper"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
cb_demo cb_demo
cb_website cb_website
cb_close cb_close
dw_1 dw_1
end type
global w_lesson_selection w_lesson_selection

type variables
string is_file_list[]
long il_method_id_list_from[] = {2, 3, 17, 25, 16, 15, 14, 23, 24, 21, 22}
long il_method_id_list_to[] = {2, 13, 19, 25, 16, 15, 14, 23, 24, 21, 22}
string is_method_description_list[] = {"Object Identification", "Scale Comparison", "Object Comparison", "Object Matching", &
		"Object Grouping", "Drag-drop Counting", "Number-mathcing Counting", "Addition", "Subtraction", &
		"Unscramble Words (spelling)", "Unscramble Sentences (sentence composing)"}

end variables

forward prototypes
public subroutine wf_play_lesson (long al_method_id, string as_lesson_file)
public function integer wf_load_lesson_list ()
end prototypes

public subroutine wf_play_lesson (long al_method_id, string as_lesson_file);gn_appman.of_set_parm("Method ID", al_method_id)
		gw_selection = this
choose case al_method_id
	case 2 // Object Identification
		hide()
		post OpenWithParm(w_lesson_discrete_trial, as_lesson_file)
	case 3 to 13 // Scale Comparison
		hide()
		post OpenWithParm(w_lesson_comp_scale, as_lesson_file)
	case 14 // Counting - Number (Symbol) Match
		hide()
		post OpenWithParm(w_lesson_numbermatch_count, as_lesson_file)
	case 15 // Counting - Drag-drop
		hide()
		post OpenWithParm(w_lesson_dragdrop_count, as_lesson_file)
	case 16 // Object  Grouping
		hide()
		post OpenWithParm(w_lesson_mw_cmmnd, as_lesson_file)
	case 17 to 19 // Object Comparison
		hide()
		post OpenWithParm(w_lesson_comp_object, as_lesson_file)
	case 21 // Unscramble Words
		hide()
		post OpenWithParm(w_lesson_unscramble_word, as_lesson_file)
	case 22 // Unscramble Sentences
		hide()
		post OpenWithParm(w_lesson_unscramble_sentence, as_lesson_file)
	case 23 // Addition
		hide()
		post OpenWithParm(w_lesson_addition, as_lesson_file)
	case 24 // Subtraction
		hide()
		post OpenWithParm(w_lesson_subtraction, as_lesson_file)
	case 25 // Matching
		hide()
		post OpenWithParm(w_lesson_matching, as_lesson_file)
end choose

end subroutine

public function integer wf_load_lesson_list ();int ll_i, ll_row, ll_len
string ls_expression
datawindowchild ldwc_lesson_list
if dw_1.GetChild("lesson_name", ldwc_lesson_list) = -1 then
	MessageBox("Error", "Cannot Lessons List (DWC)!")
	return 0
end if
for ll_i = 1 to upperbound(is_file_list)
	if pos(is_file_list[ll_i], "_con.tx") > 0 then continue
	ll_len = len(is_file_list[ll_i])
	ll_row = ldwc_lesson_list.InsertRow(0)
	ldwc_lesson_list.SetItem(ll_row, "file_name", is_file_list[ll_i])
	ldwc_lesson_list.SetItem(ll_row, "lesson_name", mid(is_file_list[ll_i], 3, ll_len - 6))	
	ldwc_lesson_list.SetItem(ll_row, "method_id", long(left(is_file_list[ll_i], 2)))	
next

for ll_i = 1 to upperbound(il_method_id_list_from)
	ls_expression = "method_id >= " + string(il_method_id_list_from[ll_i]) + &
		" and method_id <= " + string(il_method_id_list_to[ll_i]) 
	ldwc_lesson_list.SetFilter("")
	ldwc_lesson_list.Filter()	
	ldwc_lesson_list.SetFilter(ls_expression)
	ldwc_lesson_list.Filter()	
	if ldwc_lesson_list.RowCount() > 0 then
		ll_row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_row, "file_name", ldwc_lesson_list.GetItemString(1, "file_name"))
		dw_1.SetItem(ll_row, "method_id", ldwc_lesson_list.GetItemNUmber(1, "method_id"))	
		dw_1.SetItem(ll_row, "lesson_name", ldwc_lesson_list.GetItemString(1, "lesson_name"))	
		dw_1.SetItem(ll_row, "lesson_type", is_method_description_list[ll_i])
		dw_1.SetItem(ll_row, "method_id", il_method_id_list_from[ll_i])	
//	else
//		dw_1.SetItem(ll_row, "file_name", "No Lesson")
//		dw_1.SetItem(ll_row, "lesson_name", "No Lesson")
	end if
next
dw_1.AcceptText()
dw_1.height = 128*(dw_1.RowCount()+1)
height = 6*dw_1.x + dw_1.height + cb_close.height
cb_close.y = 2*dw_1.x + dw_1.height
cb_website.y = cb_close.y
cb_demo.y = cb_close.y

return 1

end function

event open;integer li_index, li_itemcount, li_row
string ls_tmp
window w_this
w_this = this
f_center_window(w_this)
ls_tmp = ".\Lessons\*.tx_"
li_itemcount = fnDirListCount(ls_tmp)
for li_index = 1 to li_itemcount
	is_file_list[li_index] = space(100)
next

li_itemcount = fnDirList(ls_tmp, is_file_list)

if li_itemcount < 1 then
	MessageBox("Error", "No Learning Helper Lesson(s) Avaiable!")
	event close()
	return
end if

open(gw_money_board)
wf_load_lesson_list()

end event

on w_lesson_selection.create
this.cb_demo=create cb_demo
this.cb_website=create cb_website
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_demo,&
this.cb_website,&
this.cb_close,&
this.dw_1}
end on

on w_lesson_selection.destroy
destroy(this.cb_demo)
destroy(this.cb_website)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event close;if isvalid(gw_money_board) then
	close(gw_money_board)
end if


end event

type cb_demo from commandbutton within w_lesson_selection
integer x = 1394
integer y = 1624
integer width = 699
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lesson Demo"
end type

event clicked;run("Exhibition.exe")
end event

type cb_website from commandbutton within w_lesson_selection
integer x = 32
integer y = 1624
integer width = 654
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Website"
end type

event clicked;string ls_command
ls_command = '"C:\Program Files\Internet Explorer\IEXPLORE.EXE"' + ' "http://www.learninghelper.com"'
run(ls_command)
end event

type cb_close from commandbutton within w_lesson_selection
integer x = 2958
integer y = 1624
integer width = 407
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_lesson_selection
integer x = 32
integer y = 32
integer width = 3333
integer height = 1548
integer taborder = 10
string title = "none"
string dataobject = "d_lesson_selection"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_expression
datawindowchild ldwc_lesson_list
long ll_method_id, ll_i
if row < 1 then return
//SelectRow(0, false)
//SelectRow(row, true)
SetRow(row)
ll_method_id = GetItemNumber(row, "method_id")
for ll_i = 1 to upperbound(il_method_id_list_from)
	if ll_method_id >= il_method_id_list_from[ll_i] and ll_method_id <= il_method_id_list_to[ll_i] then	
		ls_expression = "method_id >= " + string(il_method_id_list_from[ll_i]) + " and method_id <= " + string(il_method_id_list_to[ll_i]) 
		exit
	end if
next
if GetChild("lesson_name", ldwc_lesson_list) = -1 then
	MessageBox("Error", "Cannot Get Lesson List!")
	return
end if

ldwc_lesson_list.SetFilter("")
ldwc_lesson_list.Filter()

ldwc_lesson_list.SetFilter(ls_expression)
ldwc_lesson_list.Filter()


end event

event buttonclicked;long ll_method_id
string ls_lesson_file
if row < 1 then return
dwobject ldwo
event clicked(0, 0, row, ldwo)
ll_method_id = GetItemNumber(row, "method_id")
//ls_lesson_file = string(ll_method_id, "00") + GetItemString(row, "file_name") + ".tx_"
ls_lesson_file = GetItemString(row, "file_name")
//if isvalid(gw_money_board) then
//	MessageBox("gw_money_board", "is valid")
//else
//	MessageBox("gw_money_board", "is NOT valid")
//end if
if not gb_lesson_is_playing then
	gb_lesson_is_playing = true
	wf_play_lesson(ll_method_id, ls_lesson_file)
end if
end event

event itemchanged;long ll_row
DatawindowChild ldwc
if row < 1 then return
if GetChild("lesson_name", ldwc) = -1 then
	MessageBox("Error", "Cannot Get Datawindow Child!")
	return 0
end if
ll_row = ldwc.GetRow()
if ll_row < 1 then return
SetItem(row, "method_id", ldwc.GetItemNumber(ll_row, "method_id"))
SetItem(row, "file_name", ldwc.GetItemString(ll_row, "file_name"))

return 0
end event

