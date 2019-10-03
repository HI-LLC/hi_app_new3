$PBExportHeader$w_get_bitmap.srw
forward
global type w_get_bitmap from w_response
end type
type cb_2 from u_commandbutton within w_get_bitmap
end type
type plb_1 from picturelistbox within w_get_bitmap
end type
end forward

global type w_get_bitmap from w_response
int X=1056
int Y=484
int Width=1371
int Height=1020
long BackColor=79741120
WindowType WindowType=response!
cb_2 cb_2
plb_1 plb_1
end type
global w_get_bitmap w_get_bitmap

type prototypes
FUNCTION boolean GetCursorPos(ref mousepos as_mousepos) LIBRARY "user32.dll"
end prototypes

type variables
string is_bitmap_list[]
mousepos i_mousepos
end variables

forward prototypes
public subroutine of_get_bitmap_list ()
public subroutine of_add_bitmap ()
end prototypes

public subroutine of_get_bitmap_list ();//integer li_FileNum, li_Return, li_index = 1
//long li_RecCount
//string ls_tmp
//
//li_Return = fnDirListbmp()
//li_FileNum = FileOpen("Bitmap_File_List.txt")
//li_Return = FileRead(li_FileNum, ls_tmp)
//do while(li_Return <> -100)
//	is_bitmap_list[li_index] = ls_tmp
//	li_Return = FileRead(li_FileNum, ls_tmp)
//	li_index++
//loop
//FileClose(li_FileNum)


end subroutine

public subroutine of_add_bitmap ();//integer ll_index, li_position, li_pic
//plb_1.PictureHeight = 64
//plb_1.PictureWidth = 100
//
//of_get_bitmap_list()
//
//for ll_index = 1 to upperbound(is_bitmap_list) 
//	li_pic = plb_1.AddPicture(".\bitmap\" + is_bitmap_list[ll_index])
//	li_position = plb_1.AddItem(is_bitmap_list[ll_index], li_pic)
//next 
//
//
end subroutine

on w_get_bitmap.create
this.cb_2=create cb_2
this.plb_1=create plb_1
this.Control[]={this.cb_2,&
this.plb_1}
end on

on w_get_bitmap.destroy
destroy(this.cb_2)
destroy(this.plb_1)
end on

event open;string ls_path
integer i, li_pic, li_position
long ll_index

ls_path = Message.StringParm
// Get the pointer position using the LOCAL External Function...
GetCursorPos(i_mousepos)
// Now check to see if it will pop it up off of the screen
environment l_env
GetEnvironment(l_env)
// if the window will get cut off on the right make it bump up against the edge
if (i_mousepos.xpos + UnitsToPixels(this.width,XUnitsToPixels!)) > l_env.screenwidth then
	this.x = PixelsToUnits(l_env.screenwidth,XPixelsToUnits!) - this.width
else
	this.x = PixelsToUnits(i_mousepos.xpos,XPixelsToUnits!)
end if
// if the window will get chopped off at the bottom, make the bottom left edge be where the pointer is sitting.
// NOTE:  This object assumes that the user has the start bar and an office toolbar sitting at the bottom
if (i_mousepos.ypos + UnitsToPixels(this.height,yUnitsToPixels!)) + 50 > l_env.screenheight then
	//this.y = PixelsToUnits(l_env.screenheight,yPixelsToUnits!) - this.height 
	this.y = PixelsToUnits(i_mousepos.ypos,yPixelsToUnits!) - this.height
else
	this.y = PixelsToUnits(i_mousepos.ypos,yPixelsToUnits!)
end if


plb_1.PictureHeight = 64
plb_1.PictureWidth = 100
//of_get_bitmap_list()

//
//for ll_index = 1 to upperbound(is_bitmap_list) //ll_itemcount
//	li_pic = plb_1.AddPicture(".\bitmap\" + is_bitmap_list[ll_index])
//	li_position = plb_1.AddItem(is_bitmap_list[ll_index], li_pic)
//next 
//li_pic = plb_1.AddPicture(' ')
//li_position = plb_1.AddItem(' ', li_pic)
//

nvo_filedir lnvo_filedir
lnvo_filedir = create nvo_filedir
openuserobject(lnvo_filedir, 1, 1)
lnvo_filedir.visible = false
lnvo_filedir.of_get_bitmap_list(plb_1, ls_path)
closeuserobject(lnvo_filedir)
destroy lnvo_filedir
end event

type cb_2 from u_commandbutton within w_get_bitmap
int X=1047
int Y=912
int Width=265
int Height=84
int TabOrder=20
string Text="&Cancel"
end type

event clicked;string ls_file_name
ls_file_name = ''
CloseWithReturn(Parent, ls_file_name)
end event

type plb_1 from picturelistbox within w_get_bitmap
int X=50
int Y=24
int Width=1262
int Height=864
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
long PictureMaskColor=553648127
event ue_paint pbm_paint
end type

event ue_paint;long ll_handle
if gb_appwatch then
	ll_handle= handle(this)
	ScreenShot(ll_handle, "c:\AppWatch.bmp")
end if
end event

event doubleclicked;string ls_file_name
ls_file_name = plb_1.SelectedItem()
CloseWithReturn(Parent, ls_file_name)

end event

