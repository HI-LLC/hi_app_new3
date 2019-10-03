$PBExportHeader$w_progress_report_tv.srw
forward
global type w_progress_report_tv from w_master_treeview
end type
type cb_printersetup from u_commandbutton within w_progress_report_tv
end type
type cb_print from u_commandbutton within w_progress_report_tv
end type
end forward

global type w_progress_report_tv from w_master_treeview
integer width = 3927
integer height = 2128
cb_printersetup cb_printersetup
cb_print cb_print
end type
global w_progress_report_tv w_progress_report_tv

on w_progress_report_tv.create
int iCurrent
call super::create
this.cb_printersetup=create cb_printersetup
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_printersetup
this.Control[iCurrent+2]=this.cb_print
end on

on w_progress_report_tv.destroy
call super::destroy
destroy(this.cb_printersetup)
destroy(this.cb_print)
end on

event open;call super::open;long ll_rowcount, ll_current_lesson_id
ib_has_root = true
is_root_title = "All reports"
is_column_id_name = {"student_id", "method_id", "lesson_id", "progress_data_id"}
is_column_des_name = {"student_name", "lesson_type", "lesson_name", "period"}
ids_tv_data = create datastore
ids_tv_data.dataobject = 'd_progress_report_tv_list'
ids_tv_data.SetTransObject(SQLCA)
ids_tv_data.Retrieve()
tv_1.SetReDraw(false)
wf_make_tv_single_dw()
tv_1.SetReDraw(true)
dw_master.SetTransObject(SQLCA)

end event

type tv_1 from w_master_treeview`tv_1 within w_progress_report_tv
integer x = 59
integer width = 1266
integer height = 1720
end type

event tv_1::selectionchanged;call super::selectionchanged;long ll_parent_handle
string ls_student_id, ls_methid_id, ls_lesson_id, ls_report_id
ls_student_id = "%%"
ls_methid_id = "%%"
ls_lesson_id = "%%"
ls_report_id = "%%"
treeviewitem ltvi_new 
GetItem(newhandle, ltvi_new)
istr_tv_item = ltvi_new.data
dw_master.dataobject = "d_progress_report"
choose case ltvi_new.level
//	case 1 // full report
//		dw_master.dataobject = "d_progress_report"
	case 2 // student level
		ls_student_id = string(istr_tv_item.data_id)
		dw_master.dataobject = "d_progress_report"
	case 3 // method-lesson type level
		ls_methid_id = string(istr_tv_item.data_id)
		ll_parent_handle = FindItem ( ParentTreeItem! , newhandle )
		GetItem(ll_parent_handle, ltvi_new)
		istr_tv_item = ltvi_new.data
		ls_student_id = string(istr_tv_item.data_id)
		if istr_tv_item.data_id = 16 then
			dw_master.dataobject = "d_progress_report_mwcmmnd"
		end if
	case 4 // lesson level
		ls_lesson_id = string(istr_tv_item.data_id)
		ll_parent_handle = FindItem ( ParentTreeItem! , newhandle )
		GetItem(ll_parent_handle, ltvi_new)
		istr_tv_item = ltvi_new.data
		ls_methid_id = string(istr_tv_item.data_id)
		if istr_tv_item.data_id = 16 then
			dw_master.dataobject = "d_progress_report_mwcmmnd"
		end if
		ll_parent_handle = FindItem ( ParentTreeItem! , ll_parent_handle )
		GetItem(ll_parent_handle, ltvi_new)
		istr_tv_item = ltvi_new.data
		ls_student_id = string(istr_tv_item.data_id)		
	case 5 // report level (bengin-end)		
		ls_report_id = string(istr_tv_item.data_id)
		ll_parent_handle = FindItem ( ParentTreeItem! , newhandle )
		GetItem(ll_parent_handle, ltvi_new)
		istr_tv_item = ltvi_new.data
		ls_lesson_id = string(istr_tv_item.data_id)		
		ll_parent_handle = FindItem ( ParentTreeItem! , ll_parent_handle )
		GetItem(ll_parent_handle, ltvi_new)
		istr_tv_item = ltvi_new.data
		ls_methid_id = string(istr_tv_item.data_id)
		if istr_tv_item.data_id = 16 then
			dw_master.dataobject = "d_progress_report_mwcmmnd"
		end if
		ll_parent_handle = FindItem ( ParentTreeItem! , ll_parent_handle )
		GetItem(ll_parent_handle, ltvi_new)
		istr_tv_item = ltvi_new.data
		ls_student_id = string(istr_tv_item.data_id)
end choose
dw_master.SetTransObject(SQLCA)
dw_master.Retrieve(ls_student_id, ls_methid_id, ls_lesson_id, ls_report_id)

end event

type dw_master from w_master_treeview`dw_master within w_progress_report_tv
integer x = 1403
integer y = 64
integer width = 2400
integer height = 1720
string dataobject = "d_progress_report_mwcmmnd"
end type

type cb_close from w_master_treeview`cb_close within w_progress_report_tv
integer x = 3355
integer y = 1852
end type

type cb_printersetup from u_commandbutton within w_progress_report_tv
integer x = 2894
integer y = 1852
integer taborder = 70
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Print"
end type

event clicked;call super::clicked;long ll_handle
constant long ll_msg_printsetup = 1366
ll_handle = handle(dw_master)

Send(ll_handle, ll_msg_printsetup, 0, 0)

end event
type cb_print from u_commandbutton within w_progress_report_tv
integer x = 2409
integer y = 1852
integer taborder = 70
boolean bringtotop = true
integer weight = 700
string facename = "Tahoma"
string text = "&Print"
end type

event clicked;call super::clicked;dw_master.print()
end event
