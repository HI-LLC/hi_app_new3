$PBExportHeader$n_srv_resize.sru
forward
global type n_srv_resize from nonvisualobject
end type
end forward

type ostr_object from structure
	powerobject		po_obj
	long		x
	long		y
	long		width
	long		height
	long		textlinesize
	long		textlinesize2
end type

global type n_srv_resize from nonvisualobject
end type
global n_srv_resize n_srv_resize

type variables
private ostr_object istr_obj[]
powerobject ipo_parent
long il_orig_width,il_orig_height

end variables

forward prototypes
public subroutine of_store_size (powerobject apo_obj)
public subroutine of_resize (decimal adc_width_pct, decimal adc_height_pct)
end prototypes

public subroutine of_store_size (powerobject apo_obj);long					i, j


CheckBox 			lv_check_box
CommandButton 		lv_cmd_button
DataWindow 			lv_datawindow
DropDownListBox 	lv_ddlb
EditMask 			lv_edit_mask
Graph 				lv_graph
GroupBox 			lv_group_box
HScrollBar 			lv_hscroll_bar
Line 					lv_line
ListBox 				lv_list_box
MultiLineEdit 		lv_mle
Oval 					lv_oval
Picture 				lv_picture
PictureButton 		lv_picture_button
RadioButton 		lv_radio_button
Rectangle 			lv_rectangle
RoundRectangle 	lv_round_rectangle
SingleLineEdit 	lv_sle
StaticText 			lv_static_text
UserObject 			lv_user_object
VScrollBar 			lv_vscroll_bar
tab        			lv_tab
window				lv_window
TreeView				ltv_treeview


