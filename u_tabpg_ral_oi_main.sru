$PBExportHeader$u_tabpg_ral_oi_main.sru
$PBExportComments$Detail Datawindow tabpage for OIDB
forward
global type u_tabpg_ral_oi_main from u_tabpg
end type
type u_dw_main from u_dw within u_tabpg_ral_oi_main
end type
type u_dw_owners from u_dw within u_tabpg_ral_oi_main
end type
type u_dw_comments from u_dw within u_tabpg_ral_oi_main
end type
type u_cb_delete from u_cb within u_tabpg_ral_oi_main
end type
type u_dw_report from u_dw within u_tabpg_ral_oi_main
end type
type st_splitbar_3 from pfc_u_st_splitbar within u_tabpg_ral_oi_main
end type
type u_cb_add from u_cb within u_tabpg_ral_oi_main
end type
end forward

global type u_tabpg_ral_oi_main from u_tabpg
int Width=4521
int Height=1404
event ue_keydown pbm_keydown
event ue_syskeydown pbm_syskeydown
u_dw_main u_dw_main
u_dw_owners u_dw_owners
u_dw_comments u_dw_comments
u_cb_delete u_cb_delete
u_dw_report u_dw_report
st_splitbar_3 st_splitbar_3
u_cb_add u_cb_add
end type
global u_tabpg_ral_oi_main u_tabpg_ral_oi_main

type variables
w_ral_oi_main iw_main
n_cst_retrieve inv_retrieve, inv_retrieve_cmnt, inv_retrieve_owners
long il_trckng_id
constant integer ii_preupdating_state = 0
constant integer ii_postupdating_state = 1
end variables

forward prototypes
public subroutine of_retrieve_main (long al_trckng_id)
public subroutine of_new_record ()
public subroutine of_set_window (ref w_sheet aw_window)
public subroutine of_delete_owner ()
public subroutine of_print_issue ()
public subroutine of_retrieve_cmnts (long al_trckng_id)
public subroutine of_update_state (string as_status, integer ai_state)
end prototypes

public subroutine of_retrieve_main (long al_trckng_id);long ll_returncode = 0
w_master lw_dummy
string ls_expression, ls_err_parm[] = {"Error in retrieving issue"} 
any la_tranobject
n_tr_ral ltr_tranobject
datawindowchild ldwc_child
gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject
il_trckng_id = al_trckng_id
iw_main.il_trckng_id = al_trckng_id
u_dw_main.ia_parm[1] = al_trckng_id
u_dw_main.ia_parm[2] = ll_returncode
u_dw_main.SetTransObject(ltr_tranobject)

if not isvalid(inv_retrieve) then
	return
end if
SetRedraw(false)
if inv_retrieve.of_retrieve(lw_dummy, u_dw_main) < 1 then
	gnv_app.inv_error.of_Message("RL006",  ls_err_parm)
	u_dw_main.InsertRow(0)
	il_trckng_id = 0
else
	of_retrieve_cmnts(al_trckng_id)
	u_dw_owners.SetTransObject(ltr_tranobject)
	u_dw_owners.ia_parm[1] = al_trckng_id
	u_dw_owners.ia_parm[2] = ll_returncode
	inv_retrieve_owners.of_retrieve(lw_dummy, u_dw_owners)
	u_dw_owners.SelectRow(0, false)
	iw_main.u_tab_main.tabpage_hist.of_retrieve(al_trckng_id)	
	of_update_state(trim(u_dw_main.GetItemString(1,"stat_cde")), 1)
	If u_dw_main.getchild("prior_trckng_id", ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"GetChild Error"})
		return
	end if
	ldwc_child.SetFilter("")
	ldwc_child.Filter()
	ls_expression = "trckng_id <> '" + string(al_trckng_id) + "'"
	ldwc_child.SetFilter(ls_expression)
	ldwc_child.Filter()
	iw_main.of_setlines(u_dw_main, ldwc_child, "prior_trckng_id")
end if
il_trckng_id = al_trckng_id
SetRedraw(true)

gnv_app.of_getframe().inv_frame.of_set_parm("Trckng_id", al_trckng_id)

u_dw_main.Resetupdate()
u_dw_comments.Resetupdate()
u_dw_owners.Resetupdate()


end subroutine

public subroutine of_new_record ();integer li_i
string ls_expression, ls_security_permission
string ls_user_id
									
u_dw_comments.Reset()
u_dw_owners.Reset()
u_dw_main.Reset()
iw_main.u_tab_main.tabpage_hist.dw_hist.Reset()
u_dw_main.insertrow(0)
u_dw_comments.insertrow(0)
u_cb_add.enabled = true
u_cb_delete.enabled = true
u_dw_comments.enabled = true
//u_dw_comments.object.cmnt_desc.protect = 0
//u_dw_comments.object.cmnt_desc.BackGround.Color = f_getcolor(4)

il_trckng_id = 0
iw_main.il_trckng_id = 0
ls_user_id = gnv_app.inv_hi_security.dynamic of_get_user_id()
u_dw_main.SetItem(1, "creat_dt_tm", datetime(today(), now()))
u_dw_main.SetItem(1, "srce_id", ls_user_id) // set column properties for required columns
u_dw_main.SetItem(1, "req_srce_id", ls_user_id) // set column properties for required columns
ls_security_permission = upper(gnv_app.inv_hi_security.dynamic of_get_user_permission('OI02'))
if ls_security_permission = "N" then
	u_dw_main.Modify("orign_srce_cde" + ".protect=1")
	u_dw_main.Modify("orign_srce_cde" + ".BackGround.Color=" + string(f_getcolor(2)))
end if	

of_update_state('S', 0)
iw_main.u_dw_list.SelectRow(0, false)
gnv_app.of_getframe().inv_frame.of_set_parm("Trckng_id", il_trckng_id)
u_dw_main.Resetupdate()
u_dw_comments.Resetupdate()
u_dw_owners.Resetupdate()
if not isvalid(u_dw_main.inv_dropdownsearch) then
	u_dw_main.of_SetDropDownSearch(True)
end if
u_dw_main.inv_dropdownsearch.of_UnRegister()
u_dw_main.inv_dropdownsearch.of_Register()
u_dw_main.SetFocus()
u_dw_main.SetColumn("desc_short")
u_dw_main.SetColumn("dept_cde")
if not isvalid(u_dw_owners.inv_dropdownsearch) then
	u_dw_owners.of_SetDropDownSearch(True)
end if
u_dw_owners.inv_dropdownsearch.of_UnRegister()
u_dw_owners.inv_dropdownsearch.of_Register()


