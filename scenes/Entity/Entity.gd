extends Node

class_name Entity

var id = Constants.UNDEFINED_ID

func _ready():
	id = IdManager.getNextId()

# @pre: other.id != Constants.UNDEFINED_ID or self.id != Constants.UNDEFINED_ID
func isSameEntityThan(other:Entity) -> bool:
	return other.id == id
