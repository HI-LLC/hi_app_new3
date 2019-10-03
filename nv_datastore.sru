$PBExportHeader$nv_datastore.sru
forward
global type nv_datastore from datastore
end type
end forward

global type nv_datastore from datastore
end type
global nv_datastore nv_datastore

on nv_datastore.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on nv_datastore.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