end subroutine

public subroutine of_set_window (ref w_sheet aw_window);iw_main = aw_window
end subroutine

public subroutine of_delete_owner ();any la_transaction, la_parm, la_empty
n_tr ltr_object
long ll_row, ll_retsqlcd = 0
string ls_update_ind
long ll_trckng_id
string ls_owner_type_cde
string ls_srce_id, ls_racf_id_xref
string ls_test, new_create_dt_tm, ls_creat_dt_tm, ls_updt_dt_tm
datetime ldt_creat_dt_tm, ldt_updt_dt_tm

gnv_app.of_getframe().inv_frame.of_get_parm('RAL', la_transaction)
ltr_object = la_transaction
ls_srce_id = gnv_app.inv_platform.of_getuserid()

gnv_app.of_getframe().inv_frame.of_get_parm('Trckng_id', la_parm)
ll_trckng_id = la_parm

ll_row = u_dw_owners.GetRow()
ldt_creat_dt_tm = u_dw_owners.GetItemDateTime(ll_row, "creat_dt_tm") 
ls_owner_type_cde = u_dw_owners.GetItemString(ll_row, "owner_type_cde") 
ls_racf_id_xref = u_dw_owners.GetItemString(ll_row, "racf_id_xref") 
ldt_updt_dt_tm = u_dw_owners.GetItemDateTime(ll_row, "updt_dt_tm") 

if u_dw_owners.RowCount() > 0 then
	ll_row = u_dw_owners.GetRow()
	if ll_row > 0 then
		u_dw_owners.DeleteRow(ll_row)
//		if not isnull(ldt_creat_dt_tm) and ll_trckng_id > 0 then
//			ls_update_ind = "DELETE"
//			ltr_object.dynamic of_update_issue_owners(ls_update_ind,ll_trckng_id,ls_owner_type_cde,&
//						ls_racf_id_xref,ls_srce_id,ll_retsqlcd)
//			If ll_retsqlcd <> 0  Then
//				ltr_object.of_rollback();
//				gnv_app.inv_error.of_Message("RL007",  {"Issue Owner"})
//				RETURN 
//			end If			
//			ltr_object.of_commit();	
//			u_dw_owners.RowsDiscard(1, u_dw_owners.DeletedCount(), Delete!)
//			iw_main.u_tab_main.tabpage_hist.of_retrieve(ll_trckng_id)	
//		end if
	end if
end if

end subroutine

public subroutine of_print_issue ();///////////////////////////////////////////////////////////////////////////////////////////
//	function:  			of_print
//
//	Arguments:		None
//
//	Returns:  		None
//
//	Description:	 print issue
//
// Initial Version :
// 07/01/2001	EMPT79				
//	
////////////////////////////////////////////////////////////////////////////////////////////
integer li_i, li_j, li_value
long ll_trckng_id, ll_row, ll_new_row, ll_row_export, ll_rowcount, ll_col, ll_sqlcode = 0
string ls_data, ls_expression, ls_issue_col[], ls_export_col[], ls_column_list[]
ls_column_list[] = {"stat_cde","prior_stat_cde","prty_cde","rsolv_cde","trnmtr_cde","func_cde","orign_srce_cde","dept_cde","reas_cde","srce_id","req_srce_id","cmpl_srce_id","updt_srce_id"}
datawindowchild ldwc_main, ldwc_owners, ldwc_comments, ldwc_child, ldwc_child2
n_ds lds_comments, lds_owners, lds_main, lds_owner

if il_trckng_id = 0 then return

lds_comments = create n_ds
lds_owners = create n_ds
lds_main = create n_ds
lds_comments.dataobject = 'd_ral_oi_comments_report'
lds_owners.dataobject = 'd_ral_oi_owners_report'
lds_main.dataobject = 'd_ral_oi_main'
u_dw_report.dataobject = 'd_ral_oi_report_composit'
u_dw_report.object.report_title.text = "Issue Detail Report of Issue No.  " + string( il_trckng_id  )

if u_dw_report.getchild("d_main", ldwc_main) > 0 then
	u_dw_main.RowsCopy(1, 1, Primary!, lds_main, 1, Primary!)
	lds_main.ShareData(ldwc_main)
else
	gnv_app.inv_error.of_message("RL006",{"Cannot Get Main Report Object"})
	destroy lds_comments
	destroy lds_owners	
	destroy lds_main
	return
end if

if u_dw_report.getchild("d_owners", ldwc_owners) > 0 then
	for ll_row = 1 to u_dw_owners.RowCount()
		if not isnull(u_dw_owners.GetItemString(ll_row, "racf_id_xref")) then
			ll_new_row =  lds_owners.InsertRow(0)
			lds_owners.object.data[ll_new_row] = u_dw_owners.object.data[ll_row]
		end if
	next
	lds_owners.ShareData(ldwc_owners)
else
	gnv_app.inv_error.of_message("RL006",{"Cannot Get Owner Report Object"})
	destroy lds_comments
	destroy lds_owners		
	destroy lds_main
	return
end if
if u_dw_report.getchild("d_comments", ldwc_comments) > 0 then
	for ll_row = 1 to u_dw_comments.RowCount()
		if not isnull(u_dw_comments.GetItemString(ll_row, "cmnt_desc")) then
			ll_new_row =  lds_comments.InsertRow(0)
			lds_comments.object.data[ll_new_row] = u_dw_comments.object.data[ll_row]
		end if
	next
	lds_comments.ShareData(ldwc_comments)
else
	gnv_app.inv_error.of_message("RL006",{"Cannot Get Comment Report Object"})
	destroy lds_comments
	destroy lds_owners	
	destroy lds_main
	return
end if

for li_i = 1 to upperbound(ls_column_list)
	If u_dw_main.getchild(ls_column_list[li_i], ldwc_child) > 0 and ldwc_main.getchild(ls_column_list[li_i], ldwc_child2) > 0 Then
		ldwc_child.ShareData(ldwc_child2)
	end if
next
ls_column_list[] = {"srce_id","updt_srce_id"}
for li_i = 1 to upperbound(ls_column_list)
	If u_dw_comments.getchild(ls_column_list[li_i], ldwc_child) > 0 and ldwc_comments.getchild(ls_column_list[li_i], ldwc_child2) > 0 Then
		ldwc_child.ShareData(ldwc_child2)
	end if
next
If u_dw_owners.getchild("racf_id_xref", ldwc_child) > 0 and ldwc_owners.getchild("racf_id_xref", ldwc_child2) > 0 Then
	ldwc_child.ShareData(ldwc_child2)
