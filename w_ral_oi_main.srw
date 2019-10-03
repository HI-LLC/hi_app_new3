$PBExportHeader$w_ral_oi_main.srw
$PBExportComments$OIDB window
forward
global type w_ral_oi_main from w_sheet
end type
type u_cb_cancel_comments from u_cb_cancel within w_ral_oi_main
end type
type cb_apply from u_cb within w_ral_oi_main
end type
type u_cb_new from u_cb within w_ral_oi_main
end type
type tv_record_list from u_tv within w_ral_oi_main
end type
type u_dw_filter from u_dw within w_ral_oi_main
end type
type u_dw_list from u_dw within w_ral_oi_main
end type
type u_cb_export from u_cb within w_ral_oi_main
end type
type st_splitbar_1 from pfc_u_st_splitbar within w_ral_oi_main
end type
type st_splitbar_2 from pfc_u_st_splitbar within w_ral_oi_main
end type
type u_cb_new_comment from u_cb within w_ral_oi_main
end type
type u_cb_reset from u_cb within w_ral_oi_main
end type
type u_tab_main from u_tab_ral_oi_main within w_ral_oi_main
end type
type u_cb_all from commandbutton within w_ral_oi_main
end type
type u_cb_print from u_cb within w_ral_oi_main
end type
type u_cb_owner_filter from u_cb within w_ral_oi_main
end type
type u_cb_reset_filter from u_cb within w_ral_oi_main
end type
type u_tab_main from u_tab_ral_oi_main within w_ral_oi_main
end type
end forward

global type w_ral_oi_main from w_sheet
int Width=4667
int Height=2928
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
WindowState WindowState=maximized!
u_cb_cancel_comments u_cb_cancel_comments
cb_apply cb_apply
u_cb_new u_cb_new
tv_record_list tv_record_list
u_dw_filter u_dw_filter
u_dw_list u_dw_list
u_cb_export u_cb_export
st_splitbar_1 st_splitbar_1
st_splitbar_2 st_splitbar_2
u_cb_new_comment u_cb_new_comment
u_cb_reset u_cb_reset
u_tab_main u_tab_main
u_cb_all u_cb_all
u_cb_print u_cb_print
u_cb_owner_filter u_cb_owner_filter
u_cb_reset_filter u_cb_reset_filter
end type
global w_ral_oi_main w_ral_oi_main

type prototypes

end prototypes

type variables
boolean ib_verified = false
boolean ib_rowfocuschanging_permit = false
boolean ib_rowfocuschanging = false
boolean ib_first_click = false

long il_trckng_id = 0
long il_show = 0

n_cst_retrieve inv_retrieve
n_ds ids_status, ids_dept, ids_function, ids_list
n_ds ids_owner_filter, ids_owner_filter_backup
n_ds ids_owner_dddw
n_ds ids_owner
n_ds ids_move_to_list
userobject ivo_list[]
long il_x[], il_y[], il_width[], il_height[]
end variables

forward prototypes
public subroutine of_populate_level_1 ()
public subroutine of_populate_level_2 (ref treeviewitem atvi_parent)
public subroutine of_populate_level_3 (ref treeviewitem atvi_parent)
public subroutine of_populate_level_4 (ref treeviewitem atvi_parent)
public subroutine of_retrieve_list ()
public subroutine of_filter_setup ()
public subroutine of_hide_all_button ()
public subroutine of_export ()
public subroutine of_make_datawindow (string as_column)
public subroutine of_refresh_issue_list ()
public function long of_find_item (string as_stat_cde, string as_dept_cde, string as_func_cde, long al_trckng_id)
public function long of_set_selection (string as_stat_cde, string as_dept_cde, string as_func_cde, long al_trckng_id)
public subroutine of_insert_treeview_item (long al_parent_handle, long al_sibling_handle, integer ai_indicator)
public subroutine of_make_new_status (string as_status)
public subroutine of_make_new_dept (string as_status, string as_dept_cde)
public subroutine of_make_new_func (string as_status, string as_dept_cde, string as_func_cde)
public function long of_find_insert_spot (string as_stat_cde, string as_dept_cde, string as_func_cde, long al_trckng_id, ref long al_parent_handle, ref long al_sibling_handle)
public subroutine of_delete_item (long al_handle)
public function integer of_update_confirmation ()
public function string of_setlines (ref hi_u_dw adw, ref datawindowchild adwc, string as_colname)
public function string of_set_dddw_width (ref hi_u_dw adw, ref datawindowchild adwc, string as_colname, string as_display_colname)
public subroutine of_data_filter ()
public subroutine of_make_owner_filter ()
public subroutine of_add_owner_to_list ()
public subroutine of_delete_status (string as_status)
public subroutine of_delete_dept (string as_status, string as_dept)
public subroutine of_delete_func (string as_status, string as_dept, string as_func)
end prototypes

public subroutine of_populate_level_1 ();string ls_security_all_status
string ls_filter
long ll_row, ll_rowcount, ll_sqlcode = 0
long ll_root_handle, ll_parent_handle, ll_current_handle
long ll_found_R, ll_found_A
treeviewitem ltvi_new 
string ls_tvitem_label, ls_lp_ind
n_ds lds_cdv
datawindowchild ldwc_child


ids_status.Retrieve(ll_sqlcode)

if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_STAT_CD",lds_cdv) < 1 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE STATUS get_cdv"})
else
	If ids_status.getchild("stat_cde", ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE STATUS"})
	Else
		lds_cdv.sharedata(ldwc_child)
	End If
end if

ll_rowcount = ids_status.RowCount()
if ll_rowcount < 1 then return
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ltvi_new.children = true
ltvi_new.label = "RAL Open Issue List"
ll_root_handle = tv_record_list.InsertItemLast(0, ltvi_new)

tv_record_list.SetRedraw(false)
for ll_row = 1 to ll_rowcount
	if trim(ids_status.GetItemString(ll_row, "stat_cde")) = "" then
		continue
	end if
	ls_tvitem_label = ids_status.describe("Evaluate('lookupdisplay(stat_cde)',"+string(ll_row)+")")
	ltvi_new.children = false
	ltvi_new.label = trim(ls_tvitem_label)
	ltvi_new.data = trim(ids_status.GetItemString(ll_row, "stat_cde"))	
	ll_parent_handle = tv_record_list.InsertItemLast(ll_root_handle, ltvi_new)
next
tv_record_list.SetRedraw(true)
tv_record_list.ExpandItem(ll_root_handle)

end subroutine

public subroutine of_populate_level_2 (ref treeviewitem atvi_parent);long ll_row, ll_rowcount, ll_sqlcode = 0
long ll_parent_handle, ll_current_handle
treeviewitem ltvi_new 
string ls_tvitem_label, ls_stat_cde, ls_cdv_type, ls_desc
string ls_expression = ""
n_ds lds_cdv, lds_cdv_cs, lds_cdv_lp
datawindowchild ldwc_child
any la_tranobject
n_tr ltr_tranobject

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
ids_dept = create datastore
ids_dept.dataobject = 'd_ral_oi_tv_dept'
ids_dept.SetTransObject(ltr_tranobject)


if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_DEPT_CD",lds_cdv) < 1 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE STATUS"})
else
	If ids_dept.getchild("dept_cde", ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE STATUS"})
	Else
		lds_cdv.sharedata(ldwc_child)
	End If
end if

ls_stat_cde = atvi_parent.data
ids_dept.Retrieve(ls_stat_cde, ll_sqlcode)
ll_rowcount = ids_dept.RowCount()

if ll_rowcount < 1 then 
	destroy ids_dept
	return
end if
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ll_parent_handle = atvi_parent.ItemHandle
for ll_row = 1 to ll_rowcount
	if trim(ids_dept.GetItemString(ll_row, "dept_cde")) <> "" then
		ls_tvitem_label = ids_dept.describe("Evaluate('lookupdisplay(dept_cde)',"+string(ll_row)+")")
		ltvi_new.children = false
		ltvi_new.label = trim(ls_tvitem_label)
		ltvi_new.data = ids_dept.GetItemString(ll_row, "dept_cde") 
		tv_record_list.InsertItemLast(ll_parent_handle, ltvi_new)
	end if
next
tv_record_list.Sort(ll_parent_handle, Ascending!)
if ll_row > 0 then
	atvi_parent.Children = true
	tv_record_list.SetItem(ll_parent_handle, atvi_parent)
end if
tv_record_list.ExpandItem(ll_parent_handle)

destroy ids_dept

end subroutine

public subroutine of_populate_level_3 (ref treeviewitem atvi_parent);long ll_row, ll_rowcount, ll_prim_ssn, ll_sqlcode = 0
long ll_parent_handle, ll_status_handle, ll_current_handle, ll_trckng_id
treeviewitem ltvi_new, ltvi_status 
string ls_tvitem_label, ls_stat_cde, ls_dept_no
string ls_lastname, ls_firstname, ls_midinit, ls_prty_cde
string ls_expression = ""
n_ds lds_cdv, lds_cdv_cs, lds_cdv_lp
datawindowchild ldwc_child
any la_tranobject
n_tr ltr_tranobject

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
ids_function = create datastore
ids_function.dataobject = 'd_ral_oi_tv_func'
ids_function.SetTransObject(ltr_tranobject)

if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_FUNC_CD",lds_cdv) < 1 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE functional area"})
else
	If ids_function.getchild("func_cde", ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE functional area"})
	Else
		lds_cdv.sharedata(ldwc_child)
	End If
end if

ls_dept_no = atvi_parent.data
ll_parent_handle = atvi_parent.ItemHandle	
ll_status_handle = tv_record_list.FindItem ( ParentTreeItem! ,  ll_parent_handle)
tv_record_list.GetItem(ll_status_handle, ltvi_status)
ls_stat_cde = ltvi_status.data

ids_function.Retrieve( ls_stat_cde, trim(ls_dept_no), ll_sqlcode)
ll_rowcount = ids_function.RowCount()

if ll_rowcount < 1 then 
	destroy ids_function	
	return
end if
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2

for ll_row = 1 to ll_rowcount
	if trim(ids_function.GetItemString(ll_row, "func_cde")) <> "" then
		ls_tvitem_label = ids_function.describe("Evaluate('lookupdisplay(func_cde)',"+string(ll_row)+")")
		ltvi_new.label = trim(ls_tvitem_label)	
		ltvi_new.data = trim(ids_function.GetItemString(ll_row, "func_cde"))	
		ltvi_new.children = false
		ltvi_new.ItemHandle = tv_record_list.InsertItemLast(ll_parent_handle, ltvi_new)
	end if
next

if ll_row > 0 then
	atvi_parent.Children = true
	tv_record_list.SetItem(ll_parent_handle, atvi_parent)
end if

tv_record_list.ExpandItem(ll_parent_handle)

destroy ids_function
end subroutine

public subroutine of_populate_level_4 (ref treeviewitem atvi_parent);long ll_row, ll_rowcount, ll_trckng_id, ll_sqlcode = 0
long ll_parent_handle, ll_status_handle, ll_dept_handle, ll_current_handle
treeviewitem ltvi_new, ltvi_status , ltvi_dept
string ls_tvitem_label, ls_stat_cde, ls_dept_no, ls_function
string ls_lastname, ls_firstname, ls_midinit, ls_prty_cde
string ls_expression = ""
n_ds lds_cdv, lds_cdv_cs, lds_cdv_lp
datawindowchild ldwc_child
any la_tranobject
n_tr ltr_tranobject

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject

ids_list = create datastore
ids_list.dataobject = 'd_ral_oi_tv_list'
ids_list.SetTransObject(ltr_tranobject)

ls_function = atvi_parent.data
ll_parent_handle = atvi_parent.ItemHandle	
ll_dept_handle = tv_record_list.FindItem ( ParentTreeItem! ,  ll_parent_handle)
tv_record_list.GetItem(ll_dept_handle, ltvi_dept)
ls_dept_no = ltvi_dept.data
ll_status_handle = tv_record_list.FindItem ( ParentTreeItem! ,  ll_dept_handle)
tv_record_list.GetItem(ll_status_handle, ltvi_status)
ls_stat_cde = ltvi_status.data

ids_list.Retrieve( ls_stat_cde, ls_dept_no, ls_function, ll_sqlcode)
ll_rowcount = ids_list.RowCount()

if ll_rowcount < 1 then 
	destroy ids_list
	return
end if
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2

for ll_row = 1 to ll_rowcount
	ll_trckng_id = ids_list.GetItemNumber(ll_row, "trckng_id")	
	ls_tvitem_label =  String(ids_list.GetItemDateTime(ll_row, "creat_dt_tm"), "mm/dd/yyyy hh:mm:ss") + &
							 "  " + String(ll_trckng_id, "0000000") + "  " + ids_list.GetItemString(ll_row, "desc_short")
	ltvi_new.label = trim(ls_tvitem_label)	
	ltvi_new.data = ll_trckng_id
	ltvi_new.children = false
	ltvi_new.ItemHandle = tv_record_list.InsertItemLast(ll_parent_handle, ltvi_new)
next

if ll_row > 0 then
	atvi_parent.Children = true
	tv_record_list.SetItem(ll_parent_handle, atvi_parent)
end if

tv_record_list.ExpandItem(ll_parent_handle)

destroy ids_list
end subroutine

public subroutine of_retrieve_list ();///////////////////////////////////////////////////////////////////////////////////////////
//	function:  			of_retrieve_list
//
//	Arguments:		None
//
//	Returns:  		None
//
//	Description:	 Retrieve all issue to the filter
//
// Initial Version :
// 06/05/2001	EMPT79				
//	
////////////////////////////////////////////////////////////////////////////////////////////
integer li_i, li_j
long ll_sqlcode = 0
Any la_tranobject
n_tr ltr_tranobject
n_ds lds_cdv,lds_username
string ls_cdv_type

string ls_column_list[] = {"stat_cde", "prior_stat_cde", "prty_cde", "reas_cde", "rsolv_cde", "trnmtr_cde", "dept_cde", "func_cde", "orign_srce_cde","rleas_id"}
string ls_cdv_type_list[] = {"OI_STAT_CD", "OI_STAT_CD", "OI_PRTY_CD", "OI_REAS_CD", "OI_RESO_CD", "OI_TRNMTR", "OI_DEPT_CD", "OI_FUNC_CD", "OI_SRCE_CD","OI_RELE_CD"}
string ls_user_col[] = {"srce_id","req_srce_id","cmpl_srce_id"}
datawindowchild ldwc_child
w_master lw_dummy
string ls_err_parm[] = {"Error in retrieving issue list"} 

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
u_dw_list.SetTransObject(ltr_tranobject)

// SET CDV for columns in issue list datawindow
for li_i = 1 to upperbound(ls_column_list)
	if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv(ls_cdv_type_list[li_i], lds_cdv) < 1 then
		gnv_app.inv_error.of_message("RL006",{"CDV For Data List (fail in of_get_cdv)"})
	else
		If u_dw_list.getchild(ls_column_list[li_i], ldwc_child) < 0 Then
			gnv_app.inv_error.of_message("RL006",{"CDV For Data List (fail in getchild)"})
		Else
			lds_cdv.RowsCopy(1, lds_cdv.RowCount(), Primary!, ldwc_child, 1, Primary!)
		End If
	end if
next

if gnv_app.of_getframe().inv_frame.dynamic of_get_userid_list(lds_username) < 1 then
	gnv_app.inv_error.of_message("RL006",{"User List"})
else
	for li_i = 1 to upperbound(ls_user_col)
			If u_dw_list.getchild(ls_user_col[li_i], ldwc_child) < 0 Then
				gnv_app.inv_error.of_message("RL006",{"User List"})
			Else
				lds_username.sharedata(ldwc_child)
			End If
	next
end if

u_dw_list.ia_parm[1] = ll_sqlcode
if inv_retrieve.of_retrieve(lw_dummy, u_dw_list) < 1 then
	gnv_app.inv_error.of_Message("RL006",  ls_err_parm)
end if





end subroutine

public subroutine of_filter_setup ();///////////////////////////////////////////////////////////////////////////////////////////
//	function:  			of_filter_setup
//
//	Arguments:		None
//
//	Returns:  		None
//
//	Description:	 Setup filter datawindow
//
// Initial Version :
// 06/05/2001	EMPT79				
//	
////////////////////////////////////////////////////////////////////////////////////////////
integer li_i
n_ds lds_cdv
string ls_cdv_type,ls_cdv_cde,ls_expression,ls_data, ls_cdv_cde_cur, ls_tmp
string ls_cdv_col[] = {"stat_cde","prty_cde","rsolv_cde","trnmtr_cde","func_cde","orign_srce_cde","dept_cde","srce_id","req_srce_id","cmpl_srce_id","rleas_id"}
string ls_string_col[]
//ls_string_col[] = {"spr_num", "rleas_id"}
ls_string_col[] = {"spr_num"}
datawindowchild ldwc_child, ldwc_child_2, ldwc_child_3
long ll_column_count, ll_col, ll_row, ll_cdv_row, ll_rowcount, ll_trckng_id

if u_dw_list.RowCount() = 0 then
	return
end if
// build DDDW for String columns
for ll_col = 1 to upperbound(ls_string_col)
	If u_dw_filter.getchild(ls_string_col[ll_col], ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"GetChild Error in filter setup"})
	end if
	ldwc_child.Reset()
	u_dw_list.SetSort(ls_string_col[ll_col] + " A")
	u_dw_list.Sort()
	ll_rowcount = u_dw_list.RowCount()
	ls_cdv_cde = ''
	for ll_row = 1 to ll_rowcount		
		ls_cdv_cde_cur = trim(u_dw_list.GetItemString(ll_row, ls_string_col[ll_col]))
		if ls_cdv_cde_cur <> '' and ls_cdv_cde <> ls_cdv_cde_cur then
			ls_cdv_cde = ls_cdv_cde_cur
			ll_cdv_row = ldwc_child.InsertRow(0)
			ldwc_child.SetItem(ll_cdv_row, "description", ls_cdv_cde)
		end if
	next
	ldwc_child.InsertRow(1)
	ldwc_child.SetItem(1, "description", 'ALL')
