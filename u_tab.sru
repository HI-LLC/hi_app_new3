$PBExportHeader$u_tab.sru
forward
global type u_tab from tab
end type
type tabpage_1 from userobject within u_tab
end type
type tabpage_1 from userobject within u_tab
end type
end forward

global type u_tab from tab
int Width=922
int Height=691
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
end type
global u_tab u_tab

on u_tab.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on u_tab.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within u_tab
int X=15
int Y=99
int Width=892
int Height=579
long BackColor=67108864
string Text="none"
long TabBackColor=67108864
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

