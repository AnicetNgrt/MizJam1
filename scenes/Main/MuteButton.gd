extends TextureButton




func _on_MuteButton_pressed():
	AudioServer.set_bus_mute(0,not AudioServer.is_bus_mute(0))