end if

OpenWithParm(w_r_print, u_dw_report)
destroy lds_main
destroy lds_comments
destroy lds_owners

end subroutine

public subroutine of_retrieve_cmnts (long al_trckng_id);long ll_returncode = 0
w_master lw_dummy
string ls_err_parm[] = {"Error in retrieving issue comments"} 
any la_tranobject
n_tr_ral ltr_tranobject
gnv_app.of_getframe().inv_frame.of_get_parm('RAL',la_tranobject)
ltr_tranobject = la_tranobject

u_dw_comments.SetTransObject(ltr_tranobject)
u_dw_comments.ia_parm[1] = al_trckng_id
u_dw_comments.ia_parm[2] = ll_returncode
inv_retrieve_cmnt.of_retrieve(lw_dummy, u_dw_comments)

end subroutine

public subroutine of_update_state (string as_status, integer ai_state);long ll_column_count, ll_col, ll_i, ll_col_id, ll_null, ll_row
string ls_filter, ls_filter_list[], ls_expression, ls_col_name, ls_date_tmp,ls_null
string ls_issue_status, ls_req_col_list[],ls_opt_col_list[],ls_prt_col_list[],ls_blank_col_list[],ls_empty_col_list[]
string ls_security_col_list[] = {"orign_srce_cde", "reas_cde", "rsolv_cde", "rleas_id", "spr_num", "prior_trckng_id"}
string ls_security_permission
date ldt_date_tmp, ldt_null
datawindowchild ldwc_stat, ldwc_tmp
n_ds lds_cdv, lds_tmp
userobject luo_list[]
SetNull(ls_null)
SetNull(ldt_null)
SetNull(ll_null)
ls_opt_col_list = ls_empty_col_list							
ls_req_col_list = ls_empty_col_list							
ls_prt_col_list = ls_empty_col_list											
ls_blank_col_list = ls_empty_col_list							
ls_filter_list = ls_empty_col_list	
ls_security_permission = upper(gnv_app.inv_hi_security.dynamic of_get_user_permission('OI02'))
for ll_row = 1 to u_dw_owners.rowcount()
	u_dw_owners.SetItem(ll_row, "owner_type_cde", "A")
next
if ai_state = ii_preupdating_state then
	choose case upper(trim(as_status))
		case 'S' // SUBMIT: Owner is required  ls_empty_col_list[]
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","orign_srce_cde","func_cde","desc_short","desc_issue"}
			ls_opt_col_list = {"trnmtr_cde","rsolv_by_dt"} 
			ls_prt_col_list = {"stat_cde","trckng_id","creat_dt_tm","srce_id","est_cmpl_dt","cmpl_dt","spr_num","rleas_id","rsolv_cde","reas_cde","cmpl_srce_id","prior_trckng_id"}
			ls_blank_col_list = {"est_cmpl_dt","prior_trckng_id","cmpl_dt","spr_num","rleas_id","rsolv_cde","prior_trckng_id","reas_cde","cmpl_srce_id","cmpl_dt"}
			ls_filter_list = {'S','O','C'}
			u_cb_delete.enabled = false
			u_dw_owners.enabled = false
			u_dw_comments.enabled = true
			if u_dw_comments.RowCount() < 1 then
				u_dw_comments.InsertRow(0)
			else
				if not isnull(u_dw_comments.GetItemDateTime(u_dw_comments.RowCount(), "creat_dt_tm")) then
					u_dw_comments.InsertRow(0)
				end if								
			end if
			u_dw_comments.ScrollToRow(u_dw_comments.RowCount())
		case 'O' // OPEN: Owner is required  ls_empty_col_list[]
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","func_cde","orign_srce_cde","desc_short","desc_issue"}
			ls_opt_col_list = {"trnmtr_cde","rsolv_by_dt","est_cmpl_dt","spr_num","prior_trckng_id"} 
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","cmpl_dt","rleas_id","rsolv_cde","reas_cde","cmpl_dt"}
			ls_blank_col_list = {"cmpl_dt","rleas_id","rsolv_cde","reas_cde","prior_trckng_id"}
			ls_filter_list = {'O','C','T','P'}		
			if u_dw_owners.RowCount() = 0 then
				u_dw_owners.InsertRow(0)
			end if
			if not isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
				u_dw_owners.InsertRow(0)
			end if					
			if u_dw_owners.rowcount() = 1 then
				u_cb_delete.enabled = false
			else
				u_cb_delete.enabled = true
			end if			
			u_dw_owners.enabled = true
			u_dw_comments.enabled = true
		case 'C' // CLOSED
			if isnull(u_dw_main.object.prior_trckng_id[1]) then // regular close not a moving issue
				ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","orign_srce_cde","func_cde","reas_cde","rsolv_cde","cmpl_dt","desc_short","desc_issue"}						
				ls_opt_col_list = {"rsolv_by_dt","est_cmpl_dt","rleas_id"} 
				ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","prior_trckng_id"}
				if ls_security_permission = "N" then
					ls_filter_list = {'C','R'}	
				else
					ls_filter_list = {'C','O','T','R','P'}
				end if
				if u_dw_owners.RowCount() > 0 then
					if not isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
						u_dw_owners.InsertRow(0)
					end if	
				else
					u_dw_owners.InsertRow(0)
				end if
				if not isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
					u_dw_owners.InsertRow(0)
				end if
				if u_dw_owners.rowcount() = 1 then
					u_cb_delete.enabled = false
				else
					u_cb_delete.enabled = true
				end if				
				u_dw_owners.enabled = true
				u_dw_comments.enabled = true
			else // move to new issue
				ls_req_col_list = {"stat_cde","cmpl_dt"}
				ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","prty_cde","dept_cde","req_srce_id","desc_short","desc_issue","orign_srce_cde","func_cde","reas_cde","cmpl_dt","rsolv_cde","rsolv_by_dt","est_cmpl_dt","trnmtr_cde","spr_num","rleas_id"}
