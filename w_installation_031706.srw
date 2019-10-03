$PBExportHeader$w_installation.srw
forward
global type w_installation from window
end type
type install_dir from statictext within w_installation
end type
type st_4 from statictext within w_installation
end type
type st_3 from statictext within w_installation
end type
type st_2 from statictext within w_installation
end type
type cbx_4 from checkbox within w_installation
end type
type cbx_3 from checkbox within w_installation
end type
type cbx_2 from checkbox within w_installation
end type
type cbx_1 from checkbox within w_installation
end type
type st_1 from statictext within w_installation
end type
type hpb_1 from hprogressbar within w_installation
end type
type cb_installation from commandbutton within w_installation
end type
type cb_cancel from commandbutton within w_installation
end type
type cb_browse from commandbutton within w_installation
end type
type gb_2 from groupbox within w_installation
end type
type gb_3 from groupbox within w_installation
end type
type hpb_2 from hprogressbar within w_installation
end type
type gb_1 from groupbox within w_installation
end type
end forward

global type w_installation from window
integer x = 1001
integer y = 800
integer width = 2574
integer height = 1616
boolean titlebar = true
string title = "Learning Helper Installation"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = ".\LearningHelper.ico"
boolean clientedge = true
event ue_filecopied pbm_custom01
event ue_filecopying pbm_custom02
event ue_timecheck pbm_custom03
install_dir install_dir
st_4 st_4
st_3 st_3
st_2 st_2
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
st_1 st_1
hpb_1 hpb_1
cb_installation cb_installation
cb_cancel cb_cancel
cb_browse cb_browse
gb_2 gb_2
gb_3 gb_3
hpb_2 hpb_2
gb_1 gb_1
end type
global w_installation w_installation

type variables
ulong iul_cur_diskfree, iul_init_diskfree, iul_diff
ulong iul_total_size
long il_full_file_size, il_movie_file_size, il_help_file_size, il_install_file_size
long il_path_size[7]
long il_current_installed_file_size
long il_child_proc_handle
string is_currentPath, is_selectedPath
string is_source_path[], is_dest_path[]
string is_dde_data_queue[], is_copied_file
string is_link_file = "C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper.lnk"
string is_vb_script_file
string is_all_path[] = {"bin", "database", "materials", "videos", "help", "load", "Static Table"}

long il_test_index  = 0, il_total_time = 0
long il_full_length, il_process_id
long il_start_copying_time //milisecond
long il_start_file_copying_time //milisecond
long il_current_file_size
decimal idec_copying_rate = 0.0
integer ii_path_index
integer ii_install_option[] = {0, 0, 0, 0, 0, 1, 0}
CheckBox icbx[4]
string is_hbar
boolean ib_software_installed = false
end variables

forward prototypes
public subroutine of_cal_copying_rate ()
public subroutine of_post_filecopy ()
end prototypes

event ue_filecopied;decimal ld_installed_pct, ll_ret, ll_parenthandle
integer li_ret

//if wparam = 999 then
//	if ii_path_index < upperbound(is_source_path) then
//		ll_parenthandle = long(Handle(this))
//		ii_path_index++
//		ll_ret = fnCopyFolder(is_source_path[ii_path_index], is_dest_path[ii_path_index], ll_parenthandle, is_copied_file)
//	else
//		ib_software_installed = true
//		st_4.width = il_full_length
//		hpb_1.position = 100
//		st_1.text = "Total Completion 100%"	
//		of_post_filecopy()
//	end if
//	return
//end if
//st_4.width = il_full_length
//il_current_file_size = long(lparam)
//il_current_installed_file_size = il_current_installed_file_size + long(lparam)
//il_total_time = il_total_time + (cpu() - il_start_copying_time)
//idec_copying_rate = dec(il_current_installed_file_size)/dec(il_total_time)
//ld_installed_pct = dec(il_current_installed_file_size)/dec(il_install_file_size)
//if ld_installed_pct > 1.0 then ld_installed_pct = 1.0
//hpb_1.position = long(ceiling(ld_installed_pct*100))
//st_1.text = "Total Completion " + string(hpb_1.position) + "%"
return 1
end event

event ue_filecopying;decimal ld_installed_pct
integer li_ret
// update file copy progress bar
//il_current_file_size = long(lparam)
//st_2.text = is_copied_file
//il_start_file_copying_time = cpu()
//st_4.width = 0
return 1
end event

