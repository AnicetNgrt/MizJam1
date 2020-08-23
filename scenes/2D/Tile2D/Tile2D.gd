extends Tile

const _textures = [
	[
		preload("res://assets/tile_textures/normal_light.png"),
		preload("res://assets/tile_textures/normal_dark.png")
	],
	[
		preload("res://assets/tile_textures/void.png"),
		preload("res://assets/tile_textures/void.png")
	],
	[
		preload("res://assets/tile_textures/conq_blue_light.png"),
		preload("res://assets/tile_textures/conq_blue_dark.png")
	],
	[
		preload("res://assets/tile_textures/conq_red_light.png"),
		preload("res://assets/tile_textures/conq_red_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_b_light.png"),
		preload("res://assets/tile_textures/wind_b_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_br_light.png"),
		preload("res://assets/tile_textures/wind_br_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_d_light.png"),
		preload("res://assets/tile_textures/wind_d_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_tr_light.png"),
		preload("res://assets/tile_textures/wind_tr_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_t_light.png"),
		preload("res://assets/tile_textures/wind_t_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_tl_light.png"),
		preload("res://assets/tile_textures/wind_tl_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_g_light.png"),
		preload("res://assets/tile_textures/wind_g_dark.png")
	],
	[
		preload("res://assets/tile_textures/wind_bl_light.png"),
		preload("res://assets/tile_textures/wind_bl_dark.png")
	]
]

onready var _Texture = $CenterContainer/TextureRect

signal hovered(tile)
signal not_hovered(tile)
signal clicked(tile)

func _set_windDirection(val):
	._set_windDirection(val)
	_set_state(state)

func _set_position(val):
	._set_position(val)
	_set_state(state)
	if not is_inside_tree(): yield(self, "ready")
	$CenterContainer.rect_position = Vector2(72+position.y*16,66+position.x*16)

func _set_state(val):
	._set_state(val)
	if not is_inside_tree(): yield(self, "ready")
	var isDarker = int(position.x) % 2 != int(position.y) % 2
	var texture = null
	var row = _textures[0]
	if val == TileStates.VOID:
		row = _textures[1]
	elif val == TileStates.CONQUERED_S1:
		row = _textures[2]
	elif val == TileStates.CONQUERED_S2:
		row = _textures[3]
	elif val == TileStates.SLIPPERY:
		match(windDirection):
			Cardinals.DIRECTIONS.N: row = _textures[4]
			Cardinals.DIRECTIONS.NE: row = _textures[5]
			Cardinals.DIRECTIONS.E: row = _textures[6]
			Cardinals.DIRECTIONS.SE: row = _textures[7]
			Cardinals.DIRECTIONS.S: row = _textures[8]
			Cardinals.DIRECTIONS.SW: row = _textures[9]
			Cardinals.DIRECTIONS.W: row = _textures[10]
			Cardinals.DIRECTIONS.NW: row = _textures[11]
	
	if isDarker:
		texture = row[0]
	else:
		texture = row[1]
	
	$CenterContainer/TextureRect.texture = texture

func getGlobalAnchorPos():
	return $CenterContainer/Control.rect_global_position


func _on_CenterContainer_mouse_entered():
	emit_signal("hovered",self)
	$CenterContainer/AudioStreamPlayer2D.play()

func _on_CenterContainer_mouse_exited():
	emit_signal("not_hovered",self)

func _on_CenterContainer_gui_input(event):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("selectTile"):
			emit_signal("clicked",self)
