$PBExportHeader$nvo_lesson_export_import.sru
forward
global type nvo_lesson_export_import from nvo_base
end type
end forward

global type nvo_lesson_export_import from nvo_base
end type
global nvo_lesson_export_import nvo_lesson_export_import

type prototypes

end prototypes

type variables
constant integer ici_updated_export = 0
constant integer ici_insert_export = 1
constant integer ici_the_item_only = 0
constant integer ici_inclusive = 1
string is_resource_file_list[], is_lesson_file_list[], is_resource_dir_list[]
integer ii_SQL_FileNum, ii_Resource_Index_FileNum, ii_Lesson_Index_FileNum, ii_Resource_Dir_List_FileNum
end variables

forward prototypes
public function integer of_export_resource_dir_list (string as_dir_path)
public function integer of_init_import ()
public function integer of_export_preposition (long al_word_id, integer ai_insert_update_ind)
public function integer of_export_response_to_right (long al_response_id, integer ai_insert_update_ind)
public function integer of_export_response_to_wrong (long al_response_id, integer ai_insert_update_ind)
public function integer of_export_instruction (long al_instruction_id, integer ai_insert_update_ind)
public function integer of_post_exporting (string as_export_file, string as_export_type, integer ai_update_ind)
public function integer of_export_resource_index (string as_file_path)
public function integer of_export_prompt_inst (long al_prompt_id, integer ai_insert_update_ind)
public function integer of_export_lesson_index (string as_file_path)
public function integer of_export_content (long al_content_id)
public function string of_export_lesson (long al_lesson_id, integer ai_insert_update_ind, integer ai_export_ind)
public function string of_export_ilesson (long al_lesson_id, integer ai_insert_update_ind, integer ai_export_ind)
public function integer of_init_export ()
end prototypes

public function integer of_export_resource_dir_list (string as_dir_path);integer li_i
long ll_filelength
boolean lb_file_in_the_list
lb_file_in_the_list = false
for li_i = 1 to upperbound(is_resource_dir_list)
	if lower(as_dir_path) = is_resource_dir_list[li_i] then
		lb_file_in_the_list = true
		exit
	end if
next
if not lb_file_in_the_list then
	is_resource_file_list[upperbound(is_resource_dir_list) + 1] = lower(as_dir_path)
	FileWrite(ii_resource_dir_list_filenum, lower(as_dir_path)) 
end if
return 1
end function

public function integer of_init_import ();integer li_row, li_value
long ll_lesson_id
string ls_Docname, ls_named, ls_sql_statement
string ls_resource_file_prefix, ls_lesson_file_prefix = ""
ls_resource_file_prefix = gn_appman.is_app_path
Pointer lp_oldpointer
lp_oldpointer = SetPointer ( HourGlass! )
li_value = GetFileOpenName("Select File To Be Imported", ls_Docname, ls_named, "EXP", "Export File (*.EXP),*.EXP")

if li_value <> 1 then
//	MessageBox("Error", "Not a valid file name specified")
	return 0
end if
ls_resource_file_prefix = gn_appman.is_app_path
if fnSplitImportFile(ls_named) > 0 then
	fnExtractResourceFile(ls_lesson_file_prefix, "nDBLH_LESSON")
	fnExtractResourceFile(ls_resource_file_prefix, "LESSON")
	ii_sql_filenum = FileOpen("c:\lh_sql_export_tmp.sql")
	do while FileRead(ii_sql_filenum, ls_sql_statement) > 0
//		MessageBox("ls_sql_statement", ls_sql_statement)
//		of_import_execute_sql(ls_sql_statement)
	loop
	commit;
//	FileDelete("c:\lh_sql_export_tmp.sql")
//	FileDelete("c:\lh_res_index_export_tmp.txt")
//	FileDelete("c:\lh_res_export_tmp.bny")
//	FileDelete("c:\lh_directory_list.txt")	
end if
return 1 

end function

