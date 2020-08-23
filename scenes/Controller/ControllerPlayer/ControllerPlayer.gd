extends ControllerSpectator

class_name ControllerPlayer

signal takesAction(action)

func _on_Game2D_takesAction(action):
	emit_signal("takesAction",action)