//	gnv_app.of_getframe().inv_frame.dynamic of_setlines(u_dw_filter, ldwc_child, ls_string_col[ll_col])
	of_setlines(u_dw_filter, ldwc_child, ls_string_col[ll_col])
	If u_dw_filter.getchild(ls_string_col[ll_col], ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"GetChild Error in filter setup"})
	end if
	of_set_dddw_width(u_dw_filter, ldwc_child, ls_string_col[ll_col], "description")
next

// build DDDW for CDV columns
for ll_col = 1 to upperbound(ls_cdv_col)
	If u_dw_filter.getchild(ls_cdv_col[ll_col], ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"GetChild Error in CDV of filter setup"})
		return
	end if
	ldwc_child.Reset()
	u_dw_list.SetSort(ls_cdv_col[ll_col] + " A")
	u_dw_list.Sort()
	ll_rowcount = u_dw_list.RowCount()
	ls_cdv_cde = ''
	for ll_row = 1 to ll_rowcount		
		ls_cdv_cde_cur = trim(u_dw_list.GetItemString(ll_row, ls_cdv_col[ll_col]))
		if ls_cdv_cde_cur <> '' and ls_cdv_cde <> ls_cdv_cde_cur then
			ls_cdv_cde = ls_cdv_cde_cur
			ll_cdv_row = ldwc_child.InsertRow(0)
			ldwc_child.SetItem(ll_cdv_row, "cdv_cde", ls_cdv_cde)
			ls_expression = "Evaluate('" + "lookupdisplay(" + ls_cdv_col[ll_col] + ")'," + string(ll_row)+")"
			ls_data = u_dw_list.describe(ls_expression)
			ldwc_child.SetItem(ll_cdv_row, "cdv_desc", ls_data)
		end if
	next
	ldwc_child.SetSort("cdv_desc A")
	ldwc_child.Sort()
	ll_cdv_row = ldwc_child.InsertRow(1)
	ldwc_child.SetItem(ll_cdv_row, "cdv_cde", 'ALL')	
	ldwc_child.SetItem(ll_cdv_row, "cdv_desc", 'ALL')	
	of_setlines(u_dw_filter, ldwc_child, ls_cdv_col[ll_col])
	If u_dw_filter.getchild(ls_cdv_col[ll_col], ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"GetChild Error in filter setup"})
	end if
	of_set_dddw_width(u_dw_filter, ldwc_child, ls_cdv_col[ll_col], "cdv_desc")
next
			
// build DDDW for trckng_id_2
If u_dw_filter.getchild("trckng_id_2", ldwc_child_2) < 0 Then
	gnv_app.inv_error.of_message("RL006",{"GetChild Error on Issue ID filter"})
	return
else
	u_dw_list.SetSort("trckng_id A")
	u_dw_list.Sort()
	ldwc_child_2.Reset()
	for li_i = 1 to u_dw_list.RowCount()
		ll_row =  ldwc_child_2.InsertRow(0)
		ldwc_child_2.SetItem(ll_row, "trckng_id", string(u_dw_list.GetItemNumber(li_i, "trckng_id")))
	next		
	ll_row = ldwc_child_2.InsertRow(1)
	ldwc_child_2.SetItem(1, "trckng_id", "ALL")	
	if ldwc_child_2.RowCount() > 1 and u_dw_filter.GetItemString(1, "trckng_id_2") = 'ALL' then
		u_dw_filter.SetItem(1, "trckng_id_2", ldwc_child_2.GetItemString(ldwc_child_2.RowCount(), "trckng_id"))
	end if
	of_setlines(u_dw_filter, ldwc_child_2, "trckng_id_2")
end if
// build DDDW for trckng_id
If u_dw_filter.getchild("trckng_id", ldwc_child) < 0 Then
	gnv_app.inv_error.of_message("RL006",{"GetChild Error on Issue ID filter"})
	return
else
	u_dw_list.SetSort("trckng_id A")
	u_dw_list.Sort()
	ldwc_child.Reset()
	for li_i = 1 to u_dw_list.RowCount()
		ll_row =  ldwc_child.InsertRow(0)
		ldwc_child.SetItem(ll_row, "trckng_id", string(u_dw_list.GetItemNumber(li_i, "trckng_id")))
	next	
	ll_row = ldwc_child.InsertRow(1)
	ldwc_child.SetItem(1, "trckng_id", "ALL")
	if ldwc_child.RowCount() > 1 and u_dw_filter.GetItemString(1, "trckng_id") = 'ALL' then
		u_dw_filter.SetItem(1, "trckng_id", ldwc_child.GetItemString(2, "trckng_id"))
	end if
	of_setlines(u_dw_filter, ldwc_child, "trckng_id")
//	of_setlines(u_tab_main.tabpage_main.u_dw_main, ldwc_child_3, "prior_trckng_id")
end if
// build DDDW for MOVED TO field
ids_move_to_list.Reset()
If u_tab_main.tabpage_main.u_dw_main.getchild("prior_trckng_id", ldwc_child_3) < 0 Then
	gnv_app.inv_error.of_message("RL006",{"GetChild Error"})
	return
end if
for li_i = 1 to u_dw_list.RowCount()
	if u_dw_list.GetItemString(li_i, "stat_cde") <> 'C' then
		ll_row =  ids_move_to_list.InsertRow(0)
		ids_move_to_list.SetItem(ll_row, "trckng_id", string(u_dw_list.GetItemNumber(li_i, "trckng_id")))
	end if
