$PBExportHeader$w_internet_lh_mdi.srw
$PBExportComments$Ancestor for all MDI frames - LM
forward
global type w_internet_lh_mdi from window
end type
type mdi_1 from mdiclient within w_internet_lh_mdi
end type
type tab_1 from tab within w_internet_lh_mdi
end type
type tab_1 from tab within w_internet_lh_mdi
end type
end forward

global type w_internet_lh_mdi from window
string tag = "1000000"
integer width = 4503
integer height = 2764
boolean titlebar = true
string title = "Learning Helper (Internet Version)"
string menuname = "m_internet_lh_mdi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 276856960
string icon = "LearningHelper.ico"
event ue_setmenu pbm_custom02
event ue_closeall pbm_custom10
event ue_settoolbar ( )
event paint pbm_paint
mdi_1 mdi_1
tab_1 tab_1
end type
global w_internet_lh_mdi w_internet_lh_mdi

type variables
int ii_timer_entry_level=0
int gf_timer=60
int crdrsk_timer=60
long il_min=0, il_interval=10,il_old_rows=0


end variables

forward prototypes
public subroutine wf_remove_from_tab (ref window a_window)
public subroutine wf_resizing ()
public subroutine wf_open_status_window ()
public subroutine wf_database_upgrading ()
public subroutine wf_add_to_tab (ref window a_window, long a_handle)
end prototypes

event ue_setmenu;////////////////////////////////////////////////////////////////////////////////
//
//    This script is invoked by the open event of this window. The Purpose is
//		to receive an array of module ids, and the menu to be secured.
//    This script enables the menu items corresponding to the array of passed
//		modules.
//
////////////////////////////////////////////////////////////////////////////////

//int i, 		li_ret_val
//string 		ls_module_id[]
//character 	c_process_code
////
//// process code 'O' retrieves all the applications and modules for a given role id
////
//DataStore ds_info
//
//ds_info = CREATE DataStore
//ds_info.DataObject = "d_gensheng_1"
//ds_info.SetTransObject(SQLCA)
//ds_info.Retrieve(g_str_user.s_user_role_id)
//
//for i=1 to ds_info.rowcount()
//	ls_module_id[i] = ds_info.getitemstring(i,"epic_module_module_id")	
//next
//
//c_process_code = 'O'
//if (f_set_menu_options(ls_module_id[], This.Menuid)) = 1 Then
//	Return
//end if
//
return

end event

event ue_closeall;//gf_close_sheets(w_cran_main_mdi)

end event

event ue_settoolbar;//Added by James
	//tbd
//		if fileexists('c:/epicbar.ini') then 
//			gf_save_bar(menuid)	
//			FileDelete('c:/epicbar.ini')
//		end if
	//tbd

//uo_datastore lds_epic_toolbar
//lds_epic_toolbar = create uo_datastore
//lds_epic_toolbar.dataobject='d_cran_toolbar'
//lds_epic_toolbar.settransobject(sqlca)
//lds_epic_toolbar.retrieve(SQLCA.LogID)
//toolbarvisible = (gf_restore_toolbar(menuid,lds_epic_toolbar) > 0)
//destroy lds_epic_toolbar
//

end event

event paint;string ls_bitmap
long ll_handle
ll_handle = handle(mdi_1)
ls_bitmap = ".\background_1.bmp"
//post loadgraph (ll_handle, ls_bitmap)

end event

public subroutine wf_remove_from_tab (ref window a_window);long ll_i

uo_fram_control_tabpage luo_tabpage
for ll_i = 1 to upperbound(tab_1.control)
	if isvalid(tab_1.control[ll_i]) then
		if tab_1.control[ll_i].tag = a_window.ClassName() then
			luo_tabpage = tab_1.control[ll_i]
			tab_1.CloseTab(luo_tabpage)
			destroy luo_tabpage
		end if
	end if
next

end subroutine

public subroutine wf_resizing ();long dw_height=0


mdi_1.x=workspaceX()
mdi_1.y=workspaceY()
mdi_1.width=workspacewidth()
mdi_1.height=workspaceheight() - mdi_1.microhelpheight

tab_1.x = workspaceX() 
tab_1.y = mdi_1.y + mdi_1.height - 100
tab_1.width = this.workspacewidth()
tab_1.height = 100

