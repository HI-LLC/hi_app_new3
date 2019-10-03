$PBExportHeader$w_comm_board_sa.srw
forward
global type w_comm_board_sa from window
end type
type cb_close from commandbutton within w_comm_board_sa
end type
type cb_submit from commandbutton within w_comm_board_sa
end type
type cb_new from commandbutton within w_comm_board_sa
end type
type cb_retrieve from commandbutton within w_comm_board_sa
end type
type dw_comm_board from datawindow within w_comm_board_sa
end type
end forward

global type w_comm_board_sa from window
integer width = 3488
integer height = 2244
string title = "Learning Helper Training Communication Board"
long backcolor = 12632256
boolean clientedge = true
cb_close cb_close
cb_submit cb_submit
cb_new cb_new
cb_retrieve cb_retrieve
dw_comm_board dw_comm_board
end type
global w_comm_board_sa w_comm_board_sa

type variables
long il_last_seq_num
end variables

forward prototypes
public subroutine wf_insert_comment (long al_reply_to_row)
public subroutine wf_comment_retrieve ()
end prototypes

public subroutine wf_insert_comment (long al_reply_to_row);/*long ll_student_id, ll_count
string ls_poster_id, ls_poster_name, ls_title, ls_tmp_buf
	ll_student_id = 0
	dw_comm_board.SetItem(1, "Post_Type", "A")

if dw_comm_board.RowCount() = 0 then
	dw_comm_board.InsertRow(1)
elseif not isnull(dw_comm_board.GetItemDateTime(1, "Post_date")) then
	dw_comm_board.InsertRow(1)	
else
	return
end if

ls_poster_name = ProfileString (is_startupfile , "Bulletin Board", "Poster Name", "" )

ls_poster_id = string(ll_student_id, "00000")
dw_comm_board.SetItem(1, "Poster_id", ls_poster_id)

if ls_poster_name <> "" then
	dw_comm_board.SetItem(1, "Poster_Name", ls_poster_name)
end if

if al_reply_to_row > 0 then
	dw_comm_board.SetItem(1, "Post_Type", "A")	
	ls_tmp_buf = dw_comm_board.GetItemString(al_reply_to_row + 1, "title")
	ls_title = "Reply To Seq: " + string(dw_comm_board.GetItemNumber(al_reply_to_row + 1, "seq")) + " - "
	ls_title = ls_title + left(ls_tmp_buf, 50 - len(ls_title))
	dw_comm_board.SetItem(1, "title", ls_title)				
end if*/
end subroutine

public subroutine wf_comment_retrieve ();/*long ll_Seq, ll_row, ll_Content_size
date ld_post_date
time lt_post_date
datetime ldt_post_date
string ls_Post_date, ls_Poster_ID, ls_Poster_name, ls_Post_type, ls_Title, ls_Content
ls_Post_date = space(20)
ls_Poster_ID = space(5)
ls_Poster_name = space(20)
ls_Post_type = space(1)
ls_Title = space(50)
ls_Content = space(1024)
il_last_seq_num = GetLastCommentSeqNum()
if il_last_seq_num < 1 then
	il_last_seq_num = 0
end if
DownloadComments(il_last_seq_num)

OpenCommentFile()
dw_comm_board.Reset()
gl_last_seq_num = il_last_seq_num
do 
	ll_Content_size = RetrieveCommentRecord(ll_Seq, ls_Post_date, ls_Poster_ID, ls_Poster_name, &
		ls_Post_type, ls_Title, ls_Content)
	if ll_Content_size > 0 then
		ld_post_date = date(left(ls_Post_date, 10))
		lt_post_date = time(mid(ls_Post_date, 12, 8))
		ldt_post_date = datetime(ld_post_date, lt_post_date)
		ll_row = dw_comm_board.InsertRow(0)
		dw_comm_board.SetItem(ll_row, "Seq", ll_Seq)
		dw_comm_board.SetItem(ll_row, "Post_date", ldt_post_date)
		dw_comm_board.SetItem(ll_row, "Poster_ID", ls_Poster_ID)
		dw_comm_board.SetItem(ll_row, "Poster_name", ls_Poster_name)
		dw_comm_board.SetItem(ll_row, "Post_type", ls_Post_type)
		dw_comm_board.SetItem(ll_row, "Title", ls_Title)
		
		dw_comm_board.SetItem(ll_row, "Content", left(ls_Content, ll_Content_size))		
	end if
loop while ll_Content_size > 0
dw_comm_board.SetSort("Seq D")
dw_comm_board.Sort()
*/
end subroutine
on w_comm_board_sa.create
this.cb_close=create cb_close
this.cb_submit=create cb_submit
this.cb_new=create cb_new
this.cb_retrieve=create cb_retrieve
this.dw_comm_board=create dw_comm_board
this.Control[]={this.cb_close,&
this.cb_submit,&
this.cb_new,&
this.cb_retrieve,&
this.dw_comm_board}
end on