//				ls_blank_col_list = {"prior_trckng_id"}
				ls_filter_list = {'C','O','T','R','P'}		
				u_cb_delete.enabled = false
				u_dw_owners.enabled = false				
				for ll_row = 1 to u_dw_owners.rowcount()
					u_dw_owners.SetItem(ll_row, "owner_type_cde", "B")
				next
				u_dw_comments.enabled = false
				if u_dw_owners.RowCount() > 0 then
					if isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
						u_dw_owners.DeleteRow(u_dw_owners.RowCount())
					end if
				end if				
				u_dw_comments.object.cmnt_desc.BackGround.Color = f_getcolor(2)
			end if
		case 'T' // RETEST
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","orign_srce_cde","func_cde","desc_short","desc_issue"}						
			ls_opt_col_list = {"trnmtr_cde","rsolv_by_dt","est_cmpl_dt","reas_cde","rleas_id","spr_num","prior_trckng_id"} 
			ls_prt_col_list = {"cmpl_dt","trckng_id","creat_dt_tm","srce_id","rsolv_cde","cmpl_dt"}
			ls_blank_col_list = {"rsolv_cde","prior_trckng_id"}
			ls_filter_list = {'T','O','C','P'}		
			if not isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
				u_dw_owners.InsertRow(0)
			end if
			if u_dw_owners.rowcount() = 1 then
				u_cb_delete.enabled = false
			else
				u_cb_delete.enabled = true
			end if			
			u_dw_comments.enabled = true
			u_dw_owners.enabled = true
		case 'R' // RESUBMITTED
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","orign_srce_cde","func_cde","desc_short","desc_issue"}
			ls_opt_col_list = {"trnmtr_cde","rsolv_by_dt"} 
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","est_cmpl_dt","cmpl_dt","spr_num","rleas_id","rsolv_cde","reas_cde","cmpl_srce_id","prior_trckng_id"}
			ls_blank_col_list = {"est_cmpl_dt","prior_trckng_id","cmpl_dt","spr_num","rleas_id","rsolv_cde","prior_trckng_id","reas_cde","cmpl_srce_id","cmpl_dt"}

			ls_filter_list = {'R','O','C','T','P'}	
			for ll_i = u_dw_owners.RowCount() to 1 step -1
				u_dw_owners.DeleteRow(ll_i)
			next				
			u_dw_comments.enabled = true
			u_cb_delete.enabled = false
			u_dw_owners.enabled = false
		case 'P' // PENDING RELEASE
			ls_req_col_list = {"stat_cde"}
			ls_opt_col_list = {"prior_trckng_id"}
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","prty_cde","dept_cde","req_srce_id","desc_short","desc_issue","orign_srce_cde","func_cde","reas_cde","cmpl_dt","rsolv_cde","rsolv_by_dt","est_cmpl_dt","trnmtr_cde","spr_num","rleas_id","cmpl_dt"}
			ls_blank_col_list = {"prior_trckng_id"}
			ls_filter_list = {'P','O','C','T'}		
			u_cb_delete.enabled = false
			u_dw_comments.enabled = true
			u_dw_owners.enabled = false			
			for ll_row = 1 to u_dw_owners.rowcount()
				u_dw_owners.SetItem(ll_row, "owner_type_cde", "B")
			next
	end choose