if tab_1.visible then

	mdi_1.height=mdi_1.height - tab_1.height 


end if


end subroutine

public subroutine wf_open_status_window ();//Open(gnvo_is.iw_status, "w_status")

end subroutine

public subroutine wf_database_upgrading ();long ll_count
// upgrade method ID for the four method type
//select count(*) into :ll_count from method where description = 'Unscramble Words';
//if ll_count = 0 then
//	insert into method (method_id,description) values (21, 'Unscramble Words');
//end if
//
//select count(*) into :ll_count from method where description = 'Unscramble Sentences';
//if ll_count = 0 then
//	insert into method (method_id,description) values (22, 'Unscramble Sentences');
//end if
//
//select count(*) into :ll_count from method where description = 'Addition';
//if ll_count = 0 then
//	insert into method (method_id,description) values (23, 'Addition');
//end if
//
//select count(*) into :ll_count from method where description = 'Subtraction';
//if ll_count = 0 then
//	insert into method (method_id,description) values (24, 'Subtraction');
//end if

//select count(*) into :ll_count from method where description = 'Grouping';
//if ll_count = 0 then
//	update method set description = 'Grouping' where method_id = 16;
//end if
//select count(*) into :ll_count from method where description = 'Matching';
//if ll_count = 0 then
//	insert into method (method_id,description) values (25, 'Matching');
//end if
//
//commit;
end subroutine

public subroutine wf_add_to_tab (ref window a_window, long a_handle);string ls_name, ls_title
long ll_i
uo_fram_control_tabpage luo_tabpage
luo_tabpage = create uo_fram_control_tabpage

ls_name = a_window.ClassName()
ls_title = a_window.title


for ll_i = 1 to upperbound(tab_1.control) 
	if isvalid(tab_1.control[ll_i]) then
		if ls_name = tab_1.control[ll_i].tag then
			return
		end if
	end if
next
tab_1.OpenTab(luo_tabpage, 0)
tab_1.Control[upperbound(tab_1.control)].text = ls_title
tab_1.Control[upperbound(tab_1.control)].tag = ls_name


end subroutine

event timer;// Check to see if the GF and CRDRSK data has been received.

end event

event open;integer li_count
//any la_parm
//long ll_current_reward_program_id
//string ls_dbname
//boolean lb_reward_program = false
//m_internet_lh_mdi lm_mdi
//gn_appman.Of_Get_Parm("dbname", la_parm)
//ls_dbname = la_parm
//lm_mdi = menuid
//ToolBarVisible = false
//if gn_appman.ib_trial_version then
//	title = title + " - Demo/Trial Version"
//end if
//if ls_dbname <> "" then title = ls_dbname
//	
//wf_database_upgrading()
//select current_id into :ll_current_reward_program_id
//from system_parms where parm_name = 'REWARD_PROGRAM';
//if ll_current_reward_program_id > 0  then
//	select count(*) into :li_count
//	from reward_program_content where reward_program_id = :ll_current_reward_program_id;
//	if li_count > 0 then
//		gb_money_board_on = true
//		lb_reward_program = true
//		lm_mdi.m_tools.m_moneyboard.checked = true
//	end if
//end if
//
//if not lb_reward_program then
//	gb_money_board_on = false
//	lm_mdi.m_tools.m_moneyboard.checked = false
//end if

// lesson license
if gn_appman.ib_home_version then
	// lesson setup
//	lm_mdi.m_applications.m_lessonpreparation.m_discretetrial0.enabled = &
//		fnGetLicenseBit(1, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation.m_comparison.enabled = &
//		fnGetLicenseBit(2, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation.m_counting0.enabled = &
//		fnGetLicenseBit(3, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation.m_grouping.enabled = &
//		fnGetLicenseBit(4, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation.m_unscramblewords.enabled = &
//		fnGetLicenseBit(6, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation.m_unscramblesentences.enabled = &
//		fnGetLicenseBit(7, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation.m_matching.enabled = &
//		fnGetLicenseBit(8, gn_appman.iu_home_license_num) = 1
//	// lesson type
//	lm_mdi.m_applications.m_lessonpreparation0.m_0.enabled = &
//		fnGetLicenseBit(1, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_1.enabled = &
//		fnGetLicenseBit(2, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_counting.enabled = &
//		fnGetLicenseBit(3, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_grouping0.enabled = &
//		fnGetLicenseBit(4, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_reading.enabled = &
//		fnGetLicenseBit(5, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_unscrambleword.enabled = &
//		fnGetLicenseBit(6, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_unscramblesentence.enabled = &
//		fnGetLicenseBit(7, gn_appman.iu_home_license_num) = 1
//	lm_mdi.m_applications.m_lessonpreparation0.m_matching0.enabled = &
//		fnGetLicenseBit(8, gn_appman.iu_home_license_num) = 1
end if