event ue_timecheck;long ll_elapsed_time, ll_total_time_need, ll_postion
decimal ld_installed_pct
integer li_ret
//if ib_software_installed then return
//ll_elapsed_time = cpu() - il_start_file_copying_time
//if idec_copying_rate > 0 then
//	ll_total_time_need = long(dec(il_current_file_size)/idec_copying_rate)
//	ld_installed_pct = dec(ll_elapsed_time)/dec(ll_total_time_need)
//	ll_postion = ceiling(dec(il_full_length)*ld_installed_pct)
//	if ll_postion > il_full_length then ll_postion = il_full_length
//	st_4.width = ll_postion
//else
//	st_4.width = 0
//end if
return 1
end event

public subroutine of_cal_copying_rate ();//idec_copying_rate = dec(il_current_installed_file_size)/dec(cpu() - il_start_copying_time)
end subroutine

public subroutine of_post_filecopy ();string  ls_init_file, ls_vb_script
integer li_FileNum, li_ret
long ll_ret
string ls_reg_dir, ls_reg_name, ls_value

//// make init file
//ls_init_file = install_dir.text + "\Learning Helper.ini" 
//li_FileNum = FileOpen(ls_init_file, LineMode!, Write!, LockWrite!, Replace!)		
//if li_FileNum = -1 then 
//	MessageBox("Error", "Cannot create INI file!")
//	return
//end if
//
//FileWrite(li_FileNum, "[application]")
//FileWrite(li_FileNum, "program_path=" + install_dir.text + "\")
//FileWrite(li_FileNum, "app_exclusion=")
//FileWrite(li_FileNum, "[resources]")
//FileWrite(li_FileNum, "app_path=" + install_dir.text + "\")
//FileWrite(li_FileNum, "wavefile=" + install_dir.text + "\materials\wave\")
//FileWrite(li_FileNum, "bitmapfile=" + install_dir.text + "\materials\bitmap\")
//FileWrite(li_FileNum, "static_table=" + install_dir.text + "\Static Table\")
//FileWrite(li_FileNum, "videofile=" + install_dir.text + "\videos\")
//FileWrite(li_FileNum, "help_dir=" + install_dir.text + "\help\")
//FileWrite(li_FileNum, "load_dir=" + install_dir.text + "\load\")
//FileWrite(li_FileNum, "[application_setup]")
//FileWrite(li_FileNum, "demo_window_on=yes")
//FileClose(li_FileNum)
//// install learning helper
//ls_reg_dir = "HKEY_LOCAL_MACHINE\Software\Learning Helper"
//ls_reg_name = "Location"
//ls_value = install_dir.text
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//ls_reg_name = "Start"
//ls_value = install_dir.text + "\Bin\Learning Helper.exe"
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//// install database odbc registry
//ls_reg_dir = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\LearningHelper"
//ls_reg_name = "Driver"
//ls_value = install_dir.text + "\Bin\dbodbc6.DLL"
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//ls_reg_name = "Start"
//ls_value = install_dir.text + "\Bin\rteng6.exe"
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//ls_reg_name = "DatabaseFile"
//ls_value = install_dir.text + "\database\LearningHelper.DB"
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//ls_reg_name = "DatabaseName"
//ls_value = "LEARNINGHELPER"
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//ls_reg_name = "AutoStop"
//ls_value = "yes"
//RegistrySet(ls_reg_dir,ls_reg_name, RegString!, ls_value)
//// 4. create Application Shortcut
//is_vb_script_file = install_dir.text + "\" + "MakeShortCut.vbs" 
////MessageBox("of_post_filecopy", is_link_file)
//if IsFileValide(is_link_file) = 1 then
//	event timer()
//	return
//end if
////MessageBox("of_post_filecopy", "B")
//li_FileNum = FileOpen(is_vb_script_file, LineMode!, Write!, LockWrite!, Replace!)		
//if li_FileNum = -1 then 
//	MessageBox("Error", "Cannot create INI file!")
//	return
//end if
//ls_vb_script = 'Dim WSHShell'
//FileWrite(li_FileNum, ls_vb_script)
//ls_vb_script = 'Set WSHShell = WScript.CreateObject("' + 'WScript.Shell")'
//FileWrite(li_FileNum, ls_vb_script)
//ls_vb_script = 'Dim MyShortcut'
//FileWrite(li_FileNum, ls_vb_script)
//// Autoopen Autoclose shortcut
//if FileExists("C:\Documents and Settings\All Users\Desktop") then // windows 2000 and XP
//	if gb_trial_version then
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Learning Helper Auto.lnk")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Learning Helper.exe")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Arguments = WSHShell.ExpandEnvironmentStrings("autoopen autoclose' + '")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WindowStyle = 4'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Save'
//		FileWrite(li_FileNum, ls_vb_script)
//	else
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Learning Helper Introduction.lnk")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Exhibition.exe")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WindowStyle = 4'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Save'
//		FileWrite(li_FileNum, ls_vb_script)
//
//		// Upgrade Application
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Upgrade.lnk")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LHUpgrade.exe")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WindowStyle = 4'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LHUpgrade.ico, 0")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Save'
//		FileWrite(li_FileNum, ls_vb_script)
//
////MessageBox("of_post_filecopy", "XP regular")
//	end if
//	// Full Control Lerning Helper shortcut
//	if gb_trial_version then
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Learning Helper Demo-Trial.lnk")'
//	else
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Learning Helper.lnk")'
//	end if
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Learning Helper.exe")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WindowStyle = 4'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.Save'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Uninstall Learning Helper.lnk")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Uninstall.exe")' 
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WindowStyle = 4'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.Save'
//	FileWrite(li_FileNum, ls_vb_script)
//	// create short cur on desktop
//	if not gb_trial_version then
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Desktop\Learning Helper.lnk")'
//	else
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Documents and Settings\All Users\Desktop\Learning Helper Demo-Trial.lnk")'
//	end if
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Learning Helper.exe")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WindowStyle = 4'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.Save'
//	FileWrite(li_FileNum, ls_vb_script)
////MessageBox("of_post_filecopy", "XP regualr beore make folder")
//	
//	fnmkdir("C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper")
//elseif FileExists("C:\Windows\Desktop") then // windows 98
//	if gb_trial_version then
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper Auto.lnk")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Learning Helper.exe")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Arguments = WSHShell.ExpandEnvironmentStrings("autoopen autoclose' + '")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WindowStyle = 4'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Save'
//		FileWrite(li_FileNum, ls_vb_script)
//	else
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper Introduction.lnk")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Exhibition.exe")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WindowStyle = 4'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Save'
//		FileWrite(li_FileNum, ls_vb_script)
//		// Upgrade Application
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Start Menu\Programs\Learning Helper\Upgrade.lnk")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LHUpgrade.exe")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.WindowStyle = 4'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LHUpgrade.ico, 0")'
//		FileWrite(li_FileNum, ls_vb_script)
//		ls_vb_script = 'MyShortcut.Save'
//		FileWrite(li_FileNum, ls_vb_script)
//	end if
//	// Full Control Lerning Helper shortcut
//	if gb_trial_version then
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper Demo-Trial.lnk")'
//	else
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper.lnk")'
//	end if
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Learning Helper.exe")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WindowStyle = 4'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.Save'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Start Menu\Programs\Learning Helper\Uninstall Learning Helper.lnk")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Uninstall.exe")' 
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WindowStyle = 4'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.Save'
//	FileWrite(li_FileNum, ls_vb_script)
//	// create short cur on desktop
//	if not gb_trial_version then
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Desktop\Learning Helper.lnk")'
//	else
//		ls_vb_script = 'Set MyShortcut = WSHShell.CreateShortcut("' + 'C:\Windows\Desktop\Learning Helper Demo-Trial.lnk")'
//	end if
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\Learning Helper.exe")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\Bin\")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.WindowStyle = 4'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("' + install_dir.text + '\bin\LearningHelper.ico, 0")'
//	FileWrite(li_FileNum, ls_vb_script)
//	ls_vb_script = 'MyShortcut.Save'
//	FileWrite(li_FileNum, ls_vb_script)
//	fnmkdir("C:\Windows\Start Menu\Programs\Learning Helper")
//end if
//FileClose(li_FileNum)
//ls_vb_script = 'wscript.exe' + ' "' + is_vb_script_file + '"'
//run(ls_vb_script)
//timer(0.2)

