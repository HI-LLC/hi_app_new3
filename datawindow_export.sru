//Data window retrieval for local lesson playing:

long ll_orig_acct_id, ll_student_id, ll_lesson_id, ll_method_id, ll_row
string ls_index_id

nvo_datastore lds_sys_treeview, lds_account, lds_student, lds_lesson_type, lds_lesson_list
nvo_datastore lds_lesson_student, lds_lesson_parm, lds_student_RTR, lds_student_RTW, lds_reward

lds_sys_treeview = create nvo_datastore
lds_account = create nvo_datastore
lds_student = create nvo_datastore
jlds_lesson_type = create nvo_datastore
lds_lesson_list = create nvo_datastore
lds_lesson_student = create nvo_datastore
lds_lesson_parm = create nvo_datastore
lds_student_RTR = create nvo_datastore
lds_student_RTW = create nvo_datastore
lds_reward = create nvo_datastore

lds_sys_treeview.dataobject = "d_treeview_sys_table"
lds_account.dataobject = "d_account"
lds_student.dataobject = "d_student"
lds_lesson_type.dataobject = "d_lesson_type"
lds_lesson_list.dataobject = "d_lesson_list"
lds_lesson_student.dataobject = "d_student"
lds_lesson_parm.dataobject = "d_lesson_parm"
lds_student_RTR.dataobject = "d_student_rtr"
lds_student_RTW.dataobject = "d_student_rtw"
lds_reward.dataobject = "d_student_reward_source"

lds_sys_treeview.is_select_sql = "Select * From Treeview where tv_group_id eq " + string(gn_appman.il_tv_group_id) + " And Status eq 'A'"
lds_sys_treeview.data_retrieve()

lds_account.is_select_sql = "select Name, ID as account_id From Account Where ID eq " + string(gn_appman.il_account_id)
ids_account.data_retrieve()

lds_student.is_select_col = {"account_id", "student_id", "last_name", "first_name"}
lds_student.is_where_col[1] = "account_id"
lds_student.ia_where_value[1] = gn_appman.il_account_id
lds_student.data_retrieve()

lds_lesson_type.is_select_sql = "Select l.account_id as account_id, sl.student_id as student_id, m.method_cat_id as method_cat_id, m.method_cat_desc as method_name " + &
						" From Method as m, Lesson as l,StudentLesson sl Where m.method_id eq l.method_id and " + &
						" sl.account_id eq l.account_id and sl.lesson_id eq l.lesson_id and sl.active_ind eq 'A' and " + &
						" l.account_id eq " + string(gn_appman.il_account_id) + " Group By l.account_id, sl.student_id, m.method_cat_id " + &
						" union " + &
						"Select la.account_id as account_id, sl.student_id as student_id, m.method_cat_id as method_cat_id, m.method_cat_desc as method_name " + &
						" From Method as m, LessonAcquired As la, Lesson As l,StudentLesson as sl Where la.orig_acct_id eq l.account_id and " + &
						" sl.account_id eq la.account_id and sl.lesson_id eq la.lesson_id and sl.active_ind eq 'A' and " + &					
						" la.lesson_id eq l.lesson_id and l.method_id eq m.method_id and la.account_id eq " + string(gn_appman.il_account_id) + &
						" Group By la.account_id, sl.student_id, m.method_cat_id "
lds_lesson_type.data_retrieve()

lds_lesson_list.is_select_sql = "Select sl.account_id as account_id, sl.orig_acct_id as orig_acct_id, sl.student_id as student_id, l.lesson_id as lesson_id, " + &
											"l.lesson_name as lesson_name, l.method_cat_id as method_cat_id, l.method_id as method_id from StudentLesson As sl, Lesson As l " + &
											"where sl.orig_acct_id eq l.account_id and sl.active_ind eq 'A' and " + &
											"sl.lesson_id eq l.lesson_id and sl.account_id eq "  + string(gn_appman.il_account_id)
lds_lesson_list.data_retrieve()

lds_lesson_student.is_database_table = "Student"
lds_lesson_student.is_where_col[1] = "account_id"
lds_lesson_student.ia_where_value[1] = gn_appman.il_account_id
lds_lesson_student.is_where_col[2] = "student_id"

