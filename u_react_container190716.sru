$PBExportHeader$u_react_container.sru
forward
global type u_react_container from userobject
end type
type st_select_column_name from statictext within u_react_container
end type
type cb_webkit from commandbutton within u_react_container
end type
type cb_show_web_page from commandbutton within u_react_container
end type
type sle_1 from singlelineedit within u_react_container
end type
type mle_note from multilineedit within u_react_container
end type
type p_1 from picture within u_react_container
end type
type cb_html2 from commandbutton within u_react_container
end type
type pb_minimized from picturebutton within u_react_container
end type
type dw_attribute from u_datawindow within u_react_container
end type
type oleobject_2 from oleobject within u_react_container
end type
type oleobject_1 from oleobject within u_react_container
end type
end forward

global type u_react_container from userobject
integer width = 1381
integer height = 896
string dragicon = "s"
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
event mousemove pbm_mousemove
event ue_paint pbm_paint
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event tvndragdrop pbm_tvndragdrop
event lbuttondblclk pbm_lbuttondblclk
st_select_column_name st_select_column_name
cb_webkit cb_webkit
cb_show_web_page cb_show_web_page
sle_1 sle_1
mle_note mle_note
p_1 p_1
cb_html2 cb_html2
pb_minimized pb_minimized
dw_attribute dw_attribute
oleobject_2 oleobject_2
oleobject_1 oleobject_1
end type
global u_react_container u_react_container

type prototypes
function int Base64Encoding(string file_path, ref string dest) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_Base64Encoding@8"


end prototypes

type variables
constant integer RESIZE_FROM_LEFT	= 1
constant integer RESIZE_FROM_RIGHT	= 2
constant integer RESIZE_FROM_ABOVE	= 3
constant integer RESIZE_FROM_BELOW	= 4

integer ii_index, ii_width, ii_height, ii_x, ii_y
integer ii_split_bar_width = 20
long il_backcolor
long il_parent_id = 0
long il_flex_cell_id = 0
//window iw_parent, iw_dragwithin
string is_bean_DragIcon
string is_flexflow = "row"
boolean ilbuttondown = false
boolean ib_resize = false
boolean ib_read_only = false
boolean ib_read_only2 = false
boolean ib_picture_resize = false
boolean ib_autoscript = false

boolean ib_tabed = false
//userobject iu_parent
u_react_container iu_parent

long ixpos = 1
long iypos = 1
long idx = 0
long idy = 0


long il_layout_width, il_layout_height
u_react_container iu_react_container_children[], iu_react_container_empty[]

uo_st_splitbar_container iuo_splitbar[]
uo_st_splitbar_container iuo_my_left
uo_st_splitbar_container iuo_my_right
uo_st_splitbar_container iuo_my_above
uo_st_splitbar_container iuo_my_below



u_cell_gui_component iu_cell_gui_component[], iu_cell_gui_component_empty[]

u_gui_react_design iu_gui_react_design
u_cell_gui_component iu_cell_gui_component_selected

end variables

forward prototypes
public subroutine of_set_radius (integer ai_height, integer ai_width)
public function long of_close_all ()
public function integer of_save_all ()
public function integer of_add_children (string as_flexflow, integer ai_children, integer ai_gui_id, integer ai_parent_id)
public function integer of_build_children (integer ai_parent_id)
public function integer of_enable_disable_top_cells (boolean ab_enabled)
public function integer of_make_top_cells_visible ()
public function integer of_build_components ()
public function integer of_update_cell_dimension ()
public function integer of_open_all ()
public function integer of_propogate_splitter_position (readonly any aa_splitter_bar)
public function integer of_update_children_dimension (integer ai_splitter_bar_position)
end prototypes

event ue_lbuttondown;
backcolor = 13434879
if IsValid(gu_gui_react_design.iu_react_container_selected) then
	if gu_gui_react_design.iu_react_container_selected = this then return // the same cell
	gu_gui_react_design.iu_react_container_selected.backcolor = 16777215
end if
gu_gui_react_design.iu_react_container_selected = this

if enabled then gu_gui_react_design.iu_current_container = gu_gui_react_design.iu_react_container_selected

gu_gui_react_design.dw_flex_cell.Retrieve(gu_web_gui_template.il_current_gui_id, il_flex_cell_id)
gu_gui_react_design.dw_flex_cell_object.Retrieve(gu_web_gui_template.il_current_gui_id, il_flex_cell_id)

// do we need to build the components
// 1. rebuild a ) if number of components not equal to number of retrieved object
//                b ) the component type in the cell is different from the retrieve object
// 2. update  if dimension change

string ls_sel_column
if gu_gui_react_design.dw_flex_cell.RowCount() > 0 then
//	ls_sel_column = gu_gui_react_design.dw_flex_cell.GetItemString(1, "select_clause_id")
	if Not IsNull(ls_sel_column) then
		st_select_column_name.text = ls_sel_column
	end if
end if


//of_build_components()
end event

event ue_lbuttonup;//ilbuttondown = false
//ib_resize = false	

end event

event lbuttondblclk;
return 1
end event

public subroutine of_set_radius (integer ai_height, integer ai_width);
end subroutine

public function long of_close_all ();long ll_i, ll_rowcount, ll_container_index, ll_child_layout_id

ll_rowcount = upperbound(iu_react_container_children)

for ll_i = 1 to ll_rowcount
	if IsValid(iu_react_container_children[ll_i]) then
		if upperbound(iu_react_container_children[ll_i].iu_react_container_children) = 0 then
			destroy iu_react_container_children[ll_i]
		else
			iu_react_container_children[ll_i].of_close_all()
		end if
	end if
next
iu_react_container_children = iu_react_container_empty 
return 1
end function

public function integer of_save_all ();//long ll_i, ll_rowcount, ll_container_index, ll_child_layout_id
//datastore lds_page_layout
//lds_page_layout = create datastore
//lds_page_layout.DataObject = "d_page_layout_tv2"
//lds_page_layout.SetTransObject(SQLCA)
//lds_page_layout.Retrieve(istr_tv_page_layout.id)
//ll_rowcount = lds_page_layout.RowCount()
//for ll_i = 1 to ll_rowcount
//	// 1) create the child container user object
//	ll_child_layout_id = lds_page_layout.GetItemNumber(ll_i, "id")
//	ll_container_index = upperbound(iu_react_container) + 1
//	OpenUserObject ( iu_react_container[ll_container_index], 250,250)	
//	iu_react_container[ll_container_index].iu_parent = this
//	iu_react_container[ll_container_index].iu_layout_page = iu_layout_page
//	iu_react_container[ll_container_index].pb_minimized.event clicked()	// resizing to minimum
//	// 2) Retrieve page_layout record, layout data store and istr_tv_page_layout for the new created layout
//	iu_react_container[ll_container_index].istr_tv_page_layout.parent_id = istr_tv_page_layout.id
//	iu_react_container[ll_container_index].of_retrieve_layout(ll_child_layout_id)
//	// 3) Retrieve attributes
//	iu_react_container[ll_container_index].dw_attribute.Retrieve(ll_child_layout_id)
//	iu_react_container[ll_container_index].of_open_all()	
//next
//destroy lds_page_layout
return 1
end function

public function integer of_add_children (string as_flexflow, integer ai_children, integer ai_gui_id, integer ai_parent_id);integer li_box_index, li_child_height,li_child_width, li_x, li_y, li_i
long ll_flex_cell_id
integer li_count

SELECT max(flex_cell_id) INTO :ll_flex_cell_id FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :ai_gui_id;
if ai_parent_id = 0 then // starting layout
//	gu_gui_react_design.OpenUserObject ( iu_react_container_root, 0,0)
//	SELECT count(*) INTO :li_count FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :ai_gui_id and parent_id = 0;
//	if li_count > 0 then
//		
//	else
//		
//	end if