//if gn_appman.ii_site_license_num >= 10 then
//	lm_mdi.m_tools.m_export.visible = true
//	lm_mdi.m_tools.m_import.visible = true
//	lm_mdi.m_report.m_importreport.visible = true
//else
//	lm_mdi.m_tools.m_export.visible = false
//	lm_mdi.m_tools.m_import.visible = false
//	lm_mdi.m_report.m_importreport.visible = false
//end if	

// signup window - for exhibition only
//if	ProfileString (is_startupfile, "application_setup", "signup_window_on", "") = "yes" then
//	lm_mdi.m_help.m_2.visible = true
//	lm_mdi.m_help.m_7.visible = true
//	lm_mdi.m_help.m_8.visible = true
//	lm_mdi.m_tools.m_learninghelperexhibtryout.visible = true
//	lm_mdi.m_tools.m_learninghelperdemo.visible = false	
//	lm_mdi.m_help.m_8.checked = true
//	gb_signup_on = true
//else
//	lm_mdi.m_help.m_2.visible = false
//	lm_mdi.m_help.m_7.visible = false
//	lm_mdi.m_help.m_8.visible = false
//	lm_mdi.m_tools.m_learninghelperexhibtryout.visible = false
//	lm_mdi.m_tools.m_learninghelperdemo.visible = true
//	gb_signup_on = false
//end if
//if	ProfileString (is_startupfile, "application_setup", "comm_board_off", "") = "yes" then
//	lm_mdi.m_internet.m_communicationboard.visible = false
//end if

This.ArrangeSheets(Icons!)
//if gb_auto_open then
//	OpenSheetWithParm(w_lesson_program, "w_lesson_program", gn_appman.iw_frame, 0, original!)
//end if

tab_1.visible = false


end event

event resize;wf_resizing()
end event

event ue_move;This.ArrangeSheets(Icons!)
wf_resizing()

end event

on w_internet_lh_mdi.create
if this.MenuName = "m_internet_lh_mdi" then this.MenuID = create m_internet_lh_mdi
this.mdi_1=create mdi_1
this.tab_1=create tab_1
this.Control[]={this.mdi_1,&
this.tab_1}
end on

on w_internet_lh_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.tab_1)
end on

event close;//if isvalid(gw_money_board) then
//	close(gw_money_board)
//end if
//
//if isvalid(gnvo_is.iw_demo_selection) then
//	close(gnvo_is.iw_demo_selection)
//end if
end event

event key;long ll_count
//if KeyDown(KeyControl!) and KeyDown(KeyAlt!) and KeyDown(KeyZ!) then
//	open(w_training_login)
//end if

end event

type mdi_1 from mdiclient within w_internet_lh_mdi
long BackColor=276856960
end type

event paint;string ls_bitmap
long ll_handle
ll_handle = handle(mdi_1)
//ls_bitmap = ".\background_1.bmp"
//post loadgraph (ll_handle, ls_bitmap)

end event

type tab_1 from tab within w_internet_lh_mdi
integer x = 215
integer y = 1048
integer width = 2661
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
tabposition tabposition = tabsonbottom!
integer selectedtab = 2
end type

event selectionchanged;//uo_fram_control_tabpage luo_tabpage
string ls_name
ls_name = tab_1.control[newindex].tag

window lw_first, lw_next
w_internet_lh_mdi lw_mdi

lw_mdi = parent

lw_next = lw_mdi.GetFirstSheet()
do while isvalid(lw_next)
	if ls_name = lw_next.ClassName() then
		if lw_next.WindowState = Minimized! then
			lw_next.WindowState = Normal!
		end if
		lw_next.SetFocus()
		return
	end if
	lw_next = lw_mdi.GetNextSheet(lw_next)
loop


end event

