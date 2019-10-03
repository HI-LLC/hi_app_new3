$PBExportHeader$learninghelper.sra
forward
global type learninghelper from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
nvo_aba_appman gn_appman
nvo_constant gnv_constant
app_constant g_constants
str_mt_dddw gstr_mt_dddw[]
nv_sound_play inv_sound_play
integer gi_material_tabpage = 1
long gl_lesson_program_id = 0
long gl_last_seq_num
decimal gdec_threshold = 0.0
long gl_min_threshold_count = 0
string is_startupfile, gs_orig_directory
boolean gb_money_board_on = true
boolean gb_auto_close = false
boolean gb_auto_open = false
BOOLean g_TileorCas
boolean gb_signup_on = false
boolean gb_AppWatch = false
w_money_board gw_money_board
LearningHelper lh_app

nvo_input_simulator gnvo_is
//string gs_list[]
end variables

global type learninghelper from application
string appname = "learninghelper"
end type
global learninghelper learninghelper

type prototypes
// window functions
Function boolean MoveFileA (ref string oldfile, ref string newfile) library "KERNEL32.DLL"
Function uint GlobalAddAtomA (string as_atom) library "KERNEL32.DLL"
Function uint GlobalFindAtomA (string as_atom) library "KERNEL32.DLL"
Function uint GlobalDeleteAtom (uint aui_reff) library "KERNEL32.DLL"
Function uint FindWindow (string as_ClassName, String as_WindowName) library "KERNEL32.DLL"

FUNCTION int GetDesktopWindow() Library "user32.dll"
FUNCTION uint GetWindow(uint x, int y) Library "user32.dll"
FUNCTION uint SetWindowPos(int hwnd, int hwnd_topmost, int x, int y, int cx, int cy, uint uflag) Library "user32.dll"
FUNCTION BOOLean IsWindow(uint x) Library "user32.dll"
FUNCTION BOOLean IsWindowVisible(uint x) Library "user32.dll"
FUNCTION int GetWindowTextA(int hwnd, REF string  lpstring, int nMaxCount) Library "user32.dll"
FUNCTION int GetClassNameA(int hwnd, REF string  lpstring, int nsize) Library "user32.dll"
FUNCTION int PostMessage(long hWnd, uint Msg, uint wParm, ulong lParm) Library "user32.dll"
FUNCTION BOOLean  ShowWindow(int hwnd, int ncmnd) Library "user32.dll"
FUNCTION BOOLean BringWindowToTop(uint x) Library "user32.dll"
FUNCTION BOOLean IsIconic(uint x) Library "user32.dll"
FUNCTION BOOLean GetTextExtentPoint32A(ulong hwnd, string lpstring, int cbString, ref str_size lpSize) Library "Gdi32.dll"
FUNCTION uint GetDCEx(int hwnd, int cliphwnd, long flags ) Library "user32.dll"
FUNCTION ulong GetDC(ulong hwnd) Library "user32.dll"
Function long FindWindowExA (long hWnd, long hWndChild, ref string lpszClassName, ref String lpszWindow) library "user32.DLL"
Function long SetForegroundWindow (ulong Hwnd) library "user32.DLL"
FUNCTION boolean GetCursorPos(ref structure mousepos) LIBRARY "user32.dll"
FUNCTION boolean SetCursorPos(ref structure mousepos) LIBRARY "user32.dll"
FUNCTION integer _spawnl(int mode, ref string cmdname, string arg) LIBRARY "MSVCRT.DLL"
FUNCTION BOOLean ExtTextOutA(int hdc, int x, int y, uint fuOptions, ref str_rect lprc, string lpString, uint cbCount, ref int lpDx) Library "Gdi32.dll"
FUNCTION boolean sndPlaySoundA (string SoundName, 	uint Flags) LIBRARY "WINMM.DLL"

