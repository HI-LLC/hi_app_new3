$PBExportHeader$w_reward.srw
forward
global type w_reward from w_sheet
end type
type cb_load_video_file from u_commandbutton within w_reward
end type
type cb_set_reward_content from u_commandbutton within w_reward
end type
type cb_set_reward from u_commandbutton within w_reward
end type
type cb_delete_content from u_commandbutton within w_reward
end type
type cb_add_content from u_commandbutton within w_reward
end type
type cb_delete_reward_program from u_commandbutton within w_reward
end type
type cb_add_reward_program from u_commandbutton within w_reward
end type
type cb_save from u_commandbutton within w_reward
end type
type cb_close from u_commandbutton within w_reward
end type
type dw_content from u_datawindow within w_reward
end type
type dw_program from u_datawindow within w_reward
end type
end forward

global type w_reward from w_sheet
integer width = 3296
integer height = 1820
long backcolor = 15780518
cb_load_video_file cb_load_video_file
cb_set_reward_content cb_set_reward_content
cb_set_reward cb_set_reward
cb_delete_content cb_delete_content
cb_add_content cb_add_content
cb_delete_reward_program cb_delete_reward_program
cb_add_reward_program cb_add_reward_program
cb_save cb_save
cb_close cb_close
dw_content dw_content
dw_program dw_program
end type
global w_reward w_reward

type variables
long il_current_program_row 
long il_current_program_id
long il_current_content_row 
long il_current_content_id
long il_current_reward_program_id
long il_current_reward_content_id
nvo_filedir invo_filedir
end variables

on w_reward.create
int iCurrent
call super::create
this.cb_load_video_file=create cb_load_video_file
this.cb_set_reward_content=create cb_set_reward_content
this.cb_set_reward=create cb_set_reward
this.cb_delete_content=create cb_delete_content
this.cb_add_content=create cb_add_content
this.cb_delete_reward_program=create cb_delete_reward_program
this.cb_add_reward_program=create cb_add_reward_program
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_content=create dw_content
this.dw_program=create dw_program
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_load_video_file
this.Control[iCurrent+2]=this.cb_set_reward_content
this.Control[iCurrent+3]=this.cb_set_reward
this.Control[iCurrent+4]=this.cb_delete_content
this.Control[iCurrent+5]=this.cb_add_content
this.Control[iCurrent+6]=this.cb_delete_reward_program
this.Control[iCurrent+7]=this.cb_add_reward_program
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_content
this.Control[iCurrent+11]=this.dw_program
end on

on w_reward.destroy
call super::destroy
destroy(this.cb_load_video_file)
destroy(this.cb_set_reward_content)
destroy(this.cb_set_reward)
destroy(this.cb_delete_content)
destroy(this.cb_add_content)
destroy(this.cb_delete_reward_program)
destroy(this.cb_add_reward_program)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_content)
destroy(this.dw_program)
end on

event open;call super::open;long ll_rowcount
string ls_expression
dw_program.SetTransObject(SQLCA)
dw_content.SetTransObject(SQLCA)
select current_id into :il_current_reward_program_id
from system_parms where parm_name = 'REWARD_PROGRAM';
if dw_program.Retrieve() > 0 then
	ll_rowcount = dw_program.RowCount()
	ls_expression = "reward_program_id = " + string(il_current_reward_program_id)
	il_current_program_row = dw_program.find(ls_expression, 1, ll_rowcount)
	if il_current_program_row = 0 or il_current_program_row > ll_rowcount then
		il_current_program_row = 1
		il_current_program_id = dw_program.GetItemNumber(1, "reward_program_id")
	else
		il_current_program_id = il_current_reward_program_id
	end if
	dw_program.SelectRow(0, false)
	dw_program.SelectRow(il_current_program_row, true)
	
	il_current_reward_content_id = dw_program.GetItemNumber(il_current_program_row, "current_program_content_id")
	if dw_content.Retrieve(il_current_program_id) > 0 then
		ll_rowcount = dw_content.RowCount()
		ls_expression = "reward_program_content_id = " + string(il_current_reward_content_id)
		il_current_content_row = dw_content.find(ls_expression, 1, ll_rowcount)
		if il_current_content_row = 0 or il_current_content_row > ll_rowcount then
			il_current_content_row = 1
			il_current_content_id = dw_content.GetItemNumber(il_current_content_row, "il_current_reward_content_id")
		else
			il_current_program_id = il_current_reward_program_id
		end if
		dw_content.SelectRow(0, false)
		dw_content.SelectRow(il_current_content_row, true)
	end if
end if
invo_filedir = create nvo_filedir
openuserobject(invo_filedir)
datawindowchild lddc_tmp
dw_content.GetChild('video_file', lddc_tmp)
if not isvalid(lddc_tmp) then
	MessageBox("Error", "DDDW invalid")
end if
if invo_filedir.of_get_video_list(lddc_tmp, 'filename', '' ) = -1 then
	MessageBox("Error", "Cannot Get Video File!")
end if
	

end event

event close;call super::close;destroy invo_filedir
end event

type cb_load_video_file from u_commandbutton within w_reward
integer x = 2478
integer y = 624
integer width = 713
integer taborder = 40
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "Set Current Reward"
end type

event clicked;if il_current_program_id > 0 then
	update system_parms set current_id = :il_current_program_id
	where parm_name = 'REWARD_PROGRAM';
	commit;
end if
end event

type cb_set_reward_content from u_commandbutton within w_reward
integer x = 1582
integer y = 620
integer width = 713
integer taborder = 40
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "Load Video Files"
end type

