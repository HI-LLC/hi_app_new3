$PBExportHeader$nvo_validation_str.sru
forward
global type nvo_validation_str from nonvisualobject
end type
end forward

global type nvo_validation_str from nonvisualobject
end type
global nvo_validation_str nvo_validation_str

type variables
str_validation istr_validation[]
str_validation istr_duplicate[]
end variables

on nvo_validation_str.create
TriggerEvent( this, "constructor" )
end on

on nvo_validation_str.destroy
TriggerEvent( this, "destructor" )
end on

