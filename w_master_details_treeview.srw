$PBExportHeader$w_master_details_treeview.srw
forward
global type w_master_details_treeview from w_sheet
end type
type tv_1 from treeview within w_master_details_treeview
end type
type dw_master from u_datawindow within w_master_details_treeview
end type
type dw_details from u_datawindow within w_master_details_treeview
end type
type cb_add_master from u_commandbutton within w_master_details_treeview
end type
type cb_delete_master from u_commandbutton within w_master_details_treeview
end type
type cb_save from u_commandbutton within w_master_details_treeview
end type
type cb_close from u_commandbutton within w_master_details_treeview
end type
type cb_details_item from u_commandbutton within w_master_details_treeview
end type
type str_tv_item from structure within w_master_details_treeview
end type
end forward

type str_tv_item from structure
	long		data_id
	string		description
end type

global type w_master_details_treeview from w_sheet
integer width = 3310
integer height = 2080
string title = "Lesson Setup  - Comparison"
long backcolor = 15780518
tv_1 tv_1
dw_master dw_master
dw_details dw_details
cb_add_master cb_add_master
cb_delete_master cb_delete_master
cb_save cb_save
cb_close cb_close
cb_details_item cb_details_item
end type
global w_master_details_treeview w_master_details_treeview

type variables

private:
str_tv_item istr_tv_item
protected:
TreeViewItem itvi_tmp
datastore ids_tv_data
string is_column_id_name[]
string is_column_des_name[]
string is_dwobject_name[]
string is_master_id_name
string is_details_id_name
string is_master_des_name
string is_details_des_name
string is_master_title
string is_details_title
long il_current_handle
long il_retrieve_ind = 0

integer ii_add_mode
integer ii_view_mode
string is_pres_type
long il_current_master_id = 0
long il_current_details_id = 0
long il_current_master_row = 0
long il_current_details_row = 0
end variables

forward prototypes
public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level)
public function long wf_master_retrieve ()
public subroutine wf_make_tv_single_dw ()
public subroutine wf_insert_content (long a_handle)
public subroutine wf_insert_content ()
end prototypes

public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level);long ll_row, ll_rowcount
long ll_parent_handle
datastore lds_tv_data
lds_tv_data = create datastore
lds_tv_data.dataobject = is_dwobject_name[ai_level]
lds_tv_data.SetTransObject(SQLCA)
ll_rowcount = lds_tv_data.Retrieve(aa_id)
treeviewitem ltvi_new 
ltvi_new.children = false
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_row = 1 to ll_rowcount
	istr_tv_item.data_id = lds_tv_data.GetItemNumber(ll_row, is_column_id_name[ai_level])
	istr_tv_item.description = lds_tv_data.GetItemString(ll_row, is_column_des_name[ai_level])							
	ltvi_new.label = istr_tv_item.description
	ltvi_new.data = istr_tv_item	
	ll_parent_handle = tv_1.InsertItemLast(al_parent_handle, ltvi_new)
	if ai_level < upperbound(is_dwobject_name) then
		wf_make_tv_multiple_dw(ll_parent_handle, istr_tv_item.data_id, ai_level + 1)
	end if
next
if ll_rowcount > 0 then
	tv_1.GetItem(al_parent_handle, itvi_tmp)
	itvi_tmp.children = true
	tv_1.SetItem(al_parent_handle, itvi_tmp)
end if

destroy lds_tv_data 


end subroutine

public function long wf_master_retrieve ();return 0
end function

public subroutine wf_make_tv_single_dw ();
long li_level_no
long ll_rowcount, ll_row, ll_current_level
long ll_parent_handle[], ll_current_parent_handle
long ll_current_column_data[], ll_previous_column_data[]
treeviewitem ltvi_new 

li_level_no = upperbound(is_column_id_name)
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2

ll_rowcount = ids_tv_data.RowCount()
for ll_current_level = 1 to li_level_no
	ll_previous_column_data[ll_current_level] = 0
	ll_parent_handle[ll_current_level] = 0
