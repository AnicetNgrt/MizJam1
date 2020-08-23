tool
extends AnimatedSprite

enum Kinds {
	NORMAL = 0, MOVE = 2, KILL = 3, FORBIDDEN = 1, SELECTED = 4
}

const spfs = [
	preload("res://resources/tile_crosshairs/normal.tres"),
	preload("res://resources/tile_crosshairs/forbidden.tres"),
	preload("res://resources/tile_crosshairs/move.tres"),
	preload("res://resources/tile_crosshairs/kill.tres"),
	preload("res://resources/tile_crosshairs/selected.tres")
]

export(Kinds) var kind = Kinds.NORMAL setget _set_kind
func _set_kind(val):
	kind = val
	if not is_inside_tree(): yield(self, "ready")
	frames = spfs[kind]

func _ready():
	play("default")