on w_comm_board_sa.destroy
destroy(this.cb_close)
destroy(this.cb_submit)
destroy(this.cb_new)
destroy(this.cb_retrieve)
destroy(this.dw_comm_board)
end on

event open;wf_comment_retrieve()
end event
type cb_close from commandbutton within w_comm_board_sa
integer x = 2821
integer y = 44
integer width = 402
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event
type cb_submit from commandbutton within w_comm_board_sa
integer x = 2002
integer y = 44
integer width = 649
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Submit Comment"
end type

event clicked;string ls_Post_date, ls_Poster_ID, ls_Poster_name, ls_Post_type, ls_Title, ls_Content
string ls_submit_text, ls_Content_size
date ld_post_date
time lt_post_date
datetime ldt_post_date
ls_Post_date = space(20)
dw_comm_board.AcceptText()
if dw_comm_board.RowCount() = 0 then
	return
elseif isnull(dw_comm_board.GetItemDateTime(1, "Post_date")) then
	ls_Poster_ID = dw_comm_board.GetItemString(1, "Poster_ID")
	if len(ls_Poster_ID) < 6 then
		ls_Poster_ID = ls_Poster_ID + space(6 - len(ls_Poster_ID))
	elseif len(ls_Poster_ID) > 6 then
		ls_Poster_ID = left(ls_Poster_ID, 6)
	end if
	ls_Poster_name = dw_comm_board.GetItemString(1, "Poster_name")
	if isnull(ls_Poster_name) then
		MessageBox("Error", "Please enter poster name!")
		return
	end if
	if len(ls_Poster_name) < 21 then
		ls_Poster_name = ls_Poster_name + space(21 - len(ls_Poster_name))
	elseif len(ls_Poster_name) > 21 then
		ls_Poster_name = left(ls_Poster_name, 21)
	end if
	ls_Post_type = dw_comm_board.GetItemString(1, "Post_type")
	if isnull(ls_Post_type) then
		MessageBox("Error", "Please select a posting type!")
		return
	end if
	if len(ls_Post_type) < 2 then
		ls_Post_type = ls_Post_type + space(2 - len(ls_Post_type))
	elseif len(ls_Post_type) > 2 then
		ls_Post_type = left(ls_Post_type, 2)
	end if
	ls_Title = dw_comm_board.GetItemString(1, "Title")
	if isnull(ls_Title) then
		MessageBox("Error", "Please enter the title!")
		return
	end if
	if len(ls_Title) < 51 then
		ls_Title = ls_Title + space(51 - len(ls_Title))
	elseif len(ls_Poster_ID) > 51 then
		ls_Title = left(ls_Title, 51)
	end if
	ls_Content = dw_comm_board.GetItemString(1, "Content")
	if isnull(ls_Content) then
		MessageBox("Error", "No content to post!")
		return
	end if
	if len(ls_Content) > 1024 then
		ls_Content = left(ls_Content, 1024)
	end if
	ls_Content_size = string(len(ls_Content), "00000")
	ls_submit_text = ls_Poster_ID + ls_Poster_name + ls_Post_type + ls_Title + ls_Content_size + ls_Content
	if SubmitNewComment(ls_submit_text, il_last_seq_num, ls_Post_date) = 1 then
		ld_post_date = date(left(ls_Post_date, 10))
		lt_post_date = time(mid(ls_Post_date, 12, 8))
		ldt_post_date = datetime(ld_post_date, lt_post_date)
		dw_comm_board.SetItem(1, "Seq", il_last_seq_num)
		dw_comm_board.SetItem(1, "Post_date", ldt_post_date)
		MessageBox("Status", "The comment is successfully submitted!")
		ls_poster_name = dw_comm_board.GetItemString(1, "Poster_Name")
		SetProfileString (is_startupfile , "Bulletin Board", "Poster Name", ls_poster_name)		
	else
		MessageBox("Status", "Submission failed!")
	end if				
	return
else
	return
end if
end event

type cb_new from commandbutton within w_comm_board_sa
integer x = 1307
integer y = 44
integer width = 649
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert New Comment"
end type

event clicked;wf_insert_comment(0)
end event
type cb_retrieve from commandbutton within w_comm_board_sa
integer x = 613
integer y = 44
integer width = 649
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh"
end type

event clicked;wf_comment_retrieve()
end event

type dw_comm_board from datawindow within w_comm_board_sa
integer x = 23
integer y = 192
integer width = 3392
integer height = 1908
string dataobject = "d_comm_board"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;call super::buttonclicked;wf_insert_comment(row)
end event

