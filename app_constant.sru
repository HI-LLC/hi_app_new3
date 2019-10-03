$PBExportHeader$app_constant.sru
$PBExportComments$constants for the application
forward
global type app_constant from nonvisualobject
end type
end forward

global type app_constant from nonvisualobject
end type
global app_constant app_constant

type variables
constant integer cust_new = 0
constant integer cust_exist = 1
constant integer cust_opened  = 3
constant integer cust_closed = 4

constant integer customer_page = 1
constant integer exception_page = 2
constant integer loan_page = 4
constant integer guarantor_page = 5

constant integer state_0view = 0
constant integer state_view = 1
constant integer state_modify = 2
constant integer state_add = 3 
constant integer state_add1r = 4

constant integer confirm_yes = 1
constant integer confirm_no = 2
constant integer confirm_cancel = 3

constant integer execute_sucessful = 0
constant integer execute_fail = 1

end variables

on app_constant.create
TriggerEvent( this, "constructor" )
end on

on app_constant.destroy
TriggerEvent( this, "destructor" )
end on

