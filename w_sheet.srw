$PBExportHeader$w_sheet.srw
forward
global type w_sheet from w_basic
end type
end forward

global type w_sheet from w_basic
integer width = 2482
windowstate windowstate = maximized!
event ue_syscmnd pbm_syscommand
event ue_ncldblclck pbm_nclbuttondblclk
event ue_search ( )
end type
global w_sheet w_sheet

type variables
int iw_x, iw_y, iw_width, iw_height, icurr_height, icurr_width
//pfc_n_cst_resize inv_resize
boolean ib_resize = true
//n_srv_resize in_srv_resize


long il_current_row
long il_row_count
datawindow idw_share
end variables

forward prototypes
public subroutine wf_set_resize (boolean ab_resize)
end prototypes

event ue_syscmnd;//If g_TileorCas Then
//	Return
//End if
//
//If This.WindowState = Minimized! Then
//	Return
//End If
//
//int thwnd, mhwnd, mnbr
//uint mwparm
//long mlparm, mretval
//boolean mproc
//
//if Message.WordParm 		= 61488 Then //decimal of hex value for Maximize 
//	Message.Processed 	= True
//	Message.ReturnValue 	= 0
//	if (This.Width <> iw_width ) or (This.Height <> iw_height) Then
//		This.Width 				= iw_width
//		This.Height 			= iw_height
//		This.X 					= iw_x
//		This.Y 					= iw_y
//		Message.Processed 	= True
//		Message.ReturnValue 	= 0
//	End If
//End If
//

end event

event ue_ncldblclck;//If g_TileorCas Then
//	Return
//End if
//
//If This.WindowState = Minimized! Then
//	Return
//End If
//
//Message.Processed 		= True
//Message.ReturnValue 		= 0
//This.Width 					= iw_width
//This.Height 				= iw_height
//This.X 						= iw_x
//This.Y 						= iw_y
//Message.Processed 		= True
//Message.ReturnValue 		= 0
//
//

end event

public subroutine wf_set_resize (boolean ab_resize);ib_resize = ab_resize
end subroutine

event resize;//
// if window is resized to a new height and width, resize it back to the
// original values
//

// if the sheets are being tiled, do not execute any code

//If g_TileorCas Then
//	Return
//End if
//
//If This.WindowState = Minimized! Then
//	Return
//End If
//
//int tot, i
//
//if (This.Width > iw_width) or (This.height > iw_height) Then
//	Message.Processed 	= True
//	Message.ReturnValue 	= 0
//	This.Width 				= iw_width
//	This.Height 			= iw_height
//	This.X 					= iw_x
//	This.Y 					= iw_y
//	Message.Processed 	= True
//	Message.ReturnValue 	= 0
//End If



//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Notify the resize service that the window size has changed.
//If IsValid (inv_resize) Then
//	inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
//End If

// Store the position and size on the preference service.
// With this information the service knows the normal size of the 
// window even when the window is closed as maximized/minimized.	
//If IsValid (inv_preference) And This.windowstate = normal! Then
//	inv_preference.Post of_SetPosSize()
//End If

//if isvalid(in_srv_resize) then in_srv_resize.of_resize(newwidth,newheight)


end event

event closequery;//////////////////////////////////////////////////////////////////////////
////
//// 	The close query script is executed just before the window is closed.
//// 	It checks for modified or deleted rows in the datawindow. If rows have
////		been added or deleted from the datawindow, the user is prompted to save
////		the changes.
////

//if isvalid(in_srv_resize) then destroy in_srv_resize

window lw_window
w_internet_lh_mdi lw_mdi
long ll_handle
lw_window = this
lw_mdi = gn_appman.iw_frame

lw_mdi.wf_remove_from_tab(lw_window)
end event

event open;//
// set x, y, height and width of the window to the original values
//

iw_width 	= This.Width
iw_height 	= This.Height
icurr_width = This.Width
icurr_height= This.Height
iw_x 			= This.X
iw_y 			= This.Y

window lw_window
w_internet_lh_mdi lw_mdi
long ll_handle
lw_window = this
lw_mdi = this.ParentWindow()
ll_handle = Handle(this)
lw_mdi.wf_add_to_tab(lw_window, ll_handle)

//Commented by James
//inv_resize = create pfc_n_cst_resize
//
//long ll_control
//if ib_resize then 
//	inv_resize = create pfc_n_cst_resize
//	inv_resize.of_SetOrigSize(this.width, this.height)
//	inv_resize.of_SetMinSize(200, 600)	
//	for ll_control = 1 to upperbound(this.control)
//		inv_resize.of_Register(this.control[ll_control], inv_resize.SCALE)
//	next
//end if
//
//if not isvalid(in_srv_resize) then	
//	in_srv_resize=create n_srv_resize	
//	in_srv_resize.ipo_parent=this
//end if
end event

on w_sheet.create
call super::create
end on

on w_sheet.destroy
call super::destroy
end on

event activate;long ll_i
string ls_name
window lw_window
w_internet_lh_mdi lw_mdi

lw_window = this
lw_mdi = this.ParentWindow()

ls_name = lw_window.ClassName() 
for ll_i = 1 to upperbound(lw_mdi.tab_1.control) 
	if isvalid(lw_mdi.tab_1.control[ll_i]) then
		if ls_name = lw_mdi.tab_1.control[ll_i].tag then
			lw_mdi.tab_1.SelectTab(ll_i)
			return
		end if
	end if
next
end event

event close;call super::close;
if not isvalid(gn_appman.iw_frame.GetNextSheet ( this )) then
//	gnvo_is.post of_bring_to_top()
end if
end event