lds_student_RTR.dataobject = "d_student_rtr"
lds_student_RTW.dataobject = "d_student_rtw"
lds_reward.dataobject = "d_student_reward_source"
for ll_row = 1 to lds_student.RowCount()
	ll_student_id = lds_student.GetItemNumber(ll_row, "student_id")
	lds_lesson_student.ia_where_value[2] = ll_student_id
	ls_index_id = string(ll_student_id, "0000000000")
	lds_lesson_student.Reset()
	lds_lesson_student.data_retrieve(ls_index_id)
	lds_student_RTR.is_select_sql =  "Select srtr.orig_acct_id as orig_acct_id,rtr.response_id as response_id, rtr.wave_file as wave_file, a.site_path as site_path " + &
												"from StudentRTR As srtr, ResponseTR as rtr, Account as a " + &
												"where srtr.orig_acct_id eq rtr.account_id and " + &
												"      srtr.response_id eq rtr.response_id and "+ &
												"      srtr.orig_acct_id eq a.id and "+ &
												"      srtr.account_id eq " + string(gn_appman.il_account_id) + " and "+ &
												"      srtr.student_id eq " + string(ll_student_id)
	lds_student_RTR.data_retrieve(ls_index_id)	
	lds_student_RTW.is_select_sql =  "Select srtw.orig_acct_id as orig_acct_id,rtw.response_id as response_id, rtw.wave_file as wave_file, a.site_path as site_path " + &
												"from StudentRTW As srtw, ResponseTW as rtw, Account as a " + &
												"where srtw.orig_acct_id eq rtw.account_id and " + &
												"      srtw.response_id eq rtw.response_id and "+ &
												"      srtw.orig_acct_id eq a.id and "+ &
												"      srtw.account_id eq " + string(gn_appman.il_account_id) + " and "+ &
												"      srtw.student_id eq " + string(ll_student_id)	
	lds_student_RTW.data_retrieve(ls_index_id)
	lds_reward.is_select_sql =  "Select media_type, rs.site_path as site_path, rs.file_name as file_name, rs.full_path as full_path," + &
												" sr.duration as duration,sr.repeat as repeat,sr.sort_order as sort_order " + &
												"from StudentReward As sr, RewardSource As rs " + &
												"where sr.orig_acct_id eq rs.account_id and " + &
												"      sr.resource_id eq rs.resource_id and "+ &
												"      sr.account_id eq " + string(gn_appman.il_account_id) + " and "+ &
												"      sr.student_id eq " + string(ll_student_id) + " " + &
												"order by sr.sort_order "
	lds_reward.data_retrieve(ls_index_id)
next

lds_lesson_parm.dataobject = "d_lesson_parm"
for ll_row = 1 to lds_lesson_list.RowCount()
	ll_student_id = lds_lesson_list.GetItemNumber(ll_row, "student_id")
	ll_orig_acct_id = lds_lesson_list.GetItemNumber(ll_row, "orig_acct_id")
	ll_lesson_id = lds_lesson_list.GetItemNumber(ll_row, "lesson_id")
	ls_index_id = string(ll_student_id, "0000000") + string(ll_orig_acct_id, "0000000") + string(ll_lesson_id, "0000000000")
	lds_lesson_parm.is_select_sql =  "Select sl.account_id as account_id, sl.orig_acct_id as orig_acct_id, sl.student_id as student_id,sl.lesson_id as lesson_id,sl.degree as degree,sl.tries as tries,sl.prompt_inst as prompt_inst,sl.prompt_ind as prompt_ind,l.instruction_id as instruction_id," + &
										"sl.picture_ind as picture_ind,sl.text_ind as text_ind, repeat,a.site_path as site_path, l.lesson_name as lesson_name, lesson_subpath " + &
										"from StudentLesson as sl, Account as a, Lesson as l, Method as m " + &
										"where sl.orig_acct_id eq a.id and sl.lesson_id eq l.lesson_id and sl.orig_acct_id eq l.account_id and l.method_id eq m.method_id and "+ &
										"		 sl.account_id eq " + string(gn_appman.il_account_id) + " and "+ &
										"      sl.student_id eq " + string(ll_student_id) + " and "+ &
										"      sl.lesson_id eq " + string(ll_lesson_id) + " and "+ &
										"      sl.orig_acct_id eq " + string(ll_orig_acct_id)
	lds_lesson_parm.data_retrieve(ls_index_id))
next

nvo_datastore lds_sys_treeview, lds_account, lds_student, lds_lesson_type, lds_lesson_list
nvo_datastore lds_lesson_student, lds_lesson_parm, lds_student_RTR, lds_student_RTW, lds_reward

destroy lds_sys_treeview
destroy lds_account
destroy lds_student
destroy lds_lesson_type
destroy lds_lesson_list
destroy lds_lesson_student
destroy lds_lesson_parm
destroy lds_student_RTR
destroy lds_student_RTW
destroy lds_reward


	