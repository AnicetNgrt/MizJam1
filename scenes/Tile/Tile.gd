extends Highlightable

class_name Tile

enum TileStates {
	NORMAL,
	VOID,
	SLIPPERY,
	CONQUERED_S1,
	CONQUERED_S2
}

export(TileStates) var state = TileStates.NORMAL setget _set_state
func _set_state(val):
	state = val
export var position:Vector2 setget _set_position
func _set_position(val):
	position = val
export var windDirection:Vector2 = Cardinals.DIRECTIONS.C setget _set_windDirection
func _set_windDirection(val):
	windDirection = val

# @pre: side in Constants.Sides
# @post: return in Cardinals.DIRECTIONS.values()
func getNextDirection(comingDirection:Vector2,side:int) -> Vector2:
	var _nextDir = Cardinals.DIRECTIONS.C
	match(state):
		TileStates.VOID:
			_nextDir = comingDirection
		TileStates.SLIPPERY:
			_nextDir = windDirection
		_: if (TileStates.CONQUERED_S1 and side == Constants.Sides.S2) or (TileStates.CONQUERED_S2 and side == Constants.Sides.S1):
				_nextDir = -1 * comingDirection
	return _nextDir
