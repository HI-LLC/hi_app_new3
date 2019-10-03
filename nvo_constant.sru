$PBExportHeader$nvo_constant.sru
forward
global type nvo_constant from nonvisualobject
end type
end forward

global type nvo_constant from nonvisualobject
end type
global nvo_constant nvo_constant

type variables
constant long bitmap_file = 0
constant long wave_file = 1
end variables

on nvo_constant.create
TriggerEvent( this, "constructor" )
end on

on nvo_constant.destroy
TriggerEvent( this, "destructor" )
end on

