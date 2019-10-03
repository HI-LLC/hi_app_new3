$PBExportHeader$w_progress_report.srw
forward
global type w_progress_report from window
end type
type cb_close from commandbutton within w_progress_report
end type
type dw_report from datawindow within w_progress_report
end type
end forward

global type w_progress_report from window
integer x = 300
integer y = 300
integer width = 3013
integer height = 1888
boolean titlebar = true
string title = "Learning Helper"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_close cb_close
dw_report dw_report
end type
global w_progress_report w_progress_report

type variables
string is_file_list[]
long il_method_id_list_from[] = {2, 3, 17, 25, 16, 15, 14, 23, 24, 21, 22}
long il_method_id_list_to[] = {2, 13, 19, 25, 16, 15, 14, 23, 24, 21, 22}
string is_method_description_list[] = {"Object Identification", "Scale Comparison", "Object Comparison", "Object Matching", &
		"Object Grouping", "Drag-drop Counting", "Number-mathcing Counting", "Addition", "Subtraction", &
		"Unscramble Words (spelling)", "Unscramble Sentences (sentence composing)"}
datastore ids_progress_report

end variables

on w_progress_report.create
this.cb_close=create cb_close
this.dw_report=create dw_report
this.Control[]={this.cb_close,&
this.dw_report}
end on

on w_progress_report.destroy
destroy(this.cb_close)
destroy(this.dw_report)
end on

event open;ids_progress_report =  message.PowerObjectParm

ids_progress_report.ShareData(dw_report)

end event

type cb_close from commandbutton within w_progress_report
integer x = 1783
integer y = 1668
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

type dw_report from datawindow within w_progress_report
integer x = 32
integer y = 32
integer width = 2926
integer height = 1588
integer taborder = 10
string title = "none"
string dataobject = "d_ilh_pg_data_content"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