next	
if u_tab_main.tabpage_main.u_dw_main.RowCount() > 0 then
	ll_trckng_id = u_tab_main.tabpage_main.u_dw_main.GetItemNumber(1, "trckng_id")
	if not isnull(ll_trckng_id) then
		ls_expression = "trckng_id <> '" + string(ll_trckng_id) + "'"
		ids_move_to_list.SetFilter(ls_expression)
		ids_move_to_list.Filter()
	end if
end if
ids_move_to_list.ShareData(ldwc_child_3)
of_setlines(u_tab_main.tabpage_main.u_dw_main, ldwc_child_3, "prior_trckng_id")
u_dw_filter.of_SetDropDownSearch(True)
u_dw_filter.inv_dropdownsearch.of_UnRegister()
u_dw_filter.inv_dropdownsearch.of_Register()
if not isvalid(u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch) then
	u_tab_main.tabpage_main.u_dw_main.of_SetDropDownSearch(True)
end if
//u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch.of_UnRegister("prior_trckng_id")
//u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch.of_Register("prior_trckng_id")
u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch.of_UnRegister()
u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch.of_Register()


end subroutine

public subroutine of_hide_all_button ();u_cb_all.visible = false
end subroutine

public subroutine of_export ();///////////////////////////////////////////////////////////////////////////////////////////
//	function:  			of_export
//
//	Arguments:		None
//
//	Returns:  		None
//
//	Description:	 export issue list as excel file
//
// Initial Version :
// 07/01/2001	EMPT79				
//	
////////////////////////////////////////////////////////////////////////////////////////////
integer li_i, li_j, li_value
long ll_trckng_id, ll_row, ll_row_found, ll_row_export, ll_rowcount, ll_col, ll_sqlcode = 0
long ll_rowcount_desc, ll_rowcount_cmnt, ll_rowcount_owner, ll_rowcount_max,ll_rowcount_min, ll_row_i
string ls_data, ls_expression, ls_issue_col[], ls_export_col[]
string ls_docname, ls_named
datawindowchild ldwc_child, ldwc_child2
n_ds lds_issue_list, lds_issue_desc, lds_comment
any la_tranobject
n_tr_ral ltr_tranobject
Pointer lp_oldpointer

ls_issue_col[] = {"trckng_id","creat_dt_tm","srce_id","req_srce_id","prty_cde","stat_cde","prior_stat_cde","updt_dt_tm", &
						"reas_cde","cmpl_dt","cmpl_srce_id","rsolv_cde","trnmtr_cde","func_cde","rsolv_by_dt","orign_srce_cde", &
						"spr_num","est_cmpl_dt","prior_trckng_id","rleas_id","desc_short","updt_srce_id","dept_cde"} 
ls_export_col[] = {"Issue_No","Entry_Date","Submitter","Requestor","Priority","Status","Prior_Status","Last_Updated_Date","Reason", &
						"Completion_Date","Completed_By","Resolv_Reason","Transmitter","Functional_Area","Needed_Date","Control_Source","SPR_No", &
						"Est_Completion_Date","Moved_To","Fix_Version","Short_Description","Last_Updated_By","Department"}

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
ll_rowcount = u_dw_list.RowCount()
if ll_rowcount < 1 then return

ls_Docname = "C:\issue.xls"
li_value = GetFileSaveName("Select File", ls_Docname, ls_named, "XLS", "Excel File (*.XLS),*.XLS")
IF li_value = 0 THEN return
lds_issue_list = create n_ds
lds_issue_list.dataobject = 'd_ral_oi_issue_export'
lds_issue_desc = create n_ds
lds_issue_desc.dataobject = 'd_ral_oi_issue_desc'
lds_issue_desc.SetTransObject(ltr_tranobject)
lds_comment = create n_ds
lds_comment.dataobject = 'd_ral_oi_cmnt_list'
lds_comment.SetTransObject(ltr_tranobject)
ll_rowcount_desc = lds_issue_desc.Retrieve(ll_sqlcode)

lp_oldpointer = SetPointer ( HourGlass! )
If u_dw_list.getchild("srce_id", ldwc_child) > 0 then
	if ids_owner.getchild("racf_id_xref", ldwc_child2) > 0 Then
		ldwc_child.sharedata(ldwc_child2)
	end if
	if lds_comment.getchild("srce_id", ldwc_child2) > 0 Then
		ldwc_child.sharedata(ldwc_child2)
	end if	
end if
lds_comment.Retrieve(ll_sqlcode)
ids_owner.Retrieve(ll_sqlcode)
	
	
// copy data from data list to export datastore
for ll_row = 1 to ll_rowcount
	ll_trckng_id = u_dw_list.GetItemNumber(ll_row, "trckng_id")
	ll_row_export = lds_issue_list.InsertRow(0) 
	for ll_col = 1 to upperbound(ls_issue_col)
		if not isnull(u_dw_list.object.data[ll_row, ll_col]) then
			If u_dw_list.getchild(ls_issue_col[ll_col], ldwc_child) > 0 Then
				ls_expression = "Evaluate('" + "lookupdisplay(" + ls_issue_col[ll_col] + ")'," + string(ll_row)+")"
				ls_data = u_dw_list.describe(ls_expression)
				lds_issue_list.SetItem(ll_row_export, ls_export_col[ll_col], ls_data)
			else
				lds_issue_list.object.data[ll_row_export, ll_col] = u_dw_list.object.data[ll_row, ll_col]
			end if
		end if
	next
// copy issue description to export datastore
	ll_row_found =  lds_issue_desc.Find("trckng_id = " + string(ll_trckng_id), 1, ll_rowcount_desc)
	if ll_row_found > 0 then
		lds_issue_list.SetItem(ll_row_export, "Issue_Description", lds_issue_desc.GetItemString(ll_row_found, "desc_issue"))
	end if	
	lds_comment.SetFilter("")
	ids_owner.SetFilter("")
	lds_comment.Filter()
	ids_owner.Filter()
	ls_expression = "trckng_id = " + string(ll_trckng_id)
	lds_comment.SetFilter(ls_expression)
	ids_owner.SetFilter(ls_expression)
	lds_comment.Filter()
	ids_owner.Filter()
	ll_rowcount_cmnt = lds_comment.rowcount()
	ll_rowcount_owner =ids_owner.rowcount()
	if ll_rowcount_cmnt > ll_rowcount_owner then
		ll_rowcount_max = ll_rowcount_cmnt
	else
		ll_rowcount_max = ll_rowcount_owner
	end if
	for ll_row_i = 1 to ll_rowcount_max
		if ll_row_i = 2 then	ll_row_export = lds_issue_list.InsertRow(0) 
		if ll_rowcount_owner >= ll_row_i then
			ls_expression = "Evaluate('" + "lookupdisplay(" + "racf_id_xref" + ")'," + string(ll_row_i)+")"
			ls_data = ids_owner.describe(ls_expression)
			lds_issue_list.SetItem(ll_row_export, "issue_owner", ls_data)
		end if
		if ll_rowcount_cmnt >= ll_row_i then
			ls_expression = "Evaluate('" + "lookupdisplay(" + "srce_id" + ")'," + string(ll_row_i)+")"
			ls_data = lds_comment.describe(ls_expression)
			lds_issue_list.SetItem(ll_row_export, "comment_created_by", ls_data)
			lds_issue_list.object.comment_created_date[ll_row_export] = lds_comment.object.creat_dt_tm[ll_row_i]
			lds_issue_list.object.comment[ll_row_export] = lds_comment.object.cmnt_desc[ll_row_i]		
		end if
	next
next

lds_issue_list.SaveAs(ls_named, Excel!, true)
lp_oldpointer = SetPointer ( lp_oldpointer )
ids_owner.SetFilter("")
ids_owner.Filter()

destroy lds_issue_list
destroy lds_issue_desc
destroy lds_comment


end subroutine

public subroutine of_make_datawindow (string as_column);
end subroutine

public subroutine of_refresh_issue_list ();// refresh issue list due to update in detail window
long ll_column_count, ll_row, ll_row_found, ll_col, ll_trckng_id
string ls_col_name, ls_expression, ls_col_type, ls_filter, ls_owners, ls_racf_id_xref, ls_data
any la_any
boolean lb_inserting = false
u_dw ldw_details, ldw_owners

ldw_details = u_tab_main.tabpage_main.u_dw_main
ldw_owners = u_tab_main.tabpage_main.u_dw_owners
ll_trckng_id = ldw_details.GetItemNumber(1, "trckng_id")
ls_expression = "trckng_id = " + string(ll_trckng_id)

ib_rowfocuschanging_permit = false
u_dw_list.SetFilter("")
u_dw_list.Filter()

ll_row_found = u_dw_list.Find(ls_expression, 1, u_dw_list.RowCount())
if ll_row_found = 0 then
	ll_row_found = u_dw_list.InsertRow(0)
	lb_inserting = true
end if
ll_column_count = long(u_dw_list.Object.DataWindow.Column.Count)

for ll_col = 1 to (ll_column_count - 1)		
	ls_expression = "#" + string(ll_col) + ".Name"
	ls_col_name = u_dw_list.describe(ls_expression)
	ls_col_type = trim(lower(u_dw_list.describe(ls_col_name + ".ColType")))
	Choose Case true
		case pos(ls_col_type, "char") > 0
			u_dw_list.SetItem(ll_row_found, ls_col_name, ldw_details.GetItemString(1, ls_col_name))
		case ls_col_type = "date" 
			u_dw_list.SetItem(ll_row_found, ls_col_name, ldw_details.GetItemDate(1, ls_col_name))
		case ls_col_type = "datetime"
			u_dw_list.SetItem(ll_row_found, ls_col_name, ldw_details.GetItemDateTime(1, ls_col_name))
		case else
			u_dw_list.SetItem(ll_row_found, ls_col_name, ldw_details.GetItemNumber(1, ls_col_name))
	end choose
next

ls_owners = ''
for ll_row = 1 to ldw_owners.RowCount()
	ls_racf_id_xref = ldw_owners.GetItemString(ll_row, "racf_id_xref")
	if isnull(ls_racf_id_xref) then ls_racf_id_xref = ''
	if ls_racf_id_xref <> '' then
		if ls_owners <> '' then ls_owners = ls_owners + "; "
		ls_owners = ls_owners + ls_racf_id_xref
		ls_expression = "Evaluate('" + "lookupdisplay(" + "racf_id_xref" + ")'," + string(ll_row)+")"
		ls_data = ldw_owners.describe(ls_expression)		
//		ls_data = ls_racf_id_xref
		ls_owners = ls_owners + trim(ls_data)
	end if
next


u_dw_list.SetItem(ll_row_found, "owners", ls_owners)
of_filter_setup()
If lb_inserting then
	u_dw_filter.object.trckng_id_2[1] = string(ll_trckng_id)
end if
of_data_filter()
ls_expression = "trckng_id = " + string(ll_trckng_id)
ll_row_found = u_dw_list.Find(ls_expression, 1, u_dw_list.RowCount())
u_dw_list.SelectRow(0, false)
if ll_row_found > 0 then	
	u_dw_list.ScrollToRow(ll_row_found)
	u_dw_list.SelectRow(ll_row_found, true)	
end if
if not ib_rowfocuschanging then ib_rowfocuschanging_permit = true // focuschanging_permit turned back on only the rowfocus is not processing

il_trckng_id = ll_trckng_id



end subroutine

