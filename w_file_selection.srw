$PBExportHeader$w_file_selection.srw
forward
global type w_file_selection from Window
end type
type cb_cancel from u_commandbutton within w_file_selection
end type
type cb_select from u_commandbutton within w_file_selection
end type
type lb_file_dir from listbox within w_file_selection
end type
end forward

global type w_file_selection from Window
int X=1056
int Y=484
int Width=1609
int Height=1476
boolean TitleBar=true
string Title="Select Bitmap File"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_cancel cb_cancel
cb_select cb_select
lb_file_dir lb_file_dir
end type
global w_file_selection w_file_selection

type variables
string is_path
string is_extension
end variables

event open;long ll_file_type

ll_file_type = Message.LongParm

if ll_file_type = gnv_constant.bitmap_file then //bitmap file
	is_path = ".\bitmap\*.bmp"
elseif ll_file_type = 1 then //wave file
	is_path = ".\wave\*.wav" 
end if

lb_file_dir.DirList(is_path, 0)

end event

on w_file_selection.create
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.lb_file_dir=create lb_file_dir
this.Control[]={this.cb_cancel,&
this.cb_select,&
this.lb_file_dir}
end on

on w_file_selection.destroy
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.lb_file_dir)
end on

type cb_cancel from u_commandbutton within w_file_selection
int X=635
int Y=1192
int Width=265
int TabOrder=20
string Text="&Cancel"
end type

event clicked;string ls_selected_file = ''
CloseWithReturn(parent, ls_selected_file)
end event

type cb_select from u_commandbutton within w_file_selection
int X=1198
int Y=1192
int Width=256
int TabOrder=30
string Text="&Select"
end type

event clicked;string ls_selected_file

lb_file_dir.DirSelect(ls_selected_file)
CloseWithReturn(parent, ls_selected_file)
end event

type lb_file_dir from listbox within w_file_selection
int X=105
int Y=80
int Width=1362
int Height=1044
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

