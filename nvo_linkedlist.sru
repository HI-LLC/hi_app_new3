$PBExportHeader$nvo_linkedlist.sru
forward
global type nvo_linkedlist from nonvisualobject
end type
end forward

global type nvo_linkedlist from nonvisualobject
end type
global nvo_linkedlist nvo_linkedlist

type variables
nvo_linkedlist first_n
nvo_linkedlist last_n
nvo_linkedlist next_n
nvo_linkedlist previous_n
nvo_linkedlist current_n
nvo_linkedlist this_n
any data_any
string data_name

end variables

forward prototypes
private subroutine of_set_first (ref nvo_linkedlist a_linkedlist)
private subroutine of_insert_before_node (ref nvo_linkedlist a_before_linkedlist, ref nvo_linkedlist a_linkedlist)
public subroutine of_insert_before_node (string as_before_name, string as_name, any aa_data)
public subroutine of_insert_after_node (string as_after_name, string as_name, any aa_data)
public function integer of_delete_node (string as_name)
public subroutine of_set_name (string as_name)
public subroutine of_set_data (any aa_any)
private subroutine of_set_last (ref nvo_linkedlist a_linkedlist)
private function integer of_delete_node (ref nvo_linkedlist a_linkedlist)
private subroutine of_insert_after_node (ref nvo_linkedlist a_after_linkedlist, ref nvo_linkedlist a_linkedlist)
public subroutine of_delete_all ()
public function integer of_get_node (string as_name, ref any aa_data)
private subroutine of_insert_node (ref nvo_linkedlist a_linkedlist)
public subroutine of_insert_node (string as_name, any aa_data)
private subroutine of_add_node (ref nvo_linkedlist a_linkedlist)
public subroutine of_add_node (string as_name, any aa_data)
public function integer of_find_node (string as_name, ref nvo_linkedlist a_linkedlist)
public subroutine of_get_all (ref string as_name[], ref any aa_data[])
end prototypes

private subroutine of_set_first (ref nvo_linkedlist a_linkedlist);
nvo_linkedlist lnv_current
lnv_current = first_n
do 
	lnv_current.first_n = a_linkedlist
	lnv_current = lnv_current.next_n
loop while lnv_current.this_n <> last_n
end subroutine

private subroutine of_insert_before_node (ref nvo_linkedlist a_before_linkedlist, ref nvo_linkedlist a_linkedlist);
if a_before_linkedlist = this_n then
	of_insert_node(a_linkedlist)
else
	a_before_linkedlist.previous_n = a_linkedlist
	a_linkedlist.next_n = a_before_linkedlist
end if
end subroutine

public subroutine of_insert_before_node (string as_before_name, string as_name, any aa_data);
nvo_linkedlist lnv_new, lnv_target
lnv_new = create nvo_linkedlist
lnv_new.data_name = as_name
lnv_new.data_any = aa_data
if of_find_node(as_before_name, lnv_target) = 1 then
	of_insert_before_node(lnv_target, lnv_new)
else
	of_insert_node(lnv_new)
end if
end subroutine

public subroutine of_insert_after_node (string as_after_name, string as_name, any aa_data);
nvo_linkedlist lnv_new, lnv_target
lnv_new = create nvo_linkedlist
lnv_new.data_name = as_name
lnv_new.data_any = aa_data
if of_find_node(as_after_name, lnv_target) = 1 then
	of_insert_after_node(lnv_target, lnv_new)
else
	of_add_node(lnv_new)
end if
end subroutine

public function integer of_delete_node (string as_name);nvo_linkedlist lnv_target
if of_find_node(as_name, lnv_target) = 1 then
	return of_delete_node(lnv_target) 
else
	return 0
end if
end function

public subroutine of_set_name (string as_name);data_name = as_name
end subroutine

public subroutine of_set_data (any aa_any);data_any = aa_any
end subroutine

private subroutine of_set_last (ref nvo_linkedlist a_linkedlist);if a_linkedlist.this_n = this then return
nvo_linkedlist lnv_current
lnv_current = first_n
do 
	lnv_current.last_n = a_linkedlist
	lnv_current = lnv_current.next_n
loop while lnv_current.this_n <> last_n
end subroutine

private function integer of_delete_node (ref nvo_linkedlist a_linkedlist);nvo_linkedlist lnv_previous, lnv_next
if a_linkedlist = this_n then 
	return 0