public function long of_find_item (string as_stat_cde, string as_dept_cde, string as_func_cde, long al_trckng_id);long ll_level_1_handle,ll_level_2_handle,ll_level_3_handle,ll_level_4_handle
long ll_trckng_id, ll_pos
string ls_data
treeviewitem ltvi_level_1_item,ltvi_level_2_item,ltvi_level_3_item,ltvi_level_4_item
ll_level_1_handle = tv_record_list.FindItem(RootTreeItem! , 0)
ll_level_1_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
if ll_level_1_handle = -1 then return -1
do // traverse level 1
	tv_record_list.GetItem(ll_level_1_handle, ltvi_level_1_item)
	if trim(string(ltvi_level_1_item.data)) = trim(as_stat_cde) and ltvi_level_1_item.children = true then // the level2 is expanded
		ll_level_2_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
		if ll_level_2_handle = -1 then return -1
		do
			tv_record_list.GetItem(ll_level_2_handle, ltvi_level_2_item)
			if string(ltvi_level_2_item.data) = as_dept_cde and ltvi_level_2_item.children = true then // the level3 is expanded
				ll_level_3_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_2_handle )
				if ll_level_3_handle = -1 then return -1
				do
					tv_record_list.GetItem(ll_level_3_handle, ltvi_level_3_item)
					if string(ltvi_level_3_item.data) = as_func_cde and ltvi_level_3_item.children = true then // the level4 is expanded							
						ll_level_4_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_3_handle )
						if ll_level_4_handle = -1 then return -1
						do
							tv_record_list.GetItem(ll_level_4_handle, ltvi_level_4_item)
							if al_trckng_id = ltvi_level_4_item.data then return ll_level_4_handle
							ll_level_4_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_4_handle)
						loop while ll_level_4_handle <> -1
					end if
					ll_level_3_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_3_handle)		
				loop while ll_level_3_handle <> -1
			end if
			ll_level_2_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_2_handle)
		loop while ll_level_2_handle <> -1
	end if		
	ll_level_1_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_1_handle)	
loop while ll_level_1_handle <> -1	

return -1
end function

public function long of_set_selection (string as_stat_cde, string as_dept_cde, string as_func_cde, long al_trckng_id);long ll_level_1_handle,ll_level_2_handle,ll_level_3_handle,ll_level_4_handle
long ll_trckng_id, ll_pos
string ls_data
treeviewitem ltvi_level_1_item,ltvi_level_2_item,ltvi_level_3_item,ltvi_level_4_item
ll_level_1_handle = tv_record_list.FindItem(RootTreeItem! , 0)
ll_level_1_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
if ll_level_1_handle = -1 then return -1
do // traverse level 1
	tv_record_list.GetItem(ll_level_1_handle, ltvi_level_1_item)
	if trim(string(ltvi_level_1_item.data)) = trim(as_stat_cde) then
		ll_level_2_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle ) // at the end or not expanded
		if ll_level_2_handle = -1 then
			tv_record_list.SelectItem(ll_level_1_handle)
			return -1
		end if
		do
			tv_record_list.GetItem(ll_level_2_handle, ltvi_level_2_item)
			if string(ltvi_level_2_item.data) = as_dept_cde then //
				ll_level_3_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_2_handle )
				if ll_level_3_handle = -1 then 
					tv_record_list.SelectItem(ll_level_2_handle)
					return -1
				end if
				do
					tv_record_list.GetItem(ll_level_3_handle, ltvi_level_3_item)
					if string(ltvi_level_3_item.data) = as_func_cde then				
						ll_level_4_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_3_handle )
						if ll_level_4_handle = -1 then 
							tv_record_list.SelectItem(ll_level_3_handle)
							return -1
						end if
						do
							tv_record_list.GetItem(ll_level_4_handle, ltvi_level_4_item)
							if al_trckng_id = ltvi_level_4_item.data then 
								tv_record_list.SelectItem(ll_level_4_handle)
								return ll_level_4_handle
							end if
							ll_level_4_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_4_handle)
							if ll_level_4_handle = -1 then
								tv_record_list.SelectItem(ll_level_3_handle)
								return -1
							end if					
						loop while ll_level_4_handle <> -1
					end if
					ll_level_3_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_3_handle)	
					if ll_level_3_handle = -1 then
						tv_record_list.SelectItem(ll_level_2_handle)
						return -1
					end if					
				loop while ll_level_3_handle <> -1
			end if
			ll_level_2_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_2_handle)
			if ll_level_2_handle = -1 then
				tv_record_list.SelectItem(ll_level_1_handle)
				return -1
			end if
		loop while ll_level_2_handle <> -1
	end if		
	ll_level_1_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_1_handle)	
loop while ll_level_1_handle <> -1	
return -1
end function

public subroutine of_insert_treeview_item (long al_parent_handle, long al_sibling_handle, integer ai_indicator);treeviewitem ltvi_new
long ll_trckng_id, ll_treeview_handle
datetime ldt_creat_dt_tm
string ls_tvitem_label
u_dw ldw
ldw = u_tab_main.tabpage_main.u_dw_main
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ll_trckng_id = ldw.GetItemNumber(1, "trckng_id")	
ls_tvitem_label =  String(ldw.GetItemDateTime(1, "creat_dt_tm"), "mm/dd/yyyy hh:mm:ss") + &
						 "  " + String(ll_trckng_id, "0000000") + "  " + ldw.GetItemString(1, "desc_short")
//if isnull(ldw.GetItemDateTime(1, "creat_dt_tm")
ltvi_new.label = trim(ls_tvitem_label)	
ltvi_new.data = ll_trckng_id
ltvi_new.children = false


if ai_indicator = 0 then // insert at first
	ll_treeview_handle = tv_record_list.InsertItemFirst(al_parent_handle, ltvi_new)
elseif ai_indicator = 2 then // insert at last
	ll_treeview_handle = tv_record_list.InsertItemLast(al_parent_handle, ltvi_new)
else
	ll_treeview_handle = tv_record_list.FindItem ( PreviousTreeItem!,  al_sibling_handle)
	ll_treeview_handle = tv_record_list.InsertItem(al_parent_handle, ll_treeview_handle, ltvi_new)
end if

tv_record_list.SelectItem( ll_treeview_handle )

end subroutine

public subroutine of_make_new_status (string as_status);string ls_security_all_status, ls_status
string ls_filter, ls_expression, ls_stat_desc
long ll_row, ll_rowcount, ll_sqlcode = 0
long ll_root_handle, ll_parent_handle, ll_current_handle, ll_prev_handle, ll_status_handle
long ll_found, ll_i
treeviewitem ltvi_new, ltvi_status 
string ls_tvitem_label
n_ds lds_cdv
// traverse the treeview items in the status level for the target status
ll_root_handle = tv_record_list.FindItem(RootTreeItem! , 0)
ll_status_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_root_handle )
do
	tv_record_list.GetItem(ll_status_handle, ltvi_status)
	if string(ltvi_status.data) = as_status then // the target status is existing
		return 	
	end if
	ll_current_handle = tv_record_list.FindItem ( NextTreeItem!, ll_status_handle )
	if ll_current_handle = -1 then
		exit
	else
		ll_status_handle = ll_current_handle
	end if
loop while true

if ll_status_handle = -1 then ll_status_handle = 0

if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_STAT_CD",lds_cdv) < 1 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE STATUS"})
	return
end if
ls_expression = "cdv_cde = '" + as_status + "'"
ll_found = lds_cdv.Find(ls_expression, 1, lds_cdv.RowCount())
if ll_found = 0 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE STATUS"})
	return
end if	
ls_stat_desc = lds_cdv.GetItemString(ll_found, "cdv_desc")
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ltvi_new.children = false
ltvi_new.label = ls_stat_desc 
ltvi_new.data = as_status

tv_record_list.SetRedraw(false)
tv_record_list.InsertItemLast(ll_root_handle, ltvi_new)
tv_record_list.Sort(ll_root_handle, Ascending!)
tv_record_list.SetRedraw(true)


end subroutine

public subroutine of_make_new_dept (string as_status, string as_dept_cde);string ls_security_all_status, ls_status
string ls_filter, ls_expression, ls_dept_desc, ls_cdv_type
long ll_row, ll_rowcount, ll_sqlcode = 0
long ll_root_handle, ll_parent_handle, ll_current_handle, ll_status_handle, ll_dept_handle
long ll_found, ll_i
treeviewitem ltvi_new, ltvi_status, ltvi_dept
string ls_tvitem_label
n_ds lds_cdv
// traverse the treeview items in the status level for the target status
ll_root_handle = tv_record_list.FindItem(RootTreeItem! , 0)
ll_status_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_root_handle )
do
	tv_record_list.GetItem(ll_status_handle, ltvi_status)
	if string(ltvi_status.data) = as_status then // the target status
		if ltvi_status.children = false then	// the status item not opened yet, no bother, the types 
			return 										// will be populated when the user clicks the status
		else
			exit
		end if
	end if
	ll_status_handle = tv_record_list.FindItem ( NextTreeItem!, ll_status_handle )
loop while ll_status_handle <> -1
if ll_status_handle = -1 then return // something is wrong, it shouldn't happen

if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_DEPT_CD",lds_cdv) < 1 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE DEPARTMENT"})
	return
end if
ls_expression = "cdv_cde = '" + as_dept_cde + "'"
ll_found = lds_cdv.Find(ls_expression, 1, lds_cdv.RowCount())
if ll_found = 0 then
	gnv_app.inv_error.of_message("RL006",{"CDV - COPEN ISSUE DEPARTMENT"})
	return
end if	
ls_dept_desc = lds_cdv.GetItemString(ll_found, "cdv_desc")
// traverse the treeview items in the type level for the target type
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ltvi_new.children = false
ltvi_new.label = ls_dept_desc 
ltvi_new.data = as_dept_cde
ll_dept_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_status_handle )
do
	tv_record_list.GetItem(ll_dept_handle, ltvi_dept)
	if string(ltvi_dept.data) = as_dept_cde then return // the target type already existing
	ll_dept_handle = tv_record_list.FindItem ( NextTreeItem!, ll_dept_handle )
loop while ll_dept_handle <> -1
tv_record_list.SetRedraw(false)
tv_record_list.InsertItemLast(ll_status_handle, ltvi_new)
tv_record_list.Sort(ll_status_handle, Ascending!)
tv_record_list.SetRedraw(true)

end subroutine

public subroutine of_make_new_func (string as_status, string as_dept_cde, string as_func_cde);string ls_security_all_status, ls_status
string ls_filter, ls_expression, ls_dept_desc, ls_cdv_type, ls_func_desc
long ll_row, ll_rowcount, ll_sqlcode = 0
long ll_root_handle, ll_parent_handle, ll_current_handle, ll_status_handle, ll_dept_handle, ll_func_handle
long ll_found, ll_i
treeviewitem ltvi_new, ltvi_status, ltvi_dept, ltvi_func
string ls_tvitem_label
n_ds lds_cdv
// traverse the treeview items in the status level for the target status
ll_root_handle = tv_record_list.FindItem(RootTreeItem! , 0)
ll_status_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_root_handle )
do
	tv_record_list.GetItem(ll_status_handle, ltvi_status)
	if string(ltvi_status.data) = as_status then // the target status
		if ltvi_status.children = false then	// the status item not opened yet, no bother, the types 
			return 										// will be populated when the user clicks the status
		else
			exit
		end if
	end if
	ll_status_handle = tv_record_list.FindItem ( NextTreeItem!, ll_status_handle )
loop while ll_status_handle <> -1
if ll_status_handle = -1 then return // something is wrong, it shouldn't happen
ll_dept_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_status_handle )
do
	tv_record_list.GetItem(ll_dept_handle, ltvi_dept)
	if string(ltvi_dept.data) = as_dept_cde then // the target department
		if ltvi_dept.children = false then	// the department item not opened yet, no bother, the department 
			return 										// will be populated when the user clicks the department
		else
			exit
		end if
	end if
	ll_dept_handle = tv_record_list.FindItem ( NextTreeItem!, ll_dept_handle )
loop while ll_dept_handle <> -1
if ll_dept_handle = -1 then return // something is wrong, it shouldn't happen
if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_FUNC_CD",lds_cdv) < 1 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE functional area"})
	return
end if
ls_expression = "cdv_cde = '" + as_func_cde + "'"
ll_found = lds_cdv.Find(ls_expression, 1, lds_cdv.RowCount())
if ll_found = 0 then
	gnv_app.inv_error.of_message("RL006",{"CDV - OPEN ISSUE functional area"})
	return
