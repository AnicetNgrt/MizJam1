extends Node

class_name Board

const _TilePackedScene = preload("res://scenes/Tile/Tile.tscn")

var _tileCount = 0

func addTile(state:int, position:Vector2, windDirection:Vector2):
	var tile = _TilePackedScene.instance()
	tile.state = state
	tile.position = position
	tile.windDirection = windDirection
	tile.name = tileNameFromPos(position)
	add_child(tile)
	_tileCount += 1

func clear():
	for c in get_children():
		remove_child(c)
		c.queue_free()

func tileNameFromPos(pos:Vector2):
	return "Tile_"+str(pos.x)+"|"+str(pos.y)

func getTile(pos:Vector2):
	return get_node(tileNameFromPos(pos))

func getTiles():
	var tiles = []
	for c in get_children():
		if c.name.begins_with("Tile"):
			tiles.append(c)
	return tiles

func getIncidentTile(dest:Vector2, origin:Vector2):
	var tile = getTile(dest)
	if tile == null and getTile(origin) != null:
		
		var decompos = []
		for x in range(0, abs(dest.x-origin.x)):
			decompos.append(Vector2(sign(dest.x-origin.x),0))
		for y in range(0, abs(dest.y-origin.y)):
			decompos.append(Vector2(0,sign(dest.y-origin.y)))
		
		var previousTile = getTile(origin)
		for v in decompos:
			tile = getTile(previousTile.position+v)
			if tile == null:
				tile = previousTile
				var k = 0
				while(tile != null):
					k -= 1
					tile = getTile(previousTile.position+(v*k))
				tile = getTile(previousTile.position+(v*(k+1)))
			previousTile = tile
		return previousTile
	else:
		return tile
	return null