else // postupdate state
	choose case upper(trim(as_status))
		case 'S' // SUBMIT
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","orign_srce_cde","func_cde","desc_short","desc_issue"}
			ls_opt_col_list = {"rsolv_by_dt","trnmtr_cde","prior_trckng_id"} 
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","est_cmpl_dt","cmpl_dt","spr_num","rleas_id","rsolv_cde","reas_cde","cmpl_dt"}
			ls_blank_col_list = {"est_cmpl_dt","prior_trckng_id","cmpl_dt","spr_num","rleas_id","rsolv_cde","prior_trckng_id","reas_cde"}
			ls_filter_list = {'S','O','C'}
			u_cb_delete.enabled = false
			u_dw_owners.enabled = false
			u_dw_comments.enabled = true
			if u_dw_comments.RowCount() = 0 then
				u_dw_comments.InsertRow(0)
			else
				if not isnull(u_dw_comments.GetItemDateTime(u_dw_comments.RowCount(), "creat_dt_tm")) then
					u_dw_comments.InsertRow(0)
				end if								
			end if
			u_dw_comments.ScrollToRow(u_dw_comments.RowCount())
		case 'O' // OPEN: Owner is required  ls_empty_col_list[]
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","func_cde","orign_srce_cde","desc_short","desc_issue"}
			ls_opt_col_list = {"trnmtr_cde","rsolv_by_dt","est_cmpl_dt","spr_num","prior_trckng_id"} 
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","cmpl_dt","rleas_id","rsolv_cde","reas_cde","cmpl_dt"}
			ls_blank_col_list = {"cmpl_dt","rleas_id","rsolv_cde","reas_cde","prior_trckng_id"}
			ls_filter_list = {'O','C','T','P'}					
			if u_dw_owners.RowCount() = 0 then
				u_dw_owners.InsertRow(0)
			end if
			if not isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
				u_dw_owners.InsertRow(0)
			else
			end if					
			if u_dw_owners.rowcount() = 1 then
				u_cb_delete.enabled = false
			else
				u_cb_delete.enabled = true
			end if			
			u_dw_owners.enabled = true
			u_dw_comments.enabled = true
			if u_dw_owners.rowcount() = 1 then
				u_cb_delete.enabled = false
			end if
			if u_dw_comments.RowCount() = 0 then
				u_dw_comments.InsertRow(0)
			else
				if not isnull(u_dw_comments.GetItemDateTime(u_dw_comments.RowCount(), "creat_dt_tm")) then
					u_dw_comments.InsertRow(0)
				end if								
			end if
			u_dw_comments.ScrollToRow(u_dw_comments.RowCount())
		case 'C' // CLOSED
			if not isnull(u_dw_main.object.prior_trckng_id[1]) then // moved issue
				ls_prt_col_list = {"stat_cde","trckng_id","creat_dt_tm","srce_id","prty_cde","dept_cde","req_srce_id","desc_short","desc_issue","orign_srce_cde","func_cde","reas_cde","cmpl_dt","rsolv_cde","rsolv_by_dt","est_cmpl_dt","trnmtr_cde","spr_num","rleas_id", "prior_trckng_id","cmpl_dt"}
			else
				ls_req_col_list = {"stat_cde"}
				ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","prty_cde","dept_cde","req_srce_id","desc_short","desc_issue","orign_srce_cde","func_cde","reas_cde","cmpl_dt","rsolv_cde","rsolv_by_dt","est_cmpl_dt","trnmtr_cde","spr_num","rleas_id", "prior_trckng_id","cmpl_dt"}
			end if
			if ls_security_permission = "N" then
				ls_filter_list = {'C','R'}	
			else
				ls_filter_list = {'C','O','T','R','P'}
			end if
			u_cb_delete.enabled = false
			u_dw_owners.enabled = false
			for ll_row = 1 to u_dw_owners.rowcount()
				u_dw_owners.SetItem(ll_row, "owner_type_cde", "B")
			next
			u_dw_comments.enabled = true
			u_dw_comments.object.cmnt_desc.BackGround.Color = f_getcolor(2)
			if u_dw_owners.RowCount() > 0 then
				if isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
					u_dw_owners.DeleteRow(u_dw_owners.RowCount())
				end if
			end if				
			if not isnull(u_dw_main.object.prior_trckng_id[1]) then // moved issue
				if u_dw_comments.RowCount() > 0 then
					if isnull(u_dw_comments.GetItemString(u_dw_comments.RowCount(), "srce_id")) then
						u_dw_comments.DeleteRow(u_dw_comments.RowCount())
					end if
				end if				
			end if
		case 'T' // RETEST
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","orign_srce_cde","func_cde","desc_short","desc_issue"}						
			ls_opt_col_list = {"trnmtr_cde","rsolv_by_dt","est_cmpl_dt","reas_cde","rleas_id","spr_num","prior_trckng_id"} 
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","cmpl_dt","rsolv_cde","cmpl_dt"}
			ls_blank_col_list = {"prior_trckng_id","cmpl_dt","rsolv_cde"}
			ls_filter_list = {'T','O','C','P'}		
			if u_dw_owners.RowCount() = 0 then
				u_dw_owners.InsertRow(0)
			end if
			if not isnull(u_dw_owners.GetItemString(u_dw_owners.RowCount(), "racf_id_xref")) then
				u_dw_owners.InsertRow(0)
			else
			end if					
			if u_dw_owners.rowcount() = 1 then
				u_cb_delete.enabled = false
			else
				u_cb_delete.enabled = true
			end if			
			u_dw_owners.enabled = true
			u_dw_comments.enabled = true
			if u_dw_comments.RowCount() = 0 then
				u_dw_comments.InsertRow(0)
			else
				if not isnull(u_dw_comments.GetItemDateTime(u_dw_comments.RowCount(), "creat_dt_tm")) then
					u_dw_comments.InsertRow(0)
				end if								
			end if
			u_dw_comments.ScrollToRow(u_dw_comments.RowCount())
		case 'R' // RESUBMITTED
			ls_req_col_list = {"req_srce_id","dept_cde","prty_cde","stat_cde","orign_srce_cde","func_cde","desc_short","desc_issue"}
			ls_opt_col_list = {"rsolv_by_dt","trnmtr_cde","prior_trckng_id"} 
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","est_cmpl_dt","cmpl_dt","spr_num","rleas_id","rsolv_cde","reas_cde","cmpl_dt"}
			ls_blank_col_list = {"est_cmpl_dt","prior_trckng_id","cmpl_dt","spr_num","rleas_id","rsolv_cde","prior_trckng_id","reas_cde"}			
			ls_filter_list = {'R','O','C','T','P'}		
			u_dw_comments.enabled = true
			if u_dw_comments.RowCount() = 0 then
				u_dw_comments.InsertRow(0)
			else
				if not isnull(u_dw_comments.GetItemDateTime(u_dw_comments.RowCount(), "creat_dt_tm")) then
					u_dw_comments.InsertRow(0)
				end if								
			end if
			u_dw_comments.ScrollToRow(u_dw_comments.RowCount())
		case 'P' // PENDING RELEASE
			ls_req_col_list = {"stat_cde"}
			ls_prt_col_list = {"trckng_id","creat_dt_tm","srce_id","prty_cde","dept_cde","req_srce_id","desc_short","desc_issue","orign_srce_cde","func_cde","reas_cde","cmpl_dt","rsolv_cde","rsolv_by_dt","est_cmpl_dt","trnmtr_cde","spr_num","rleas_id","cmpl_dt","prior_trckng_id"}
			ls_blank_col_list = {"prior_trckng_id","cmpl_dt"}
			ls_filter_list = {'P','O','C','T'}		
			u_cb_delete.enabled = false
			u_dw_comments.enabled = true
			u_dw_owners.enabled = false
			for ll_row = 1 to u_dw_owners.rowcount()
				u_dw_owners.SetItem(ll_row, "owner_type_cde", "B")
			next
			if u_dw_comments.RowCount() = 0 then
				u_dw_comments.InsertRow(0)
			else
				if not isnull(u_dw_comments.GetItemDateTime(u_dw_comments.RowCount(), "creat_dt_tm")) then
					u_dw_comments.InsertRow(0)
				end if								
			end if
			u_dw_comments.ScrollToRow(u_dw_comments.RowCount())
	end choose	
	u_dw_owners.ResetUpdate()
end if
if u_dw_owners.rowcount() > 0 then
	if u_dw_owners.GetItemString(1, "owner_type_cde") = "B" then u_dw_owners.SelectRow(0, false)
end if
if ls_security_permission = 'N' then
//	ls_issue_status = trim(u_dw_main.GetItemString(1, "stat_cde", primary!, true))
//	if isnull(ls_issue_status) then ls_issue_status = ''
//	if ls_issue_status <> 'C' then 
//		ls_filter_list = {upper(trim(as_status))}
//	else
//		ls_filter_list = {'C', 'R'}
//	end if
	if as_status <> 'C' then ls_filter_list = {upper(trim(as_status))}
	u_dw_main.Modify("orign_srce_cde.protect=1")
	u_dw_main.Modify("orign_srce_cde.BackGround.Color=" + string(f_getcolor(2)))	
end if	
setnull(ls_null)
for ll_col = 1 to upperbound(ls_blank_col_list)
	choose case left(lower(u_dw_main.Describe(ls_blank_col_list[ll_col] + ".ColType")), 4)
		case "char"
			u_dw_main.SetItem(1, ls_blank_col_list[ll_col], ls_null)
		case "date"
			u_dw_main.SetItem(1, ls_blank_col_list[ll_col], ldt_null)
		case else
			u_dw_main.SetItem(1, ls_blank_col_list[ll_col], ll_null)
	end choose
next
for ll_col = 1 to upperbound(ls_opt_col_list)
	u_dw_main.Modify(ls_opt_col_list[ll_col] + ".protect=0")
	u_dw_main.Modify(ls_opt_col_list[ll_col] + ".BackGround.Color=" + string(f_getcolor(4)))
next
u_dw_main.Modify("desc_issue.Edit.DisplayOnly=No")
for ll_col = 1 to upperbound(ls_prt_col_list)
	if ls_prt_col_list[ll_col] = "desc_issue" then
		u_dw_main.Modify(ls_prt_col_list[ll_col] + ".Edit.DisplayOnly=Yes")
	else
		u_dw_main.Modify(ls_prt_col_list[ll_col] + ".protect=1")
	end if
	u_dw_main.Modify(ls_prt_col_list[ll_col] + ".BackGround.Color=" + string(f_getcolor(2)))