public function integer of_export_preposition (long al_word_id, integer ai_insert_update_ind);		string ls_description, ls_wave_file, ls_sql_statement, ls_filepath
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
any la_key_column_values[], la_column_values[], la_empty_list[]
if isnull(al_word_id) then return 0
if al_word_id = 0 then return 0
select description, wave_file into :ls_description, :ls_wave_file
from preposition
where word_id = :al_word_id;
if not isnull(ls_wave_file) then 		// write resource file inde
	if trim(ls_wave_file) <> '' then
		ls_filepath = 'Static Table\wave\Preposition\' + ls_wave_file
		of_export_resource_index(ls_filepath)
	end if
end if

return 1
end function

public function integer of_export_response_to_right (long al_response_id, integer ai_insert_update_ind);string ls_description, ls_wave_file, ls_sql_statement, ls_filepath
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
any la_key_column_values[], la_column_values[], la_empty_list[]
if isnull(al_response_id) then return 0
if al_response_id = 0 then return 0
select description, wave_file into :ls_description, :ls_wave_file
from response_to_right
where response_id = :al_response_id;
if not isnull(ls_wave_file) then 		// write resource file inde
	if trim(ls_wave_file) <> '' then
		ls_filepath = 'Static Table\wave\Response To Right\' + ls_wave_file
		of_export_resource_index(ls_filepath)
	end if
end if
return 1
end function

public function integer of_export_response_to_wrong (long al_response_id, integer ai_insert_update_ind);string ls_description, ls_wave_file, ls_sql_statement, ls_filepath
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
any la_key_column_values[], la_column_values[], la_empty_list[]
if isnull(al_response_id) then return 0
if al_response_id = 0 then return 0
select description, wave_file into :ls_description, :ls_wave_file
from response_to_wrong
where response_id = :al_response_id;
if not isnull(ls_wave_file) then 		// write resource file inde
	if trim(ls_wave_file) <> '' then
		ls_filepath = 'Static Table\wave\Response To Wrong\' + ls_wave_file
		of_export_resource_index(ls_filepath)
	end if
end if

return 1
end function

public function integer of_export_instruction (long al_instruction_id, integer ai_insert_update_ind);string ls_description, ls_wave_file, ls_sql_statement, ls_filepath
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
any la_key_column_values[], la_column_values[], la_empty_list[]
if isnull(al_instruction_id) then return 0
if al_instruction_id = 0 then return 0
select description, wave_file into :ls_description, :ls_wave_file
from instruction
where instruction_id = :al_instruction_id;
if not isnull(ls_wave_file) then 		// write resource file inde
	if trim(ls_wave_file) <> '' then
		ls_filepath = 'Static Table\wave\instruction\' + ls_wave_file
		of_export_resource_index(ls_filepath)
	end if
end if

return 1
end function

public function integer of_post_exporting (string as_export_file, string as_export_type, integer ai_update_ind);string ls_resource_file_prefix, ls_lesson_file_prefix 
string ls_export_type
ls_resource_file_prefix = gn_appman.is_app_path
ls_lesson_file_prefix = ""
//MessageBox("ls_resource_file_prefix", ls_resource_file_prefix)
//MessageBox("ls_lesson_file_prefix", ls_lesson_file_prefix)
//FileClose(ii_sql_filenum)
FileClose(ii_resource_index_filenum)
FileClose(ii_lesson_index_filenum)
//FileClose(ii_resource_dir_list_filenum)
//MessageBox("of_post_exporting", "Before nDBLH_LESSON")
ls_export_type = "nDBLH_LESSON"
fnAddResourceFile(ls_lesson_file_prefix, ls_export_type, 1)
//MessageBox("of_post_exporting", "After nDBLH_LESSON")
ls_export_type = "RESOURCE"
fnAddResourceFile(ls_resource_file_prefix, ls_export_type, 0)
//MessageBox("of_post_exporting", "After LESSON")
//MessageBox("as_export_file", as_export_file)
fnIntegrateExportFile(as_export_file, as_export_type, ai_update_ind, 0)
//MessageBox("of_post_exporting", "After fnIntegrateExportFile")

return 1


end function

public function integer of_export_resource_index (string as_file_path);integer li_i
long ll_filelength
boolean lb_file_in_the_list
lb_file_in_the_list = false
//MessageBox("of_export_resource_index: as_file_path", as_file_path)
for li_i = 1 to upperbound(is_resource_file_list)
	if lower(as_file_path) = is_resource_file_list[li_i] then
		lb_file_in_the_list = true
		exit
	end if