else
	if ai_children > 1 then
		is_flexflow = as_flexflow
		for li_box_index = 1 to ai_children
			iu_react_container_children[li_box_index] = create u_react_container
		next
		if as_flexFlow = "row" then // divide the container into ai_children children with equal height
			li_child_height = (height - ii_split_bar_width*(ai_children - 1))/ai_children
			li_x = 0
			li_y = 0
			for li_box_index = 1 to ai_children
				 iu_react_container_children[li_box_index].width = width
				 iu_react_container_children[li_box_index].height = li_child_height
				OpenUserObject ( iu_react_container_children[li_box_index], li_x,li_y)	
				iu_react_container_children[li_box_index].iu_parent = this
				iu_react_container_children[li_box_index].iu_gui_react_design = iu_gui_react_design
				
				iu_react_container_children[li_box_index].il_parent_id = ai_parent_id
				ll_flex_cell_id = ll_flex_cell_id + 1
				iu_react_container_children[li_box_index].il_flex_cell_id = ll_flex_cell_id
				
				INSERT INTO Sys_Gui_Data_Mapping_Flex_Cell(gui_id,flex_cell_id,parent_id,flexFlow,x,y,width,height,flex)
				VALUES(:ai_gui_id,:ll_flex_cell_id,:ai_parent_id,:as_flexFlow,:li_x,:li_y,:width,:li_child_height,1);
				commit;
				if li_box_index < ai_children then
					OpenUserObject ( iuo_splitbar[li_box_index], li_x,li_y + li_child_height)			
					iuo_splitbar[li_box_index].BringToTop = true
					 iuo_splitbar[li_box_index].width = width
					 iuo_splitbar[li_box_index].height = ii_split_bar_width
					iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].ABOVE)
					iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].BELOW)
					iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
					iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]					
					iu_react_container_children[li_box_index].iuo_my_below = iuo_splitbar[li_box_index]
					iu_react_container_children[li_box_index+1].iuo_my_above = iuo_splitbar[li_box_index]		
				end if
				li_y = li_y + li_child_height + ii_split_bar_width
			next
		else  // divide the container into ai_children children with equal width
			// 	li_child_height = (height - ii_split_bar_width*(ai_children - 1))/ai_children
			li_child_width = (width - ii_split_bar_width*(ai_children - 1))/ai_children
			li_x = 0
			li_y = 0
			for li_box_index = 1 to ai_children
				 iu_react_container_children[li_box_index].width = li_child_width
				 iu_react_container_children[li_box_index].height = height
				 
				OpenUserObject ( iu_react_container_children[li_box_index], li_x,li_y)	
				iu_react_container_children[li_box_index].iu_parent = this
				iu_react_container_children[li_box_index].iu_gui_react_design = iu_gui_react_design
				iu_react_container_children[li_box_index].il_parent_id = ai_parent_id
				ll_flex_cell_id = ll_flex_cell_id + 1
				iu_react_container_children[li_box_index].il_flex_cell_id = ll_flex_cell_id
				
				INSERT INTO Sys_Gui_Data_Mapping_Flex_Cell(gui_id,flex_cell_id,parent_id,flexFlow,x,y,width,height,flex)
				VALUES(:ai_gui_id,:ll_flex_cell_id,:ai_parent_id,:as_flexFlow,:li_x,:li_y,:li_child_width,:height,1);
	
				if li_box_index < ai_children then					
					OpenUserObject (iuo_splitbar[li_box_index], li_x + li_child_width,li_y)
					iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
					iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]
					iuo_splitbar[li_box_index].BringToTop = true
					iuo_splitbar[li_box_index].width = ii_split_bar_width
					iuo_splitbar[li_box_index].height = height
					iuo_splitbar[li_box_index].of_set_style( iuo_splitbar[li_box_index].VERTICAL)
					iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].LEFT)
					iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].RIGHT)
					iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
					iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]
					
					iu_react_container_children[li_box_index].iuo_my_right = iuo_splitbar[li_box_index]
					iu_react_container_children[li_box_index+1].iuo_my_left = iuo_splitbar[li_box_index]
					
				end if
				li_x = li_x + li_child_width + ii_split_bar_width
			next
		end if	
		
//		if is_flexflow = "row" then // splitting into rows
//			if IsValid(iuo_my_above) then
//				iuo_my_above.of_Register(iu_react_container_children[1],iuo_my_above.BELOW)	
//			end if
//			if IsValid(iuo_my_below) then
////				MessageBox("IsValid(iuo_my_below)", "iuo_my_below.of_Register(iu_react_container_children[li_count],iuo_my_below.ABOVE)")	
//				iuo_my_below.of_Register(iu_react_container_children[ai_children],iuo_my_below.ABOVE)	
//			end if
//			if IsValid(iuo_my_left) then
//				for li_i = 1 to ai_children
//					iuo_my_left.of_Register(iu_react_container_children[li_i],iuo_my_left.RIGHT)		
//					if li_i <= upperbound(iuo_splitbar) then
//						iuo_my_left.of_Register(iuo_splitbar[li_i],iuo_my_right.RIGHT)	
//					end if
//				next
//			end if		
//			if IsValid(iuo_my_right) then
//				for li_i = 1 to ai_children
//					iuo_my_right.of_Register(iu_react_container_children[li_i],iuo_my_right.LEFT)		
//					if li_i <= upperbound(iuo_splitbar) then
//						iuo_my_right.of_Register(iuo_splitbar[li_i],iuo_my_right.LEFT)	
//					end if
//				next
//			end if		
//
//		else	// splitting into columns
//			if IsValid(iuo_my_left) then // splitter on my left
//				iuo_my_left.of_Register(iu_react_container_children[1],iuo_my_left.RIGHT)	
//			end if
//			if IsValid(iuo_my_right) then // splitter on my right
//				iuo_my_right.of_Register(iu_react_container_children[ai_children],iuo_my_right.LEFT)	
//			end if		
//			if IsValid(iuo_my_above) then // spitter above me
//				for li_i = 1 to ai_children
//					iuo_my_above.of_Register(iu_react_container_children[li_i],iuo_my_above.BELOW)		
//					if li_i <= upperbound(iuo_splitbar) then
//						iuo_my_above.of_Register(iuo_splitbar[li_i],iuo_my_below.BELOW)	
//					end if
//				next
//			end if		
//			if IsValid(iuo_my_below) then // splitter below me
//				for li_i = 1 to ai_children
//					iuo_my_below.of_Register(iu_react_container_children[li_i],iuo_my_below.ABOVE)		
//					if li_i <= upperbound(iuo_splitbar) then
//						iuo_my_below.of_Register(iuo_splitbar[li_i],iuo_my_below.ABOVE)	
//					end if
//				next
//			end if		
//			
//		end if		

		
		
		
	end if
end if
return 1

end function

public function integer of_build_children (integer ai_parent_id);integer li_count, li_box_index, li_x, li_y
datastore lds_flex_cell 
datastore lds_flex_cell_object 

SELECT COUNT(*) INTO :li_count FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :gu_web_gui_template.il_current_gui_id and parent_id = :ai_parent_id;
datastore ids_flex_cell 
datastore ids_flex_cell_object 

if li_count = 0 then return 1

lds_flex_cell = create datastore
lds_flex_cell.DataObject = "d_gui_mapping_flex_cell"
lds_flex_cell.SetTransObject(SQLCA)

lds_flex_cell.Retrieve(gu_web_gui_template.il_current_gui_id, il_flex_cell_id)

if is_flexflow = "row" then
	lds_flex_cell.SetSort("y as")	
else
	lds_flex_cell.SetSort("x as")	
end if
lds_flex_cell.Sort()

for li_box_index = 1 to li_count
	iu_react_container_children[li_box_index] = create u_react_container	
	iu_react_container_children[li_box_index].x = lds_flex_cell.GetItemNumber(li_box_index, "x")
	iu_react_container_children[li_box_index].y = lds_flex_cell.GetItemNumber(li_box_index, "y")
	iu_react_container_children[li_box_index].width = lds_flex_cell.GetItemNumber(li_box_index, "width")
	iu_react_container_children[li_box_index].height = lds_flex_cell.GetItemNumber(li_box_index, "height")
	OpenUserObject ( iu_react_container_children[li_box_index], iu_react_container_children[li_box_index].x,iu_react_container_children[li_box_index].y)	
	iu_react_container_children[li_box_index].il_parent_id = lds_flex_cell.GetItemNumber(li_box_index, "parent_id")
	iu_react_container_children[li_box_index].il_flex_cell_id =  lds_flex_cell.GetItemNumber(li_box_index, "flowflex_id")
next