next
//if string(u_dw_main.Describe("desc_issue.protect")) =  "1" then
//	u_dw_main.Modify("desc_issue.protect=0")
//	u_dw_main.SetTabOrder("desc_issue", 180)
//else
//	u_dw_main.SetTabOrder("desc_issue", 180)
//end if	
for ll_col = 1 to upperbound(ls_req_col_list)
	u_dw_main.Modify(ls_req_col_list[ll_col] + ".protect=0")
	u_dw_main.Modify(ls_req_col_list[ll_col] + ".BackGround.Color=" + string(f_getcolor(5)))
next
// reset status dropdown list
if u_dw_main.GetChild("stat_cde", ldwc_stat) > 0 then
	if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_STAT_CD", lds_cdv) < 1 then
		gnv_app.inv_error.of_message("RL006",{"CDV For Issue Detail Datawindow (RETRIEVE fail in of_get_cdv)"})
	else
		ldwc_stat.reset()
		lds_cdv.RowsCopy(1, lds_cdv.RowCount(), Primary!, ldwc_stat, 1, Primary!)
	end if
	ls_filter = ""
	for ll_col = 1 to  upperbound(ls_filter_list)
		if len(ls_filter) > 0 then
			ls_filter = ls_filter + " or "
		end if
		ls_filter = ls_filter + "cdv_cde = '" + ls_filter_list[ll_col] + "'"	
	next
	ldwc_stat.SetFilter(ls_filter)
	ldwc_stat.Filter()	
	iw_main.of_setlines(u_dw_main, ldwc_stat, "stat_cde")
end if
// security level protect columns from updating
if ls_security_permission = 'N' then
	for ll_col = 1 to upperbound(ls_security_col_list)
		u_dw_main.Modify(ls_security_col_list[ll_col] + ".protect=1")
		u_dw_main.Modify(ls_security_col_list[ll_col] + ".BackGround.Color=" + string(f_getcolor(2)))
	next
	u_cb_delete.enabled = false
	u_dw_comments.Modify("cmnt_desc" + ".protect=1")
	u_dw_comments.Modify("cmnt_desc" + ".BackGround.Color=" + string(f_getcolor(2)))
	u_dw_owners.Modify("racf_id_xref" + ".protect=1")
	u_dw_owners.Modify("racf_id_xref" + ".BackGround.Color=" + string(f_getcolor(2)))
end if

if upperbound(ls_filter_list) = 1 then
	u_dw_main.Modify("stat_cde.protect=1")
	u_dw_main.Modify("stat_cde.BackGround.Color=" + string(f_getcolor(2)))
end if

// disable delete button if valid rowcount is one
if u_dw_owners.rowcount() = 2 then
	if isnull(u_dw_owners.GetItemString(2, "racf_id_xref")) or trim(u_dw_owners.GetItemString(2, "racf_id_xref")) = "" then
		u_cb_delete.enabled = false
	end if
end if
if not isvalid(u_dw_main.inv_dropdownsearch) then
	u_dw_main.of_SetDropDownSearch(True)
end if
u_dw_main.inv_dropdownsearch.of_UnRegister()
u_dw_main.inv_dropdownsearch.of_Register()
// remove MOVED TO from resulotion method if it is editable
if u_dw_main.GetChild("rsolv_cde", ldwc_tmp) > 0 then
	if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv("OI_RESO_CD", lds_tmp) < 1 then
		gnv_app.inv_error.of_message("RL006",{"CDV For Issue Detail Datawindow (RETRIEVE fail in of_get_cdv)"})
	else
		ldwc_tmp.reset()
		lds_tmp.RowsCopy(1, lds_tmp.RowCount(), Primary!, ldwc_tmp, 1, Primary!)
	end if
	if string(u_dw_main.object.rsolv_cde.protect) = "0" then
		ls_expression = "cdv_cde <> '" + "12" + "'"
		ldwc_tmp.SetFilter(ls_expression)
		ldwc_tmp.filter()
	end if
end if
	
// set field focus
// set focus to the first reqired column that is null
u_dw_main.post SetFocus()
for ll_col = 1 to upperbound(ls_req_col_list)
	ll_col_id = long(u_dw_main.Describe(ls_req_col_list[ll_col] + ".id"))
	if isnull(u_dw_main.object.data[1, ll_col_id]) and long(u_dw_main.Describe(ls_req_col_list[ll_col] + ".protect")) = 0  then
		u_dw_main.post SetColumn(ls_req_col_list[ll_col])
		return
	end if
next
// set focus to the first optional column that is null
for ll_col = 1 to upperbound(ls_opt_col_list)
	ll_col_id = long(u_dw_main.Describe(ls_opt_col_list[ll_col] + ".id"))
	if isnull(u_dw_main.object.data[1, ll_col_id]) and long(u_dw_main.Describe(ls_opt_col_list[ll_col] + ".protect")) = 0  then
		u_dw_main.post SetColumn(ls_opt_col_list[ll_col])
		return
	end if
next
// if none of the required or optional columns are null, set column focus to the first required column
for ll_col = 1 to upperbound(ls_req_col_list)
	ll_col_id = long(u_dw_main.Describe(ls_req_col_list[ll_col] + ".id"))
	if long(u_dw_main.Describe(ls_req_col_list[ll_col] + ".protect")) = 0  then
		u_dw_main.post SetColumn(ls_req_col_list[ll_col])
		return
	end if
next
// if there are no req columns, set column focus to the first optional column
for ll_col = 1 to upperbound(ls_opt_col_list)
	ll_col_id = long(u_dw_main.Describe(ls_opt_col_list[ll_col] + ".id"))
	if long(u_dw_main.Describe(ls_opt_col_list[ll_col] + ".protect")) = 0  then
		u_dw_main.post SetColumn(ls_opt_col_list[ll_col])
		return
	end if
next

end subroutine

on u_tabpg_ral_oi_main.create
int iCurrent
call super::create
this.u_dw_main=create u_dw_main
this.u_dw_owners=create u_dw_owners
this.u_dw_comments=create u_dw_comments
this.u_cb_delete=create u_cb_delete
this.u_dw_report=create u_dw_report
this.st_splitbar_3=create st_splitbar_3
this.u_cb_add=create u_cb_add
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.u_dw_main
this.Control[iCurrent+2]=this.u_dw_owners
this.Control[iCurrent+3]=this.u_dw_comments
this.Control[iCurrent+4]=this.u_cb_delete
this.Control[iCurrent+5]=this.u_dw_report
this.Control[iCurrent+6]=this.st_splitbar_3
this.Control[iCurrent+7]=this.u_cb_add
end on

