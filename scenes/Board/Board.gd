extends Node

class_name Board

const _TilePackedScene = preload("res://scenes/Tile/Tile.tscn")

func addTile(state:int, position:Vector2, windDirection:Vector2):
	var tile = _TilePackedScene.instance()
	tile.state = state
	tile.position = position
	tile.windDirection = windDirection
	tile.name = tileNameFromPos(position)
	add_child(tile)

func clear():
	for c in get_children():
		remove_child(c)
		c.queue_free()

func tileNameFromPos(pos:Vector2):
	return "Tile_"+str(pos.x)+"|"+str(pos.y)

func getTile(pos:Vector2):
	return get_node(tileNameFromPos(pos))