i=upperbound(istr_obj)+1
CHOOSE CASE apo_obj.typeof()
	CASE window!
		lv_window=apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_window.height
		istr_obj[i].width = lv_window.width
		istr_obj[i].X = lv_window.X
		istr_obj[i].Y = lv_window.Y	
		for j=1 to upperbound(lv_window.control)
			of_store_size(lv_window.control[j])
		next
	CASE UserObject!
		lv_user_object = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_user_object.height
		istr_obj[i].width = lv_user_object.width
		istr_obj[i].X = lv_user_object.X
		istr_obj[i].Y = lv_user_object.Y	
		for j=1 to upperbound(lv_user_object.control)
			of_store_size(lv_user_object.control[j])
		next	
	CASE TAB!
		lv_tab = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_tab.height
		istr_obj[i].width = lv_tab.width
		istr_obj[i].X = lv_tab.X
		istr_obj[i].Y = lv_tab.Y			
		istr_obj[i].TextLineSize = lv_tab.TextSize		
		for j=1 to upperbound(lv_tab.control)
			of_store_size(lv_tab.control[j])
		next	
	CASE CheckBox!
		lv_check_box =	apo_obj
		istr_obj[i].po_obj =	apo_obj
		istr_obj[i].height = lv_check_box.height
		istr_obj[i].width = lv_check_box.width
		istr_obj[i].X = lv_check_box.X
		istr_obj[i].Y = lv_check_box.Y
		istr_obj[i].TextLineSize = lv_check_box.TextSize
		
		
	CASE CommandButton!
		lv_cmd_button = apo_obj
		istr_obj[i].po_obj =	apo_obj
		istr_obj[i].height = lv_cmd_button.height
		istr_obj[i].width = lv_cmd_button.width
		istr_obj[i].X = lv_cmd_button.X
		istr_obj[i].Y = lv_cmd_button.Y
		istr_obj[i].TextLineSize = lv_cmd_button.TextSize
	CASE DataWindow!
		lv_datawindow = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_datawindow.height
		istr_obj[i].width = lv_datawindow.width
		istr_obj[i].X = lv_datawindow.X
		istr_obj[i].Y = lv_datawindow.Y
	CASE DropDownListBox!
		lv_ddlb = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_ddlb.height
		istr_obj[i].width = lv_ddlb.width
		istr_obj[i].X = lv_ddlb.X
		istr_obj[i].Y = lv_ddlb.Y
		istr_obj[i].TextLineSize = lv_ddlb.TextSize
	CASE EditMask!
		lv_edit_mask = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_edit_mask.height
		istr_obj[i].width = lv_edit_mask.width
		istr_obj[i].X = lv_edit_mask.X
		istr_obj[i].Y = lv_edit_mask.Y
		istr_obj[i].TextLineSize = lv_edit_mask.TextSize
	CASE Graph!
		lv_graph = apo_obj
		istr_obj[i].po_obj =	apo_obj
		istr_obj[i].height = lv_graph.height
		istr_obj[i].width = lv_graph.width
		istr_obj[i].X = lv_graph.X
		istr_obj[i].Y = lv_graph.Y
		istr_obj[i].TextLineSize = lv_graph.TitleDispAttr.TextSize
		istr_obj[i].TextLineSize2 = lv_graph.LegendDispAttr.TextSize
	CASE GroupBox!
		lv_group_box = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_group_box.height
		istr_obj[i].width = lv_group_box.width
		istr_obj[i].X = lv_group_box.X
		istr_obj[i].Y = lv_group_box.Y
		istr_obj[i].TextLineSize = lv_group_box.TextSize
	CASE HScrollBar!
		lv_hscroll_bar = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_hscroll_bar.height
		istr_obj[i].width = lv_hscroll_bar.width
		istr_obj[i].X = lv_hscroll_bar.X
		istr_obj[i].Y = lv_hscroll_bar.Y
	CASE Line!
		lv_line = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].X = lv_line.BeginX
		istr_obj[i].Y = lv_line.BeginY
		istr_obj[i].Width = lv_line.EndX - lv_line.BeginX
		istr_obj[i].Height = lv_line.EndY - lv_line.BeginY
		istr_obj[i].TextLineSize = lv_line.LineThickness
	CASE ListBox!
		lv_list_box = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_list_box.height
		istr_obj[i].width = lv_list_box.width
		istr_obj[i].X = lv_list_box.X
		istr_obj[i].Y = lv_list_box.Y
		istr_obj[i].TextLineSize = lv_list_box.TextSize
	CASE MultiLineEdit!
		lv_mle = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_mle.height
		istr_obj[i].width = lv_mle.width
		istr_obj[i].X = lv_mle.X
		istr_obj[i].Y = lv_mle.Y
		istr_obj[i].TextLineSize = lv_mle.TextSize
	CASE Oval!
		lv_oval = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_oval.height
		istr_obj[i].width = lv_oval.width
		istr_obj[i].X = lv_oval.X
		istr_obj[i].Y = lv_oval.Y
		istr_obj[i].TextLineSize = lv_oval.LineThickness
	CASE Picture!
		lv_picture = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_picture.height
		istr_obj[i].width = lv_picture.width
		istr_obj[i].X = lv_picture.X
		istr_obj[i].Y = lv_picture.Y
	CASE PictureButton!
		lv_picture_button = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_picture_button.height
		istr_obj[i].width = lv_picture_button.width
		istr_obj[i].X = lv_picture_button.X
		istr_obj[i].Y = lv_picture_button.Y
		istr_obj[i].TextLineSize = lv_picture_button.TextSize
	CASE RadioButton!
		lv_radio_button = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_radio_button.height
		istr_obj[i].width = lv_radio_button.width
		istr_obj[i].X = lv_radio_button.X
		istr_obj[i].Y = lv_radio_button.Y
		istr_obj[i].TextLineSize = lv_radio_button.TextSize
	CASE Rectangle!
		lv_rectangle = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_rectangle.height
		istr_obj[i].width = lv_rectangle.width
		istr_obj[i].X = lv_rectangle.X
		istr_obj[i].Y = lv_rectangle.Y
		istr_obj[i].TextLineSize = lv_rectangle.LineThickness
	CASE RoundRectangle!
		lv_round_rectangle = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_round_rectangle.height
		istr_obj[i].width = lv_round_rectangle.width
		istr_obj[i].X = lv_round_rectangle.X
		istr_obj[i].Y = lv_round_rectangle.Y
		istr_obj[i].TextLineSize = lv_round_rectangle.LineThickness
	CASE SingleLineEdit!
		lv_sle = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_sle.height
		istr_obj[i].width = lv_sle.width
		istr_obj[i].X = lv_sle.X
		istr_obj[i].Y = lv_sle.Y
		istr_obj[i].TextLineSize = lv_sle.TextSize
	CASE StaticText!
		lv_static_text = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_static_text.height
		istr_obj[i].width = lv_static_text.width
		istr_obj[i].X = lv_static_text.X
		istr_obj[i].Y = lv_static_text.Y
		istr_obj[i].TextLineSize = lv_static_text.TextSize
	CASE VScrollBar!
		lv_vscroll_bar = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = lv_vscroll_bar.height
		istr_obj[i].width = lv_vscroll_bar.width
		istr_obj[i].X = lv_vscroll_bar.X
		istr_obj[i].Y = lv_vscroll_bar.Y			
	CASE Treeview!
		ltv_treeview = apo_obj
		istr_obj[i].po_obj =	apo_obj		
		istr_obj[i].height = ltv_treeview.height
		istr_obj[i].width = ltv_treeview.width
		istr_obj[i].X = ltv_treeview.X
		istr_obj[i].Y = ltv_treeview.Y		
	end choose
end subroutine

public subroutine of_resize (decimal adc_width_pct, decimal adc_height_pct);long i

CheckBox lv_check_box
CommandButton lv_cmd_button
DataWindow lv_datawindow
DropDownListBox lv_ddlb
EditMask lv_edit_mask
Graph lv_graph
GroupBox lv_group_box
HScrollBar lv_hscroll_bar
Line lv_line
ListBox lv_list_box
MultiLineEdit lv_mle
Oval lv_oval
Picture lv_picture
PictureButton lv_picture_button
RadioButton lv_radio_button
Rectangle lv_rectangle
RoundRectangle lv_round_rectangle
SingleLineEdit lv_sle
StaticText lv_static_text
UserObject lv_user_object
VScrollBar lv_vscroll_bar
tab        lv_tab
TreeView		ltv_treeview


