extends Board

const _Tile2DPackedScene = preload("res://scenes/2D/Tile2D/Tile2D.tscn")

signal tile_hovered(tile)
signal tile_not_hovered(tile)
signal tile_clicked(tile)

func _ready():
	$Props/Background/AnimationPlayer.play("scroll")

func addTile(state:int, position:Vector2, windDirection:Vector2):
	var tile = _Tile2DPackedScene.instance()
	tile.state = state
	tile.position = position
	tile.windDirection = windDirection
	tile.name = tileNameFromPos(position)
	add_child(tile)
	tile.connect("hovered",self,"_on_tile_hovered")
	tile.connect("not_hovered",self,"_on_tile_not_hovered")
	tile.connect("clicked",self,"_on_tile_clicked")

func _on_tile_hovered(tile):
	emit_signal("tile_hovered",tile)

func _on_tile_not_hovered(tile):
	emit_signal("tile_not_hovered",tile)

func _on_tile_clicked(tile):
	emit_signal("tile_clicked",tile)