event clicked;string ls_win_title, ls_path, ls_filetype
dwobject dwo
ls_win_title = "Load video files"
ls_path = gn_appman.is_videofile_path
ls_filetype = "*.*"
gn_appman.of_set_parm("Win Title", ls_win_title)
gn_appman.of_set_parm("File Path",  ls_path)
gn_appman.of_set_parm("File Type",  ls_filetype)
Open(w_resource_loading)

end event

type cb_set_reward from u_commandbutton within w_reward
integer x = 1513
integer y = 1576
integer width = 782
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "Set Current Reward Content"
end type

event clicked;call super::clicked;if il_current_content_id > 0 then
	dw_program.SetItem(il_current_program_row, "current_program_content_id", il_current_content_id)
end if
end event

type cb_delete_content from u_commandbutton within w_reward
integer x = 727
integer y = 1576
integer width = 713
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Delete Content"
end type

event clicked;call super::clicked;long ll_count
dwobject ldwo
if il_current_content_id < 1 then
	MessageBox("Warning", "No reward program content to delete!")
	return
end if
if MessageBox("Warning!", "Do you want to delete the selected reward program item?", Question!, YesNo!) = 1 then
	select count(*) into :ll_count 
	from reward_program_content 
	where reward_program_id = :il_current_program_id;
	if ll_count > 0 then
		delete reward_program_content 
		where reward_program_content_id = :il_current_content_id;
		commit;
	end if
	dw_content.DeleteRow(il_current_content_row)
	if dw_content.RowCount() > 0 then
		if il_current_content_row > 1 then 
			il_current_content_row = il_current_content_row - 1
		end if
		ldwo = dw_content.object.reward_program_content_id
		dw_content.event clicked(0, 0, il_current_content_row, ldwo)
	else
		il_current_content_row = 0
		il_current_content_id = 0
	end if
end if
end event

type cb_add_content from u_commandbutton within w_reward
integer x = 46
integer y = 1576
integer width = 645
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Add Content"
end type

event clicked;call super::clicked;il_current_content_row = dw_content.InsertRow(il_current_content_row)
dw_content.SetItem(il_current_content_row, 'reward_program_id', il_current_program_id)
dw_content.ScrollToRow(il_current_content_row)
dw_content.SelectRow(0, false)
dw_content.SelectRow(il_current_content_row, true)
dwobject ldwo
ldwo = dw_content.object.rogram_content_id
dw_content.event clicked(0, 0, il_current_content_row, ldwo)
end event

type cb_delete_reward_program from u_commandbutton within w_reward
integer x = 722
integer y = 624
integer width = 713
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Delete Reward Program"
end type

event clicked;call super::clicked;long ll_count
dwobject ldwo
if il_current_program_id < 1 then
	MessageBox("Warning", "No reward program to delete!")
	return
end if
if MessageBox("Warning!", "Do you want to delete the selected reward program?", Question!, YesNo!) = 1 then
	select count(*) into :ll_count 
	from reward_program_content 
	where reward_program_id = :il_current_program_id;
	if ll_count > 0 then
		delete reward_program_content where reward_program_id = :il_current_program_id;
	end if
	dw_content.reset()
	select count(*) into :ll_count 
	from reward_program 
	where reward_program_id = :il_current_program_id;
	if ll_count > 0 then
		delete reward_program where reward_program_id = :il_current_program_id;
	end if
	commit;
	dw_program.DeleteRow(il_current_program_row)
	if dw_program.RowCount() > 0 then
		if il_current_program_row > 1 then 
			il_current_program_row = il_current_program_row - 1
		end if
		ldwo = dw_program.object.reward_program_id
		dw_program.event clicked(0, 0, il_current_program_row, ldwo)
	else
		il_current_program_row = 0
		il_current_program_id = 0
		il_current_content_row = 0
		il_current_content_id = 0
	end if
end if
end event

type cb_add_reward_program from u_commandbutton within w_reward
integer x = 46
integer y = 624
integer width = 645
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Add Reward Program"
end type

event clicked;call super::clicked;il_current_program_row = dw_program.InsertRow(il_current_program_row)
dw_program.ScrollToRow(il_current_program_row)
dw_program.SelectRow(0, false)
dw_program.SelectRow(il_current_program_row, true)

end event

type cb_save from u_commandbutton within w_reward
integer x = 2546
integer y = 1576
integer width = 311
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Save"
end type

event clicked;integer li_return
if dw_program.RowCount() > 0 then
	li_return = dw_program.Update()
//	if li_return = 1 and SQLCA.SQLNRows > 0 then
		commit;
//	else
//		rollback;
//	end if
end if

if dw_content.RowCount() > 0 then
	li_return = dw_content.Update()
//	if li_return = 1 and SQLCA.SQLNRows > 0 then
		commit;
//	else
//		rollback;
//	end if
end if

if isvalid(gw_money_board) then
	gw_money_board.wf_refresh()
end if
end event

type cb_close from u_commandbutton within w_reward
integer x = 2880
integer y = 1576
integer width = 311
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_content from u_datawindow within w_reward
integer x = 41
integer y = 760
integer width = 3154
integer height = 784
string dataobject = "d_reward_program_content"
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then
	return
end if
this.SelectRow(0, false)
this.SelectRow(row,true)
il_current_content_row = row
il_current_content_id = this.GetItemNumber(il_current_content_row, 'reward_program_content_id')
end event

type dw_program from u_datawindow within w_reward
integer x = 41
integer y = 56
integer width = 3154
integer height = 528
string dataobject = "d_reward_program"
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then
	return
end if
this.SelectRow(0, false)
this.SelectRow(row, true)
il_current_program_row = row
il_current_program_id = this.GetItemNumber(il_current_program_row, 'reward_program_id')
dw_content.retrieve(il_current_program_id)

end event