next
if not lb_file_in_the_list then
	is_resource_file_list[upperbound(is_resource_file_list) + 1] = lower(as_file_path)
	If not FileExists(gn_appman.is_app_path + as_file_path) then
		MessageBox("Error - of_export_resource_index", "File: " + gn_appman.is_app_path + as_file_path + " does not exist!")
		return 0
	end if
	ll_filelength = FileLength(gn_appman.is_app_path + as_file_path)
	FileWrite(ii_Resource_Index_FileNum, lower(as_file_path)) 
	FileWrite(ii_Resource_Index_FileNum, string(ll_filelength))
end if
return 1
end function

public function integer of_export_prompt_inst (long al_prompt_id, integer ai_insert_update_ind);string ls_description, ls_wave_file, ls_sql_statement, ls_filepath
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
any la_key_column_values[], la_column_values[], la_empty_list[]
if isnull(al_prompt_id) then return 0
if al_prompt_id = 0 then return 0
select description, wave_file into :ls_description, :ls_wave_file
from prompt
where prompt_id = :al_prompt_id;
if not isnull(ls_wave_file) then 		// write resource file inde
	if trim(ls_wave_file) <> '' then
		ls_filepath = 'Static Table\wave\Prompt\' + ls_wave_file
		of_export_resource_index(ls_filepath)
	end if
end if

return 1
end function

public function integer of_export_lesson_index (string as_file_path);integer li_i
long ll_filelength
boolean lb_file_in_the_list
lb_file_in_the_list = false
for li_i = 1 to upperbound(is_lesson_file_list)
	if as_file_path = is_lesson_file_list[li_i] then
		lb_file_in_the_list = true
		exit
	end if
next
if not lb_file_in_the_list then
	is_lesson_file_list[upperbound(is_lesson_file_list) + 1] = as_file_path
	If not FileExists(as_file_path) then
		MessageBox("Error - of_export_lesson_index", "File: " + as_file_path + " does not exist!")
		return 0
	end if
	ll_filelength = FileLength(as_file_path)
	FileWrite(ii_Lesson_Index_FileNum, as_file_path) 
	FileWrite(ii_Lesson_Index_FileNum, string(ll_filelength))
end if
return 1
end function

public function integer of_export_content (long al_content_id);long ll_content_id, ll_chapter_id, ll_subject_id, ll_total_correct_answers, ll_total_tries
string ls_description, ls_bitmap_file, ls_wave_file, ls_details
string ls_subject_desc, ls_chapter_desc, ls_filepath, ls_sql_statement
double lf_wave_time
string ls_column_names[], ls_key_column_names[], ls_empty_list[]
any la_column_values[], la_key_column_values[], la_empty_list[]

SELECT content_id, chapter_id, description, bitmap_file, wave_file, total_correct_answers, total_tries, details, wave_time
INTO :ll_content_id, :ll_chapter_id, :ls_description,
	:ls_bitmap_file, :ls_wave_file, :ll_total_correct_answers,
	:ll_total_tries, :ls_details, :lf_wave_time
FROM content
WHERE content_id = :al_content_id;

SELECT subject_id, description
INTO :ll_subject_id, :ls_chapter_desc
FROM chapter
WHERE chapter_id = :ll_chapter_id;

SELECT description
INTO :ls_subject_desc
FROM subject
WHERE subject_id = :ll_subject_id;

if not isnull(ls_bitmap_file) then 		// write resource file inde
	if trim(ls_bitmap_file) <> '' then
		ls_filepath = 'materials\bitmap\' + ls_subject_desc + '\' + ls_chapter_desc + '\' + ls_bitmap_file
		of_export_resource_index(ls_filepath)
	end if		
end if

if not isnull(ls_wave_file) then 		// write resource file inde
	if trim(ls_wave_file) <> '' then
		if ls_wave_file = 'DICTIONARY' then
			if IsNumber(ls_details) then
				ls_filepath = "Static Table\wave\Dictionary\Numbers\" + ls_details + ".wav"
			else
				ls_filepath = "Static Table\wave\Dictionary\" + upper(left(ls_details, 1)) + "\" + ls_details + ".wav"			
			end if
		else	
			ls_filepath = 'materials\wave\' + ls_subject_desc + '\' + ls_chapter_desc + '\' + ls_wave_file
		end if	
		of_export_resource_index(ls_filepath)
	end if