end if	
ls_func_desc = lds_cdv.GetItemString(ll_found, "cdv_desc")
// traverse the treeview items in the functional area level for the target item
ltvi_new.PictureIndex = 1
ltvi_new.SelectedPictureIndex = 2
ltvi_new.children = false
ltvi_new.label = ls_func_desc 
ltvi_new.data = as_func_cde
ll_func_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_dept_handle )
do
	tv_record_list.GetItem(ll_func_handle, ltvi_func)
	if string(ltvi_func.data) = as_func_cde then return // the target already existing	
	ll_func_handle = tv_record_list.FindItem ( NextTreeItem!, ll_func_handle )
loop while ll_func_handle <> -1
tv_record_list.SetRedraw(false)
tv_record_list.InsertItemLast(ll_dept_handle, ltvi_new)
tv_record_list.Sort(ll_dept_handle, Ascending!)
tv_record_list.SetRedraw(true)

end subroutine

public function long of_find_insert_spot (string as_stat_cde, string as_dept_cde, string as_func_cde, long al_trckng_id, ref long al_parent_handle, ref long al_sibling_handle);long ll_level_1_handle, ll_level_2_handle, ll_level_3_handle, ll_level_4_handle
long ll_trckng_id, ll_pos
boolean lb_tv_leave_found = false

treeviewitem ltvi_level_1_item, ltvi_level_2_item, ltvi_level_3_item, ltvi_level_4_item
ll_level_1_handle = tv_record_list.FindItem(RootTreeItem! , 0)
ll_level_1_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
if ll_level_1_handle = -1 then return -1
do // traverse level 1
	tv_record_list.GetItem(ll_level_1_handle, ltvi_level_1_item)
	if ltvi_level_1_item.data = as_stat_cde and ltvi_level_1_item.children = true then // the level2 is expanded
		ll_level_2_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
		if ll_level_2_handle = -1 then return -1
		do
			tv_record_list.GetItem(ll_level_2_handle, ltvi_level_2_item)
			if ltvi_level_2_item.data = as_dept_cde and ltvi_level_2_item.children = true then // the level3 is expanded
				al_parent_handle = ll_level_2_handle
				ll_level_3_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_2_handle )
				if ll_level_3_handle = -1 then return -1
				do					
					tv_record_list.GetItem(ll_level_3_handle, ltvi_level_3_item)
					if string(ltvi_level_3_item.data) = as_func_cde and ltvi_level_3_item.children = true then // the level4 is expanded
						al_parent_handle = ll_level_3_handle
						ll_level_4_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_3_handle )
						if ll_level_4_handle = -1 then return -1	
						do 						
							al_sibling_handle = ll_level_4_handle
							tv_record_list.GetItem(ll_level_4_handle, ltvi_level_4_item)													
							ll_trckng_id = ltvi_level_4_item.data
							if ll_trckng_id > al_trckng_id then
								if not lb_tv_leave_found then // first item
									return 0
								else
									return 1
								end if
							end if						
							lb_tv_leave_found = true
							ll_level_4_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_4_handle)
						loop while ll_level_4_handle <> -1
					end if		
					ll_level_3_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_3_handle)		
				loop while ll_level_3_handle <> -1
			end if
			ll_level_2_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_2_handle)
		loop while ll_level_2_handle <> -1
	end if		
	ll_level_1_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_1_handle)	
loop while ll_level_1_handle <> -1	

if lb_tv_leave_found then // last item
	return 2
else
	return -1
end if
			

return -1
end function

public subroutine of_delete_item (long al_handle);long ll_parent_handle, ll_child_handle, ll_current_handle
treeviewitem ltvi_level_1_item,ltvi_level_2_item,ltvi_level_3_item,ltvi_level_4_item
ll_current_handle = al_handle
do
	ll_parent_handle = tv_record_list.FindItem(ParentTreeItem! , ll_current_handle)	
	if tv_record_list.FindItem(ChildTreeItem! , ll_current_handle) = -1 then
		tv_record_list.DeleteItem(ll_current_handle)
	end if	
	ll_current_handle = ll_parent_handle
loop while ll_parent_handle <> -1	


end subroutine

public function integer of_update_confirmation ();long ll_return_code
u_tab_main.tabpage_main.u_dw_main.AcceptText()
u_tab_main.tabpage_main.u_dw_comments.AcceptText()
u_tab_main.tabpage_main.u_dw_owners.AcceptText()
if u_tab_main.tabpage_main.u_dw_main.ModifiedCount() > 0 or &
	u_tab_main.tabpage_main.u_dw_comments.ModifiedCount() > 0 or &
	u_tab_main.tabpage_main.u_dw_owners.ModifiedCount() > 0 or &
	u_tab_main.tabpage_main.u_dw_owners.DeletedCount() > 0 then
	ll_return_code = gnv_app.inv_error.of_message("RL308")
	choose case ll_return_code
		case 1 // Yes, save and move to other item			
			cb_apply.event clicked()
			if not ib_verified then
				return 0
			else
				return 1
			end if
		case 2 // abandom the change and move to other item		
			return 2
		case 3 // cancel
			return 0
	end choose
else
	return 2
end if

end function

public function string of_setlines (ref hi_u_dw adw, ref datawindowchild adwc, string as_colname);if adwc.rowcount() > 15 then
	return adw.modify(as_colname + ".dddw.lines = 15 " + as_colname + ".DDDW.VScrollbar=Yes " + as_colname + ".DDDW.HScrollbar=No")
else
	return adw.modify(as_colname + ".dddw.lines = " + string(adwc.rowcount()) + " " +  as_colname + ".DDDW.VScrollbar=No " + as_colname + ".DDDW.HScrollbar=No")
end if
if isvalid(adw.inv_dropdownsearch) then
	adw.inv_dropdownsearch.of_unregister(as_colname)
	adw.inv_dropdownsearch.of_register(as_colname)
end if
end function

public function string of_set_dddw_width (ref hi_u_dw adw, ref datawindowchild adwc, string as_colname, string as_display_colname);integer li_dc, li_i, li_row, li_width, li_height,li_max_width = 0, li_col_width, li_width_pct, li_font_size, li_col_height
string ls_desc, ls_tmp, ls_font_face, ls_font_height, ls_attribute, ls_expression 
real lr_xy_ratio, lr_height_ratio
window lw_window
n_cst_platformwin32 lnv_platform
lnv_platform = create n_cst_platformwin32
lw_window = this
lr_xy_ratio = PixelsToUnits(1000, XPixelsToUnits!)/PixelsToUnits(1000, YPixelsToUnits!)
li_col_width = integer(adw.Describe(as_colname + ".width"))
li_width_pct = integer(adw.Describe(as_colname + ".dddw.PercentWidth")) 
ls_font_face = adwc.describe(as_display_colname + ".Font.Face")
li_font_size = integer(adwc.describe(as_display_colname + ".Font.Height"))
if li_font_size = -9 then
	li_col_height = 55
else // 10
	li_col_height = 55*(10/9)
end if
for li_row = 1 to adwc.rowcount()
	if pos(lower(adwc.describe(as_display_colname + ".Attributes")), "computed") > 0 then // computed field
		ls_expression = adwc.describe(as_display_colname + ".expression")
		ls_desc = trim(adwc.Describe("evaluate('"+ ls_expression + "'," + string(li_row) + ")"))
	else // string column
		ls_desc = trim(adwc.GetItemString(li_row, as_display_colname))
	end if
	if lnv_platform.of_GetTextSize(lw_window,ls_desc,ls_font_face,li_font_size,false,false,false,li_height,li_width) = -1 then
		exit
	end if
	lr_height_ratio = li_col_height/PixelsToUnits(li_height, YPixelsToUnits!)
	li_width = PixelsToUnits(li_width, XPixelsToUnits!)
	li_width =  li_width*lr_xy_ratio*lr_height_ratio
	if adwc.rowcount() > 15 then li_width = li_width + 80
	if li_width > li_max_width then li_max_width = li_width
next
if li_max_width > li_col_width then
	li_width_pct = (li_max_width/li_col_width)*100
else
	li_width_pct = 100
end if
adw.modify(as_colname + ".dddw.PercentWidth = " + string(li_width_pct))
if isvalid(adw.inv_dropdownsearch) then
	adw.inv_dropdownsearch.of_unregister(as_colname)
	adw.inv_dropdownsearch.of_register(as_colname)
end if

destroy lnv_platform
return ""
end function

public subroutine of_data_filter ();// refresh issue list due to update in detail window
long ll_column_count, ll_row, ll_row_found, ll_col, ll_trckng_id
string ls_col_name, ls_expression, ls_col_type, ls_filter, ls_racf_id_xref
boolean lb_ored = false

ib_rowfocuschanging_permit = false
u_dw_list.SetFilter("")
u_dw_list.Filter()
ll_column_count = long(u_dw_filter.Object.DataWindow.Column.Count)
ls_filter = ""
for ll_col = 1 to (ll_column_count - 6)
	ls_expression = "#" + string(ll_col) + ".Name"
	ls_col_name = u_dw_filter.describe(ls_expression)			
	if string(u_dw_filter.object.data[1, ll_col]) <> "ALL" then
		if len(ls_filter) > 0 then
			ls_filter = ls_filter + " and "
		end if
		choose case ls_col_name
			case "trckng_id"					
				ls_filter = ls_filter + ls_col_name + " >= " + string(u_dw_filter.object.data[1, ll_col])
			case "trckng_id_2"
				ls_filter = ls_filter + left(ls_col_name, len(ls_col_name) - 2) + " <= " + string(u_dw_filter.object.data[1, ll_col])
			case "creat_dt_tm"
				ls_filter = ls_filter + "date(" + ls_col_name + ") >= date('" + string(u_dw_filter.object.data[1, ll_col]) + "')"
			case "est_cmpl_dt", "cmpl_dt" 
				ls_filter = ls_filter + ls_col_name + " >= date('" + string(u_dw_filter.object.data[1, ll_col]) + "')"
				ls_filter = ls_filter + " and " + "string(" + ls_col_name + ",'mm/dd/yyyy" + "') <> " + "'01/01/0001" + "'"
			case "creat_dt_tm_2"
				ls_filter = ls_filter + "date(" + left(ls_col_name, len(ls_col_name) - 2) + ") <= date('" + string(u_dw_filter.object.data[1, ll_col]) + "')"
			case "est_cmpl_dt_2", "cmpl_dt_2" 
				ls_filter = ls_filter + left(ls_col_name, len(ls_col_name) - 2) + " <= date('" + string(u_dw_filter.object.data[1, ll_col]) + "')"
				ls_filter = ls_filter + " and " + "string(" + left(ls_col_name, len(ls_col_name) - 2) + ",'mm/dd/yyyy" + "') <> " + "'01/01/0001" + "'"
			case else
				ls_filter = ls_filter + ls_col_name + " = '" + string(u_dw_filter.object.data[1, ll_col]) + "'"	
				ls_filter = ls_filter + " and " + "trim(" + ls_col_name + ") <> '" +  "'"		
		end choose
	end if
next

for ll_row = 1 to ids_owner_filter.RowCount()
	ls_racf_id_xref = ids_owner_filter.GetItemString(ll_row, "racf_id_xref")
	if isnull(ls_racf_id_xref) then ls_racf_id_xref = ''
	if trim(ls_racf_id_xref) <> '' then
		if len(ls_filter) > 0 then
			if ll_row = 1 then 
				ls_filter = ls_filter + " and ( "
				lb_ored = true
			else
				ls_filter = ls_filter + " or "
			end if
		end if
		ls_filter = ls_filter + "pos(owners, " + "'" + trim(ls_racf_id_xref) + "') > 0"
	end if
next
if lb_ored then ls_filter = ls_filter + " )"	
u_dw_list.SetFilter(ls_filter)
u_dw_list.Filter()
ib_rowfocuschanging_permit = true
if u_dw_list.RowCount() = 1 then
	u_dw_list.event rowfocuschanged(1)
