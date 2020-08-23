extends Board

const _Tile2DPackedScene = preload("res://scenes/2D/Tile2D/Tile2D.tscn")

func _ready():
	$Props/Background/AnimationPlayer.play("scroll")

func addTile(state:int, position:Vector2, windDirection:Vector2):
	var tile = _Tile2DPackedScene.instance()
	tile.state = state
	tile.position = position
	tile.windDirection = windDirection
	tile.name = tileNameFromPos(position)
	add_child(tile)
