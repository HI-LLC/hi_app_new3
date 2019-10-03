$PBExportHeader$w_response.srw
forward
global type w_response from w_basic
end type
end forward

global type w_response from w_basic
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_response w_response

on w_response.create
call super::create
end on

on w_response.destroy
call super::destroy
end on