for li_box_index = 1 to li_count
	if li_box_index < li_count then
		if is_flexflow = "row" then
			li_x = iu_react_container_children[li_box_index].x
			li_y = iu_react_container_children[li_box_index].y + iu_react_container_children[li_box_index].height
			OpenUserObject ( iuo_splitbar[li_box_index], li_x,li_y)
			iuo_splitbar[li_box_index].width = iu_react_container_children[li_box_index].width
			iuo_splitbar[li_box_index].height = ii_split_bar_width
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].ABOVE)
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].BELOW)
		else
			li_x = iu_react_container_children[li_box_index].x + iu_react_container_children[li_box_index].width
			li_y = iu_react_container_children[li_box_index].y 
			OpenUserObject ( iuo_splitbar[li_box_index], li_x,li_y)
			iuo_splitbar[li_box_index].height = iu_react_container_children[li_box_index].height
			iuo_splitbar[li_box_index].width = ii_split_bar_width
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].LEFT)
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].RIGHT)
		end if
		iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
		iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]
	end if
next

destroy lds_flex_cell
		
return 1

end function

public function integer of_enable_disable_top_cells (boolean ab_enabled);// traverse all container object, those do not have children are top level cells

integer li_box_index

for li_box_index = 1 to upperbound(iu_react_container_children)
	if upperbound(iu_react_container_children[li_box_index].iu_react_container_children) > 0 then
		iu_react_container_children[li_box_index].of_enable_disable_top_cells(ab_enabled)
	else
		enabled = ab_enabled
	end if
next

return 1
end function

public function integer of_make_top_cells_visible ();// traverse all container object, those do not have children are top level cells

integer li_box_index, li_i
u_react_container lu_react_container_parent

for li_box_index = 1 to upperbound(iu_react_container_children)
	iu_react_container_children[li_box_index].visible = true
	if upperbound(iu_react_container_children[li_box_index].iu_react_container_children) > 0 then iu_react_container_children[li_box_index].of_make_top_cells_visible()
	
next

for li_i = 1 to upperbound(iuo_splitbar)
	iuo_splitbar[li_i].visible = true
next

return 1
end function

public function integer of_build_components ();integer li_i, li_count, li_box_index, li_x, li_y, li_width,li_height,li_row, li_i2
long ll_flex_cell_id, ll_object_id, ll_select_clause_id, ll_resource_id
string ls_object_type, ls_column_name, ls_value
datawindow ldw
DataWindowChild ldwc
integer li_find_row

ll_flex_cell_id = il_flex_cell_id

ldw = gu_gui_react_design.dw_flex_cell_object
ldw.Retrieve(gu_web_gui_template.il_current_gui_id, il_flex_cell_id)

//gu_gui_react_design.dw_flex_cell_object.Retrieve(gu_web_gui_template.il_current_gui_id, il_flex_cell_id)

// do we need to build the components
// compare components list with the retrieved data
// 1. if a retrieved object_id is not found in components, add the component
// 2. if object_id is found, the object_type is different, delete the object and rebuild it
// 3. if object_id is found, the object_type is the same:
// 		if it is picture, check the file name, if the file name is different, update it, otherwise do nothing
//       if it is text, update the text from retrieved data to the component
//		if discrepsion in dimension, update it
// 4. if a component is not found in the retrieved data, delete the component

boolean lb_found
integer li_rows_of_retrieved_object_to_be_added[]
u_cell_gui_component lu_components_to_be_deleted[]
string ls_file_name
u_cell_gui_component lu_cell_gui_component_tmp

for li_row = 1 to ldw.RowCount()
	ll_object_id = ldw.GetItemNumber(li_row, "object_id")
	ls_object_type = ldw.GetItemString(li_row, "object_type")
	if IsNull(ls_object_type) then 
		ls_object_type = ""
	else
		ls_object_type = trim(ls_object_type)
	end if
	lb_found = false
//	MessageBox("upperbound(iu_cell_gui_componen", upperbound(iu_cell_gui_component))
	if upperbound(iu_cell_gui_component) > 0 then
		for li_i = 1 to upperbound(iu_cell_gui_component)
			if ll_object_id = iu_cell_gui_component[li_i].ii_my_object_id then 
				lb_found = true	
				lu_cell_gui_component_tmp = iu_cell_gui_component[li_i]
			end if
		next	
	end if
	if lb_found then		// component found
		if ls_object_type <> lu_cell_gui_component_tmp.is_my_object_type then // delete and rebuild
			lu_components_to_be_deleted[upperbound(lu_components_to_be_deleted)+1] = lu_cell_gui_component_tmp
			li_rows_of_retrieved_object_to_be_added[upperbound(li_rows_of_retrieved_object_to_be_added)+1] = li_row
		else	// update			
			if lu_cell_gui_component_tmp.is_my_object_type = "Picture" and IsValid(lu_cell_gui_component_tmp.iPicture) then
				ll_resource_id = ldw.GetItemNumber(li_row, "resource_id")
				if IsNull(ll_resource_id) then ll_resource_id = 0
				if ll_resource_id > 0 then
					lu_cell_gui_component_tmp.of_retrieve_image(ll_resource_id)
				end if
			else	// "MultiLineEdit" or ls_object_type = "SingleLineEdit" or ls_object_type = "StaticText"  or CommandButton
				ll_select_clause_id = ldw.GetItemNumber(li_row, "select_clause_id")
				if IsNull(ll_select_clause_id) then ll_select_clause_id = 0
				if ll_select_clause_id > 0 then
					if ldw.GetChild('select_clause_id', ldwc) > -1 then	
						li_find_row = ldwc.find("id = " + string(ll_select_clause_id), 1, ldwc.RowCount())
						if li_find_row > 0 then
							ls_column_name = ldwc.GetItemString(li_find_row, "column_name")
							ls_value = "db:" + ls_column_name
						else
							ls_value = "db:"
						end if
					end if
				else
					ls_value = ldw.GetItemString(li_row, "value")
					if IsNull(ls_value) then ls_value = ""
				end if	
				choose case ls_object_type
					case "CommandButton"
						lu_cell_gui_component_tmp.iCommandButton.text = ls_value
					case "StaticText"
						lu_cell_gui_component_tmp.iStaticText.text = ls_value
					case "SingleLineEdit"
						lu_cell_gui_component_tmp.iSingleLineEdit.text = ls_value
					case "MultiLineEdit"
						lu_cell_gui_component_tmp.iMultiLineEdit.text = ls_value
					case else
				end choose
			end if // 	ls_object_type				
			// update x, y, width, height
			li_x = ldw.GetItemNumber(li_row, "x")
			li_y = ldw.GetItemNumber(li_row, "y")
			li_width = ldw.GetItemNumber(li_row, "width")
			li_height = ldw.GetItemNumber(li_row, "height")

//			lu_cell_gui_component_tmp.x = ldw.GetItemNumber(li_row, "x")
//			lu_cell_gui_component_tmp.y = ldw.GetItemNumber(li_row, "y")
//			lu_cell_gui_component_tmp.width = ldw.GetItemNumber(li_row, "width")
//			lu_cell_gui_component_tmp.height = ldw.GetItemNumber(li_row, "height")
//			lu_cell_gui_component_tmp.post of_set_dimension(ldw.GetItemNumber(li_row, "x")
			lu_cell_gui_component_tmp.post of_set_dimension(li_x,li_y,li_width,li_height)
			
		end if // END UPDATE
	else // component not found, in the component list add	
		li_rows_of_retrieved_object_to_be_added[upperbound(li_rows_of_retrieved_object_to_be_added)+1] = li_row			
	end if
next

// find components that are not in the datawindow
for li_i = 1 to upperbound(iu_cell_gui_component)
	lb_found = false	
	for li_row = 1 to ldw.RowCount()
		ll_object_id =  ldw.GetItemNumber(li_row, "object_id")
		if ll_object_id = iu_cell_gui_component[li_i].ii_my_object_id then 
			lb_found = true	
		end if		
	next
	if not lb_found then
		lu_components_to_be_deleted[upperbound(lu_components_to_be_deleted)+1] = iu_cell_gui_component[li_i]
	end if
next	


// PROCESS COMPONENT BUILD, UPDATE
u_cell_gui_component iu_cell_gui_component_lis_tmp[]
//for li_row = 1 to ldw.RowCount()
//	li_rows_of_retrieved_object_to_be_added[upperbound(li_rows_of_retrieved_object_to_be_added)+1] = li_row			
//next