else
	if u_dw_list.RowCount() > 0 then
		u_dw_list.SelectRow(0, false)
		ll_trckng_id = u_tab_main.tabpage_main.u_dw_main.GetItemNumber(1, "trckng_id")
		ls_expression = "trckng_id = " + string(ll_trckng_id)
		ll_row_found = u_dw_list.Find(ls_expression, 1, u_dw_list.RowCount())
		if ll_row_found > 0 then
			u_dw_list.ScrollToRow(ll_row_found)
			u_dw_list.SelectRow(ll_row_found, true)
		else
			ib_first_click = false
		end if
	end if		
end if

end subroutine

public subroutine of_make_owner_filter ();long ll_row, ll_row_found, ll_row_found_owner_dddw, ll_rowcount, ll_col, ll_sqlcode = 0
long ll_rowcount_cmnt, ll_rowcount_owner, ll_row_i
string ls_data, ls_expression
string ls_named, ls_racf_id_xref
datawindowchild ldwc_child, ldwc_child2
//u_dw ldw_owner
any la_tranobject
n_tr_ral ltr_tranobject

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
If u_dw_list.getchild("srce_id", ldwc_child) < 0 then
	return
else
	If ids_owner.getchild("racf_id_xref", ldwc_child2) > 0 then
		ldwc_child.ShareData(ldwc_child2)
	end if	
end if
ll_rowcount = ids_owner.Retrieve(ll_sqlcode)
if ll_rowcount = 0 then 
//	destroy ids_owner
	return
end if
	
ls_racf_id_xref = trim(upper(ids_owner.GetItemString(1, "racf_id_xref")))
ids_owner_dddw.Reset()
ll_row_i = ids_owner_dddw.InsertRow(0)
ls_expression = "racf_id_xref = '" + ls_racf_id_xref + "'"
ll_row_found = ldwc_child.Find(ls_expression, 0, ldwc_child.RowCount())
if ll_row_found = 0 then
//	destroy ids_owner
	return
end if
ids_owner_dddw.SetItem(ll_row_i, "racf_id_xref", ldwc_child.GetItemString(ll_row_found,  "racf_id_xref"))
ids_owner_dddw.SetItem(ll_row_i, "name_last", ldwc_child.GetItemString(ll_row_found,  "name_last"))
ids_owner_dddw.SetItem(ll_row_i, "name_first", ldwc_child.GetItemString(ll_row_found,  "name_first"))
for ll_row = 2 to ll_rowcount
	if ls_racf_id_xref <> trim(upper(ids_owner.GetItemString(ll_row, "racf_id_xref"))) then
		ls_racf_id_xref = trim(upper(ids_owner.GetItemString(ll_row, "racf_id_xref")))
		ll_row_found = ldwc_child.Find("racf_id_xref = '" + ls_racf_id_xref + "'", 0, ldwc_child.RowCount())
		if ll_row_found = 0 then
			destroy ids_owner
			return
		end if
		if ids_owner_dddw.RowCount() > 0 then
			ll_row_found_owner_dddw	= 	ids_owner_dddw.Find("racf_id_xref = '" + ls_racf_id_xref + "'", 0, &
													ids_owner_dddw.RowCount())
			if ll_row_found_owner_dddw > 0 then continue // already there
		end if
		ll_row_i = ids_owner_dddw.InsertRow(0)		
		ids_owner_dddw.SetItem(ll_row_i, "racf_id_xref", ldwc_child.GetItemString(ll_row_found,  "racf_id_xref"))
		ids_owner_dddw.SetItem(ll_row_i, "name_last", ldwc_child.GetItemString(ll_row_found,  "name_last"))
		ids_owner_dddw.SetItem(ll_row_i, "name_first", ldwc_child.GetItemString(ll_row_found,  "name_first"))
	end if
next
ids_owner_dddw.SetSort("fullname A")
ids_owner_dddw.Sort()



end subroutine

public subroutine of_add_owner_to_list ();long ll_trckng_id, ll_owner_trckng_id, ll_row_owner, ll_row, ll_rowcount_owner, ll_rowcount
string ls_expression, ls_owners, ls_racf_id_xref, ls_data
ids_owner.SetSort("trckng_id A")
ids_owner.Sort()
u_dw_list.SetSort("trckng_id A")
u_dw_list.Sort()
ll_rowcount_owner =ids_owner.rowcount()
ll_row_owner = 1
for ll_row = 1 to u_dw_list.RowCount()
	if ll_row_owner <= ids_owner.RowCount() then
		ll_trckng_id = u_dw_list.GetItemNumber(ll_row, "trckng_id")
		ll_owner_trckng_id = ids_owner.GetItemNumber(ll_row_owner, "trckng_id")
		ls_owners = ''	
		do while ll_owner_trckng_id <=  ll_trckng_id and ll_row_owner <= ll_rowcount_owner
			if ll_owner_trckng_id =  ll_trckng_id then
				ls_racf_id_xref = ids_owner.GetItemString(ll_row_owner, "racf_id_xref")
				if isnull(ls_racf_id_xref) then ls_racf_id_xref = ''
				if ls_racf_id_xref <> '' then
					ls_expression = "Evaluate('" + "lookupdisplay(" + "racf_id_xref" + ")'," + string(ll_row_owner)+")"
					ls_data = ids_owner.describe(ls_expression)			
	//				ls_data = ls_racf_id_xref
					if ls_owners <> '' then ls_owners = ls_owners + "; "
					ls_owners = ls_owners + trim(ls_data)
				end if
			end if		
			ll_row_owner++
			if ll_row_owner <= ids_owner.RowCount() then
				ll_owner_trckng_id = ids_owner.GetItemNumber(ll_row_owner, "trckng_id")	
			end if
		loop 
		u_dw_list.SetItem(ll_row, "owners", ls_owners)
	end if
next

end subroutine

public subroutine of_delete_status (string as_status);long ll_row_found, ll_sqlcode = 0, ll_root_handle, ll_status_handle, ll_current_handle
string ls_expression
boolean lb_found = false
treeviewitem ltvi_status
any la_tranobject
n_tr ltr_tranobject
n_ds lds_status

lds_status = create n_ds
lds_status.dataobject = 'd_ral_oi_tv_status'
gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
lds_status.SetTransObject(ltr_tranobject)
lds_status.Retrieve(ll_sqlcode)

if lds_status.RowCount() < 1 then return
ls_expression = "stat_cde = '" + trim(as_status) + "'"
ll_row_found = lds_status.Find(ls_expression, 1, lds_status.RowCount())
if ll_row_found = 0 then // need to delete the status in the treeview
// traverse the treeview items in the status level for the target status
	ll_root_handle = tv_record_list.FindItem(RootTreeItem! , 0)
	ll_status_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_root_handle )
	do
		tv_record_list.GetItem(ll_status_handle, ltvi_status)
		if string(ltvi_status.data) = as_status then // the target status found
			lb_found = true
			exit 	
		end if
		ll_current_handle = tv_record_list.FindItem ( NextTreeItem!, ll_status_handle )
		if ll_current_handle = -1 then
			exit
		else
			ll_status_handle = ll_current_handle
		end if
	loop while true
	if lb_found then
		tv_record_list.DeleteItem(ll_status_handle)
		if ids_status.RowCount() > 0 then
			ll_row_found = ids_status.Find(ls_expression, 1, ids_status.RowCount())
			if ll_row_found > 0 then ids_status.DeleteRow(ll_row_found)
		end if
	end if
end if
destroy lds_status

end subroutine

public subroutine of_delete_dept (string as_status, string as_dept);long ll_level_1_handle,ll_level_2_handle
long ll_row, ll_row_found, ll_rowcount, ll_sqlcode = 0
treeviewitem ltvi_level_1_item,ltvi_level_2_item
string ls_tvitem_label, ls_stat_cde, ls_cdv_type, ls_desc
string ls_expression = ""
n_ds lds_dept
any la_tranobject
n_tr ltr_tranobject

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
lds_dept = create n_ds
lds_dept.dataobject = 'd_ral_oi_tv_dept'
lds_dept.SetTransObject(ltr_tranobject)

lds_dept.Retrieve(as_status, ll_sqlcode)
ll_rowcount = lds_dept.RowCount()

if ll_rowcount < 1 then 
	destroy lds_dept
	return
end if
ls_expression = "dept_cde = '" + trim(as_dept) + "'"
ll_row_found = lds_dept.Find(ls_expression, 1, lds_dept.RowCount())
if ll_row_found = 0 then // need to delete the department in the treeview
	ll_level_1_handle = tv_record_list.FindItem(RootTreeItem! , 0)
	ll_level_1_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
	if ll_level_1_handle > -1 then
		do // traverse level 1
			tv_record_list.GetItem(ll_level_1_handle, ltvi_level_1_item)
			if trim(string(ltvi_level_1_item.data)) = trim(as_status) and ltvi_level_1_item.children = true then // the level2 is expanded
				ll_level_2_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
				if ll_level_2_handle > -1 then
					do
						tv_record_list.GetItem(ll_level_2_handle, ltvi_level_2_item)
						if string(ltvi_level_2_item.data) = as_dept then // found
							tv_record_list.DeleteItem(ll_level_2_handle)
						end if
						ll_level_2_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_2_handle)
					loop while ll_level_2_handle <> -1
				end if
			end if		
			ll_level_1_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_1_handle)	
		loop while ll_level_1_handle <> -1	
	end if
end if
destroy lds_dept
end subroutine

public subroutine of_delete_func (string as_status, string as_dept, string as_func);long ll_level_1_handle,ll_level_2_handle, ll_level_3_handle
long ll_row, ll_row_found, ll_rowcount, ll_sqlcode = 0
treeviewitem ltvi_level_1_item,ltvi_level_2_item,ltvi_level_3_item
string ls_tvitem_label, ls_stat_cde, ls_cdv_type, ls_desc
string ls_expression = ""
n_ds lds_func
any la_tranobject
n_tr ltr_tranobject

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
lds_func = create n_ds
lds_func.dataobject = 'd_ral_oi_tv_func'
lds_func.SetTransObject(ltr_tranobject)

lds_func.Retrieve(as_status, as_dept, ll_sqlcode)
ll_rowcount = lds_func.RowCount()

if ll_rowcount < 1 then 
	destroy lds_func
	return
end if
ls_expression = "func_cde = '" + trim(as_dept) + "'"
ll_row_found = lds_func.Find(ls_expression, 1, lds_func.RowCount())
if ll_row_found = 0 then // need to delete the department in the treeview
	ll_level_1_handle = tv_record_list.FindItem(RootTreeItem! , 0)
	ll_level_1_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
	if ll_level_1_handle > -1 then
		do // traverse level 1
			tv_record_list.GetItem(ll_level_1_handle, ltvi_level_1_item)
			if trim(string(ltvi_level_1_item.data)) = trim(as_status) and ltvi_level_1_item.children = true then // the level2 is expanded
				ll_level_2_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_1_handle )
				if ll_level_2_handle > -1 then
					do
						tv_record_list.GetItem(ll_level_2_handle, ltvi_level_2_item)
						if string(ltvi_level_2_item.data) = as_dept and ltvi_level_2_item.children = true then // the level3 is expanded
							ll_level_3_handle = tv_record_list.FindItem ( ChildTreeItem!, ll_level_2_handle )
							if ll_level_3_handle > -1 then
								do
									tv_record_list.GetItem(ll_level_3_handle, ltvi_level_3_item)
									if string(ltvi_level_3_item.data) = as_func then // found							
										tv_record_list.DeleteItem(ll_level_3_handle)
									end if
									ll_level_3_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_3_handle)		
								loop while ll_level_3_handle <> -1
							end if
						end if
						ll_level_2_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_2_handle)
					loop while ll_level_2_handle <> -1
				end if
			end if		
			ll_level_1_handle = tv_record_list.FindItem ( NextTreeItem!,  ll_level_1_handle)	
		loop while ll_level_1_handle <> -1	
	end if
