extends HBoxContainer


onready var _fs_button = $GoFullScreenButton
onready var _no_fs_button = $QuitFullScreenButton


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_setting_changed(OS.window_fullscreen)

func _on_setting_changed(val:bool):
	if val:
		_fs_button.hide()
		_no_fs_button.show()
	else:
		_fs_button.show()
		_no_fs_button.hide()

func _on_GoFullScreenButton_pressed():
	OS.window_fullscreen = true
	_on_setting_changed(true)

func _on_QuitFullScreenButton_pressed():
	OS.window_fullscreen = false
	_on_setting_changed(false)