for li_i = 1 to upperbound(iu_cell_gui_component)
	lb_found = false
	for li_i2 = 1 to upperbound(lu_components_to_be_deleted)
		if iu_cell_gui_component[li_i] = lu_components_to_be_deleted[li_i2] then lb_found = true
	next
	if not lb_found then	// keep it
		iu_cell_gui_component_lis_tmp[upperbound(iu_cell_gui_component_lis_tmp)+1] = iu_cell_gui_component[li_i]
	else
		if IsValid(iu_cell_gui_component[li_i]) then CloseUserObject( iu_cell_gui_component[li_i])
		if IsValid(iu_cell_gui_component[li_i]) then destroy iu_cell_gui_component[li_i]
	end if
next

iu_cell_gui_component = iu_cell_gui_component_lis_tmp

for li_i2 = 1 to upperbound(li_rows_of_retrieved_object_to_be_added)
	li_row = li_rows_of_retrieved_object_to_be_added[li_i2]
	ll_object_id = ldw.GetItemNumber(li_row, "object_id")
	ls_object_type = ldw.GetItemString(li_row, "object_type")
	if IsNull(ls_object_type) then 
		ls_object_type = ""
	else
		ls_object_type = trim(ls_object_type)
	end if
	if ls_object_type = "" then continue
	li_i = upperbound(iu_cell_gui_component) + 1
	iu_cell_gui_component[li_i] = create u_cell_gui_component
	iu_cell_gui_component[li_i].x = ldw.GetItemNumber(li_row, "x")
	iu_cell_gui_component[li_i].y = ldw.GetItemNumber(li_row, "y")
	li_width = ldw.GetItemNumber(li_row, "width")
	li_height = ldw.GetItemNumber(li_row, "height")
	iu_cell_gui_component[li_i].width = ldw.GetItemNumber(li_row, "width")
	iu_cell_gui_component[li_i].height = ldw.GetItemNumber(li_row, "height")
	iu_cell_gui_component[li_i].ii_my_object_id = ll_object_id
	iu_cell_gui_component[li_i].iu_react_container = this
	string ls_resource_type
	ll_resource_id = 0
	ls_resource_type = ldw.GetItemString(li_row, "resource_type")
	ls_object_type = ldw.GetItemString(li_row, "object_type")
	if IsNull(ls_resource_type) then ls_resource_type = ""
	
	OpenUserObject (iu_cell_gui_component[li_i], iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y)	

	if ls_resource_type = "image_raster" then
		iu_cell_gui_component[li_i].of_create_control(ls_object_type, ls_object_type, iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y,li_width,li_height,"","")
		ll_resource_id = ldw.GetItemNumber(li_row, "resource_id")
		if IsNull(ll_resource_id) then ll_resource_id = 0
		if ll_resource_id > 0 then
			iu_cell_gui_component[li_i].of_retrieve_image(ll_resource_id)
		end if
	elseif ls_object_type = "MultiLineEdit" or ls_object_type = "SingleLineEdit" or ls_object_type = "StaticText" then
		string ls_label
		ll_select_clause_id = ldw.GetItemNumber(li_row, "select_clause_id")
		if IsNull(ll_select_clause_id) then ll_select_clause_id = 0
		if ll_select_clause_id > 0 then
			if ldw.GetChild('select_clause_id', ldwc) > -1 then	
				li_find_row = ldwc.find("id = " + string(ll_select_clause_id), 1, ldwc.RowCount())
				if li_find_row > 0 then
					ls_column_name = ldwc.GetItemString(li_find_row, "column_name")
					ls_label = "db:" + ls_column_name
				else
					ls_label = "db:"
				end if
			end if
			iu_cell_gui_component[li_i].of_create_control(ls_object_type, ls_label, iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y,li_width,li_height,ls_label,"")
		else
			ls_value = ldw.GetItemString(li_row, "value")
			if IsNull(ls_value) then ls_value = ""
		end if
	end if
	iu_cell_gui_component[li_i].of_create_control(ls_object_type, ls_value, iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y,li_width,li_height,ls_value,"")
	
//	iu_cell_gui_component[li_i].width = iu_cell_gui_component[li_i].st_right_border.x + iu_cell_gui_component[li_i].ii_object_margin_x
//	iu_cell_gui_component[li_i].height = iu_cell_gui_component[li_i].st_bottom_border.y + iu_cell_gui_component[li_i].ii_object_margin_y
	iu_cell_gui_component[li_i].post of_set_dimension(true)
next



//for li_i = 1 to upperbound(iu_cell_gui_component)
//	if IsValid(iu_cell_gui_component[li_i]) then CloseUserObject( iu_cell_gui_component[li_i])
//	if IsValid(iu_cell_gui_component[li_i]) then destroy iu_cell_gui_component[li_i]
//next
//
//iu_cell_gui_component = iu_cell_gui_component_empty
//
//li_i = 0
//for li_row = 1 to ldw.RowCount()
//	ll_object_id = ldw.GetItemNumber(li_row, "object_id")
//	ls_object_type = ldw.GetItemString(li_row, "object_type")
//	if IsNull(ls_object_type) then 
//		ls_object_type = ""
//	else
//		ls_object_type = trim(ls_object_type)
//	end if
//	if ls_object_type = "" then continue
//	li_i = upperbound(iu_cell_gui_component) + 1
//	iu_cell_gui_component[li_i] = create u_cell_gui_component
//	iu_cell_gui_component[li_i].x = ldw.GetItemNumber(li_row, "x")
//	iu_cell_gui_component[li_i].y = ldw.GetItemNumber(li_row, "y")
//	li_width = ldw.GetItemNumber(li_row, "width")
//	li_height = ldw.GetItemNumber(li_row, "height")
//	iu_cell_gui_component[li_i].width = ldw.GetItemNumber(li_row, "width")
//	iu_cell_gui_component[li_i].height = ldw.GetItemNumber(li_row, "height")
//	iu_cell_gui_component[li_i].ii_my_object_id = ll_object_id
//	iu_cell_gui_component[li_i].iu_react_container = this
//	string ls_resource_type
//	ll_resource_id = 0
//	ls_resource_type = ldw.GetItemString(li_row, "resource_type")
//	ls_object_type = ldw.GetItemString(li_row, "object_type")
//	if IsNull(ls_resource_type) then ls_resource_type = ""
//	
//	OpenUserObject (iu_cell_gui_component[li_i], iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y)	
//
//	if ls_resource_type = "image_raster" then
//		iu_cell_gui_component[li_i].of_create_control(ls_object_type, ls_object_type, iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y,li_width,li_height,"","")
//		ll_resource_id = ldw.GetItemNumber(li_row, "resource_id")
//		if IsNull(ll_resource_id) then ll_resource_id = 0
//		if ll_resource_id > 0 then
//			iu_cell_gui_component[li_i].of_retrieve_image(ll_resource_id)
//		end if
//	elseif ls_object_type = "MultiLineEdit" or ls_object_type = "SingleLineEdit" or ls_object_type = "StaticText" then
//		string ls_label
//		ll_select_clause_id = ldw.GetItemNumber(li_row, "select_clause_id")
//		if IsNull(ll_select_clause_id) then ll_select_clause_id = 0
//		if ll_select_clause_id > 0 then
////			DataWindowChild ldwc
////			integer li_find_row
//			if ldw.GetChild('select_clause_id', ldwc) > -1 then	
//				li_find_row = ldwc.find("id = " + string(ll_select_clause_id), 1, ldwc.RowCount())
//				if li_find_row > 0 then
//					ls_column_name = ldwc.GetItemString(li_find_row, "column_name")
//					ls_label = "db:" + ls_column_name
//				else
//					ls_label = "db:"
//				end if
//			end if
//			iu_cell_gui_component[li_i].of_create_control(ls_object_type, ls_label, iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y,li_width,li_height,ls_label,"")
//		else
//			ls_value = ldw.GetItemString(li_row, "value")
//			if IsNull(ls_value) then ls_value = ""
//			iu_cell_gui_component[li_i].of_create_control(ls_object_type, ls_value, iu_cell_gui_component[li_i].x,iu_cell_gui_component[li_i].y,li_width,li_height,ls_value,"")
//		end if
//	end if
//next

return 1


end function

public function integer of_update_cell_dimension ();integer li_x,li_y, li_width, li_height, li_flex_cell_id, li_gui_id
li_x = x
li_y = y
li_width = width
li_height = height
li_flex_cell_id = il_flex_cell_id
li_gui_id = gu_web_gui_template.il_current_gui_id
UPDATE Sys_Gui_Data_Mapping_Flex_Cell 
SET x = :li_x, y=:li_y, width=:li_width,height=:li_height
WHERE gui_id = :gu_web_gui_template.il_current_gui_id and flex_cell_id = :il_flex_cell_id;
commit;