end subroutine

on w_installation.create
this.install_dir=create install_dir
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.hpb_1=create hpb_1
this.cb_installation=create cb_installation
this.cb_cancel=create cb_cancel
this.cb_browse=create cb_browse
this.gb_2=create gb_2
this.gb_3=create gb_3
this.hpb_2=create hpb_2
this.gb_1=create gb_1
this.Control[]={this.install_dir,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cbx_4,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.st_1,&
this.hpb_1,&
this.cb_installation,&
this.cb_cancel,&
this.cb_browse,&
this.gb_2,&
this.gb_3,&
this.hpb_2,&
this.gb_1}
end on

on w_installation.destroy
destroy(this.install_dir)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.hpb_1)
destroy(this.cb_installation)
destroy(this.cb_cancel)
destroy(this.cb_browse)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.hpb_2)
destroy(this.gb_1)
end on

event open;integer li_i, li_ret
long ll_filesize, ll_ret , ll_mb, ll_filesize_1, ll_filesize_2
string ls_path, ls_label
ulong ll_total, ll_free
environment    lenv_env                                // holds environment information
//
//is_copied_file = space(200)
//icbx[1] = cbx_1
//icbx[2] = cbx_2
//icbx[3] = cbx_3
//icbx[4] = cbx_4
//hpb_1.position = 0
//ls_path = ".\Learning Helper"
//il_full_file_size = fnDirSize(ls_path)
//for li_i = 1 to 7
//	il_path_size[li_i] = fnDirSize(ls_path + "\" + is_all_path[li_i])
//next
//icbx[1].text = icbx[1].text + " (" + string(ceiling(il_path_size[1]/(1024*1024))) + " MB)"
//icbx[2].text = icbx[2].text + " (" + string(ceiling((il_path_size[2] + il_path_size[3] + il_path_size[7])/(1024*1024))) + " MB)"
//icbx[3].text = icbx[3].text + " (" + string(ceiling((il_path_size[4])/(1024*1024))) + " MB)"
//icbx[4].text = icbx[4].text + " (" + string(ceiling((il_path_size[5])/(1024*1024))) + " MB)"
//
//is_currentPath = space(200)
//li_ret = GetCurrentDir(200, is_currentPath)
//if len(trim(is_currentPath)) = 3 then is_currentPath = left(is_currentPath, 2)
//hpb_1.position = 0
//il_full_length = st_4.width
//st_4.width = 0
//
//GetEnvironment ( lenv_env )
//x = (PixelsToUnits(lenv_env.ScreenWidth, XPixelsToUnits!) - width)/2
//y = (PixelsToUnits(lenv_env.ScreenHeight, YPixelsToUnits!) - height)/2
//
//if FileExists("C:\Documents and Settings\All Users\Desktop") then
//	if gb_trial_version then
////		MessageBox("open", "XP gb_trial_version")
//		is_link_file = "C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Learning Helper Demo-Trial.lnk"
//	else
////		MessageBox("open", "XP regular version")
//		is_link_file = "C:\Documents and Settings\All Users\Start Menu\Programs\Learning Helper\Learning Helper.lnk"
//	end if
////		MessageBox("open", is_link_file)
//else
//	if gb_trial_version then
//		is_link_file = "C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper Demo-Trial.lnk"
//	else
//		is_link_file = "C:\Windows\Start Menu\Programs\Learning Helper\Learning Helper.lnk"
//	end if
//end if