if UpperBound(istr_obj)=0 then
	il_orig_width=adc_width_pct
	il_orig_height=adc_height_pct
	of_store_size(ipo_parent)
	return
end if

adc_width_pct=adc_width_pct/il_orig_width
adc_height_pct=adc_height_pct/il_orig_height

if adc_width_pct<.7 or adc_height_pct<.5 then return

FOR i = 1 TO UpperBound(istr_obj)
	CHOOSE CASE istr_obj[i].po_obj.TypeOf()
		CASE CheckBox!
			lv_check_box = istr_obj[i].po_obj
//			lv_check_box.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_check_box.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_check_box.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE CommandButton!
			lv_cmd_button = istr_obj[i].po_obj
//			lv_cmd_button.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_cmd_button.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_cmd_button.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE TAB!
			lv_tab = istr_obj[i].po_obj
			lv_tab.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_tab.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
			lv_tab.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE DataWindow!
			lv_datawindow = istr_obj[i].po_obj
			lv_datawindow.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_datawindow.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_datawindow.Modify("datawindow.Zoom=" + String(Min(adc_height_pct*100,adc_width_pct*100), '######'))
		CASE DropDownListBox!
			lv_ddlb = istr_obj[i].po_obj
//			lv_ddlb.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_ddlb.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_ddlb.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE EditMask!
			lv_edit_mask = istr_obj[i].po_obj
//			lv_edit_mask.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_edit_mask.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_edit_mask.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE Graph!
			lv_graph = istr_obj[i].po_obj
			lv_graph.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_graph.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
			lv_graph.TitleDispAttr.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
			lv_graph.LegendDispAttr.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE GroupBox!
			lv_group_box = istr_obj[i].po_obj
			lv_group_box.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_group_box.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_group_box.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE HScrollBar!
			lv_hscroll_bar = istr_obj[i].po_obj
			lv_hscroll_bar.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_hscroll_bar.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
		CASE Line!
			lv_line = istr_obj[i].po_obj
			lv_line.BeginX = istr_obj[i].X*adc_width_pct
			lv_line.BeginY = istr_obj[i].Y*adc_height_pct
			lv_line.EndX = lv_line.BeginX + istr_obj[i].width*adc_width_pct
			lv_line.EndY = lv_line.BeginY + istr_obj[i].height*adc_height_pct
			lv_line.LineThickness = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE ListBox!
			lv_list_box = istr_obj[i].po_obj
//			lv_list_box.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_list_box.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_list_box.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE MultiLineEdit!
			lv_mle = istr_obj[i].po_obj
//			lv_mle.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_mle.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_mle.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE Oval!
			lv_oval = istr_obj[i].po_obj
			lv_oval.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_oval.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
			lv_oval.LineThickness = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE Picture!
			lv_picture = istr_obj[i].po_obj
			lv_picture.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_picture.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
		CASE PictureButton!
			lv_picture_button = istr_obj[i].po_obj
//			lv_picture_button.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_picture_button.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_picture_button.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE RadioButton!
			lv_radio_button = istr_obj[i].po_obj
//			lv_radio_button.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_radio_button.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_radio_button.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE Rectangle!
			lv_rectangle = istr_obj[i].po_obj
			lv_rectangle.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_rectangle.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
			lv_rectangle.LineThickness = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE RoundRectangle!
			lv_round_rectangle = istr_obj[i].po_obj
			lv_round_rectangle.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_round_rectangle.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
			lv_round_rectangle.LineThickness = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE SingleLineEdit!
			lv_sle = istr_obj[i].po_obj
//			lv_sle.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_sle.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_sle.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE StaticText!
			lv_static_text = istr_obj[i].po_obj
//			lv_static_text.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_static_text.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
//			lv_static_text.TextSize = istr_obj[i].TextLineSize*Min(adc_height_pct, adc_width_pct)
		CASE UserObject!
			lv_user_object = istr_obj[i].po_obj
			lv_user_object.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_user_object.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
		CASE VScrollBar!
			lv_vscroll_bar = istr_obj[i].po_obj
			lv_vscroll_bar.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			lv_vscroll_bar.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)
		CASE TreeView!
			ltv_treeview = istr_obj[i].po_obj
			ltv_treeview.Resize(istr_obj[i].width*adc_width_pct, istr_obj[i].height*adc_height_pct)
			ltv_treeview.Move(istr_obj[i].X*adc_width_pct, istr_obj[i].Y*adc_height_pct)			
	END CHOOSE
NEXT
end subroutine

on n_srv_resize.create
TriggerEvent( this, "constructor" )
end on

on n_srv_resize.destroy
TriggerEvent( this, "destructor" )
end on