end if

return 1
end function

public function string of_export_lesson (long al_lesson_id, integer ai_insert_update_ind, integer ai_export_ind);integer li_i, li_j, li_count
long ll_lesson_id, ll_student_id, ll_teacher_id, ll_chapter_id, ll_subject_id, ll_content_id
long ll_response_to_right_id, ll_response_to_wrong_id, ll_instruction_id, ll_preposition1, ll_preposition2
long ll_instruction_id2, ll_method_id, ll_prompt_inst, ll_threshold_min_count
long ll_lesson_content_id, ll_rowcount, ll_colcount, ll_col, ll_row, ll_new_row
double ldb_degree, ldb_tries, ldb_threshold
string ls_description,ls_picture_ind,ls_text_ind,ls_lesson_type,ls_data_collection_ind,ls_pair_ind,ls_prompt_ind,ls_active_ind
string ls_subject_desc, ls_chapter_desc, ls_filepath, ls_sql_statement
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
string ls_lesson_file_name, ls_coltype, ls_expression
string ls_bitmap_path, ls_wavefile_path
datetime ldt_now
date ld_now
ld_now = today()
ldt_now= datetime(ld_now, now())
any la_key_column_values[], la_column_values[], la_empty_list[]
datastore lds_lesson, lds_lesson_container
lds_lesson = create datastore
lds_lesson.dataobject = 'd_lesson'
lds_lesson.SetTransObject(SQLCA)
lds_lesson.Retrieve(al_lesson_id)
ll_rowcount = lds_lesson.rowcount()
	if ll_rowcount < 1 then 
		destroy lds_lesson
		return "-1"
	end if
ll_colcount = long(lds_lesson.object.datawindow.column.count)
for ll_col = 1 to ll_colcount
	ls_expression = "#" + string(ll_col) + ".ColType"
	ls_coltype = left(lds_lesson.Describe(ls_expression), 5)
	for ll_row = 1 to ll_rowcount
		if isnull(lds_lesson.object.data[ll_row, ll_col]) then
			choose case ls_coltype
				case "char("
					lds_lesson.object.data[ll_row, ll_col] = " "
				case "date"
					lds_lesson.object.data[ll_row, ll_col] = ld_now
				case "datet"
					lds_lesson.object.data[ll_row, ll_col] = ldt_now
				case else
					lds_lesson.object.data[ll_row, ll_col] = 0
			end choose
		end if
	next
next
//MessageBox("rowcount", ll_rowcount)
select student_id, teacher_id, description, response_to_right_id, response_to_wrong_id, 
		instruction_id, degree,	tries, picture_ind, text_ind, lesson_type, preposition1, 
		preposition2, instruction_id2, method_id, data_collection_ind, pair_ind, prompt_ind, 
		prompt_inst, threshold, threshold_min_count, active_ind 
into :ll_student_id, :ll_teacher_id, :ls_description, :ll_response_to_right_id, :ll_response_to_wrong_id, 
		:ll_instruction_id, :ldb_degree,	:ldb_tries, :ls_picture_ind, :ls_text_ind, :ls_lesson_type, :ll_preposition1, 
		:ll_preposition2, :ll_instruction_id2, :ll_method_id, :ls_data_collection_ind, :ls_pair_ind, :ls_prompt_ind, 
		:ll_prompt_inst, :ldb_threshold, :ll_threshold_min_count, :ls_active_ind 