next

for ll_row = 1 to ll_rowcount
	for ll_current_level = 1 to li_level_no
		ll_current_column_data[ll_current_level] = ids_tv_data.GetItemNumber(ll_row, is_column_id_name[ll_current_level])
		if ll_current_column_data[ll_current_level] <>  ll_previous_column_data[ll_current_level] then
			istr_tv_item.data_id = ll_current_column_data[ll_current_level]
			istr_tv_item.description = ids_tv_data.GetItemString(ll_row, is_column_des_name[ll_current_level])							
			ltvi_new.label = istr_tv_item.description
			ltvi_new.data = istr_tv_item	
			if ll_current_level < li_level_no then
				ltvi_new.children = true
			else
				ltvi_new.children = false
			end if
			if ll_current_level = 1 then
				ll_current_parent_handle = 0
				ll_parent_handle[ll_current_level] = tv_1.InsertItemLast(0, ltvi_new)
			else
				ll_parent_handle[ll_current_level] = tv_1.InsertItemLast(ll_parent_handle[ll_current_level - 1], ltvi_new)
			end if	
		end if
	next	
	for ll_current_level = 1 to li_level_no
		ll_previous_column_data[ll_current_level] = ll_current_column_data[ll_current_level]
	next
next
end subroutine

public subroutine wf_insert_content (long a_handle);TreeViewItem ltvi_tmp
long ll_child
if isnull(il_current_master_row) or il_current_master_row = 0 then
	MessageBox("Warning", "Add or select a row in " + is_master_title + " before add row(s) to " + is_details_title + ".")
	return
end if
if isnull(il_current_master_id) or il_current_master_id = 0 then
	MessageBox("Warning", "Save first before add row(s) to " + is_details_title + ".")
	return
end if
tv_1.GetItem(a_handle, ltvi_tmp)
if ltvi_tmp.level = 2 then // insert whole chapter
	ll_child = tv_1.FindItem(ChildTreeItem!, a_handle)
	do while ll_child <> -1
		tv_1.GetItem(ll_child, ltvi_tmp)
		istr_tv_item = ltvi_tmp.data
		wf_insert_content()
		ll_child = tv_1.FindItem(NextTreeItem! , ll_child)
	loop
elseif ltvi_tmp.level = 3 then
	istr_tv_item = ltvi_tmp.data
	wf_insert_content()
end if


end subroutine

public subroutine wf_insert_content ();long ll_row
ll_row = dw_details.InsertRow(0)
dw_details.SetItem(ll_row, is_details_id_name, istr_tv_item.data_id)
dw_details.SetItem(ll_row, is_details_des_name, istr_tv_item.description)
if not isnull(is_master_id_name) then
	if len(is_master_id_name) > 0 then
		dw_details.SetItem(ll_row, is_master_id_name, il_current_master_id)
	end if
end if
end subroutine
on w_master_details_treeview.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_master=create dw_master
this.dw_details=create dw_details
this.cb_add_master=create cb_add_master
this.cb_delete_master=create cb_delete_master
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_details_item=create cb_details_item
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_master
this.Control[iCurrent+3]=this.dw_details
this.Control[iCurrent+4]=this.cb_add_master
this.Control[iCurrent+5]=this.cb_delete_master
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_details_item
end on

on w_master_details_treeview.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.dw_master)
destroy(this.dw_details)
destroy(this.cb_add_master)
destroy(this.cb_delete_master)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_details_item)
end on

event close;call super::close;if isvalid(ids_tv_data) then
	destroy ids_tv_data
end if
end event

type tv_1 from treeview within w_master_details_treeview
integer x = 78
integer y = 620
integer width = 873
integer height = 1312
integer taborder = 10
boolean dragauto = true
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long backcolor = 12639424
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 553648127
end type

type dw_master from u_datawindow within w_master_details_treeview
integer x = 82
integer y = 76
integer width = 3118
integer height = 492
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then
	return
