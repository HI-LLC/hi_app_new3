$PBExportHeader$graphic_digitizer_only.sra
$PBExportComments$Generated Application Object
forward
global type graphic_digitizer_only from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
constant integer SB_LINEUP	= 0
constant integer SB_LINEDOWN	= 1
constant integer SB_PAGEUP	= 2
constant integer SB_PAGEDOWN	= 3
constant integer SB_THUMBPOSITION = 4
constant integer SB_THUMBTRACK = 5
constant integer SB_TOP = 6
constant integer SB_BOTTOM	= 7
constant integer SB_ENDSCROLL = 8

nvo_aba_appman gn_appman

end variables

global type graphic_digitizer_only from application
string appname = "graphic_digitizer_only"
end type
global graphic_digitizer_only graphic_digitizer_only

type prototypes
// window functions
Function boolean MoveFileA (ref string oldfile, ref string newfile) library "KERNEL32.DLL"
Function uint GlobalAddAtomA (string as_atom) library "KERNEL32.DLL"
Function uint GlobalFindAtomA (string as_atom) library "KERNEL32.DLL"
Function uint GlobalDeleteAtom (uint aui_reff) library "KERNEL32.DLL"
Function uint FindWindow (string as_ClassName, String as_WindowName) library "KERNEL32.DLL"
Function long GetEnvironmentVariable(string lpName , ref string lpBuffer , long nSize )  Library "kernel32.dll" Alias for "GetEnvironmentVariableA"
Function long GetLongPathName(string lpName , ref string lpBuffer , long nSize )  Library "kernel32.dll" Alias for "GetLongPathNameA"