return 1
end function

public function integer of_open_all ();integer li_count, li_box_index, li_x, li_y, li_count2, li_width,li_height, li_i
long ll_flex_cell_id
long ll_this_flex_cell_id
datastore lds_flex_cell 

ll_this_flex_cell_id = il_flex_cell_id
SELECT COUNT(*) INTO :li_count FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :gu_web_gui_template.il_current_gui_id and parent_id = :il_flex_cell_id;

if li_count = 0 then return 1

lds_flex_cell = create datastore
lds_flex_cell.DataObject = "d_gui_mapping_flex_cell_children"
lds_flex_cell.SetTransObject(SQLCA)

lds_flex_cell.Retrieve(gu_web_gui_template.il_current_gui_id, il_flex_cell_id)

if is_flexflow = "row" then
	lds_flex_cell.SetSort("y as")	
else
	lds_flex_cell.SetSort("x as")	
end if
lds_flex_cell.Sort()

// select the last non-children container as the current flex cell
for li_box_index = 1 to li_count
	iu_react_container_children[li_box_index] = create u_react_container
next

if is_flexFlow = "row" then // divide the container into ai_children children with equal height
	li_x = 0
	li_y = 0
	for li_box_index = 1 to lds_flex_cell.RowCount()
		li_x = lds_flex_cell.GetItemNumber(li_box_index, "x")
		li_y = lds_flex_cell.GetItemNumber(li_box_index, "y")		
		iu_react_container_children[li_box_index].width = lds_flex_cell.GetItemNumber(li_box_index, "width")
		iu_react_container_children[li_box_index].height = lds_flex_cell.GetItemNumber(li_box_index, "height")
		OpenUserObject ( iu_react_container_children[li_box_index], li_x,li_y)	
		ll_flex_cell_id = lds_flex_cell.GetItemNumber(li_box_index, "flex_cell_id")
		iu_react_container_children[li_box_index].il_parent_id = ll_this_flex_cell_id
		iu_react_container_children[li_box_index].il_flex_cell_id = ll_flex_cell_id	
		iu_react_container_children[li_box_index].is_flexflow = lds_flex_cell.GetItemString(li_box_index, "FlexFlow")
		iu_react_container_children[li_box_index].iu_parent = this
		iu_react_container_children[li_box_index].iu_gui_react_design = iu_gui_react_design
		
		if li_box_index < lds_flex_cell.RowCount() then			
			li_x = iu_react_container_children[li_box_index].x
			li_y = iu_react_container_children[li_box_index].y + iu_react_container_children[li_box_index].height
			this.OpenUserObject ( iuo_splitbar[li_box_index], li_x,li_y)			
			iuo_splitbar[li_box_index].width = iu_react_container_children[li_box_index].width
			iuo_splitbar[li_box_index].height = ii_split_bar_width
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].ABOVE)
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].BELOW)		
			iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
			iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]					
			iu_react_container_children[li_box_index].iuo_my_below = iuo_splitbar[li_box_index]
			iu_react_container_children[li_box_index+1].iuo_my_above = iuo_splitbar[li_box_index]		
		end if
		
		SELECT COUNT(*) INTO :li_count2 FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :gu_web_gui_template.il_current_gui_id and parent_id = :iu_react_container_children[li_box_index].il_flex_cell_id;
		if li_count2 > 0 then
			iu_react_container_children[li_box_index].of_open_all()			
		else
			iu_react_container_children[li_box_index].of_build_components()
		end if
		
	next
else  
	li_x = 0
	li_y = 0
	for li_box_index = 1 to lds_flex_cell.RowCount()
		li_x = lds_flex_cell.GetItemNumber(li_box_index, "x")
		li_y = lds_flex_cell.GetItemNumber(li_box_index, "y")
		iu_react_container_children[li_box_index].width = lds_flex_cell.GetItemNumber(li_box_index, "width")
		iu_react_container_children[li_box_index].height = lds_flex_cell.GetItemNumber(li_box_index, "height")
		OpenUserObject ( iu_react_container_children[li_box_index], li_x,li_y)	
		ll_flex_cell_id = lds_flex_cell.GetItemNumber(li_box_index, "flex_cell_id")
		iu_react_container_children[li_box_index].is_flexflow = lds_flex_cell.GetItemString(li_box_index, "FlexFlow")
		iu_react_container_children[li_box_index].il_flex_cell_id = ll_flex_cell_id	
		iu_react_container_children[li_box_index].il_parent_id = ll_this_flex_cell_id
				
		iu_react_container_children[li_box_index].iu_parent = this
		iu_react_container_children[li_box_index].iu_gui_react_design = iu_gui_react_design
		
		if li_box_index < lds_flex_cell.RowCount() then			
			li_x = iu_react_container_children[li_box_index].x + iu_react_container_children[li_box_index].width
			OpenUserObject (iuo_splitbar[li_box_index], li_x,li_y)
			iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
			iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]
			iuo_splitbar[li_box_index].BringToTop = true
			iuo_splitbar[li_box_index].width = ii_split_bar_width
			iuo_splitbar[li_box_index].height = height
			iuo_splitbar[li_box_index].of_set_style( iuo_splitbar[li_box_index].VERTICAL)
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].LEFT)
			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].RIGHT)
			iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
			iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]			
			iu_react_container_children[li_box_index].iuo_my_right = iuo_splitbar[li_box_index]
			iu_react_container_children[li_box_index+1].iuo_my_left = iuo_splitbar[li_box_index]
		end if
		SELECT COUNT(*) INTO :li_count2 FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :gu_web_gui_template.il_current_gui_id and parent_id = :iu_react_container_children[li_box_index].il_flex_cell_id;
		if li_count2 > 0 then
			iu_react_container_children[li_box_index].of_open_all()			
		else
			iu_react_container_children[li_box_index].of_build_components()
		end if
		
	next
end if	



