$PBExportHeader$u_tbpg_material.sru
forward
global type u_tbpg_material from userobject
end type
type st_split_bar_2 from uo_st_splitbar within u_tbpg_material
end type
type st_split_bar_1 from uo_st_splitbar within u_tbpg_material
end type
type dw_chapter from u_datawindow within u_tbpg_material
end type
type dw_content from u_datawindow within u_tbpg_material
end type
type dw_subject from u_datawindow within u_tbpg_material
end type
end forward

global type u_tbpg_material from userobject
integer width = 3721
integer height = 2112
long backcolor = 15780518
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_dropdown pbm_dwndropdown
event ue_paint pbm_paint
st_split_bar_2 st_split_bar_2
st_split_bar_1 st_split_bar_1
dw_chapter dw_chapter
dw_content dw_content
dw_subject dw_subject
end type
global u_tbpg_material u_tbpg_material

type variables
long il_current_subject_id = 0
long il_current_chapter_id = 0
long il_current_content_id = 0
long il_current_subject_row = 0
long il_current_chapter_row = 0
long il_current_content_row = 0
long il_tabpage_id = 0
string is_bitmap_list[]
string is_wave_list[]
string is_current_subject
string is_current_chapter
string is_current_content
window iw_main
end variables

on u_tbpg_material.create
this.st_split_bar_2=create st_split_bar_2
this.st_split_bar_1=create st_split_bar_1
this.dw_chapter=create dw_chapter
this.dw_content=create dw_content
this.dw_subject=create dw_subject
this.Control[]={this.st_split_bar_2,&
this.st_split_bar_1,&
this.dw_chapter,&
this.dw_content,&
this.dw_subject}
end on

on u_tbpg_material.destroy
destroy(this.st_split_bar_2)
destroy(this.st_split_bar_1)
destroy(this.dw_chapter)
destroy(this.dw_content)
destroy(this.dw_subject)
end on

type st_split_bar_2 from uo_st_splitbar within u_tbpg_material
event ue_paint pbm_paint
integer x = 37
integer y = 1280
integer width = 3643
boolean bringtotop = true
end type

event constructor;call super::constructor;of_Register(dw_chapter, ABOVE)
of_Register(dw_content,BELOW)
of_SetBarColor(f_getcolor(5))

end event

type st_split_bar_1 from uo_st_splitbar within u_tbpg_material
event ue_paint pbm_paint
integer x = 37
integer y = 624
integer width = 3643
boolean bringtotop = true
end type

event constructor;call super::constructor;of_Register(dw_subject,ABOVE)
of_Register(dw_chapter, BELOW)
of_SetBarColor(f_getcolor(5))

end event

type dw_chapter from u_datawindow within u_tbpg_material
string tag = "1303020"
integer x = 37
integer y = 648
integer width = 3643
integer height = 624
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_chapter"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then
	return
end if
il_current_chapter_row = row
//if not isvalid(dwo) then
	ScrollToRow(row)
//end if
dw_subject.SelectRow(0, false)
dw_content.SelectRow(0, false)
this.SelectRow(0, false)
this.SelectRow(row, true)
il_current_chapter_id = this.GetItemNumber(il_current_chapter_row, 'chapter_id')
is_current_chapter = this.GetItemString(il_current_chapter_row, 'description')
if isnull(il_current_chapter_id) then
	il_current_chapter_id = 0
	is_current_chapter = this.GetItemString(il_current_chapter_row, 'description')
	dw_content.reset()
	il_current_content_row = 0
	il_current_content_id = 0
	return
end if

datawindowchild ldddwc_wave, ldddwc_bitmap

if dw_content.GetChild('wave_file', ldddwc_wave) =-1 then
	MessageBox("Error", "Cannot get wave file dropdown datawindow!")