// WIN32DLL.DLL
FUNCTION integer Keybd_Event (long bVk, long bScan, long dwFlags, long dwExtraInfo) LIBRARY	"WIN32DLL.DLL" ALIAS FOR "_Keybd_Event@16"
FUNCTION integer Mouse_Event (long dwFlags, long dx, long dy, long dwData, long dwExtraInfo) LIBRARY	"WIN32DLL.DLL" ALIAS FOR "_Mouse_Event@20"
FUNCTION integer fnMkDir(string path) LIBRARY  "WIN32DLL.DLL" ALIAS FOR "_fnMkDir@4"
FUNCTION integer fnRmDir(string path) LIBRARY  "WIN32DLL.DLL" ALIAS FOR "_fnRmDir@4"
Function integer SetCurrentDir(string PathName) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_SetCurrentDir@4"
Function integer GetCurrentDir(integer DirLen, ref string PathName) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_GetCurrentDir@8"
Function integer fnDeleteFile( string asFileName) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDeleteFile@4"
Function integer fnCopyFile(string asExistingFileName , string asNewFileName, integer aiFailIfExists) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnCopyFile@12"
FUNCTION integer fnDirList(string path, ref string filelist[]) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDirList@8"
FUNCTION integer fnDirListDir(string path, ref string filelist[]) LIBRARY  "WIN32DLL.DLL" ALIAS FOR   "_fnDirListDir@8"
FUNCTION integer fnDirListAll(string path, ref string filelist[]) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDirListAll@8"
FUNCTION integer fnDirListCount(string path) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDirListCount@4"
FUNCTION integer fnDirListDirCount(string path) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDirListDirCount@4"
FUNCTION integer fnDirListCountAll(string path) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDirListCountAll@4"
FUNCTION long Get_System_ID () LIBRARY "WIN32DLL.dll" ALIAS FOR  "_Get_System_ID@0"
FUNCTION long get_message ( ref str_msg lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "WIN32DLL.dll" ALIAS FOR  "_get_message@16"
FUNCTION long peek_message ( ref str_msg lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "WIN32DLL.dll" ALIAS FOR  "_peek_message@16"
FUNCTION long remove_message ( ref str_msg lpMsg, long hWnd, integer msgMin, integer msgMax ) LIBRARY "WIN32DLL.dll" ALIAS FOR "_remove_message@16"    
FUNCTION integer TerminateProc(int hProcess) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_TerminateProc@4"
FUNCTION integer CreatePro(int mode, string cmdname, string arg) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_CreateProcc@12"
FUNCTION BOOLEAN SafeTerminateProcess(int hProcess/*, UINT uExitCode*/) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_SafeTerminateProcess@4"
SUBROUTINE sleeping(integer milisecond) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_sleeping@4"
SUBROUTINE enable_ctrl_alt_del() LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_enable_ctrl_alt_del@0"
SUBROUTINE disable_ctrl_alt_del() LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_disable_ctrl_alt_del@0"
FUNCTION int fnSetDisplay(int dmPelsWidth, int dmPelsHeight, int dmBitsperPel) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnSetDisplay@12"
FUNCTION int fnGetDisplay(ref int dmPelsWidth, ref int dmPelsHeight, ref int dmBitsperPel) LIBRARY "WIN32DLL.DLL" ALIAS FOR "_fnGetDisplay@12" 
FUNCTION int fnSetValidDisplay() LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnSetValidDisplay@0"
FUNCTION int MakeHomeLicenseKey(uint SiteLicenseNum, string SystemID, ref string AuthenKey) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_MakeHomeLicenseKey@12"
FUNCTION uint GetHomeLicenseNum(string SystemID, string AuthenKey) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_GetHomeLicenseNum@8"
FUNCTION int fnGetLicenseBit(int bitNum, uint LincenseBitMap) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnGetLicenseBit@8"
FUNCTION ulong GetThread(ulong starting_address, integer stock_size, string arglist) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_GetThread@12"
SUBROUTINE EndThread() LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_EndThread@0"
FUNCTION integer fnSHBrowseForFolder(ulong parent_handle, string title, string currentPath, ref string selectedPath) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnSHBrowseForFolder@16"
FUNCTION integer GetFileNameAll(ulong parent_handle, string lsDirPath , ref string FileName) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_GetFileNameAll@12"
FUNCTION int fnGetClipboardData(long cliphwnd, string WaveFile) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnGetClipboardData@8"
FUNCTION int fnSetClipboardData(long cliphwnd, string WaveFile) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnSetClipboardData@8"
FUNCTION int fnEmptyClipboard(long cliphwnd) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnEmptyClipboard@4"
FUNCTION int fnCheckClipboardData(long cliphwnd) LIBRARY "WIN32DLL.DLL" ALIAS FOR "_fnCheckClipboardData@4" 
FUNCTION int fnAddResourceFile(string fname_prefix, string ExportType, int CompressInd) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnAddResourceFile@12"
FUNCTION int fnExtractResourceFile(string fname_prefix, string ExportType) LIBRARY "WIN32DLL.DLL" ALIAS FOR "_fnExtractResourceFile@8" 
FUNCTION int fnIntegrateExportFile(string FileName, string ExportType, int UpdateIndicator, int CompressInd) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnIntegrateExportFile@16"
FUNCTION int fnSplitImportFile(string FileName) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnSplitImportFile@4"
FUNCTION long fnCopyFolder(string SourcePath, string DestPath, long ParentHandle, ref string CopedFile) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnCopyFolder@16"
FUNCTION int Compress(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_Compress@8"
FUNCTION int Uncompress(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_Uncompress@8"
FUNCTION int fnTextFile2BinFile(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnTextFile2BinFile@8"
FUNCTION int fnBinFile2TextFile(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnBinFile2TextFile@8"
SUBROUTINE JPegHeaderComplement(string file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_JPegHeaderComplement@4"
SUBROUTINE JPegHeaderComplementOut(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_JPegHeaderComplementOut@8"
SUBROUTINE OSversion(ref string WinVersion) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_OSversion@4"

// Internet.dll
SUBROUTINE UpLoadReport(string local_full_path, string file_name_only) LIBRARY "Internet.DLL" ALIAS FOR  "_UpLoadReport@8"
SUBROUTINE DirectoryList(string RemoteFilePath, ref string DirList[], long FileCount) LIBRARY "Internet.DLL" ALIAS FOR  "_DirectoryList@12"
SUBROUTINE DownLoadReport(string LocalFilePath, string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_DownLoadReport@8"
FUNCTION long RemoteFileCount(string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_RemoteFileCount@4"
SUBROUTINE DownloadComments(ref long LastSeqNum) LIBRARY "Internet.DLL" ALIAS FOR  "_DownloadComments@4"
FUNCTION long SubmitNewComment(string NewComments, ref long NewSeqNum, ref string PostDate) LIBRARY "Internet.DLL" ALIAS FOR  "_SubmitNewComment@12"
SUBROUTINE OpenCommentFile() LIBRARY "Internet.DLL" ALIAS FOR  "_OpenCommentFile@0"
FUNCTION long RetrieveCommentRecord(ref long Sequence, ref string Post_date, ref string Poster_ID, ref string Poster_name, ref string Post_type, ref string Title, ref string Content) LIBRARY "Internet.DLL" ALIAS FOR  "_RetrieveCommentRecord@28"
FUNCTION long GetLastCommentSeqNum() LIBRARY "Internet.DLL" ALIAS FOR  "_GetLastCommentSeqNum@0"
FUNCTION long extGetFileSize(string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetFileSize@4"
SUBROUTINE extGetFile(string LocalFilePath, string RemoteFilePath, long BinInd) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetFile@12"
SUBROUTINE extGetFileImage(string RemoteFilePath, ref string Buffer) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetFileImage@8"
SUBROUTINE extGetBinaryFile(string LocalFilePath, string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetBinaryFile@8"
SUBROUTINE extPutBinaryFile(string LocalFilePath, string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutBinaryFile@8"
SUBROUTINE extGetBinaryFile2(string LocalFilePath, string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetBinaryFile2@8"
SUBROUTINE extPutBinaryFile2(string LocalFilePath, string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutBinaryFile2@8"
FUNCTION int CreateLHOA(string Host, string Key, string Name, string Password, string LastName,string FirstName, string Email, string PasswordHint, string Address, string City, string State, string Country, string Zipcode, string Phone, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_CreateLHOA@60"
FUNCTION int LHOA_Login(string Host, string Key, string Name, string Password, ref long aID, ref long Trans_code, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_Login@28"
FUNCTION int LHOA_SQL_retrieve(string Host, string Key, string SQL, long aID, long Trans_code,  ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_retrieve@24"
FUNCTION int LHOA_SQL_load(ref string aColName[], ref string aResultSet[]) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_load@8"
FUNCTION int LHOA_SQL_dml(string Host, string Key, string SQL, long aID, long Trans_code, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_dml@24"
FUNCTION int extAddFile(string DestFile, string SourceFile) LIBRARY "Internet.DLL" ALIAS FOR  "_extAddFile@8"
FUNCTION int extExtractFile(string DestFile, string SourceFile, long fIndex, long fSize) LIBRARY "Internet.DLL" ALIAS FOR  "_extExtractFile@16"
FUNCTION int SetFileWallInfo(string Login, string Password) LIBRARY "Internet.DLL" ALIAS FOR  "_SetFileWallInfo@8"
FUNCTION int GetHostName(ref string Host) LIBRARY "Internet.DLL" ALIAS FOR  "_GetHostName@4"
FUNCTION int GetHomePath(ref string HomePath) LIBRARY "Internet.DLL" ALIAS FOR  "_GetHomePath@4"
FUNCTION int extAddIndex(string DestFile, string SourceFile, long FileSize, long FileIndex) LIBRARY "Internet.DLL" ALIAS FOR  "_extAddIndex@16" 
FUNCTION int extMakeiLessonPackage(string PackagePrefix, long LessonCount, long ResourceCount) LIBRARY "Internet.DLL" ALIAS FOR  "_extMakeiLessonPackage@12" 
FUNCTION int extExtractPackageFile(string PackagePrefix, string DestFile, long SourceInd) LIBRARY "Internet.DLL" ALIAS FOR  "_extExtractPackageFile@12"
FUNCTION int extGetPkgHeader(string PackagePrefix, ref str_lesson_package pkrec) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetPkgHeader@8" 
FUNCTION int extGetPkgLessonList(string PackagePrefix, ref string LessonList[]) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetPkgLessonList@8" 
FUNCTION int extUploadResourceFiles(string fname_prefix, string remote_path_prefix) LIBRARY "Internet.DLL" ALIAS FOR  "_extUploadResourceFiles@8"
FUNCTION int extUploadLessonFiles(string fname_prefix, string remote_path_prefix) LIBRARY "Internet.DLL" ALIAS FOR  "_extUploadLessonFiles@8"
FUNCTION int extRunBatchSQL(string Host,string Key,long aID, long Trans_code, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_extRunBatchSQL@20"
FUNCTION int SwapProgram(string NewProgram) LIBRARY "Internet.DLL" ALIAS FOR  "_SwapProgram@4"

//SUBROUTINE CreateWindowForPB(ref long WinHandle) LIBRARY	"graphic.DLL"
//SUBROUTINE LoadGraph(long WndHandle, string FileName, ref string BitmapPtr, ref long asciisize, ref long binsize ) LIBRARY	"graphic.DLL"
//SUBROUTINE do_paint_ext(long WndHandle, ref string BitmapPtr, long asciisize, long binsize ) LIBRARY	"graphic.DLL"
//SUBROUTINE free_memory(ulong AppHandle, ref string BitmapPtr) LIBRARY	"graphic.DLL"
//SUBROUTINE CreateAgentWindowForPB(ref long AgentWinHandle, long ClientWndHandle, string FileName) LIBRARY	"graphic.DLL"
//SUBROUTINE PaintExtWinGraph(long WndHandle, string FileName) LIBRARY	"graphic.DLL"
//FUNCTION int PostThreadMessageExt(ulong idThread,UINT Msg,uint wParam,long lParam) LIBRARY	"graphic.DLL"
//SUBROUTINE StartThread(long ClientWndHandle, string FileName, ref ulong ThreadID) LIBRARY	"graphic.DLL"
subroutine LoadGraph(long WndHandle, string FileName) library "graphic.dll" ALIAS FOR "_LoadGraph@8"
subroutine ScreenShot(long WndHandle, string FileName) library "graphic.dll" ALIAS FOR "_ScreenShot@8"
//subroutine SetAppWatchStatus(string FileName, int status) library "graphic.dll"
subroutine SetGraphicFileType(boolean FileType) library "graphic.dll" ALIAS FOR "_SetGraphicFileType@1"
FUNCTION long  WaveFileDuration(string FileName) library "voiceman.dll" ALIAS FOR "_WaveFileDuration@4"

end prototypes
type variables
uint iui_atom = 0
uint iui_atom_time = 0
string is_time_stamp
boolean ib_running = false
end variables

forward prototypes
public subroutine of_excluding_application ()
end prototypes

public subroutine of_excluding_application ();integer li_window, li_i
string ls_null
time  ldt_now
long  ll_WinHandle

setnull(ls_null)
ldt_now = now()
for li_i = -5 to 0
	is_time_stamp = string(RelativeTime ( ldt_now, li_i ))
	iui_atom_time = GlobalFindAtomA("LH" + is_time_stamp)
	if iui_atom_time > 0 then
		do until iui_atom_time = 0
			GlobalDeleteAtom(iui_atom_time)
			iui_atom_time = GlobalFindAtomA("LH" + is_time_stamp)
		loop
		GlobalDeleteAtom(iui_atom_time) 
		halt
	end if  
next

iui_atom_time = GlobalAddAtomA("LH" + string(ldt_now))
// application double run stopper

iui_atom = GlobalFindAtomA("LEARNING HELPER COMPUTER SYSTEM")

if iui_atom > 0 then
//	ll_WinHandle = FindWindow(ls_null, "Learning Helper")
//	if ll_WinHandle <> 0 then
//		SetForegroundWindow(ll_WinHandle)
	if gf_appalreadyrunning("Learning Helper") then
		ib_running = true
		Halt Close
	else
		do until iui_atom = 0
			GlobalDeleteAtom(iui_atom)
			iui_atom = GlobalFindAtomA("LEARNING HELPER COMPUTER SYSTEM")
		loop
	end if
End if
iui_atom = GlobalAddAtomA("LEARNING HELPER COMPUTER SYSTEM")  


end subroutine

on learninghelper.create
appname="learninghelper"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on learninghelper.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;////////////////////////////////////////////////////////
//     Application Open Script
//             Selects start-up file according to Operating System
//             Populates sqlca from start-up file
//             Connects to DB (if uncommented)
//             Opens frame window
////////////////////////////////////////////////////////

environment    lenv_env                                // holds environment information
long ll_count
string         ls_message, ls_startupfile          // holds name of start-up file
string	ls_current_dir, ls_tmp, ls_dbname
integer ret, value, li_pos, li_len, li_day_diff
date ld_today, ld_expiration_date
nvo_authen lnv_authen
if upper(ProfileString ("..\Learning Helper.ini" , "application", "app_exclusion", "" )) <> "NO" then
	of_excluding_application()
end if

enable_ctrl_alt_del()

gs_orig_directory = space(150);
GetCurrentDir(150, gs_orig_directory)
//MessageBox("gs_orig_directory",gs_orig_directory)
ls_current_dir = ProfileString ("..\Learning Helper.ini" , "application", "program_path", "" )
if ls_current_dir = "" then
	RegistryGet( "HKEY_LOCAL_MACHINE\Software\Learning Helper", "Location", RegString!, ls_current_dir)
end if
//MessageBox("ls_current_dir", ls_current_dir)
SetCurrentDir( ls_current_dir + "\bin" )
//if gf_appalreadyrunning("Learning Helper") then
//	MessageBox("Error", "Learning Helper is already running!")
//	return
//end if

is_startupfile = "..\Learning Helper.ini"
//MessageBox("is_startupfile", is_startupfile)
gn_appman = create nvo_aba_appman

if not gn_appman.ib_trial_version or not gn_appman.ib_home_version  then
	ld_today = today()
	ld_expiration_date = RelativeDate(gn_appman.id_build_date, 365 + 30)
	if ld_today > ld_expiration_date then
		MessageBox("Error", "The software license is expired. " + &
				"~nPlease visit our website @www.learninghelper.com to renew the license.~nThank You!") 
		destroy gn_appman
		halt
	end if
	li_day_diff = DaysAfter ( ld_today, ld_expiration_date )
	if li_day_diff <= 30 then
		MessageBox("Warning", "The software license will be expired in " + string(li_day_diff) + &
				" days. ~nPlease visit our website @www.learninghelper.com to renew the license.~nThank You!") 
	end if
end if
if not gn_appman.ib_trial_version then
	lnv_authen = create nvo_authen
	gn_appman.ii_site_license_num = lnv_authen.of_is_authenticated()
	if gn_appman.ii_site_license_num = 0 then
		open(w_authen)
		ls_message = Message.StringParm
		if ls_message <> "Pass" then
			MessageBox("Info", "NOT authenticated")
			destroy lnv_authen
			return
		end if
	end if
	destroy lnv_authen
end if

//SetGraphicFileType(false)
fnSetValidDisplay()

lh_app = this
//
if ( GetEnvironment(gn_appman.ie_env) <> 1 ) then
       MessageBox( "Application: Open", &
               "Unable to get environment information.~nHalting ..." )
       halt
end if
// Initialize the global variable with the epic ini file

ToolBarText=false
ToolbarTips=True

sqlca.DBMS       = "ODBC"
ls_dbname = ProfileString ("..\Learning Helper.ini" , "database", "dbname", "" )
if ls_dbname = "" then
	sqlca.DbParm="disablebind=1,ConnectString='DSN=learninghelper;UID=dba;PWD=123456'"
else
	sqlca.DbParm="disablebind=1,ConnectString='DSN=" + ls_dbname + ";UID=dba;PWD=123456'"
end if
//MessageBox("sqlca.DbParm", sqlca.DbParm)

connect;
/* Uncomment the following for actual DB connection */

if sqlca.sqlcode <> 0 then
     MessageBox ("Cannot Connect to Database", sqlca.sqlerrtext)
     return
end if

// training program
//SELECT COUNT(*) INTO :ll_count
//FROM system_parms
//WHERE system_parms_id = 6;
//if ll_count = 0 then
//  INSERT INTO system_parms
//			( system_parms_id,   
//			  parm_name,   
//			  current_id,   
//			  description )  
//  VALUES ( 6,   
//			  'TRAINER_INDICATOR',   
//			  1,   
//			  'N' )  ;
//end if
//
//SELECT COUNT(*) INTO :ll_count
//FROM student
//WHERE student_id between 10010 and 15000;
//
//if ll_count = 0 then
//	open(w_training_login)
//end if

if gn_appman.ii_site_license_num >= 10 then
	UPDATE system_parms
	SET description = 'Y'
	WHERE system_parms_id = 6;	
else
	UPDATE system_parms
	SET description = 'N'
	WHERE system_parms_id = 6;	
end if	
commit;
if ProfileString (ls_startupfile, "OnlineSetting", "autoopen",       "") = "true" then
	gb_auto_open = true
end if
if ProfileString (ls_startupfile, "OnlineSetting", "autoclose",       "") = "true" then
	gb_auto_close = true
end if
if ProfileString (ls_startupfile, "OnlineSetting", "autoopen",       "") = "false" then
	gb_auto_open = false
end if
if ProfileString (ls_startupfile, "OnlineSetting", "autoclose",       "") = "false" then
	gb_auto_close = false
end if

if not isnull(commandline) and len(commandline) > 0 then
	if pos(commandline, "autoopen") > 0 then
			gb_auto_open = true
	end if
	if pos(commandline, "autoclose") > 0 then
			gb_auto_close = true
	end if		
end if

if gb_auto_open and gb_auto_close then
	li_len = len(commandline)
	li_pos = pos(commandline, "autoclose")
	if li_len > (li_pos + 8) then
		gl_lesson_program_id = long(right(commandline, li_len - li_pos - 8))
	end if
end if
if not gb_auto_open then
	Open(w_splash)
	timer(2, w_splash)
end if

//if fnGetDisplay (gn_appman.dmPelsWidth, gn_appman.dmPelsHeight, gn_appman.dmBitsperPel) = 1 then
//	fnSetValidDisplay()
//	gn_appman.ib_reset_display = true
//end if
//nvo_input_simulator gnvo_is

gnvo_is = create nvo_input_simulator
gn_appman.Of_Set_Parm("dbname", ls_dbname)
Open(gn_appman.iw_frame,"w_label_main_mdi")
if	ProfileString (is_startupfile, "application_setup", "signup_window_on", "") = "yes" and not gb_auto_open then
	post Open(gnvo_is.iw_demo_selection, "w_demo_trial_selection")
elseif (not gb_auto_open) and ProfileString (is_startupfile, "application_setup", "demo_window_on",       "") = "yes" then
	post Open(gnvo_is.iw_demo_selection, "w_demo_selection")
end if

end event

event close;//if gn_appman.ib_reset_display then
//	fnSetDisplay (gn_appman.dmPelsWidth, gn_appman.dmPelsHeight, gn_appman.dmBitsperPel) 
//end if

//close(gnvo_is.iw_input_simulator)
if iui_atom > 0 and not ib_running then
	GlobalDeleteAtom(iui_atom)
	iui_atom = 0
end if
if iui_atom_time > 0 then
	GlobalDeleteAtom(iui_atom_time)
	iui_atom_time = 0
end if
destroy gn_appman

destroy gnvo_is
end event