on u_tabpg_ral_oi_main.destroy
call super::destroy
destroy(this.u_dw_main)
destroy(this.u_dw_owners)
destroy(this.u_dw_comments)
destroy(this.u_cb_delete)
destroy(this.u_dw_report)
destroy(this.st_splitbar_3)
destroy(this.u_cb_add)
end on

event ue_initialize_tabpg;call super::ue_initialize_tabpg;integer li_i
long ll_row, ll_returncode = 0
long ll_column_count, ll_col
string ls_init_message, ls_prim_lastname
string ls_cdv_type, ls_user_id, ls_expression
string ls_column_list[], ls_cdv_type_list[], ls_user_col[]
Any la_tranobject, la_parm, la_empty
n_ds lds_cdv, lds_username
datawindowchild ldwc_child
n_tr ltr_tranobject
string ls_err_parm[] = {"Open Issue"}

u_dw_report.visible = false
ls_column_list[] = {"stat_cde","prior_stat_cde","prty_cde","rsolv_cde","trnmtr_cde","func_cde","orign_srce_cde","dept_cde","reas_cde","rleas_id"}
ls_cdv_type_list[] = {"OI_STAT_CD","OI_STAT_CD","OI_PRTY_CD","OI_RESO_CD","OI_TRNMTR","OI_FUNC_CD","OI_SRCE_CD","OI_DEPT_CD","OI_REAS_CD","OI_RELE_CD"}
ls_user_col[] = {"srce_id","req_srce_id","cmpl_srce_id","updt_srce_id"}

u_dw_main.of_set_business_rule(TRUE, 'n_cst_bus_rule_ral_oi')
//u_dw_main.of_setupdateable(TRUE)
u_dw_main.of_set_update(TRUE,"n_cst_update_ral_oi")
u_dw_comments.of_set_update(TRUE,"n_cst_update_ral_oi_cmnt")
u_dw_owners.of_set_update(TRUE,"n_cst_update_ral_oi_owners")
u_dw_main.of_set_retrieve(TRUE,"n_cst_retrieve_ral_oi_main")
u_dw_comments.of_set_retrieve(TRUE,"n_cst_retrieve_ral_oi_cmnt")
u_dw_owners.of_set_retrieve(TRUE,"n_cst_retrieve_ral_oi_owners")

inv_retrieve = gnv_app.inv_object_mgr.of_get_object("n_cst_retrieve_ral_oi_main")
inv_retrieve_cmnt = gnv_app.inv_object_mgr.of_get_object("n_cst_retrieve_ral_oi_cmnt")
inv_retrieve_owners = gnv_app.inv_object_mgr.of_get_object("n_cst_retrieve_ral_oi_owners")

u_dw_main.of_set_business_rule(TRUE, 'n_cst_bus_rule_ral_oi')
u_dw_comments.of_set_business_rule(TRUE, 'n_cst_bus_rule_ral_oi')
u_dw_owners.of_set_business_rule(TRUE, 'n_cst_bus_rule_ral_oi')

// SET CDV for columns in issue list datawindow
for li_i = 1 to upperbound(ls_column_list)
	if gnv_app.of_getframe().inv_frame.dynamic of_get_cdv(ls_cdv_type_list[li_i], lds_cdv) < 1 then
		gnv_app.inv_error.of_message("RL006",{"CDV For Issue Detail Datawindow (RETRIEVE fail in of_get_cdv)"})
	else
		gnv_app.of_getframe().inv_frame.dynamic of_remove_space(lds_cdv)
		If u_dw_main.getchild(ls_column_list[li_i], ldwc_child) < 0 Then
			gnv_app.inv_error.of_message("RL006",{"CDV For Issue Detail Datawindow (fail in getchild)"})
		Else
			lds_cdv.RowsCopy(1, lds_cdv.RowCount(), Primary!, ldwc_child, 1, Primary!)
		End If
		ldwc_child.SetSort("cdv_desc A")
		ldwc_child.Sort()
	end if
//	gnv_app.of_getframe().inv_frame.dynamic of_setlines(u_dw_main, ldwc_child, ls_column_list[li_i])
	iw_main.of_setlines(u_dw_main, ldwc_child, ls_column_list[li_i])
	If u_dw_main.getchild(ls_column_list[li_i], ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"GetChild"})
	end if
	iw_main.of_set_dddw_width(u_dw_main, ldwc_child, ls_column_list[li_i], "cdv_desc")
next
// control production user from production support as source control only

// set dddw for user columns
if gnv_app.of_getframe().inv_frame.dynamic of_get_userid_list(lds_username) < 1 then
	gnv_app.inv_error.of_message("RL006",{"User List"})
else
	ls_expression = "name_last <> '" + "FOR SECURITY'" 
	lds_username.SetFilter(ls_expression)
	lds_username.Filter()
	lds_username.SetSort("name_last A")
	lds_username.Sort()
	for li_i = 1 to upperbound(ls_user_col)
		If u_dw_main.getchild(ls_user_col[li_i], ldwc_child) < 0 Then
			gnv_app.inv_error.of_message("RL006",{"User List"})
		Else
			lds_username.sharedata(ldwc_child)
		End If
//		gnv_app.of_getframe().inv_frame.dynamic of_setlines(u_dw_main, ldwc_child, ls_user_col[li_i])
		iw_main.of_setlines(u_dw_main, ldwc_child, ls_user_col[li_i])
		If u_dw_main.getchild(ls_user_col[li_i], ldwc_child) < 0 Then
			gnv_app.inv_error.of_message("RL006",{"GetChild"})
		end if
		iw_main.of_set_dddw_width(u_dw_main, ldwc_child, ls_user_col[li_i], "fullname")
	next
	If u_dw_comments.getchild("srce_id", ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"User List"})
	Else
		lds_username.sharedata(ldwc_child)
	End If
//	If u_dw_comments.getchild("updt_srce_id", ldwc_child) < 0 Then
//		gnv_app.inv_error.of_message("RL006",{"User List"})
//	Else
//		lds_username.sharedata(ldwc_child)
//	End If
	If u_dw_owners.getchild("racf_id_xref", ldwc_child) < 0 Then
		gnv_app.inv_error.of_message("RL006",{"User List"})
	Else
		lds_username.sharedata(ldwc_child)
		iw_main.of_setlines(u_dw_owners, ldwc_child, "racf_id_xref")
		If u_dw_owners.getchild("racf_id_xref", ldwc_child) < 0 Then
			gnv_app.inv_error.of_message("RL006",{"GetChild"})
		end if
		iw_main.of_set_dddw_width(u_dw_owners, ldwc_child, "racf_id_xref", "fullname")
	End If