end event

event timer;//if IsFileValide(is_link_file) = 0 then
//	timer(0.2)
//else
//	timer(0)
//	fnDeleteFile(is_vb_script_file)
//	if gb_trial_version then
//		MessageBox("Congratulation!", "Learning Helper Trial/Demo version is successfully installed!")
//	else	
//		MessageBox("Congratulation!", "Learning Helper is successfully installed!")
//	end if
////	run("explorer.exe " + '"C:\Windows\Start Menu\Programs\Learning Helper'+ '"')
//	run(install_dir.text + "\bin\Learning Helper.exe")
//	post close(this)
//end if
end event

type install_dir from statictext within w_installation
integer x = 229
integer y = 504
integer width = 2107
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "C:\Learning Helper"
boolean focusrectangle = false
end type

type st_4 from statictext within w_installation
integer x = 183
integer y = 1092
integer width = 2181
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
long textcolor = 33554432
long backcolor = 8388608
boolean focusrectangle = false
end type

type st_3 from statictext within w_installation
integer x = 174
integer y = 988
integer width = 389
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Copying File:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_installation
integer x = 576
integer y = 988
integer width = 1074
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cbx_4 from checkbox within w_installation
integer x = 1367
integer y = 220
integer width = 686
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Help"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cbx_3 from checkbox within w_installation
integer x = 1367
integer y = 120
integer width = 686
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Movies"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cbx_2 from checkbox within w_installation
integer x = 215
integer y = 220
integer width = 686
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materials"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_installation
integer x = 215
integer y = 144
integer width = 686
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Software"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_installation
integer x = 1015
integer y = 1176
integer width = 635
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Total Completion %"
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_installation
integer x = 174
integer y = 1260
integer width = 2203
integer height = 80
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
end type

type cb_installation from commandbutton within w_installation
integer x = 133
integer y = 784
integer width = 526
integer height = 96
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Start Installation"
end type