//
//
//
//
//
//
//
//
//
//for li_box_index = 1 to li_count
//	iu_react_container_children[li_box_index] = create u_react_container	
//	iu_react_container_children[li_box_index].x = lds_flex_cell.GetItemNumber(li_box_index, "x")
//	iu_react_container_children[li_box_index].y = lds_flex_cell.GetItemNumber(li_box_index, "y")
//	iu_react_container_children[li_box_index].width = lds_flex_cell.GetItemNumber(li_box_index, "width")
//	iu_react_container_children[li_box_index].height = lds_flex_cell.GetItemNumber(li_box_index, "height")
////	iu_react_container_children[li_box_index].il_parent_id = lds_flex_cell.GetItemNumber(li_box_index, "parent_id")
//	iu_react_container_children[li_box_index].il_parent_id = ll_this_flex_cell_id
//	
//	ll_flex_cell_id = lds_flex_cell.GetItemNumber(li_box_index, "flex_cell_id")
//	
//	iu_react_container_children[li_box_index].il_flex_cell_id = ll_flex_cell_id
//	this.OpenUserObject ( iu_react_container_children[li_box_index], iu_react_container_children[li_box_index].x,iu_react_container_children[li_box_index].y)	
//	iu_react_container_children[li_box_index].iu_parent = this
//	iu_react_container_children[li_box_index].iu_gui_react_design = iu_gui_react_design
//
////	SELECT COUNT(*) INTO :li_count2 FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :gu_web_gui_template.il_current_gui_id and parent_id = :iu_react_container_children[li_box_index].il_flex_cell_id;
////	if li_count2 > 0 then
////		iu_react_container_children[li_box_index].of_open_all()			
////	else
////		iu_react_container_children[li_box_index].of_build_components()
////	end if
//next
//
////if li_count > 0 then
////	if is_flexflow = "row" then // vertical splitting
////		if IsValid(iuo_my_above) then
////			iuo_my_above.of_Register(iu_react_container_children[1],iuo_my_above.BELOW)	
////		end if
////		if IsValid(iuo_my_below) then
//////			MessageBox("IsValid(iuo_my_below)", "iuo_my_below.of_Register(iu_react_container_children[li_count],iuo_my_below.ABOVE)")	
////			iuo_my_below.of_Register(iu_react_container_children[li_count],iuo_my_below.ABOVE)	
////		end if
////		if IsValid(iuo_my_left) then
////			for li_i = 1 to li_count
////				iuo_my_left.of_Register(iu_react_container_children[li_i],iuo_my_left.RIGHT)		
////				if li_i < li_count then
////					iuo_my_left.of_Register(iuo_splitbar[li_i], iuo_my_left.RIGHT)
////				end if
////				iuo_my_left.of_set_style(iuo_my_left.VERTICAL)
////			next
////		end if		
////		if IsValid(iuo_my_right) then
////			for li_i = 1 to li_count
////				iuo_my_right.of_Register(iu_react_container_children[li_i],iuo_my_right.LEFT)		
////				if li_i < li_count then
////					if li_i <= upperbound(iuo_splitbar) then
////						iuo_my_right.of_Register(iuo_splitbar[li_i], iuo_my_right.LEFT)
////					end if
////				end if
////				iuo_my_right.of_set_style(iuo_my_right.VERTICAL)
////			next
////		end if		
////	else	// horizontal splitting
////		if IsValid(iuo_my_left) then
////			iuo_my_left.of_Register(iu_react_container_children[1],iuo_my_left.RIGHT)	
////		end if
////		if IsValid(iuo_my_right) then
////			iuo_my_right.of_Register(iu_react_container_children[li_count],iuo_my_right.LEFT)	
////		end if				
////		
////		if IsValid(iuo_my_above) then
////			for li_i = 1 to li_count
////				iuo_my_above.of_Register(iu_react_container_children[li_i],iuo_my_above.BELOW)		
////				if li_i < li_count then
////					iuo_my_above.of_Register(iuo_splitbar[li_i], iuo_my_above.BELOW)
////				end if
////			next
////		end if		
////		if IsValid(iuo_my_below) then
////			for li_i = 1 to li_count
////				iuo_my_below.of_Register(iu_react_container_children[li_i],iuo_my_below.ABOVE)		
////				if li_i < li_count then
////					iuo_my_below.of_Register(iuo_splitbar[li_i], iuo_my_below.ABOVE)
////				end if
////			next
////		end if		
////	end if
////end if		
//
//for li_box_index = 1 to li_count
//	if li_box_index < li_count then
//		if is_flexflow = "row" then
//			li_x = iu_react_container_children[li_box_index].x
//			li_y = iu_react_container_children[li_box_index].y + iu_react_container_children[li_box_index].height
//			this.OpenUserObject ( iuo_splitbar[li_box_index], li_x,li_y)			
//			iuo_splitbar[li_box_index].width = iu_react_container_children[li_box_index].width
//			iuo_splitbar[li_box_index].height = ii_split_bar_width
//			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].ABOVE)
//			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].BELOW)			
//			iu_react_container_children[li_box_index].iuo_my_below = iuo_splitbar[li_box_index]
//			iu_react_container_children[li_box_index+1].iuo_my_above = iuo_splitbar[li_box_index]		
//		else
//			li_x = iu_react_container_children[li_box_index].x + iu_react_container_children[li_box_index].width
//			li_y = iu_react_container_children[li_box_index].y 
//			li_width = ii_split_bar_width
//			li_height = iu_react_container_children[li_box_index].height
//			this.OpenUserObject ( iuo_splitbar[li_box_index], li_x,li_y)
//			iuo_splitbar[li_box_index].height = iu_react_container_children[li_box_index].height
//			iuo_splitbar[li_box_index].width = ii_split_bar_width
//			iuo_splitbar[li_box_index].of_set_style( iuo_splitbar[li_box_index].VERTICAL)
//			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index],iuo_splitbar[li_box_index].LEFT)
//			iuo_splitbar[li_box_index].of_Register(iu_react_container_children[li_box_index+1],iuo_splitbar[li_box_index].RIGHT)
//			iu_react_container_children[li_box_index].iuo_my_right = iuo_splitbar[li_box_index]
//			iu_react_container_children[li_box_index+1].iuo_my_left = iuo_splitbar[li_box_index]
//		end if
//		iuo_splitbar[li_box_index].iu_react_container1 = iu_react_container_children[li_box_index]
//		iuo_splitbar[li_box_index].iu_react_container2 = iu_react_container_children[li_box_index+1]
//		iuo_splitbar[li_box_index].BringToTop = true
//		iuo_splitbar[li_box_index].visible = true		
//	end if
//	
//	SELECT COUNT(*) INTO :li_count2 FROM Sys_Gui_Data_Mapping_Flex_Cell WHERE gui_id = :gu_web_gui_template.il_current_gui_id and parent_id = :iu_react_container_children[li_box_index].il_flex_cell_id;
//	if li_count2 > 0 then
//		iu_react_container_children[li_box_index].of_open_all()			
//	else
//		iu_react_container_children[li_box_index].of_build_components()
//	end if
//	
//next
//

destroy lds_flex_cell
		
return 1


end function

public function integer of_propogate_splitter_position (readonly any aa_splitter_bar);integer li_total_height, li_total_width, li_delta
integer li_i, li_count
li_count = upperbound(iu_react_container_children)
if li_count = 0 then return 0
uo_st_splitbar_container luo_the_splitter_bar
luo_the_splitter_bar = aa_splitter_bar

if luo_the_splitter_bar = iuo_my_left then 
	if  is_flexflow = "row" then // width of all rows will be impacted
		li_delta = iu_react_container_children[1].width - width
		for li_i = 1 to li_count
			iu_react_container_children[li_i].width = iu_react_container_children[li_i].width - li_delta
			if li_i < li_count then iuo_splitbar[li_i].width = iuo_splitbar[li_i].width - li_delta
		next
	else // is_flexflow = "column",  the first column width and x of other columns impacted
		li_total_width = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_width = li_total_width + iu_react_container_children[li_i].width
		next
		li_delta = li_total_width - width
		iu_react_container_children[1].width = iu_react_container_children[1].width - li_delta
		for li_i = 2 to (li_count)
			iu_react_container_children[li_i].x = iu_react_container_children[li_i].x - li_delta
			iuo_splitbar[li_i - 1].x = iuo_splitbar[li_i - 1].x - li_delta
		next	
	end if
elseif luo_the_splitter_bar = iuo_my_right then 
	if  is_flexflow = "row" then // width of all rows will be impacted
		li_delta = iu_react_container_children[1].width - width
		for li_i = 1 to li_count
			iu_react_container_children[li_i].width = iu_react_container_children[li_i].width - li_delta
			if li_i < li_count then iuo_splitbar[li_i].width = iuo_splitbar[li_i].width - li_delta
		next
	else // is_flexflow = "column", only the last column width impacted
		li_total_width = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_width = li_total_width + iu_react_container_children[li_i].width
		next
		li_delta = li_total_width - width
		iu_react_container_children[li_count].width = iu_react_container_children[li_count].width - li_delta
				
//		for li_i = 1 to (li_count - 1)
//			iu_react_container_children[li_i].y = iu_react_container_children[li_i].y - li_delta
//		next
		 
	end if
elseif luo_the_splitter_bar = iuo_my_above then 
	if  is_flexflow = "row" then // the height of fist row and y of other rows will be impacted
		li_total_height = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_height = li_total_height + iu_react_container_children[li_i].height
		next
		li_delta = li_total_height - height
		iu_react_container_children[1].height = iu_react_container_children[1].height - li_delta
		for li_i = 2 to (li_count)
			iu_react_container_children[li_i].y = iu_react_container_children[li_i].y - li_delta
			iuo_splitbar[li_i - 1].y = iuo_splitbar[li_i - 1].y - li_delta		
		next
	else	// is_flexflow = "column", heights of all columns and splitter bars will be impacted
		li_delta = iu_react_container_children[1].height - height
		for li_i = 1 to li_count
			iu_react_container_children[li_i].height = iu_react_container_children[li_i].height - li_delta
			if li_i < li_count then iuo_splitbar[li_i].height = iuo_splitbar[li_i].height - li_delta
		next
	end if
elseif luo_the_splitter_bar = iuo_my_below then 
	if  is_flexflow = "row" then // only the height of the last row will be impacted
		li_total_height = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_height = li_total_height + iu_react_container_children[li_i].height
		next
		li_delta = li_total_height - height
		iu_react_container_children[li_count].height = iu_react_container_children[li_count].height - li_delta
	else	// is_flexflow = "column", heights of all columns and splitter bars will be impacted
		li_delta = iu_react_container_children[1].height - height
		for li_i = 1 to li_count
			iu_react_container_children[li_i].height = iu_react_container_children[li_i].height - li_delta
			if li_i < li_count then iuo_splitbar[li_i].height = iuo_splitbar[li_i].height - li_delta
		next
	end if		