end if
destroy lds_func
end subroutine

on w_ral_oi_main.create
int iCurrent
call super::create
this.u_cb_cancel_comments=create u_cb_cancel_comments
this.cb_apply=create cb_apply
this.u_cb_new=create u_cb_new
this.tv_record_list=create tv_record_list
this.u_dw_filter=create u_dw_filter
this.u_dw_list=create u_dw_list
this.u_cb_export=create u_cb_export
this.st_splitbar_1=create st_splitbar_1
this.st_splitbar_2=create st_splitbar_2
this.u_cb_new_comment=create u_cb_new_comment
this.u_cb_reset=create u_cb_reset
this.u_tab_main=create u_tab_main
this.u_cb_all=create u_cb_all
this.u_cb_print=create u_cb_print
this.u_cb_owner_filter=create u_cb_owner_filter
this.u_cb_reset_filter=create u_cb_reset_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.u_cb_cancel_comments
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.u_cb_new
this.Control[iCurrent+4]=this.tv_record_list
this.Control[iCurrent+5]=this.u_dw_filter
this.Control[iCurrent+6]=this.u_dw_list
this.Control[iCurrent+7]=this.u_cb_export
this.Control[iCurrent+8]=this.st_splitbar_1
this.Control[iCurrent+9]=this.st_splitbar_2
this.Control[iCurrent+10]=this.u_cb_new_comment
this.Control[iCurrent+11]=this.u_cb_reset
this.Control[iCurrent+12]=this.u_tab_main
this.Control[iCurrent+13]=this.u_cb_all
this.Control[iCurrent+14]=this.u_cb_print
this.Control[iCurrent+15]=this.u_cb_owner_filter
this.Control[iCurrent+16]=this.u_cb_reset_filter
end on

on w_ral_oi_main.destroy
call super::destroy
destroy(this.u_cb_cancel_comments)
destroy(this.cb_apply)
destroy(this.u_cb_new)
destroy(this.tv_record_list)
destroy(this.u_dw_filter)
destroy(this.u_dw_list)
destroy(this.u_cb_export)
destroy(this.st_splitbar_1)
destroy(this.st_splitbar_2)
destroy(this.u_cb_new_comment)
destroy(this.u_cb_reset)
destroy(this.u_tab_main)
destroy(this.u_cb_all)
destroy(this.u_cb_print)
destroy(this.u_cb_owner_filter)
destroy(this.u_cb_reset_filter)
end on

event pfc_preopen;call super::pfc_preopen;///////////////////////////////////////////////////////////////////////////////////////////
//	Event:  			pfc_preopen
//
//	Arguments:		None
//
//	Returns:  		None
//
//	Description:	 Initial screen setup
//
// Initial Version :
// 06/05/2001	EMPT79				
//
////////////////////////////////////////////////////////////////////////////////////////////
w_sheet lw_window
w_master lw_master
any la_tranobject
n_tr ltr_tranobject

lw_master = this
gnv_app.of_getframe().inv_frame.dynamic of_set_bubblehelp(true, lw_master)
//long ll_handle
//string ls_filename
//ll_handle = handle(gnv_app.of_getframe().MDI_1)
//ls_filename = "c:\logon.bmp"
//LoadGraph(ll_handle, ls_filename)


lw_window = this

gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
//
u_cb_all.visible = false
u_tab_main.tabpage_main.of_set_window(lw_window)
u_tab_main.tabpage_hist.of_set_window(lw_window)

u_dw_filter.of_set_business_rule(TRUE, 'n_cst_bus_rule_ral_oi')
u_dw_list.of_set_business_rule(TRUE, 'n_cst_bus_rule_ral_oi')
u_dw_list.of_set_retrieve(TRUE,"n_cst_retrieve_ral_oi_list")
inv_retrieve = gnv_app.inv_object_mgr.of_get_object("n_cst_retrieve_ral_oi_list")

ids_status = create n_ds
ids_status.dataobject = 'd_ral_oi_tv_status'
ids_status.SetTransObject(ltr_tranobject)
ids_move_to_list = create n_ds
ids_move_to_list.dataobject = 'd_ral_oi_dddw_id'

of_populate_level_1()

ids_owner_filter = create n_ds
ids_owner_filter.dataobject = 'd_ral_oi_owner_filter'
ids_owner_filter_backup = create n_ds
ids_owner_filter_backup.dataobject = 'd_ral_oi_owner_filter'
ids_owner_dddw = create n_ds
ids_owner_dddw.dataobject = 'd_ral_oi_user_id_diaply'
ids_owner = create n_ds
ids_owner.dataobject = 'd_ral_oi_owner_list'
ids_owner.SetTransObject(ltr_tranobject)
u_dw_filter.InsertRow(0)
u_dw_list.SetRedraw(false)
of_retrieve_list()
of_filter_setup()
u_tab_main.tabpage_main.of_new_record()
of_make_owner_filter()
of_add_owner_to_list()
u_dw_list.SetRedraw(true)
datetime ldt
ldt = dateTime('01/01/0001')






end event

event activate;call super::activate;u_cb_all.visible = false

end event

event ue_ok;call super::ue_ok;string ls_broadcast, ls_prim_lastname
long ll_prim_ssn
if event pfc_save() < 1 then
	ib_verified = false
	return
end if
//tab_main.tabpage_callinfo.of_set_status_security()
//
//ll_prim_ssn = tab_main.tabpage_custinfo.dw_custserv_callrec_custinfo.GetItemNumber(1, "prim_ssn")
//ls_prim_lastname = tab_main.tabpage_custinfo.dw_custserv_callrec_custinfo.GetItemString(1, "prim_last_name")
//title = is_orig_win_title + " - " + trim(ls_prim_lastname) + " (" + string(ll_prim_ssn, "000-00-0000") + ")"


gnv_app.of_getframe().inv_sheetmanager.of_broadcast("ISSUE UPDATED")	
ib_verified = true
u_tab_main.tabpage_main.u_dw_main.Resetupdate()
u_tab_main.tabpage_main.u_dw_comments.Resetupdate()
u_tab_main.tabpage_main.u_dw_owners.Resetupdate()

end event

event ue_cancel;call super::ue_cancel;if u_tab_main.tabpage_main.u_dw_comments.accepttext() < 1 then return
if u_tab_main.tabpage_main.u_dw_owners.accepttext() < 1 then return
if gnv_app.of_getframe().TriggerEvent("pfc_close") > 1 then return

end event

event pfc_postopen;call super::pfc_postopen;integer li_i
powerobject lpo_objects[]
ivo_list = {tv_record_list,u_dw_filter,u_dw_list,u_tab_main,st_splitbar_1,st_splitbar_2,u_cb_export,u_cb_owner_filter,u_cb_reset_filter,& 
			u_tab_main.tabpage_main.u_dw_main,u_tab_main.tabpage_main.u_dw_comments,u_tab_main.tabpage_main.u_dw_owners,& 
			u_tab_main.tabpage_main.u_cb_add,u_tab_main.tabpage_main.u_cb_delete,u_tab_main.tabpage_main.st_splitbar_3, u_tab_main.tabpage_hist.dw_hist}
for li_i = 1 to upperbound(ivo_list)
	il_x[li_i] = ivo_list[li_i].x
	il_y[li_i] = ivo_list[li_i].y
	il_width[li_i] = ivo_list[li_i].width
	il_height[li_i] = ivo_list[li_i].height
next

u_dw_filter.of_SetDropDownSearch(True)
u_dw_filter.inv_dropdownsearch.of_UnRegister()
u_dw_filter.inv_dropdownsearch.of_Register()
u_dw_filter.SetFocus()
u_dw_filter.SetColumn("rsolv_cde")
u_dw_filter.SetColumn("trckng_id")

u_tab_main.tabpage_main.u_dw_main.of_SetDropDownSearch(True)
u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch.of_UnRegister()
u_tab_main.tabpage_main.u_dw_main.inv_dropdownsearch.of_Register()
u_tab_main.tabpage_main.u_dw_owners.of_SetDropDownSearch(True)
u_tab_main.tabpage_main.u_dw_owners.inv_dropdownsearch.of_UnRegister()
u_tab_main.tabpage_main.u_dw_owners.inv_dropdownsearch.of_Register()
u_tab_main.tabpage_main.u_dw_main.SetFocus()
u_tab_main.tabpage_main.u_dw_main.SetColumn("desc_short")
u_tab_main.tabpage_main.u_dw_main.SetColumn("dept_cde")

u_tab_main.tabpage_main.u_dw_main.Resetupdate()
u_tab_main.tabpage_main.u_dw_comments.Resetupdate()
u_tab_main.tabpage_main.u_dw_owners.Resetupdate()
ib_rowfocuschanging_permit = true
//lpo_objects[1] = u_tab_main.tabpage_main.u_dw_main
//lpo_objects[2] = u_tab_main.tabpage_main.u_dw_owners
//lpo_objects[3] = u_tab_main.tabpage_main.u_dw_comments
//of_SetUpdateObjects ( lpo_objects )

end event

event ue_broadcast;call super::ue_broadcast;string ls_message, ls_status
long ll_trckng_id, ll_procs_year
any la_parm, la_empty, la_any
ls_message = Message.StringParm
if ls_message = "ISSUE UPDATED" then
	gnv_app.of_getframe().inv_frame.of_get_parm("Trckng_id", la_parm)
	of_refresh_issue_list()
	of_make_owner_filter()
	ls_status = u_tab_main.tabpage_main.u_dw_main.GetItemString(1, "stat_cde")
	u_tab_main.tabpage_main.of_update_state(ls_status, 1)
end if

// broadcast message to other tabpages
la_any    = ls_message
This.u_tab_main.of_broadcast(la_any )

end event

event pfc_close;call super::pfc_close;//if isvalid(ids_status) then destroy ids_status
//if isvalid(ids_dept) then destroy ids_dept
//if isvalid(ids_function) then destroy ids_function
//if isvalid(ids_list) then destroy ids_list
//if isvalid(ids_owner_filter) then destroy ids_owner_filter
//if isvalid(ids_owner_dddw) then destroy ids_owner_dddw
//if isvalid(ids_owner) then destroy ids_owner
//if isvalid(ids_move_to_list) then destroy ids_move_to_list
end event

event pfc_save;ib_closestatus = false
return super::event pfc_save()
//return AncestorReturnValue
end event

event close;call super::close;if isvalid(ids_status) then destroy ids_status
if isvalid(ids_dept) then destroy ids_dept
if isvalid(ids_function) then destroy ids_function
if isvalid(ids_list) then destroy ids_list
if isvalid(ids_owner_filter) then destroy ids_owner_filter
if isvalid(ids_owner_dddw) then destroy ids_owner_dddw
if isvalid(ids_owner) then destroy ids_owner
if isvalid(ids_move_to_list) then destroy ids_move_to_list
end event

type u_cb_cancel_comments from u_cb_cancel within w_ral_oi_main
int X=4306
int Y=2700
int Width=302
int TabOrder=130
string Tag="MicroHelp=To quit the application"
boolean BringToTop=true
string Text="Exit"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;parent.event ue_cancel()
end event

type cb_apply from u_cb within w_ral_oi_main
int X=3799
int Y=2700
int Width=302
int TabOrder=120
string Tag="MicroHelp=To save the current issue associated comments and owners without quitting the application"
boolean BringToTop=true
string Text="Apply"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;u_dw_list.SetReDraw(false)

u_dw_filter.SetReDraw(false)
u_tab_main.tabpage_main.SetReDraw(false)
//u_tab_main.tabpage_main.u_dw_main.SetReDraw(false)
SetRedraw(false)
parent.event ue_ok()
u_dw_list.SetReDraw(true)
u_dw_filter.SetReDraw(true)
u_tab_main.tabpage_main.SetReDraw(true)
//u_tab_main.tabpage_main.u_dw_main.SetReDraw(true)
SetRedraw(true)

