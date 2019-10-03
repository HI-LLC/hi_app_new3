$PBExportHeader$w_master_treeview.srw
forward
global type w_master_treeview from w_sheet
end type
type tv_1 from treeview within w_master_treeview
end type
type dw_master from u_datawindow within w_master_treeview
end type
type cb_close from u_commandbutton within w_master_treeview
end type
type str_tv_item from structure within w_master_treeview
end type
end forward

type str_tv_item from structure
	long		data_id
	string		description
end type

global type w_master_treeview from w_sheet
integer width = 3301
integer height = 1764
string title = ""
long backcolor = 15780518
tv_1 tv_1
dw_master dw_master
cb_close cb_close
end type
global w_master_treeview w_master_treeview

type variables
protected:
gstr_tv_item istr_tv_item
TreeViewItem itvi_tmp
datastore ids_tv_data
string is_column_id_name[]
string is_column_des_name[]
string is_dwobject_name[]
string is_master_id_name
string is_master_des_name
string is_master_title
long il_current_handle
long il_retrieve_ind = 0
long il_current_master_id = 0
long il_current_master_row = 0
boolean ib_has_root = false
string is_root_title = ""

end variables
forward prototypes
public subroutine wf_make_tv_multiple_dw (long al_parent_handle, any aa_id, integer ai_level)
public subroutine wf_make_tv_single_dw ()
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

public subroutine wf_make_tv_single_dw ();
long li_level_no
long ll_rowcount, ll_row, ll_current_level
long ll_parent_handle[], ll_current_parent_handle, ll_root_handle = 0
long ll_current_column_data[], ll_previous_column_data[]
treeviewitem ltvi_new 

li_level_no = upperbound(is_column_id_name)
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
for ll_current_level = 1 to li_level_no
	ll_previous_column_data[ll_current_level] = 0
	ll_parent_handle[ll_current_level] = 0
next
if ib_has_root then
	ltvi_new.label = is_root_title
	ltvi_new.children = true
	ll_root_handle = tv_1.InsertItemLast(0, ltvi_new)
end if	

ll_rowcount = ids_tv_data.RowCount()


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
				ll_parent_handle[ll_current_level] = tv_1.InsertItemLast(ll_root_handle, ltvi_new)
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

on w_master_treeview.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_master=create dw_master
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_master
this.Control[iCurrent+3]=this.cb_close
end on

on w_master_treeview.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.dw_master)
destroy(this.cb_close)
end on

event close;call super::close;if isvalid(ids_tv_data) then
	destroy ids_tv_data
end if
end event

type tv_1 from treeview within w_master_treeview
integer x = 50
integer y = 64
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

type dw_master from u_datawindow within w_master_treeview
integer x = 1010
integer y = 68
integer width = 2176
integer height = 1316
integer taborder = 80
boolean bringtotop = true
boolean vscrollbar = true
end type

type cb_close from u_commandbutton within w_master_treeview
integer x = 2761
integer y = 1484
integer taborder = 60
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;close(parent)
end event

