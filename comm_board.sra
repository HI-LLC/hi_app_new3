$PBExportHeader$comm_board.sra
forward
global type comm_board from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
long gl_last_seq_num
string is_startupfile = "comm_board.ini"
end variables

global type comm_board from application
string appname = "comm_board"
end type
global comm_board comm_board

type prototypes

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
end prototypes

on comm_board.create
appname="comm_board"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on comm_board.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//open(w_comm_board_sa)
end event

event close;
end event

event systemerror;
end event

