$PBExportHeader$w_group.srw
forward
global type w_group from w_generic_update
end type
end forward

global type w_group from w_generic_update
integer width = 1893
integer height = 1708
end type
global w_group w_group

on w_group.create
call super::create
end on

on w_group.destroy
call super::destroy
end on

event open;call super::open;ib_is_odbc = false
is_update_col = {"group_name", "note"}
is_key_col[] = {"account_id", "group_id"}
is_database_table = "StudentGroup"
is_constant_col[1] = "account_id"
ia_constant_val[1] = gn_appman.il_account_id
is_unique_col[1] = "group_id"
is_where_col[1] = "account_id"
ia_where_value[1] = gn_appman.il_account_id
gn_appman.invo_sqlite.of_retrieve_to_datawindow (dw_1, "StudentGroup", is_select_col, is_where_col, ia_where_value)

end event

type dw_1 from w_generic_update`dw_1 within w_group
integer x = 32
integer y = 28
integer width = 1769
string dataobject = "d_group"
borderstyle borderstyle = StyleLowered!
end type

type cb_add from w_generic_update`cb_add within w_group
integer x = 78
integer y = 1484
end type

type cb_delete from w_generic_update`cb_delete within w_group
integer x = 416
integer y = 1484
end type

type cb_save from w_generic_update`cb_save within w_group
integer x = 1088
integer y = 1484
end type

type cb_close from w_generic_update`cb_close within w_group
integer x = 1426
integer y = 1484
end type

type cb_cancel from w_generic_update`cb_cancel within w_group
integer x = 750
integer y = 1484
end type

