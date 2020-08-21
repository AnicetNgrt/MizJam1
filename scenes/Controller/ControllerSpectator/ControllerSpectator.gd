extends Controller

class_name ControllerSpectator

func executeModifier(modifier:Modifier):
	if has_node("game"):
		get_node("game").executeModifier(modifier)

func undoModifier(modifier:Modifier):
	if has_node("game"):
		get_node("game").undoModifier(modifier)