end if

return 1


end event

type u_dw_main from u_dw within u_tabpg_ral_oi_main
int X=32
int Y=36
int Width=3675
int Height=896
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ral_oi_main"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;call super::constructor;//integer li_i
//string ls_column_list[]
//ls_column_list[] = {"srce_id","req_srce_id","cmpl_srce_id","updt_srce_id", "stat_cde","prior_stat_cde","prty_cde","rsolv_cde","trnmtr_cde","func_cde","orign_srce_cde","dept_cde","reas_cde"}
//
of_setdropdowncalendar(true)
iuo_calendar.of_setdropdown(true)
iuo_calendar.of_Register("rsolv_by_dt")
iuo_calendar.of_Register("est_cmpl_dt")
iuo_calendar.of_Register("cmpl_dt")
iuo_calendar.post of_UnRegister()
iuo_calendar.post of_Register()

//of_SetDropDownSearch(True)
//for li_i = 1 to upperbound(ls_column_list)
//	inv_dropdownsearch.post of_Register(ls_column_list[li_i])
//next
//
end event

event ue_mousemove;call super::ue_mousemove;// bubble help
u_dw ldw
ldw = this
iw_parent = iw_main
gnv_app.of_getframe().inv_frame.dynamic of_bubblehelp(ldw, iw_parent)
end event

type u_dw_owners from u_dw within u_tabpg_ral_oi_main
int X=3735
int Y=32
int Width=745
int Height=772
int TabOrder=20
boolean BringToTop=true
string DataObject="d_ral_oi_owners"
end type

event itemchanged;call super::itemchanged;//of_SetDropDownSearch(True)
//inv_dropdownsearch.post of_Register("racf_id_xref")

end event

event constructor;call super::constructor;//of_SetDropDownSearch(True)
//inv_dropdownsearch.post of_Register("racf_id_xref")

end event

event clicked;call super::clicked;if row < 1 then return
SelectRow(0, false)
SelectRow(row, true)
//if isnull(GetItemDateTime(row, "creat_dt_tm")) then
//	SetTabOrder("racf_id_xref", 1)
//else
//	SetTabOrder("racf_id_xref", 0)
//end if


end event

event getfocus;call super::getfocus;//long ll_currentrow
//ll_currentrow = GetRow()
//if ll_currentrow > 0 then
//	SelectRow(0, false)
//	SelectRow(ll_currentrow, true)
//elseif RowCount() > 0 then
//	SelectRow(0, false)
//	SelectRow(1, true)
//end if
//
end event

event ue_mousemove;call super::ue_mousemove;// bubble help
u_dw ldw
ldw = this
iw_parent = iw_main
gnv_app.of_getframe().inv_frame.dynamic of_bubblehelp(ldw, iw_parent)
end event

type u_dw_comments from u_dw within u_tabpg_ral_oi_main
int X=37
int Y=972
int Width=4448
int Height=400
int TabOrder=50
boolean BringToTop=true
string DataObject="d_ral_oi_comments"
boolean LiveScroll=false
end type

event ue_mousemove;call super::ue_mousemove;// bubble help
u_dw ldw
ldw = this
iw_parent = iw_main
gnv_app.of_getframe().inv_frame.dynamic of_bubblehelp(ldw, iw_parent)
end event

type u_cb_delete from u_cb within u_tabpg_ral_oi_main
int X=3986
int Y=840
int Width=306
int TabOrder=30
string Tag="Microhelp=To delete the selected owner"
boolean BringToTop=true
string Text="Delete"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;long ll_row
ll_row = u_dw_owners.GetSelectedRow(0)
if ll_row < 1 then return
u_dw_owners.DeleteRow(ll_row)
if u_dw_main.GetItemString(1, "stat_cde") = 'S' then return
if u_dw_main.GetItemString(1, "stat_cde") = 'R' then return
if u_dw_owners.rowcount() = 1 then
	enabled = false
end if
if u_dw_owners.rowcount() = 2 then
	if isnull(u_dw_owners.GetItemString(2, "racf_id_xref")) or trim(u_dw_owners.GetItemString(2, "racf_id_xref")) = "" then
		enabled = false
	end if
end if
if u_dw_owners.RowCount() = 0 then
	u_cb_add.event clicked()
end if



end event

type u_dw_report from u_dw within u_tabpg_ral_oi_main
int X=110
int Y=1020
int Width=1394
int Height=76
int TabOrder=40
end type

event itemchanged;call super::itemchanged;of_SetDropDownSearch(True)
inv_dropdownsearch.post of_Register("racf_id_xref")

end event

type st_splitbar_3 from pfc_u_st_splitbar within u_tabpg_ral_oi_main
int X=41
int Y=932
int Width=4553
int Height=36
boolean BringToTop=true
end type

event constructor;call super::constructor;of_Register(u_dw_main,ABOVE)
of_Register(u_dw_owners, ABOVE)
//of_Register(u_cb_add, ABOVE)
//of_Register(u_cb_delete, ABOVE)
of_Register(u_dw_comments, BELOW)
of_SetBarColor(f_getcolor(2))

end event

event lbuttonup;call super::lbuttonup;u_cb_add.y = y - u_cb_add.height -1
u_cb_delete.y = y - u_cb_delete.height -1
//if u_cb_export.y <> u_tab_main.y then
//	u_cb_export.y = u_tab_main.y
//	u_tab_main.tabpage_main.u_dw_comments.height = u_tab_main.tabpage_main.height - u_tab_main.tabpage_main.u_dw_main.height - 108
//end if
end event

type u_cb_add from u_cb within u_tabpg_ral_oi_main
int X=4229
int Y=840
int Width=302
int TabOrder=40
boolean Visible=false
string Tag="Microhelp=To delete the selected owner"
boolean BringToTop=true
string Text="Add"
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;long ll_row
dwobject dwo
ll_row = u_dw_owners.InsertRow(0)
u_dw_owners.SetItemStatus(ll_row, "racf_id_xref", Primary!, DataModified!)
dwo = u_dw_owners.object.racf_id_xref
u_dw_owners.post SetFocus()
u_dw_owners.post SetRow(ll_row)
u_dw_owners.post SetColumn("racf_id_xref")
end event

