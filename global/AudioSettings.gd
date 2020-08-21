extends Node

var volume_db = 0 setget set_volume_db
func set_volume_db(val):
	volume_db = val
	emit_signal("volume_db_changed",val)

signal volume_db_changed(vol)