end if

if a_linkedlist.this_n = last_n then // last node
	lnv_previous = a_linkedlist.previous_n
	of_set_last(lnv_previous)
else
	lnv_previous = a_linkedlist.previous_n
	lnv_next = a_linkedlist.next_n
	lnv_previous.next_n = lnv_next.this_n
	lnv_next.previous_n = lnv_previous.this_n
end if
destroy a_linkedlist

return 1 
end function

private subroutine of_insert_after_node (ref nvo_linkedlist a_after_linkedlist, ref nvo_linkedlist a_linkedlist);a_after_linkedlist.next_n = a_linkedlist
a_linkedlist.previous_n = a_after_linkedlist
end subroutine

public subroutine of_delete_all ();nvo_linkedlist lnv_current
lnv_current = last_n
DO WHILE lnv_current.last_n <> this_n
	of_delete_node(lnv_current)
	lnv_current = last_n
LOOP 
end subroutine

public function integer of_get_node (string as_name, ref any aa_data);nvo_linkedlist lnv_target

if of_find_node(as_name, lnv_target) = 1 then
	aa_data = lnv_target.data_any
	return 1
else
	return 0
end if
end function

private subroutine of_insert_node (ref nvo_linkedlist a_linkedlist);any data_tmp
string name_tmp
data_tmp = data_any
name_tmp = data_name
data_any = a_linkedlist.data_any
data_name = a_linkedlist.data_name
a_linkedlist.data_any = data_tmp
a_linkedlist.data_name = name_tmp
of_insert_after_node(this_n, a_linkedlist)
end subroutine

public subroutine of_insert_node (string as_name, any aa_data);nvo_linkedlist lnv_new, lnv_target
if of_find_node(as_name, lnv_target) = 1 then
	aa_data = lnv_target.data_any
else
	if len(data_name) = 0 then
		of_set_name(as_name)
		of_set_data(aa_data)
	else
		lnv_new = create nvo_linkedlist
		lnv_new.data_name = as_name
		lnv_new.data_any = aa_data
		of_insert_node(lnv_new)
	end if
end if
end subroutine

private subroutine of_add_node (ref nvo_linkedlist a_linkedlist); // add as last note
if next_n <> this_n then // more than one node
	last_n.next_n = a_linkedlist
	a_linkedlist.previous_n = last_n
	last_n = a_linkedlist
else							// single node
	last_n = a_linkedlist
	next_n = a_linkedlist	
	a_linkedlist.previous_n = this_n
end if
//of_set_last(a_linkedlist)
end subroutine

public subroutine of_add_node (string as_name, any aa_data);nvo_linkedlist lnv_new, lnv_target

if of_find_node(as_name, lnv_target) = 1 then
	lnv_target.data_any = aa_data
else
	if len(data_name) = 0 then // the first linkedlist item
		of_set_name(as_name)
		of_set_data(aa_data)
	else
		lnv_new = create nvo_linkedlist
		lnv_new.data_name = as_name
		lnv_new.data_any = aa_data
		lnv_new.first_n = first_n
		lnv_new.last_n = last_n
		of_add_node(lnv_new)
	end if
end if

end subroutine

public function integer of_find_node (string as_name, ref nvo_linkedlist a_linkedlist);nvo_linkedlist lnv_current
lnv_current = first_n
do 
//	MessageBox("name", lnv_current.data_name)
	if string(lnv_current.data_name) = as_name then
		a_linkedlist = lnv_current
		return 1
	end if
	lnv_current = lnv_current.next_n
loop while lnv_current.this_n <> last_n
if lnv_current.data_name = as_name then
	a_linkedlist = lnv_current
	return 1
end if
return 0

end function

public subroutine of_get_all (ref string as_name[], ref any aa_data[]);int ll_i = 1
nvo_linkedlist lnv_current
lnv_current = first_n
do 
	as_name[ll_i] = lnv_current.data_name
	aa_data[ll_i] = lnv_current.data_any
	lnv_current = lnv_current.next_n
	ll_i++
loop while lnv_current <> last_n
as_name[ll_i] = lnv_current.data_name
aa_data[ll_i] = lnv_current.data_any

end subroutine

on nvo_linkedlist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_linkedlist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;first_n = this
last_n = this
next_n = this
previous_n = this
this_n = this
data_name = ""
end event

