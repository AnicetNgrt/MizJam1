extends Controller

class_name ControllerSpectator

export var mySide:int = 0 setget _set_mySide
func _set_mySide(val):
	mySide = val
	if not is_inside_tree(): yield(self, "ready")
	get_child(0).mySide = val

func executeModifier(modifier:Modifier):
	get_child(0).executeModifier(modifier)

func undoModifier(modifier:Modifier):
	get_child(0).undoModifier(modifier)