from lesson 
where lesson_id = :al_lesson_id;
//ls_lesson_file_name = "C:\" + ls_description + ".txt"
ls_lesson_file_name = string(ll_method_id, "00") + ls_description + ".txt"
lds_lesson.SaveAs(ls_lesson_file_name, Text!, FALSE)
of_export_preposition(ll_preposition1, ai_insert_update_ind)
of_export_preposition(ll_preposition2, ai_insert_update_ind)
of_export_instruction(ll_instruction_id, ai_insert_update_ind)
of_export_instruction(ll_instruction_id2, ai_insert_update_ind)
of_export_response_to_right(ll_response_to_right_id, ai_insert_update_ind)
of_export_response_to_wrong(ll_response_to_wrong_id, ai_insert_update_ind)
of_export_prompt_inst(ll_prompt_inst, ai_insert_update_ind)
of_export_lesson_index(ls_lesson_file_name)
if ll_method_id = 15 or ll_method_id = 16 then
	ls_lesson_file_name = string(ll_method_id, "00") + ls_description + "_con.txt"
	lds_lesson_container = create datastore
	lds_lesson_container.dataobject = 'd_lesson_container'
	lds_lesson_container.SetTransObject(SQLCA)
	ll_rowcount = lds_lesson_container.Retrieve(al_lesson_id)
	if ll_rowcount < 1 then 
		destroy lds_lesson
		return "-1"
	end if
	for ll_row = 1 to ll_rowcount
		ls_bitmap_path = trim(lds_lesson_container.GetItemString(ll_row, 'bitmap_file'))
		if isnull(ls_bitmap_path) then ls_bitmap_path = ""
		if ls_bitmap_path <> "" then
			ls_bitmap_path = "Static Table\bitmap\container\" + ls_bitmap_path
			of_export_resource_index(ls_bitmap_path)
		end if
		ls_wavefile_path = trim(lds_lesson_container.GetItemString(ll_row, 'wave_file'))
		if isnull(ls_wavefile_path) then ls_wavefile_path = ""
		if ls_wavefile_path <> "" then
			ls_wavefile_path = "Static Table\wave\container\" + ls_wavefile_path
			of_export_resource_index(ls_wavefile_path)
		end if
		ls_bitmap_path = trim(lds_lesson_container.GetItemString(ll_row, 'bean_bitmap_file'))
		if isnull(ls_bitmap_path) then ls_bitmap_path = ""
		if ls_bitmap_path <> "" then
			ls_bitmap_path = "Static Table\bitmap\Bean\" + ls_bitmap_path
			of_export_resource_index(ls_bitmap_path)
		end if
		ls_wavefile_path = trim(lds_lesson_container.GetItemString(ll_row, 'bean_wave_file'))
		if isnull(ls_wavefile_path) then ls_wavefile_path = ""
		if ls_wavefile_path <> "" then
			ls_wavefile_path = "Static Table\wave\Bean\" + ls_wavefile_path
			of_export_resource_index(ls_wavefile_path)
		end if
	next	
	ll_colcount = long(lds_lesson_container.object.datawindow.column.count)
	ll_rowcount = lds_lesson_container.RowCount()
	for ll_col = 1 to ll_colcount
		ls_expression = "#" + string(ll_col) + ".ColType"
		ls_coltype = trim(left(lds_lesson_container.Describe(ls_expression), 5))
		for ll_row = 1 to ll_rowcount
			if isnull(lds_lesson_container.object.data[ll_row, ll_col]) then
				choose case ls_coltype
					case "char("
						lds_lesson_container.object.data[ll_row, ll_col] = " "
					case else
						lds_lesson_container.object.data[ll_row, ll_col] = 0
				end choose
			end if
		next
	next	
	lds_lesson_container.SaveAs(ls_lesson_file_name, Text!, FALSE)
	destroy lds_lesson_container
	of_export_lesson_index(ls_lesson_file_name)		
end if
DECLARE content_cur CURSOR FOR
	select content_id
	from lesson_content
	where lesson_content.lesson_id = :al_lesson_id;
OPEN content_cur;
do 	
	FETCH content_cur INTO :ll_content_id;
	IF SQLCA.sqlcode <> 0 THEN exit
	of_export_content(ll_content_id)
LOOP WHILE SQLCA.sqlcode <> 100 or  SQLCA.sqlcode <> -1
Close content_cur;
destroy lds_lesson

return left(ls_lesson_file_name, len(ls_lesson_file_name) - 4)

end function

