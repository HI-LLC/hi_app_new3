$PBExportHeader$nvo_reward_program.sru
forward
global type nvo_reward_program from nonvisualobject
end type
end forward

global type nvo_reward_program from nonvisualobject
end type
global nvo_reward_program nvo_reward_program

type variables
datastore ids_reward_program
long il_current_content_id
long il_current_replay_num
long il_current_reward_program_id
long il_rowcount
long il_token_num
end variables

forward prototypes
public subroutine of_init ()
public function string of_get_video_file ()
end prototypes

public subroutine of_init ();integer li_row
boolean lb_retry_num_is_non_zero = false
m_label_main_mdi lm_mdi
lm_mdi = gn_appman.iw_frame.menuid
select current_id into :il_current_reward_program_id
from system_parms where parm_name = 'REWARD_PROGRAM';
if il_current_reward_program_id = 0 then
	MessageBox("Error", "No reward program available.")
	gb_money_board_on = false
	lm_mdi.m_tools.m_moneyboard.checked = false
	return
end if
select current_program_content_id, token_num into :il_current_content_id, :il_token_num
from reward_program 
where reward_program_id = :il_current_reward_program_id;
ids_reward_program.DataObject = 'd_reward_program_content'
ids_reward_program.SetTransObject(SQLCA)
il_rowcount = ids_reward_program.Retrieve(il_current_reward_program_id) 
if il_rowcount < 1 then
	MessageBox("Error", "No reward program contents available.")
	gb_money_board_on = false
	lm_mdi.m_tools.m_moneyboard.checked = false
	return
end if
for li_row = 1 to il_rowcount
	if ids_reward_program.object.replay_num[li_row] > 0 then
		lb_retry_num_is_non_zero = true
		exit
	end if
next
if lb_retry_num_is_non_zero = false then
	MessageBox("Error", "No retry numbers in the contents are setup.")
	gb_money_board_on = false
	lm_mdi.m_tools.m_moneyboard.checked = false
	return
end if	
if il_current_content_id = 0 then
	il_current_content_id = 1
end if
if il_current_content_id > il_rowcount then
	il_current_content_id = il_rowcount
end if		
il_current_replay_num = 1
end subroutine

public function string of_get_video_file ();string ls_video_file
do while il_current_replay_num > ids_reward_program.object.replay_num[il_current_content_id]
	il_current_content_id = il_current_content_id + 1
	il_current_replay_num = 1
	if il_current_content_id > il_rowcount then
		il_current_content_id = 1
	end if
loop
ls_video_file = ids_reward_program.object.video_file[il_current_content_id]
il_current_replay_num = il_current_replay_num + 1
return ls_video_file
end function

on nvo_reward_program.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_reward_program.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_reward_program = create datastore
of_init()
end event

event destructor;if ids_reward_program.RowCount() > 0 then
	update reward_program 
	set current_program_content_id = :il_current_content_id
	where reward_program_id = :il_current_reward_program_id;
	commit;
end if
destroy ids_reward_program
end event

