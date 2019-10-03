$PBExportHeader$w_treeview_sys_table.srw
forward
global type w_treeview_sys_table from w_generic_update
end type
end forward

global type w_treeview_sys_table from w_generic_update
integer width = 4343
integer height = 1876
end type
global w_treeview_sys_table w_treeview_sys_table

on w_treeview_sys_table.create
call super::create
end on

on w_treeview_sys_table.destroy
call super::destroy
end on

event open;call super::open;ib_is_odbc = false
is_update_col = {"parent_id", "description", "update_ind","dw_name","sender_dw","note","sort_seq","status"}
is_key_col[] = {"tv_group_id", "treeview_id"}
is_database_table = "Treeview"
//is_constant_col[1] = "account_id"
//ia_constant_val[1] = gn_appman.il_account_id
//is_unique_col[1] = "group_id"
//is_where_col[1] = "il_tv_group_id"
//ia_where_value[1] = gn_appman.il_tv_group_id
gn_appman.invo_sqlite.of_retrieve_to_datawindow (dw_1, "Treeview", is_select_col, is_where_col, ia_where_value)

end event

type dw_1 from w_generic_update`dw_1 within w_treeview_sys_table
integer x = 32
integer y = 28
integer width = 4229
integer height = 1520
string dataobject = "d_treeview_sys_table"
borderstyle borderstyle = stylelowered!
end type

type cb_add from w_generic_update`cb_add within w_treeview_sys_table
integer x = 2519
integer y = 1600
end type

type cb_delete from w_generic_update`cb_delete within w_treeview_sys_table
integer x = 2857
integer y = 1600
end type

type cb_save from w_generic_update`cb_save within w_treeview_sys_table
integer x = 3529
integer y = 1600
end type

type cb_close from w_generic_update`cb_close within w_treeview_sys_table
integer x = 3867
integer y = 1600
end type

type cb_cancel from w_generic_update`cb_cancel within w_treeview_sys_table
integer x = 3191
integer y = 1600
end type

