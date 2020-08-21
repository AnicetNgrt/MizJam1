extends Controller

class_name ControllerSpectator

func executeModifier(modifier:Modifier):
	get_child(0).executeModifier(modifier)

func undoModifier(modifier:Modifier):
	get_child(0).undoModifier(modifier)