end event

type u_cb_new from u_cb within w_ral_oi_main
int X=3205
int Y=2700
int Width=389
int TabOrder=110
string Tag="Microhelp=To create new issue"
boolean BringToTop=true
string Text="New Issue"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;if of_update_confirmation() > 0 then
	u_tab_main.tabpage_main.of_new_record()
end if
end event

type tv_record_list from u_tv within w_ral_oi_main
int X=41
int Y=24
int Width=1271
int Height=1096
int TabOrder=10
boolean BringToTop=true
boolean HideSelection=false
end type

event selectionchanged;long ll_rowcount, ll_trckng_id
long ll_current_handle,ll_row_found
string ls_data, ls_tmp
n_cst_string lnv_string
treeviewitem ltvi_current
GetItem(newhandle, ltvi_current)

choose case ltvi_current.level
	case 1 // root
	case 2 // Status as parent 
		if not ltvi_current.children then // the subtreeview is not populated yet
			of_populate_level_2(ltvi_current) //populate Dept
		end if 
	case 3 // Department as parent
		if not ltvi_current.children then // the subtreeview is not populated yet
			of_populate_level_3(ltvi_current) //populate functional area
		end if 
	case 4 // Functional Area as parent
		if not ltvi_current.children then // the subtreeview is not populated yet
			of_populate_level_4(ltvi_current) //populate treeview items
		end if 
		
	case 5 // Treeview Item
		ll_trckng_id = ltvi_current.data
		if ll_trckng_id <> il_trckng_id then
			if of_update_confirmation() = 0 then return
			u_tab_main.tabpage_main.of_retrieve_main(ll_trckng_id)
			u_tab_main.tabpage_hist.of_retrieve(ll_trckng_id)	
			u_tab_main.SelectTab("tabpage_main")	
			ll_row_found = u_dw_list.Find("trckng_id = " + string(ll_trckng_id), 1, u_dw_list.RowCount())
			if ll_row_found <> u_dw_list.GetRow() then
				u_dw_list.event rowfocuschanged(ll_row_found)
			end if
		end if 
end choose




end event

event getfocus;call super::getfocus;u_cb_all.visible = false
end event

event itemexpanding;//
end event

type u_dw_filter from u_dw within w_ral_oi_main
int X=1344
int Y=28
int Width=3250
int Height=532
int TabOrder=20
boolean BringToTop=true
string DataObject="d_ral_oi_filter"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;call super::constructor;integer li_i
string ls_column_list[] = {"stat_cde", "prty_cde", "rsolv_cde", "trnmtr_cde", "func_cde", "orign_srce_cde", "dept_cde"}

of_setdropdowncalendar(true)
iuo_calendar.of_setdropdown(true)
iuo_calendar.of_Register("creat_dt_tm_dd")
iuo_calendar.of_Register("est_cmpl_dt_dd")
iuo_calendar.of_Register("cmpl_dt_dd")
iuo_calendar.of_Register("creat_dt_tm_2_dd")
iuo_calendar.of_Register("est_cmpl_dt_2_dd")
iuo_calendar.of_Register("cmpl_dt_2_dd")

//of_SetDropDownSearch(True)
//for li_i = 1 to upperbound(ls_column_list)
////	inv_dropdownsearch.post of_Register(ls_column_list[li_i])
//	inv_dropdownsearch.post of_Register()
//next
//	

end event

event dropdown;call super::dropdown;string ls_column, ls_date
date ldt_date
ls_column = GetColumnName()
if right(ls_column, 3) = "_dd" then
	ls_date = GetItemString(1, left(ls_column, len(ls_column) - 3))
	if ls_date = "ALL" then
		setnull(ldt_date)
	else
		ldt_date =  date(ls_date)
	end if
	SetItem(1, ls_column, ldt_date)
	SetColumn(left(ls_column, (len(ls_column) - 3)))
	u_cb_all.x = iuo_calendar.x + iuo_calendar.width - u_cb_all.width
	u_cb_all.y = iuo_calendar.y + iuo_calendar.height - u_cb_all.height
	u_cb_all.post show()
	return 1
end if


end event

event getfocus;call super::getfocus;u_cb_all.visible = false
AcceptText()
end event

event ue_mousemove;call super::ue_mousemove;// bubble help
u_dw ldw
ldw = this
iw_parent = parent
gnv_app.of_getframe().inv_frame.dynamic of_bubblehelp(ldw, iw_parent)
end event

type u_dw_list from u_dw within w_ral_oi_main
int X=1344
int Y=584
int Width=3250
int Height=536
int TabOrder=30
boolean BringToTop=true
string DataObject="d_ral_oi_issue_list"
boolean HScrollBar=true
end type

event getfocus;call super::getfocus;u_cb_all.visible = false
end event

event constructor;call super::constructor;of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_sort.of_SetUseDisplay(TRUE)

end event

event clicked;call super::clicked;if row = 1 /*and not ib_first_click*/ then
	event rowfocuschanged(row)
//	ib_first_click = true
end if


end event

event ue_mousemove;call super::ue_mousemove;// bubble help
u_dw ldw
ldw = this
iw_parent = parent
gnv_app.of_getframe().inv_frame.dynamic of_bubblehelp(ldw, iw_parent)
end event

type u_cb_export from u_cb within w_ral_oi_main
int X=4297
int Y=1168
int Width=302
int TabOrder=60
string Tag="Microhelp=To export the issue list to an excel file"
boolean BringToTop=true
string Text="Export"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;of_export()
end event

type st_splitbar_1 from pfc_u_st_splitbar within w_ral_oi_main
int X=1303
int Y=24
int Width=37
int Height=1096
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

event constructor;call super::constructor;of_Register(u_dw_filter,RIGHT)
of_Register(u_dw_list,RIGHT)
of_Register(tv_record_list, LEFT)
of_SetBarColor(f_getcolor(2))
end event

type st_splitbar_2 from pfc_u_st_splitbar within w_ral_oi_main
int X=46
int Y=1124
int Width=4553
int Height=36
boolean BringToTop=true
end type

event constructor;call super::constructor;//of_Register(u_dw_filter,ABOVE)
of_Register(u_dw_list,ABOVE)
of_Register(tv_record_list, ABOVE)
of_Register(st_splitbar_1, ABOVE)
of_Register(u_tab_main, BELOW)
of_SetBarColor(f_getcolor(2))

end event

event lbuttonup;call super::lbuttonup;if u_cb_export.y <> u_tab_main.y then
	u_cb_export.y = u_tab_main.y
	u_cb_owner_filter.y = u_tab_main.y
	u_cb_reset_filter.y = u_tab_main.y
	u_tab_main.tabpage_main.u_dw_comments.height = u_tab_main.tabpage_main.height - u_tab_main.tabpage_main.u_dw_main.height - 108
	u_tab_main.tabpage_hist.dw_hist.height = u_tab_main.tabpage_hist.height - 60
end if
end event

type u_cb_new_comment from u_cb within w_ral_oi_main
int X=2496
int Y=2700
int Width=521
int TabOrder=100
boolean Visible=false
string Tag="Microhelp=To insert a new comment for the issue"
boolean BringToTop=true
string Text="New Comment"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;string ls_user_id, ls_dummy
dwobject dwo
long ll_row
dwo = u_tab_main.tabpage_main.u_dw_comments.object.cmnt_desc
ls_dummy = " "
ls_user_id = gnv_app.inv_hi_security.dynamic of_get_user_id()
u_tab_main.tabpage_main.u_dw_comments.InsertRow(1)
//u_tab_main.tabpage_main.u_dw_comments.SetItem(1, "creat_dt_tm", datetime(today(), now()))
//u_tab_main.tabpage_main.u_dw_comments.SetItem(1, "srce_id", ls_user_id) // set column properties for required columns
u_tab_main.tabpage_main.u_dw_comments.ScrollToRow(1)
u_tab_main.tabpage_main.u_dw_comments.post SetFocus()
u_tab_main.tabpage_main.u_dw_comments.post SetColumn("cmnt_desc")
//for ll_row = 1 to u_tab_main.tabpage_main.u_dw_comments.rowcount()	
//	u_tab_main.tabpage_main.u_dw_comments.SetColumn("cmnt_desc")
//	u_tab_main.tabpage_main.u_dw_comments.SetRow(ll_row)
//	if isnull(u_tab_main.tabpage_main.u_dw_comments.object.cmnt_desc[ll_row]) then
//		u_tab_main.tabpage_main.u_dw_comments.object.cmnt_desc.height.autosize = "No"
//	else
//		u_tab_main.tabpage_main.u_dw_comments.object.cmnt_desc.height.autosize = "Yes"
//	end if
//next
//	u_tab_main.tabpage_main.u_dw_comments.SetItem(1, "cmnt_desc", " ")



end event

type u_cb_reset from u_cb within w_ral_oi_main
int X=41
int Y=2700
int Width=695
int TabOrder=80
string Tag="Microhelp=To reset screen layout to the default position"
boolean BringToTop=true
string Text="Reset Screen Layout"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;integer li_i
for li_i = 1 to upperbound(ivo_list)
	ivo_list[li_i].x = il_x[li_i]
	ivo_list[li_i].y = il_y[li_i]
	ivo_list[li_i].width = il_width[li_i]
	ivo_list[li_i].height = il_height[li_i]
next
end event

event constructor;call super::constructor;is_bhelp = "To reset screen layout to the default position"
end event

type u_tab_main from u_tab_ral_oi_main within w_ral_oi_main
int X=41
int Y=1168
int Width=4562
int Height=1516
int TabOrder=70
end type

event getfocus;call super::getfocus;u_cb_all.visible = false
end event

event constructor;call super::constructor;this.of_set_init_tabpages(true)
end event

type u_cb_all from commandbutton within w_ral_oi_main
int X=1275
int Y=1304
int Width=224
int Height=88
string Text="ALL"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;u_dw_filter.SetText("ALL")
//visible = false
u_dw_filter.post SetFocus()


end event

event losefocus;visible = false
end event

type u_cb_print from u_cb within w_ral_oi_main
int X=2478
int Y=2700
int Width=521
int TabOrder=90
string Tag="Microhelp=To print the current issue including associated owners and comments"
boolean BringToTop=true
string Text="Print"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;u_tab_main.tabpage_main.of_print_issue()

end event

type u_cb_owner_filter from u_cb within w_ral_oi_main
int X=3767
int Y=1168
int Width=457
int TabOrder=50
string Tag="Microhelp=To Filter Owners"
boolean BringToTop=true
string Text="Owner Filter"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;string ls_return
w_sheet lw_main
lw_main = parent
ids_owner_filter_backup.Reset()
ids_owner_filter.RowsCopy(1, ids_owner_filter.RowCount(), Primary!, ids_owner_filter_backup, 1, Primary!)
openWithParm(w_oi_owner_filter, lw_main)
ls_return = Message.StringParm
if ls_return = "OK" then
	of_data_filter()
else
	ids_owner_filter.Reset()
	ids_owner_filter_backup.RowsCopy(1, ids_owner_filter_backup.RowCount(), Primary!, ids_owner_filter, 1, Primary!)	
end if

end event

type u_cb_reset_filter from u_cb within w_ral_oi_main
int X=3131
int Y=1168
int Width=549
int TabOrder=40
string Tag="Microhelp=To reset all filters to the default"
boolean BringToTop=true
string Text="Reset All Filters"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;long ll_col, ll_column_count
string ls_expression, ls_col_name
ids_owner_filter.Reset()
ids_owner_filter_backup.Reset()
ll_column_count = long(u_dw_filter.Object.DataWindow.Column.Count)
for ll_col = 1 to (ll_column_count - 6)		
	ls_expression = "#" + string(ll_col) + ".Name"
	ls_col_name = u_dw_filter.describe(ls_expression)
	u_dw_filter.SetItem(1, ls_col_name, "ALL")
next

of_data_filter()

end event