end if
this.SelectRow(0, false)
this.SelectRow(row, true)
il_current_master_row = row
il_current_master_id = this.GetItemNumber(il_current_master_row, is_master_id_name)
dw_details.retrieve(il_current_master_id)
dwobject ldwo
if dw_details.RowCount() > 0 then
	dw_details.event clicked(0, 0, 1, ldwo)
else
	il_current_details_row = 0
	il_current_details_id = 0
end if
end event

event rowfocuschanged;call super::rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(currentrow,true)
il_current_master_row = currentrow
il_current_master_id = this.GetItemNumber(il_current_master_row, is_master_id_name)
end event

type dw_details from u_datawindow within w_master_details_treeview
integer x = 1015
integer y = 800
integer width = 2190
integer height = 1016
integer taborder = 80
boolean bringtotop = true
boolean vscrollbar = true
end type

event clicked;if row < 1 then
	return
end if
this.SelectRow(0, false)
this.SelectRow(row,true)
il_current_details_row = row
il_current_details_id = this.GetItemNumber(il_current_details_row, is_details_id_name)
end event

event rowfocuschanged;scrolltorow(currentrow)
this.SelectRow(0, false)
this.SelectRow(currentrow,true)
il_current_details_row = currentrow
il_current_details_id = this.GetItemNumber(il_current_details_row, is_details_id_name)
end event

event dragdrop;long ll_handle
if source.TypeOf() = TreeView! then
	ll_handle = tv_1.FindItem(CurrentTreeItem! ,0)
	wf_insert_content(ll_handle)
end if
drag(End!)

end event

type cb_add_master from u_commandbutton within w_master_details_treeview
integer x = 1006
integer y = 620
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Add Master"
end type

event clicked;call super::clicked;il_current_master_row = dw_master.InsertRow(il_current_master_row)
//dw_master.ScrollToRow(il_current_master_row)
dw_master.SelectRow(0, false)
dw_master.SelectRow(il_current_master_row, true)
il_current_master_id = 0
end event

type cb_delete_master from u_commandbutton within w_master_details_treeview
integer x = 1477
integer y = 620
integer width = 462
integer taborder = 40
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Delete Master"
end type

type cb_save from u_commandbutton within w_master_details_treeview
integer x = 2327
integer y = 1832
integer taborder = 50
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Save"
end type

event clicked;call super::clicked;integer li_return
string ls_desc
long ll_row, ll_rowcount
dwobject dwo
dw_master.AcceptText()
dw_details.AcceptText()
if dw_master.RowCount() > 0 and dw_master.ModifiedCount() > 0 then
	ls_desc = dw_master.GetItemString(il_current_master_row, is_master_des_name)
	li_return = dw_master.Update()
	if SQLCA.sqlcode <> 0 then
		f_log_error(dw_master.dataobject, SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot save!")
		rollback;
		return
	end if
	commit;
	ll_rowcount = wf_master_retrieve()
	ll_row = dw_master.of_get_row(is_master_des_name, ls_desc)
	if ll_row < 1 then
		ll_row = 1
	end if
	dw_master.event clicked(0, 0, ll_row, dwo) 
end if

if dw_details.RowCount() > 0 and dw_details.ModifiedCount() > 0 then
	li_return = dw_details.Update()
	if SQLCA.sqlcode <> 0 then
		f_log_error(dw_details.dataobject, SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext)
		MessageBox("Error", "Cannot save!")
		rollback;
		return
	end if
	commit;
	dw_details.Retrieve(il_current_master_id)
	dw_details.event clicked(0, 0, 1, dwo)
end if
end event

type cb_close from u_commandbutton within w_master_details_treeview
integer x = 2789
integer y = 1832
integer taborder = 60
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_details_item from u_commandbutton within w_master_details_treeview
integer x = 1047
integer y = 1832
integer width = 677
integer taborder = 70
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Delete Detail Item"
end type

