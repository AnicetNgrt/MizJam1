extends Modifier

class_name ModifierAddTile

var _board:Board
var _tile:Tile

func _init(board:Board,tile:Tile):
	_board = board
	_tile = tile

func execute():
	.execute()
	_board.add_child(_tile)

func undo():
	.undo()
	_board.remove_child(_tile)