end if		

//for li_i = 1 to upperbound(iuo_splitbar)
//	if IsValid(iuo_splitbar[li_i]) then
//		if IsValid(iuo_splitbar[li_i].iu_react_container1) then iuo_splitbar[li_i].iu_react_container1.of_propogate_splitter_position(iuo_splitbar[li_i])
//		if IsValid(iuo_splitbar[li_i].iu_react_container2) then iuo_splitbar[li_i].iu_react_container2.of_propogate_splitter_position(iuo_splitbar[li_i])
//	end if
//next

//for li_i = 1 to upperbound(iu_react_container_children)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_left)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_right)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_above)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_below)	
//next

return 1
end function

public function integer of_update_children_dimension (integer ai_splitter_bar_position);integer li_total_height, li_total_width, li_delta
integer li_i, li_count
li_count = upperbound(iu_react_container_children)

of_update_cell_dimension()

if li_count = 0 then return 0


if ai_splitter_bar_position = RESIZE_FROM_LEFT then 
	if  is_flexflow = "row" then // width of all rows will be impacted
		li_delta = iu_react_container_children[1].width - width
		for li_i = 1 to li_count
			iu_react_container_children[li_i].width = iu_react_container_children[li_i].width - li_delta
			if li_i < li_count then iuo_splitbar[li_i].width = iuo_splitbar[li_i].width - li_delta
			iu_react_container_children[li_i].of_update_children_dimension(RESIZE_FROM_LEFT)
		next		
	else // is_flexflow = "column",  the first column width and x of other columns impacted
		li_total_width = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_width = li_total_width + iu_react_container_children[li_i].width
		next
		li_delta = li_total_width - width
		iu_react_container_children[1].width = iu_react_container_children[1].width - li_delta
		iu_react_container_children[1].of_update_children_dimension(RESIZE_FROM_LEFT) 
		// I THINK NO RESIZE NEEDED FOR OTHER CHILDREN'S CHILDREN
		for li_i = 2 to (li_count)
			iu_react_container_children[li_i].x = iu_react_container_children[li_i].x - li_delta
			iuo_splitbar[li_i - 1].x = iuo_splitbar[li_i - 1].x - li_delta
		next	
	end if
elseif ai_splitter_bar_position = RESIZE_FROM_RIGHT then 
	if  is_flexflow = "row" then // width of all rows will be impacted
		li_delta = iu_react_container_children[1].width - width
		for li_i = 1 to li_count
			iu_react_container_children[li_i].width = iu_react_container_children[li_i].width - li_delta
			if li_i < li_count then iuo_splitbar[li_i].width = iuo_splitbar[li_i].width - li_delta
			iu_react_container_children[li_i].of_update_children_dimension(RESIZE_FROM_RIGHT)			
		next
	else // is_flexflow = "column", only the last column width impacted
		li_total_width = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_width = li_total_width + iu_react_container_children[li_i].width
		next
		li_delta = li_total_width - width
		iu_react_container_children[li_count].width = iu_react_container_children[li_count].width - li_delta
		iu_react_container_children[li_count].of_update_children_dimension(RESIZE_FROM_RIGHT) 
		// I THINK NO RESIZE NEEDED FOR OTHER CHILDREN'S CHILDREN					 
	end if
elseif ai_splitter_bar_position = RESIZE_FROM_ABOVE then 
	if  is_flexflow = "row" then // the height of fist row and y of other rows will be impacted
		li_total_height = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_height = li_total_height + iu_react_container_children[li_i].height
		next
		li_delta = li_total_height - height
		iu_react_container_children[1].height = iu_react_container_children[1].height - li_delta
		iu_react_container_children[1].of_update_children_dimension(RESIZE_FROM_ABOVE)
		for li_i = 2 to (li_count)
			iu_react_container_children[li_i].y = iu_react_container_children[li_i].y - li_delta
			iuo_splitbar[li_i - 1].y = iuo_splitbar[li_i - 1].y - li_delta		
		next
	else	// is_flexflow = "column", heights of all columns and splitter bars will be impacted
		li_delta = iu_react_container_children[1].height - height
		for li_i = 1 to li_count
			iu_react_container_children[li_i].height = iu_react_container_children[li_i].height - li_delta
			if li_i < li_count then iuo_splitbar[li_i].height = iuo_splitbar[li_i].height - li_delta
			iu_react_container_children[li_i].of_update_children_dimension(RESIZE_FROM_ABOVE)	
		next
	end if
elseif ai_splitter_bar_position = RESIZE_FROM_BELOW then 
	if  is_flexflow = "row" then // only the height of the last row will be impacted
		li_total_height = ii_split_bar_width*(li_count - 1)
		for li_i = 1 to li_count
			li_total_height = li_total_height + iu_react_container_children[li_i].height
		next
		li_delta = li_total_height - height
		iu_react_container_children[li_count].height = iu_react_container_children[li_count].height - li_delta
		iu_react_container_children[li_count].of_update_children_dimension(RESIZE_FROM_BELOW)	
	else	// is_flexflow = "column", heights of all columns and splitter bars will be impacted
		li_delta = iu_react_container_children[1].height - height
		for li_i = 1 to li_count
			iu_react_container_children[li_i].height = iu_react_container_children[li_i].height - li_delta
			if li_i < li_count then iuo_splitbar[li_i].height = iuo_splitbar[li_i].height - li_delta
			iu_react_container_children[li_i].of_update_children_dimension(RESIZE_FROM_BELOW)	
		next
	end if		
end if		

//if IsValid(iu_react_container1) then iu_react_container1.post of_update_cell_dimension()
//if IsValid(iu_react_container2) then iu_react_container2.post of_update_cell_dimension()
for li_i = 1 to li_count
	iu_react_container_children[li_i].of_update_cell_dimension()
next


//for li_i = 1 to upperbound(iuo_splitbar)
//	if IsValid(iuo_splitbar[li_i]) then
//		if IsValid(iuo_splitbar[li_i].iu_react_container1) then iuo_splitbar[li_i].iu_react_container1.of_propogate_splitter_position(iuo_splitbar[li_i])
//		if IsValid(iuo_splitbar[li_i].iu_react_container2) then iuo_splitbar[li_i].iu_react_container2.of_propogate_splitter_position(iuo_splitbar[li_i])
//	end if
//next
//
//for li_i = 1 to upperbound(iu_react_container_children)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_left)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_right)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_above)
//	if IsValid(iuo_my_left) then	iu_react_container_children[li_i].of_propogate_splitter_position(iuo_my_below)	
//next

return 1

end function

on u_react_container.create
this.st_select_column_name=create st_select_column_name
this.cb_webkit=create cb_webkit
this.cb_show_web_page=create cb_show_web_page
this.sle_1=create sle_1
this.mle_note=create mle_note
this.p_1=create p_1
this.cb_html2=create cb_html2
this.pb_minimized=create pb_minimized
this.dw_attribute=create dw_attribute
this.oleobject_2=create oleobject_2
this.oleobject_1=create oleobject_1
this.Control[]={this.st_select_column_name,&
this.cb_webkit,&
this.cb_show_web_page,&
this.sle_1,&
this.mle_note,&
this.p_1,&
this.cb_html2,&
this.pb_minimized,&
this.dw_attribute}
end on

on u_react_container.destroy
destroy(this.st_select_column_name)
destroy(this.cb_webkit)
destroy(this.cb_show_web_page)
destroy(this.sle_1)
destroy(this.mle_note)
destroy(this.p_1)
destroy(this.cb_html2)
destroy(this.pb_minimized)
destroy(this.dw_attribute)
destroy(this.oleobject_2)
destroy(this.oleobject_1)
end on

event constructor;//datastore ids_flex_cell 
//datastore ids_flex_cell_object 

//ids_flex_cell = create datastore
//ids_flex_cell.DataObject = "d_gui_mapping_flex_cell"
//
//ids_flex_cell_object = create datastore
//ids_flex_cell_object.DataObject = "d_gui_mapping_flex_cell_object"
//
//ids_flex_cell.SetTransObject(SQLCA)
//ids_flex_cell_object.SetTransObject(SQLCA)


//ilbuttondown = false

end event

event destructor;//cb_close.event clicked()

//if IsValid(ids_page_layout) then destroy ids_page_layout
//if IsValid(ids_page_layout_html) then destroy ids_page_layout_html
//

integer li_i

