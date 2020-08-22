extends Modifier

class_name ModifierBuildRectBoardFromSize

export(Vector2) var _size

func _init(size:Vector2 = Vector2(0,0)):
	_size = size

# @param: game:Game
func execute(game):
	.execute(game)
	for y in range(0,_size.y):
		for x in range(0,_size.x):
			var wind_x = -1
			var wind_y = -1
			if x < (_size.x-1)/2.0: wind_x = 1
			if x == floor((_size.x-1)/2.0) or x == ceil((_size.x-1)/2.0): wind_x = 0
			if y < (_size.y-1)/2.0: wind_y = 1
			if y == floor((_size.y-1)/2.0) or y == ceil((_size.y-1)/2.0): wind_y = 0
			var wind_direction = Vector2(wind_x,wind_y)
			game._board.addTile(Tile.TileStates.NORMAL,Vector2(x,y),wind_direction)

# @param: game:Game
func undo(game):
	.undo(game)
	game._board.clear()

func copy():
	var copy = get_script().new(_size)
	copy.propagate = propagate
	copy.silent = silent
	return copy

func getPastDescription():
	if silent: return ""
	return "The board was built."

func getFutureDescription():
	if silent: return ""
	return "The board will be built."

func getPropagatedVersion():
	return copy()
