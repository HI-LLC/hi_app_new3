$PBExportHeader$w_child.srw
forward
global type w_child from w_basic
end type
end forward

global type w_child from w_basic
end type
global w_child w_child

on w_child.create
call super::create
end on

on w_child.destroy
call super::destroy
end on

