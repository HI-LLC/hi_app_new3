$PBExportHeader$ilearninghelper.sra
$PBExportComments$Generated Application Object
forward
global type ilearninghelper from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
nvo_aba_appman gn_appman
boolean gb_lesson_is_playing = false
boolean gb_money_board_on
string is_startupfile, gs_vedio_file = ""
integer gi_token_num = 0
window gw_selection
w_money_board gw_money_board

end variables
global type ilearninghelper from application
string appname = "ilearninghelper"
string displayname = "Learning Helper Lessons"
end type
global ilearninghelper ilearninghelper

type prototypes
// window functions
FUNCTION integer _spawnl(int mode, ref string cmdname, string arg) LIBRARY "MSVCRT.DLL"
FUNCTION integer fnMkDir(string path) LIBRARY  "MSVCRT.DLL" ALIAS FOR "_mkdir"
FUNCTION integer fnRmDir(string path) LIBRARY  "MSVCRT.DLL" ALIAS FOR "_rmdir"
FUNCTION boolean GetCursorPos(ref structure mousepos) LIBRARY "user32.dll"
FUNCTION boolean SetCursorPos(ref structure mousepos) LIBRARY "user32.dll"
FUNCTION uint SetWindowPos(int hwnd, int hwnd_topmost, int x, int y, int cx, int cy, uint uflag) Library "user32.dll"
SUBROUTINE keybd_event (int bVk, int bScan, long dwFlags, long dwExtraInfo) LIBRARY	"USER32.DLL"
SUBROUTINE mouse_event (long dwFlags, long dx, long dy, long dwData, long dwExtraInfo) LIBRARY	"USER32.DLL"
FUNCTION boolean sndPlaySoundA (string SoundName, 		uint Flags) LIBRARY "WINMM.DLL"
Function boolean MoveFileA (ref string oldfile, ref string newfile) library "KERNEL32.DLL"
FUNCTION int GetDesktopWindow() Library "user32.dll"
FUNCTION uint GetWindow(uint x, int y) Library "user32.dll"
FUNCTION BOOLean IsWindow(uint x) Library "user32.dll"
FUNCTION BOOLean IsWindowVisible(uint x) Library "user32.dll"
FUNCTION int GetWindowTextA(int hwnd, REF string  lpstring, int nMaxCount) Library "user32.dll"
FUNCTION int GetClassNameA(int hwnd, REF string  lpstring, int nsize) Library "user32.dll"
FUNCTION BOOLean  ShowWindow(int hwnd, int ncmnd) Library "user32.dll"
FUNCTION BOOLean BringWindowToTop(uint x) Library "user32.dll"
FUNCTION BOOLean IsIconic(uint x) Library "user32.dll"
FUNCTION BOOLean GetTextExtentPoint32A(int hwnd, string lpstring, int cbString, ref str_size lpSize) Library "Gdi32.dll"
FUNCTION uint GetDCEx(int hwnd, int cliphwnd, long flags ) Library "user32.dll"
FUNCTION uint GetDC(int hwnd) Library "user32.dll"
FUNCTION BOOLean ExtTextOutA(int hdc, int x, int y, uint fuOptions, ref str_rect lprc, string lpString, uint cbCount, ref int lpDx) Library "Gdi32.dll"


// WIN32DLL.DLL
Function integer SetCurrentDir(string PathName) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_SetCurrentDir@4"
Function integer GetCurrentDir(integer DirLen, ref string PathName) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_GetCurrentDir@8"
Function integer fnDeleteFile( string asFileName) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnDeleteFile@4"
Function integer fnCopyFile(string asExistingFileName , string asNewFileName, integer aiFailIfExists) LIBRARY  "WIN32DLL.DLL" ALIAS FOR  "_fnCopyFile@10"
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
FUNCTION int fnAddResourceFile(string fname_prefix, string ExportType, boolean CompressInd) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnAddResourceFile@9"
FUNCTION int fnExtractResourceFile(string fname_prefix, string ExportType) LIBRARY "WIN32DLL.DLL" ALIAS FOR "_fnExtractResourceFile@8" 
FUNCTION int fnIntegrateExportFile(string FileName, string ExportType, int UpdateIndicator, boolean CompressInd) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnIntegrateExportFile@13"
FUNCTION int fnSplitImportFile(string FileName) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnSplitImportFile@4"
FUNCTION long fnCopyFolder(string SourcePath, string DestPath, long ParentHandle, ref string CopedFile) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_fnCopyFolder@16"
FUNCTION int Compress(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_Compress@8"
FUNCTION int Uncompress(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_Uncompress@8"
SUBROUTINE JPegHeaderComplement(string file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_JPegHeaderComplement@4"
SUBROUTINE JPegHeaderComplementOut(string input_file_name, string output_file_name) LIBRARY "WIN32DLL.DLL" ALIAS FOR  "_JPegHeaderComplementOut@8"
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
FUNCTION int SwapProgram(string NewProgram) LIBRARY "Internet.DLL" ALIAS FOR  "_SwapProgram@4"

end prototypes

type variables

end variables

on ilearninghelper.create
appname="ilearninghelper"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on ilearninghelper.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;integer li_method_id
string ls_file_name
gn_appman = create nvo_aba_appman
is_startupfile = "c:\Learning Helper.ini"
gn_appman.is_videofile_path = ".\videos\"
if FileExists(is_startupfile) then
	gs_vedio_file = ProfileString(is_startupfile, "reward", "vedio_file", "")
	gi_token_num = integer(ProfileString(is_startupfile, "reward", "token_num", "0"))
end if
Open(gn_appman.iw_frame,"w_internet_lh_mdi")
//open(w_lesson_selection)
//open(w_lesson_selection_lv)

		
end event

event close;//destroy gn_appman

if FileExists(is_startupfile) then
	SetProfileString(is_startupfile, "reward", "vedio_file", gs_vedio_file)
	SetProfileString(is_startupfile, "reward", "token_num", string(gi_token_num))
end if

if isvalid(gw_money_board) then
	close(gw_money_board)
end if
end event