event clicked;// get installation option
//string ls_init_file, ls_vb_script
//string ls_all_path[] = {"bin", "database", "materials", "videos", "help", "load", "Static Table"}
//string source_path, dest_path
//integer li_i, li_ret, li_FileNum
//long ll_ret, ll_parenthandle
//SetPointer(HourGlass!)
//cb_cancel.enabled = false
//ib_software_installed = false
////li_ret = SetCurrentDir(is_currentPath)
//ll_parenthandle = long(Handle(parent))
//il_current_installed_file_size = 0
//il_install_file_size = 0
//if cbx_1.checked then 
//	il_install_file_size = il_install_file_size + il_path_size[1]
//	ii_install_option[1] = 1
//end if
//if cbx_2.checked then // data
//	il_install_file_size = il_install_file_size + il_path_size[2] + il_path_size[3] + il_path_size[7]
//	ii_install_option[2] = 1
//	ii_install_option[3] = 1
//	ii_install_option[7] = 1
//end if
//if cbx_3.checked then // movie
//	il_install_file_size = il_install_file_size + il_path_size[4]
//	ii_install_option[4] = 1
//end if
//if cbx_4.checked then // help
//	il_install_file_size = il_install_file_size + il_path_size[5]
//	ii_install_option[5] = 1
//end if
//
//fnMkDir(trim(install_dir.text))
//hpb_1.position = 0
//// 1. install data file
//ii_path_index = 0
//il_start_copying_time = cpu()
//il_start_file_copying_time = cpu()
//for li_i = 1 to upperbound(ls_all_path)
//	if ii_install_option[li_i] = 1 then
//		ii_path_index++
//		is_source_path[ii_path_index] = is_currentPath + "\Learning Helper\" + ls_all_path[li_i]
//		is_dest_path[ii_path_index] = trim(install_dir.text) + "\" + ls_all_path[li_i]
//end if
//next
//st_4.width = 0
//ii_path_index = 1
//ll_ret = fnCopyFolder(is_source_path[1], is_dest_path[1], ll_parenthandle, is_copied_file)
//fnCopyFile(is_currentPath + "\setup.exe", install_dir.text + "\setup.exe", 0)
//fnCopyFile(is_currentPath + "\uninstall.exe", install_dir.text + "\uninstall.exe", 0)
//fnCopyFile(is_currentPath + "\libjcc.dll", install_dir.text + "\libjcc.dll", 0)
//fnCopyFile(is_currentPath + "\win32dll.dll", install_dir.text + "\win32dll.dll", 0)
//fnCopyFile(is_currentPath + "\pbvm70.dll", install_dir.text + "\pbvm70.dll", 0)

end event

type cb_cancel from commandbutton within w_installation
integer x = 1947
integer y = 788
integer width = 462
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit Installation"
boolean default = true
end type

event clicked;StopServerDDE("Installation", "FolderCopy")

Close(parent)


end event

type cb_browse from commandbutton within w_installation
integer x = 1760
integer y = 616
integer width = 585
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change Directory ..."
end type

event clicked;integer li_pos, li_ret
string ls_title = "Select Direction to Install Learning Helper"
string ls_currentPath, ls_selectedPath
//ls_currentPath = install_dir.text
//if fnSHBrowseForFolder(long(parent), ls_title, ls_currentPath, ls_selectedPath) > 0 then
//	li_pos = pos(is_selectedPath, ":")
//	if li_pos > 0 and mid(is_selectedPath, li_pos + 1, 1) = ")" then
//		ls_currentPath = mid(ls_selectedPath, li_pos - 1, 2) 
//	else
//		ls_currentPath = ls_selectedPath
//	end if	
//	install_dir.text = trim(ls_currentPath) + "\Learning Helper"
//end if
//li_ret = SetCurrentDir(is_currentPath)
end event

type gb_2 from groupbox within w_installation
integer x = 133
integer y = 400
integer width = 2281
integer height = 348
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Directory that Learning Helper to be installed"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_installation
integer x = 133
integer y = 64
integer width = 2281
integer height = 296
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Installation Option"
borderstyle borderstyle = stylelowered!
end type

type hpb_2 from hprogressbar within w_installation
integer x = 174
integer y = 1080
integer width = 2203
integer height = 80
unsignedinteger maxposition = 100
integer setstep = 10
end type

type gb_1 from groupbox within w_installation
integer x = 133
integer y = 900
integer width = 2281
integer height = 500
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Installation Status"
borderstyle borderstyle = stylelowered!
end type