public function string of_export_ilesson (long al_lesson_id, integer ai_insert_update_ind, integer ai_export_ind);integer li_i, li_j, li_count
long ll_lesson_id, ll_student_id, ll_teacher_id, ll_chapter_id, ll_subject_id, ll_content_id
long ll_response_to_right_id, ll_response_to_wrong_id, ll_instruction_id, ll_preposition1, ll_preposition2
long ll_instruction_id2, ll_method_id, ll_prompt_inst, ll_threshold_min_count
long ll_lesson_content_id, ll_rowcount, ll_colcount, ll_col, ll_row, ll_new_row
double ldb_degree, ldb_tries, ldb_threshold
string ls_description,ls_picture_ind,ls_text_ind,ls_lesson_type,ls_data_collection_ind,ls_pair_ind,ls_prompt_ind,ls_active_ind
string ls_subject_desc, ls_chapter_desc, ls_filepath, ls_sql_statement
string ls_key_column_names[], ls_column_names[], ls_empty_list[]
string ls_lesson_file_name, ls_coltype, ls_expression
string ls_bitmap_path, ls_wavefile_path
datetime ldt_now
date ld_now
ld_now = today()
ldt_now= datetime(ld_now, now())
any la_key_column_values[], la_column_values[], la_empty_list[]
datastore lds_lesson, lds_lesson_container
lds_lesson = create datastore
lds_lesson.dataobject = 'd_lesson'
lds_lesson.SetTransObject(SQLCA)
lds_lesson.Retrieve(al_lesson_id)
ll_rowcount = lds_lesson.rowcount()
	if ll_rowcount < 1 then 
		destroy lds_lesson
		return "-1"
	end if
ll_colcount = long(lds_lesson.object.datawindow.column.count)
for ll_col = 1 to ll_colcount
	ls_expression = "#" + string(ll_col) + ".ColType"
	ls_coltype = left(lds_lesson.Describe(ls_expression), 5)
	for ll_row = 1 to ll_rowcount
		if isnull(lds_lesson.object.data[ll_row, ll_col]) then
			choose case ls_coltype
				case "char("
					lds_lesson.object.data[ll_row, ll_col] = " "
				case "date"
					lds_lesson.object.data[ll_row, ll_col] = ld_now
				case "datet"
					lds_lesson.object.data[ll_row, ll_col] = ldt_now
				case else
					lds_lesson.object.data[ll_row, ll_col] = 0
			end choose
		end if
	next
next
//MessageBox("rowcount", ll_rowcount)
select student_id, teacher_id, description, response_to_right_id, response_to_wrong_id, 
		instruction_id, degree,	tries, picture_ind, text_ind, lesson_type, preposition1, 
		preposition2, instruction_id2, method_id, data_collection_ind, pair_ind, prompt_ind, 
		prompt_inst, threshold, threshold_min_count, active_ind 
into :ll_student_id, :ll_teacher_id, :ls_description, :ll_response_to_right_id, :ll_response_to_wrong_id, 
		:ll_instruction_id, :ldb_degree,	:ldb_tries, :ls_picture_ind, :ls_text_ind, :ls_lesson_type, :ll_preposition1, 
		:ll_preposition2, :ll_instruction_id2, :ll_method_id, :ls_data_collection_ind, :ls_pair_ind, :ls_prompt_ind, 
		:ll_prompt_inst, :ldb_threshold, :ll_threshold_min_count, :ls_active_ind 