else
	if gn_appman.invo_filedir.of_get_wave_list(ldddwc_wave, 'filename', gn_appman.is_wavefile_path + is_current_subject + '\' + is_current_chapter + '\') = -1 then
		MessageBox("Error", "Cannot wave file!")
	end if
	ldddwc_wave.InsertRow(1)
	ldddwc_wave.SetItem(1, "filename", "DICTIONARY")
end if
if dw_content.GetChild('bitmap_file', ldddwc_bitmap) =-1 then
	MessageBox("Error", "Cannot get bitmap file dropdown datawindow!")
else
	if gn_appman.invo_filedir.of_get_bitmap_list(ldddwc_bitmap, 'filename', gn_appman.is_bitmap_path + is_current_subject + '\' + is_current_chapter + '\' ) = -1 then
		MessageBox("Error", "Cannot wave file!")
	end if
end if
string ls_file_name, as_details, ls_column
if isvalid(dwo) then
	ls_column = dwo.name		
	if dwo.name = "bitmap_dd" then
		openwithparm(w_get_bitmap, gn_appman.is_bitmap_path + is_current_subject + '\')
		ls_file_name = Message.StringParm	
		if len(ls_file_name) > 0 and ls_file_name <> ' ' then
			this.SetItem(row, "bitmap_file", ls_file_name)
		elseif ls_file_name = ' ' then
			setnull(ls_file_name)
			this.SetItem(row, "bitmap_file", ls_file_name)
		end if 
	end if
end if

if dw_subject.GetItemString(il_current_subject_row, "presentation_type") <> "Reading" then
	dw_content.SetSort("description A")
else
	dw_content.SetSort("content_id A")	
end if
if dw_content.Retrieve(il_current_chapter_id) > 0 then
//	dw_content.Sort()
	dw_content.event clicked(0, 0, 1, dwo)
else
	il_current_content_id = 0
	il_current_content_row = 0
end if


end event

event constructor;call super::constructor;//of_set_verify_duplication('description', 'Chapter')
of_set_validate_column('description', 'Chapter', 1, 'None')

end event

event doubleclicked;call super::doubleclicked;string ls_details, ls_file_name
if row < 1 then return
if dwo.name = "details" then
	ls_details = this.GetItemString(row, "details")
	OpenWithParm(w_text, ls_details)
	if not isnull(Message.StringParm) then
		ls_details = Message.StringParm
		this.SetItem(row, "details", ls_details)
	end if
	this.SetFocus()
	this.SetColumn("details")
end if
if dwo.name = "wave_file" then
	ls_file_name = this.GetItemString(row, "wave_file")
	if not isnull(ls_file_name) and len(ls_file_name) > 0 then
		inv_sound_play.play_sound(is_current_subject + '\' + ls_file_name)
//		wf_sound_play(ls_file_name)
	end if
end if

if dwo.name = "bitmap_file" then
	ls_file_name = this.GetItemString(row, "bitmap_file")
	if not isnull(ls_file_name) and len(ls_file_name) > 0 then
//		MessageBox("debug", gn_appman.is_bitmap_path + is_current_subject + '\' + ls_file_name)
		iw_main.dynamic wf_picture_view(gn_appman.is_bitmap_path + is_current_subject + '\' + ls_file_name)
	end if
end if

end event

event ue_dropdown;if GetColumnName() = "bitmap_dd" then
	return 1
end if

end event

event losefocus;call super::losefocus;AcceptText()
end event

event buttonclicked;call super::buttonclicked;iw_main.dynamic wf_edit_wave_file(1, row)
end event

event itemchanged;call super::itemchanged;string ls_details
if row < 1 then return
if dwo.name = "description" then
	ls_details = this.GetItemString(row, "details")
	if isnull(ls_details) then ls_details = ""
	if trim(ls_details) = "" then
		this.SetItem(row, "details", data)
	end if
end if
end event

type dw_content from u_datawindow within u_tbpg_material
event ue_dropdown pbm_dwndropdown
event ue_set_focus_to_wavefile ( )
string tag = "1303030"
integer x = 37
integer y = 1304
integer width = 3643
integer height = 788
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_content"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_dropdown;if GetColumnName() = "bitmap_dd" then
	return 1
end if

end event

event ue_set_focus_to_wavefile;SetColumn('wave_file')
end event

event clicked;call super::clicked;string ls_file_name, as_details, ls_column
if row < 1 then return

if not isvalid(dwo) then
	ScrollToRow(row)
end if

if isvalid(dwo) then
	ls_column = dwo.name			
	if dwo.name = "bitmap_dd" then
		openwithparm(w_get_bitmap, gn_appman.is_bitmap_path + is_current_subject + '\' + is_current_chapter + '\')
		ls_file_name = Message.StringParm	
		if len(ls_file_name) > 0 and ls_file_name <> ' ' then
			this.SetItem(row, "bitmap_file", ls_file_name)
		elseif ls_file_name = ' ' then
			setnull(ls_file_name)
			this.SetItem(row, "bitmap_file", ls_file_name)
		end if 
	end if
end if

end event

event itemchanged;call super::itemchanged;string ls_file_name, ls_details, ls_column
string ls_1st_letter, ls_word, ls_dict_sound_file
if row < 1 then return
ls_column = dwo.name			
if dwo.name = "wave_dd" then
	ls_file_name = trim(this.GetItemString(row, "wave_dd"))
	if ls_file_name =  "DICTIONARY" and not gnvo_is.ib_demo_is_going then
		ls_details = this.GetItemString(row, "details")
		if isnull(ls_details) then ls_details = ""
		if trim(ls_details) <> "" then
			ls_word = trim(data)
			if gi_material_tabpage = 2 then
				ls_dict_sound_file = gn_appman.is_dictionary_wave + "\Numbers" + ls_word + ".wav"
			else
				ls_1st_letter = upper(left(ls_word, 1))
				ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
			end if
			if not FileExists(ls_dict_sound_file) then
				MessageBox("Error", "The sound file is not available in the dictionary!")
				return 1
			end if
		end if
	end if
		this.SetItem(row, "wave_file", ls_file_name)
end if
if dwo.name = "wave_file" then
	if trim(data) =  "DICTIONARY" and not gnvo_is.ib_demo_is_going then
		ls_word = this.GetItemString(row, "details")
		if isnull(ls_word) then ls_word = ""
		if trim(ls_word) <> "" then
			if gi_material_tabpage = 2 then
				ls_dict_sound_file = gn_appman.is_dictionary_wave + "\Numbers" + ls_word + ".wav"
			else
				ls_1st_letter = upper(left(ls_word, 1))
				ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
			end if
			if not FileExists(ls_dict_sound_file) then
				MessageBox("Error", "The sound file is not available in the dictionary!")
				return 1
			end if
		end if
	end if
end if

if dwo.name = "description" then
	ls_details = this.GetItemString(row, "details")
	if isnull(ls_details) then ls_details = ""
	if trim(ls_details) = "" then
		this.SetItem(row, "details", trim(data))
		ls_word = trim(data)
		ls_1st_letter = upper(left(ls_word, 1))
		ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
		if FileExists(ls_dict_sound_file) then
			if not gnvo_is.ib_demo_is_going then			
				if MessageBox("Confirmation", "Do you want to use sound file in DICTIONARY?", Question!, YesNo!) = 1 then
					this.SetItem(row, "wave_file", "DICTIONARY")
				end if
			end if
		end if	
	end if
end if

if dwo.name = "details" then
	ls_details = this.GetItemString(row, "details")
	if isnull(ls_details) then ls_details = ""
	if trim(ls_details) <> "" then
		ls_word = trim(data)
		if gi_material_tabpage = 2 then
			ls_dict_sound_file = gn_appman.is_dictionary_wave + "\Numbers" + ls_word + ".wav"
		else
			ls_1st_letter = upper(left(ls_word, 1))
			ls_dict_sound_file = gn_appman.is_dictionary_wave + ls_1st_letter + "\" + ls_word + ".wav"
		end if
		if FileExists(ls_dict_sound_file) and not gnvo_is.ib_demo_is_going then
			if MessageBox("Confirmation", "Do you want to use sound file in DICTIONARY?", Question!, YesNo!) = 1 then
				this.SetItem(row, "wave_file", "DICTIONARY")
			end if				
		end if	
	end if
end if
end event

event constructor;call super::constructor;ib_multiple_selection = true
end event

event rowfocuschanged;call super::rowfocuschanged;SelectRow(0, false)
SelectRow(currentrow, true)
end event

event buttonclicked;call super::buttonclicked;//MessageBox("buttonclicked", string(row))
if il_tabpage_id < 4 then
	iw_main.dynamic wf_edit_wave_file(2, row)
else
	iw_main.dynamic wf_edit_speech_training(row)
end if
end event

event doubleclicked;call super::doubleclicked;string ls_file_name
ls_file_name = this.GetItemString(row, "bitmap_file")
iw_main.dynamic wf_picture_view(gn_appman.is_bitmap_path + is_current_subject + '\' + &
is_current_chapter + '\' + ls_file_name)

end event

type dw_subject from u_datawindow within u_tbpg_material
string tag = "1303010"
integer x = 37
integer y = 24
integer width = 3643
integer height = 592
string dataobject = "d_subject"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;call super::clicked;if row < 1 then
	return
end if

if not isvalid(dwo) then
	ScrollToRow(row)
end if

dw_chapter.SelectRow(0, false)
dw_content.SelectRow(0, false)
this.SelectRow(0, false)
this.SelectRow(row, true)
il_current_subject_row = row
il_current_subject_id = this.GetItemNumber(il_current_subject_row, 'subject_id')
is_current_subject = this.GetItemString(il_current_subject_row, 'description')
if isnull(il_current_subject_id) then 
	il_current_subject_id = 0
	is_current_subject = this.GetItemString(il_current_subject_row, 'description')
	dw_chapter.reset()
	il_current_chapter_row = 0
	il_current_chapter_id = 0
	dw_content.reset()
	il_current_content_row = 0
	il_current_content_id = 0
	return
end if

datawindowchild ldddwc_wave, ldddwc_bitmap
dw_chapter.GetChild('wave_file', ldddwc_wave)

if gn_appman.invo_filedir.of_get_wave_list(ldddwc_wave, 'filename', gn_appman.is_wavefile_path + is_current_subject + '\' ) = -1 then
	MessageBox("Error", "Cannot wave file!")
end if

dw_chapter.GetChild('bitmap_file', ldddwc_bitmap)	
if gn_appman.invo_filedir.of_get_bitmap_list(ldddwc_bitmap, 'filename', gn_appman.is_bitmap_path + is_current_subject + '\'  ) = -1 then
	MessageBox("Error", "Cannot wave file!")
end if
dwobject ldwo
ldwo = dw_chapter.object.chapter_id
if dw_chapter.retrieve(il_current_subject_id) > 0 then
	dw_chapter.event clicked(0, 0, 1, ldwo)
else
	il_current_chapter_row = 0
	il_current_chapter_id = 0
	dw_content.reset()
	il_current_content_row = 0
	il_current_content_id = 0	
end if
end event

event constructor;call super::constructor;//of_set_verify_duplication('description', 'Subject')
of_set_validate_column('description', 'Subject', 1, 'None')
end event

event losefocus;call super::losefocus;AcceptText()
end event

 