FUNCTION int GetDesktopWindow() Library "user32.dll"
FUNCTION uint GetWindow(uint x, int y) Library "user32.dll"
FUNCTION uint SetWindowPos(int hwnd, int hwnd_topmost, int x, int y, int cx, int cy, uint uflag) Library "user32.dll"
FUNCTION BOOLean IsWindow(uint x) Library "user32.dll"
FUNCTION BOOLean IsWindowVisible(uint x) Library "user32.dll"
FUNCTION int ShowCursor(BOOLean bShow) Library "user32.dll"
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
FUNCTION ulong GetPixel(ulong hwnd, long xpos, long ypos) LIBRARY "Gdi32.dll"
FUNCTION ulong SetPixel(ulong hwnd, long xpos, long ypos, ulong pcol) LIBRARY "Gdi32.dll"
FUNCTION ulong CreatePenIndirect(ref str_logpen logpen) LIBRARY "Gdi32.dll"
FUNCTION ulong CreateBrushIndirect(ref str_logbrush logbrush) LIBRARY "Gdi32.dll"
FUNCTION ulong CreateSolidBrush(long color) LIBRARY "Gdi32.dll"
FUNCTION ulong SelectObject(int hdc, long htool) LIBRARY "Gdi32.dll"
FUNCTION ulong DeleteObject(long htool) LIBRARY "Gdi32.dll"
FUNCTION ulong FillRect(long hdc, ref str_rect_long rect, long htool) LIBRARY "Gdi32.dll"
FUNCTION ulong FillRectangle(long hdc, str_rect_long rect, long htool) LIBRARY "Gdi32.dll"
FUNCTION ulong Rectangle(int hdc, int x, int y, int w, int h) LIBRARY "Gdi32.dll"
FUNCTION boolean MoveToEx(ulong hwnd,long wx, long wy,ref structure mousepos) LIBRARY "Gdi32.dll"
FUNCTION boolean LineTo(ulong hwnd,long wx, long wy) LIBRARY "Gdi32.dll"
FUNCTION integer _spawnl(int mode, ref string cmdname, string arg) LIBRARY "MSVCRT.DLL"
FUNCTION BOOLean ExtTextOutA(int hdc, int x, int y, uint fuOptions, ref str_rect lprc, string lpString, uint cbCount, ref int lpDx) Library "Gdi32.dll"
FUNCTION boolean sndPlaySoundA (string SoundName, 	uint Flags) LIBRARY "WINMM.DLL"
Function integer waveOutGetNumDevs() Library "WINMM.DLL"
FUNCTION ulong waveOutGetDevCaps(ulong uDeviceID,ref str_waveoutcaps lpCaps,ulong uSize) LIBRARY "winmm.dll" ALIAS FOR "waveOutGetDevCapsA"
FUNCTION ulong midiInGetDevCaps(ulong uDeviceID,ref str_midiincaps lpCaps,ulong uSize) LIBRARY "winmm.dll" ALIAS FOR "midiInGetDevCapsA"
FUNCTION ulong midiOutGetDevCaps(ulong uDeviceID,ref str_midioutcaps lpCaps,ulong uSize) LIBRARY "winmm.dll" ALIAS FOR "midiOutGetDevCapsA"
Function integer midiInGetNumDevs() Library "WINMM.DLL"
Function integer midiOutGetNumDevs() Library "WINMM.DLL"

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
SUBROUTINE extPutBinaryFile3(string host, string login, string password, string LocalFilePath, string RemoteFilePath) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutBinaryFile3@20"
FUNCTION int CreateLHOA(string Host, string Key, string Name, string Password, string LastName,string FirstName, string Email, string PasswordHint, string Address, string City, string State, string Country, string Zipcode, string Phone, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_CreateLHOA@60"
FUNCTION int LHOA_Login(long local_ind, string Host, string Key, string Name, string Password, ref long aID, ref long Trans_code, ref long pin, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_Login@36"
FUNCTION int LHOA_SQL_retrieve(string Host, string Key, string SQL, long aID, long Trans_code,  ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_retrieve@24"
FUNCTION int LHOA_SQL_retrieve2(string Host, string Key, string SQL, long aID, long Trans_code,  ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_retrieve2@24"
FUNCTION int LHOA_SQL_load(ref string aColName[], ref string aResultSet[]) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_load@8"
FUNCTION int LHOA_SQL_dml(string Host, string Key, string SQL, long aID, long Trans_code, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_dml@24"
FUNCTION int LHOA_SQL_dml2(string Host, string Key, string SQL, long aID, long Trans_code, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_dml2@24"
FUNCTION int extAddFile(string DestFile, string SourceFile) LIBRARY "Internet.DLL" ALIAS FOR  "_extAddFile@8"
FUNCTION int extExtractFile(string DestFile, string SourceFile, long fIndex, long fSize) LIBRARY "Internet.DLL" ALIAS FOR  "_extExtractFile@16"
FUNCTION int extGetImageFile(string IndexFile, string ImageFile, string RemoteFileName, string LocalFileName) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetImageFile@16"
FUNCTION int SetFileWallInfo(string Login, string Password) LIBRARY "Internet.DLL" ALIAS FOR  "_SetFileWallInfo@8"
FUNCTION int GetHostName(ref string Host) LIBRARY "Internet.DLL" ALIAS FOR  "_GetHostName@4"
FUNCTION int GetHomePath(ref string HomePath) LIBRARY "Internet.DLL" ALIAS FOR  "_GetHomePath@4"
FUNCTION int extAddIndex(string DestFile, string SourceFile, long FileSize, long FileIndex) LIBRARY "Internet.DLL" ALIAS FOR  "_extAddIndex@16" 
FUNCTION int extMakeiLessonPackage(string PackagePrefix, long LessonCount, long ResourceCount) LIBRARY "Internet.DLL" ALIAS FOR  "_extMakeiLessonPackage@12" 
FUNCTION int extExtractPackageFile(string PackagePrefix, string DestFile, long SourceInd) LIBRARY "Internet.DLL" ALIAS FOR  "_extExtractPackageFile@12"
FUNCTION int extExtractPackageFile2(string PackagePrefix, string DestFile, string Timestamp, long Index, long Size, long SourceInd) LIBRARY "Internet.DLL" ALIAS FOR  "_extExtractPackageFile2@24" 
FUNCTION int extGetPkgHeader(string PackagePrefix, ref str_lesson_package pkrec) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetPkgHeader@8" 
FUNCTION int extGetPkgLessonList(string PackagePrefix, ref string LessonList[]) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetPkgLessonList@8" 
FUNCTION int SwapProgram(string NewProgram) LIBRARY "Internet.DLL" ALIAS FOR  "_SwapProgram@4"
FUNCTION int extUploadResourceFiles(string fname_prefix, string remote_path_prefix) LIBRARY "Internet.DLL" ALIAS FOR  "_extUploadResourceFiles@8"
FUNCTION int extUploadLessonFiles(string fname_prefix, string remote_path_prefix) LIBRARY "Internet.DLL" ALIAS FOR  "_extUploadLessonFiles@8"
FUNCTION int extRunBatchSQL(string Host,string Key,long aID, long Trans_code, ref string ReturnStatus) LIBRARY "Internet.DLL" ALIAS FOR  "_extRunBatchSQL@20"
FUNCTION int NativeInternetLogin() LIBRARY "Internet.DLL" ALIAS FOR  "_NativeInternetLogin@0"
FUNCTION int LHOA_SQL_version_validate(string ApplicationName, long VersionNum, long BuildNum) LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_SQL_version_validate@12"
FUNCTION int LHOA_download_installer() LIBRARY "Internet.DLL" ALIAS FOR  "_LHOA_download_installer@0"
FUNCTION int extsndPlaySound(string IndexFile, string ImageFile, string RemoteFileName, long al_flag) LIBRARY "Internet.DLL" ALIAS FOR  "_extsndPlaySound@16" 
FUNCTION int ping(string ip_or_dns) LIBRARY "Internet.DLL" ALIAS FOR  "_ping@4"
FUNCTION int extRetrieveResIndex(string IndexFile, ref string FileList[], ref string Timestamp[]) LIBRARY "Internet.DLL" ALIAS FOR  "_extRetrieveResIndex@12"
FUNCTION int extResIndexCount(string IndexFile, ref string SysDateTime) LIBRARY "Internet.DLL" ALIAS FOR  "_extResIndexCount@8"
FUNCTION int extPutImageFile(string IndexFile, string ImageFile, string LocalFileName, string RemoteFileName, ref string Timestamp, long ImageSize) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutImageFile@24"
FUNCTION int extPutImageFile2(string IndexFile, string ImageFile, string LocalFileName, string RemoteFileName, ref string Timestamp, long ImageSize) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutImageFile2@24"
FUNCTION long extGetImage(string IndexFile, string ImageFile, string RemoteFileName, ref string ImageBuf) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetImage@16"
FUNCTION int extPutImage(string IndexFile, string ImageFile, string RemoteFileName, string ImageBuf, string Timestamp, long ImageSize) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutImage@24" 
FUNCTION long extGetResourceImageSize(string IndexFile, string RemoteFileName) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetResourceImageSize@8"
FUNCTION long SetPBcharVariables(string VarName, string VarValue) LIBRARY "Internet.DLL" ALIAS FOR  "_SetPBcharVariables@8"

FUNCTION long extSetPBwinHandleToSharedMemory(long al_handle) LIBRARY "Internet.DLL" ALIAS FOR  "_extSetPBwinHandleToSharedMemory@4"
FUNCTION long extSetMusicNoteToSharedMemory(string as_note) LIBRARY "Internet.DLL" ALIAS FOR  "_extSetMusicNoteToSharedMemory@4"
FUNCTION long extCloseMusicSharedMemory() LIBRARY "Internet.DLL" ALIAS FOR  "_extCloseMusicSharedMemory@0"
FUNCTION ulong GetBitNum(ulong aul_data, long al_from, long al_to) LIBRARY "Internet.DLL" ALIAS FOR  "_GetBitNum@12"
FUNCTION int extPutCoordGraphFile(string IndexFile, string ImageFile, ref long Xarray[], ref long Yarray[], long ArraySize, string RemoteFileName, ref string Timestamp) LIBRARY "Internet.DLL" ALIAS FOR  "_extPutCoordGraphFile@28"
FUNCTION int extMkCoordGraphFile(string ImageFile, ref long Xarray[], ref long Yarray[], long ArraySize) LIBRARY "Internet.DLL" ALIAS FOR  "_extMkCoordGraphFile@16"
FUNCTION int extCreateResourceFile(string IndexFile, string ImageFile) LIBRARY "Internet.DLL" ALIAS FOR  "_extCreateResourceFile@8"
FUNCTION int extGetCoordGraphCount(string IndexFile, string ImageFile, string RemoteFileName) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetCoordGraphCount@12"
FUNCTION int extGetCoordGraphFile(string IndexFile, string ImageFile, ref long Xarray[], ref long Yarray[], long ArraySize, string RemoteFileName) LIBRARY "Internet.DLL" ALIAS FOR  "_extGetCoordGraphFile@24"
SUBROUTINE CreateWindowForPB(string WinType,long ParentHandle, long AppModule, ref long WinHandle) LIBRARY	"graphic.DLL" ALIAS FOR  "_CreateWindowForPB@16"
SUBROUTINE extGetWinTextInHexString(long WinHandle, ref string HexString) LIBRARY	"graphic.DLL" ALIAS FOR  "_extGetWinTextInHexString@8"
SUBROUTINE extSetWinTextInHexString(long WinHandle, string HexString) LIBRARY	"graphic.DLL" ALIAS FOR  "_extSetWinTextInHexString@8"

subroutine do_paint_with_hdc_ext(long ext_hdc, ref string BitmapPtr, long ascii_size, long bin_size) Library "graphic.dll" ALIAS FOR "_do_paint_with_hdc_ext@16"
subroutine do_paint_ext(long WndHandle, ref string BitmapPtr, long ascii_size, long bin_size) library "graphic.dll" alias for "_do_paint_ext@16"
subroutine do_paint_ext2(long dcHandle, ref str_rect_long rect,ref string BitmapPtr, long ascii_size, long bin_size) library "graphic.dll" alias for "_do_paint_ext2@20"
subroutine PaintExtWinGraph(long WndHandle, string FileName) Library "graphic.dll" ALIAS FOR "_PaintExtWinGraph@8"
subroutine LoadGraph(long WndHandle, string FileName, ref string BitmapPtr, ref long ascii_size, ref long bin_size) library "graphic.dll" alias for "_LoadGraph@20"
subroutine LoadGraph2(string FileName, ref string BitmapPtr, ref long ascii_size, ref long bin_size) library "graphic.dll" alias for "_LoadGraph2@16"
subroutine LoadGraph3(long hdc, string FileName) library "graphic.dll" alias for "_LoadGraph3@8"
subroutine GetGraphDim(string FileName, ref long Width,ref long Height) library "graphic.dll" alias for "_GetGraphDim@12"
subroutine DrawGraph(long hDC,string FileName,ref str_rect_long destRect,long SourceX,long SourceY,long StretchInd,long TransparentColor) library "graphic.dll" alias for "_DrawGraph@28"
subroutine CopyGraph(long sourceDC, long destDC,ref str_rect_long sourceRect, ref str_rect_long destRect) library "graphic.dll" alias for "_CopyGraph@16"
subroutine GetGraphData(string FileName, ref string BitmapPtr, ref long ascii_size, ref long bin_size) library "graphic.dll" alias for "_GetGraphData@16"
subroutine ConvertGraphFile(string InFileName, string OutFileName) library "graphic.dll" alias for "_ConvertGraphFile@8"
subroutine extTextOutFromPB(long hDC,long LangInd,long xpos,long ypos,ref long TextList[],long ArraySize,long TextColor,ref str_logfont lpLogfont) library "graphic.dll" alias for "_extTextOutFromPB@32"
subroutine extTextOutFromPB2(long hDC,long LangInd,ref str_rect_long rect,ref long TextList[],long ArraySize,long TextColor,ref str_logfont lpLogfont,long Alignment) library "graphic.dll" alias for "_extTextOutFromPB2@32"
subroutine extDrawRadioButton(long hDC,long LangInd,long xpos,long ypos,ref long TextList[],long ArraySize,long TextColor,ref str_logfont lpLogfont,long ControlType,long Radius,long OnOffInd) library "graphic.dll" alias for "_extDrawRadioButton@44"
subroutine extDrawButton(long hDC,long LangInd,long xpos,long ypos,ref long TextList[],long ArraySize,ref str_logfont lpLogfont,ref str_point_long PolyPoints[],ref long PointCounts[],long PolyCounts,long ControlColor,long ControlType,long Radius,long OnOffInd)  library "graphic.dll" alias for "_extDrawButton@56"
subroutine free_memory(long WndHandle, ref string BitmapPtr) Library "graphic.dll" ALIAS FOR "_free_memory@8"
subroutine extHexString2Number(string HexStringIn,ref ulong NumberOut[]) Library "graphic.dll" ALIAS FOR "_extHexString2Number@8"
subroutine GetClipTempGraph(long hDC, string FileName,ref string BitmapPtr, long TransColor,ref long ascii_size,ref long bin_size) Library "graphic.dll" ALIAS FOR "_GetClipTempGraph@24"
subroutine CaptureImage(long hDC, ref str_rect_long rect,ref string BitmapPtr,ref long ascii_size, ref long bin_size) Library "graphic.dll" ALIAS FOR "_CaptureImage@20" 
subroutine extMakeTransImage(long hDC,string ImageTemplate,string BackgroundImage,string SourceImage,ref string TargetImage,long ascii_size,long bin_size,long xpos,long ypos) Library "graphic.dll" ALIAS FOR "_extMakeTransImage@36"

subroutine LoadGraph(long WndHandle, string FileName) library "graphic.dll" ALIAS FOR "_LoadGraph@8"
subroutine ScreenShot(long WndHandle, string FileName) library "graphic.dll" ALIAS FOR "_ScreenShot@8"
//subroutine SetAppWatchStatus(string FileName, int status) library "graphic.dll"
subroutine SetGraphicFileType(boolean FileType) library "graphic.dll" ALIAS FOR "_SetGraphicFileType@1"
FUNCTION long  WaveFileDuration(string FileName) library "voiceman.dll" ALIAS FOR "_WaveFileDuration@4"
//SUBROUTINE PlayVideo() library "wmplayer_wrapper.dll" ALIAS FOR "_PlayVideo@0"
FUNCTION long PlayVideo(string FileName, long pb_handle, long session, long offset) library "voiceman.dll" ALIAS FOR "_PlayVideo@16"
FUNCTION long GetCurrentPosition() library "voiceman.dll" ALIAS FOR "GetCurrentPosition@0"
FUNCTION long Dummy() library "wmplayer_wrapper.dll" ALIAS FOR "_Dummy@0"
subroutine CaptureImageRegion(long sourceDC, string FileName,long sourceX,long sourceY, long Width,long Height) Library "graphic.dll" ALIAS FOR "_CaptureImageRegion@24"


subroutine extStartPianoThread2(long pb_handle,long pb_kb_handle,long pb_dc,string WinTitle,ref long ThreadID) Library "MusicLesson.dll" ALIAS FOR "_extStartPianoThread2@20"
FUNCTION boolean extPostThreadMessage(long idThread,long Msg, long wParam, ulong lParam) LIBRARY "MusicLesson.dll" ALIAS FOR "_extPostThreadMessage@16"
FUNCTION int extClearGraphLib()  Library "MusicLesson.dll" ALIAS FOR "_extClearGraphLib@0"
FUNCTION int extClearCurGraph()  Library "MusicLesson.dll" ALIAS FOR "_extClearCurGraph@0"
FUNCTION int extLoadGraphData(ref long Xarray[], ref long Yarray[], long ArraySize, long EntryID)  Library "MusicLesson.dll" ALIAS FOR "_extLoadGraphData@16"
FUNCTION int extCurrentEntry(ref long lh_id[],ref long lh_note_id[],ref long lh_note_x[],ref long lh_note_y[],ref long lh_width_pct[],ref long lh_height_pct[],long lh_size, ref long rh_id[],ref long rh_note_id[],ref long rh_note_x[],ref long rh_note_y[],ref long rh_width_pct[],ref long rh_height_pct[],long rh_size)  Library "MusicLesson.dll" ALIAS FOR "_extCurrentEntry@56"
FUNCTION int extToGetFingerCoord(long getFingerCoord) Library "MusicLesson.dll" ALIAS FOR "_extToGetFingerCoord@4"
FUNCTION int extResizeGraphLib(long vecSize) Library "MusicLesson.dll" ALIAS FOR "_extResizeGraphLib@4"
FUNCTION int extSetKeyboardParms(long PBhandle,long LowNote,long HighNote,long PrimOrSecondInd,long PromptInd,long FingerPromptInd,ref string DevName1,ref string DevName2) Library "MusicLesson.dll" ALIAS FOR "_extSetKeyboardParms@32"
FUNCTION int extSetCurrentNote(string CurrentNote) Library "MusicLesson.dll" ALIAS FOR "_extSetCurrentNote@4"
subroutine extDllTest() Library "MusicLesson.dll" ALIAS FOR "_extDllTest@0"
subroutine extToggleMIDI(long MIDIon) Library "MusicLesson.dll" ALIAS FOR "_extToggleMIDI@4"


end prototypes

on graphic_digitizer_only.create
appname="graphic_digitizer_only"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on graphic_digitizer_only.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gn_appman = create nvo_aba_appman 
open(w_graph_digitize)

end event

event close;destroy gn_appman
end event