from lesson 
where lesson_id = :al_lesson_id;
//ls_lesson_file_name = "C:\" + ls_description + ".txt"
ls_lesson_file_name = string(ll_method_id, "00") + lower(ls_description) + string(al_lesson_id, "0000000000") + ".txt"
lds_lesson.SaveAs(ls_lesson_file_name, Text!, FALSE)
of_export_preposition(ll_preposition1, ai_insert_update_ind)
of_export_preposition(ll_preposition2, ai_insert_update_ind)
of_export_instruction(ll_instruction_id, ai_insert_update_ind)
of_export_instruction(ll_instruction_id2, ai_insert_update_ind)
of_export_response_to_right(ll_response_to_right_id, ai_insert_update_ind)
of_export_response_to_wrong(ll_response_to_wrong_id, ai_insert_update_ind)
of_export_prompt_inst(ll_prompt_inst, ai_insert_update_ind)
of_export_lesson_index(ls_lesson_file_name)
if ll_method_id = 15 or ll_method_id = 16 then
	ls_lesson_file_name = string(ll_method_id, "00") + ls_description + string(al_lesson_id, "0000000000") + "_con.txt"
	lds_lesson_container = create datastore
	lds_lesson_container.dataobject = 'd_lesson_container'
	lds_lesson_container.SetTransObject(SQLCA)
	ll_rowcount = lds_lesson_container.Retrieve(al_lesson_id)
	if ll_rowcount < 1 then 
		destroy lds_lesson
		return "-1"
	end if
	for ll_row = 1 to ll_rowcount
		ls_bitmap_path = trim(lds_lesson_container.GetItemString(ll_row, 'bitmap_file'))
		if isnull(ls_bitmap_path) then ls_bitmap_path = ""
		if ls_bitmap_path <> "" then
			ls_bitmap_path = "Static Table\bitmap\container\" + ls_bitmap_path
			of_export_resource_index(ls_bitmap_path)
		end if
		ls_wavefile_path = trim(lds_lesson_container.GetItemString(ll_row, 'wave_file'))
		if isnull(ls_wavefile_path) then ls_wavefile_path = ""
		if ls_wavefile_path <> "" then
			ls_wavefile_path = "Static Table\wave\container\" + ls_wavefile_path
			of_export_resource_index(ls_wavefile_path)
		end if
		ls_bitmap_path = trim(lds_lesson_container.GetItemString(ll_row, 'bean_bitmap_file'))
		if isnull(ls_bitmap_path) then ls_bitmap_path = ""
		if ls_bitmap_path <> "" then
			ls_bitmap_path = "Static Table\bitmap\Bean\" + ls_bitmap_path
			of_export_resource_index(ls_bitmap_path)
		end if
		ls_wavefile_path = trim(lds_lesson_container.GetItemString(ll_row, 'bean_wave_file'))
		if isnull(ls_wavefile_path) then ls_wavefile_path = ""
		if ls_wavefile_path <> "" then
			ls_wavefile_path = "Static Table\wave\Bean\" + ls_wavefile_path
			of_export_resource_index(ls_wavefile_path)
		end if
	next	
	ll_colcount = long(lds_lesson_container.object.datawindow.column.count)
	ll_rowcount = lds_lesson_container.RowCount()
	for ll_col = 1 to ll_colcount
		ls_expression = "#" + string(ll_col) + ".ColType"
		ls_coltype = trim(left(lds_lesson_container.Describe(ls_expression), 5))
		for ll_row = 1 to ll_rowcount
			if isnull(lds_lesson_container.object.data[ll_row, ll_col]) then
				choose case ls_coltype
					case "char("
						lds_lesson_container.object.data[ll_row, ll_col] = " "
					case else
						lds_lesson_container.object.data[ll_row, ll_col] = 0
				end choose
			end if
		next
	next	
	lds_lesson_container.SaveAs(ls_lesson_file_name, Text!, FALSE)
	destroy lds_lesson_container
	of_export_lesson_index(ls_lesson_file_name)		
end if
DECLARE content_cur CURSOR FOR
	select content_id
	from lesson_content
	where lesson_content.lesson_id = :al_lesson_id;
OPEN content_cur;
do 	
	FETCH content_cur INTO :ll_content_id;
	IF SQLCA.sqlcode <> 0 THEN exit
	of_export_content(ll_content_id)
LOOP WHILE SQLCA.sqlcode <> 100 or  SQLCA.sqlcode <> -1
Close content_cur;
destroy lds_lesson

return left(ls_lesson_file_name, len(ls_lesson_file_name) - 4)

end function

public function integer of_init_export ();string ls_current_dir
ls_current_dir = space(150)
GetCurrentDir(150, ls_current_dir)
ii_resource_index_filenum = FileOpen("c:\lh_res_index_export_tmp.txt", LineMode!, Write!, Shared!, Replace!)
ii_lesson_index_filenum = FileOpen("c:\lh_lesson_index_export_tmp.txt", LineMode!, Write!, Shared!, Replace!)
return 1
end function

on nvo_lesson_export_import.create
call super::create
end on

on nvo_lesson_export_import.destroy
call super::destroy
end on

event destructor;call super::destructor;FileClose ( ii_resource_dir_list_filenum )
FileClose ( ii_resource_index_filenum )
FileClose ( ii_sql_filenum )

end event