for li_i =  1 to upperbound(iu_react_container_children)
	if IsValid(iu_react_container_children[li_i]) then destroy iu_react_container_children[li_i]
next
for li_i =  1 to upperbound(iuo_splitbar)
	if IsValid(iuo_splitbar[li_i]) then destroy iuo_splitbar[li_i]
next

for li_i =  1 to upperbound(iu_cell_gui_component)
	if IsValid(iu_cell_gui_component[li_i]) then destroy iu_cell_gui_component[li_i]
next

end event

event rbuttondown;//component_popup_menu pm
//
//pm = create component_popup_menu
//gu_react_container = this // NOT CHANGED YET
//if flags <> 1 then // not from icon
//	pm.m_increaseiconwidth.visible = false
//	pm.m_decreateiconwidth.visible = false
//	pm.m_increaseiconheight.visible = false
//	pm.m_decreateiconheight.visible = false
//end if		// from the container
//pm.PopMenu(gn_appman.iw_frame.PointerX() - 800, gn_appman.iw_frame.PointerY() - 50)
//destroy pm

return 1
end event

type st_select_column_name from statictext within u_react_container
boolean visible = false
integer width = 562
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "select_column_name"
boolean focusrectangle = false
end type

type cb_webkit from commandbutton within u_react_container
event mousemove pbm_mousemove
boolean visible = false
integer x = 2510
integer y = 16
integer width = 87
integer height = 76
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "W"
end type

event clicked;//OpenUserObject(iu_webkitativex, 250,250)	
end event

type cb_show_web_page from commandbutton within u_react_container
boolean visible = false
integer x = 2688
integer y = 984
integer width = 494
integer height = 120
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Show Web Page"
end type

event clicked;//ole_1.object.Navigate( sle_1.text )
end event

type sle_1 from singlelineedit within u_react_container
boolean visible = false
integer x = 2638
integer y = 724
integer width = 654
integer height = 156
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type mle_note from multilineedit within u_react_container
event mousemove pbm_mousemove
boolean visible = false
integer x = 1349
integer y = 108
integer width = 1298
integer height = 572
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within u_react_container
event lbuttondown pbm_lbuttondown
event mousemove pbm_mousemove
event ue_rbuttondown pbm_rbuttondown
boolean visible = false
integer x = 14
integer y = 108
integer width = 1266
integer height = 572
boolean originalsize = true
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event lbuttondown;//ixpos_pic = xpos
//iypos_pic = ypos
//idx_pic = width - xpos
//idy_pic = height - ypos
//if idx_pic<50 and idy_pic< 50 then // resize the module
//	ib_picture_resize = true
//else
//	ib_picture_resize = false
//end if
//
//
////ilbuttondown = true
//parent.ixpos = xpos + x
//parent.iypos = ypos + y
////mle_1.text ="keydown"

end event

event mousemove;//long dx = 0,dy=0
//If KeyDown(keyLeftButton!) Then
//	if ib_picture_resize then // resize the module
//		width = xpos + idx_pic
//		height = ypos + idy_pic
//		il_layout_width = width
//		il_layout_height = height
//	else
//		parent.event mousemove(0, x + xpos, y + ypos)
//	end if
//end if
end event

event ue_rbuttondown;parent.event rbuttondown(1, xpos, ypos)
end event

event doubleclicked;//if iu_parent <> iu_layout_page then
//	if p_1.y > 80 then // change to full icon
//		dw_attribute.visible = false
//		mle_html_script.visible = false
//		mle_inner_html.visible = false
//		mle_java_script.visible = false
//		mle_css_script.visible = false
//		mle_note.visible = false
//		dw_attribute.visible = false
//		pb_maximized.visible = false
////		pb_minimized.visible = false
//		cb_fresh_script.visible = false
//		cb_add.visible = false
//		cb_close.visible = false
//		cb_picture_browse.visible = false
//		cb_picture.visible = false
//		cb_css.visible = false
//		cb_java.visible = false
//		cb_html.visible = false
//		cbx_show.visible = false
//		cb_fresh_script.visible = false
//		r_1.visible = false
//		p_1.y = 1
//		p_1.visible = true
//	else // change to  datawindow view
//		dw_attribute.visible = true
//		mle_html_script.visible = true
//		mle_inner_html.visible = true
//		mle_java_script.visible = true
//		mle_css_script.visible = true
//		mle_note.visible = true
//		pb_maximized.visible = true
////		pb_minimized.visible = true
//		cb_fresh_script.visible = true
//		cb_add.visible = true
//		cb_close.visible = true
//		cb_picture_browse.visible = true
//		cb_picture.visible = true
//		cb_css.visible = true
//		cb_java.visible = true
//		cb_html.visible = true
//		cbx_show.visible = true
//		cb_fresh_script.visible = true	
//		p_1.y = 110 
//		r_1.visible = true		
//		p_1.visible = false
//		if upperbound(iu_react_container) = 0 then
//			width = p_1.x + p_1.width + 100
//			height = p_1.y + p_1.height + 100
//			il_layout_width = width
//			il_layout_height = height
//		end if
//	end if
//end if
end event

type cb_html2 from commandbutton within u_react_container
event mousemove pbm_mousemove
boolean visible = false
integer x = 2779
integer y = 260
integer width = 137
integer height = 76
boolean dragauto = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "html"
boolean flatstyle = true
end type

event mousemove;//if not KeyDown(keyLeftButton!) then
//	iu_layout_page.sle_1.text = "Display html editor"
//end if
end event

event clicked;//cb_html.FlatStyle = true
//cb_java.FlatStyle = false
//cb_css.FlatStyle = false
//cb_note.FlatStyle = false
//
////cb_html.Enabled = false
//cb_java.Enabled = true
//cb_css.Enabled = true
//cb_note.Enabled = true
//
//mle_html_script.visible = true
//rte_html_script.visible = true

//mle_inner_html.visible = true
//
//mle_java_script.visible = false
////rte_java_script.visible = false
//
//mle_css_script.visible = false
////rte_css_script.visible = false
//
//mle_note.visible = false
//
//
//if mle_html_script.VScrollBar then // back to standard mode
//	mle_html_script.VScrollBar = false
//	mle_html_script.HScrollBar = false
//	mle_html_script.x = il_original_mle_html_x
////	y = mle_inner_html.y
//	mle_html_script.width = il_original_mle_html_width
//	mle_html_script.height = il_original_mle_html_height
//else
//	mle_html_script.VScrollBar = true
//	mle_html_script.HScrollBar = true
//	mle_html_script.x = 10
//	mle_html_script.BringToTop = true
//	mle_html_script.width = 4500
//	mle_html_script.height = 2200
//end if
//

end event

type pb_minimized from picturebutton within u_react_container
event mousemove pbm_mousemove
boolean visible = false
integer x = 2537
integer y = 20
integer width = 78
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Custom036!"
alignment htextalign = left!
end type

event mousemove;//if not KeyDown(keyLeftButton!) then
//	iu_layout_page.sle_1.text = "Minimize to the area only of attribute editor"
//end if
end event

event clicked;//if iu_parent = parent then return
//
////if istr_tv_page_layout.parent_id = 0 then return
//
//parent.width = 1317
//parent.height = 755
//
//r_1.width = parent.width - 20

end event

type dw_attribute from u_datawindow within u_react_container
boolean visible = false
integer x = 14
integer y = 108
integer width = 2647
integer height = 576
integer taborder = 20
string dataobject = "d_page_component_layout_attribute"
boolean vscrollbar = true
end type

event clicked;call super::clicked;long ll_row, il_status

string ls_column_name
ls_column_name = dwo.name
il_current_row = row
if ls_column_name = "b_delete" then
	if il_current_row > 0 then
//		il_status = MessageBox("Warning", "Do you want to delete the selected item", Question!, YesNo!)
		if il_status = 2 then
			return
		end if
		dw_attribute.DeleteRow(il_current_row)
		if dw_attribute.Update() = -1 then
			if SQLCA.sqlcode <> 0 then
				f_log_error(dw_attribute.dataobject, SQLCA.sqlcode, SQLCA.sqldbcode, SQLCA.sqlerrtext,"")
				MessageBox("Error", "Fail to save!")
				rollback;
				return
			end if
			return
		else
			commit;
		end if	
	else
		return
	end if		
end if		

end event

type oleobject_2 from oleobject within u_react_container descriptor "pb_nvo" = "true" 
end type

on oleobject_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

type oleobject_1 from oleobject within u_react_container descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

