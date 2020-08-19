extends Node

class_name Highlightable

var id = Constants.UNDEFINED_ID

func _init():
	id = IdManager.getNextId()

# @pre: other.id != Constants.UNDEFINED_ID or self.id != Constants.UNDEFINED_ID
func isSameHighlightableThan(other:Highlightable) -> bool:
	return other.id == id
