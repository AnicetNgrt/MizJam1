extends GameReactive

func _ready():
	randomize()

func executeModifier(modifier):
	.executeModifier(modifier)
	if get_parent() != null:
		if hasPawnUnplaced:
			if myTurn:
				$Tween.interpolate_callback(self,0.5,"_tryPlacePawns")
				$Tween.start()
		if _canSkipTurn:
			$Tween.interpolate_callback(get_parent(),0.5,"skipTurn")
			$Tween.start()

func _onMyTurn():
	._onMyTurn()

func _onNotMyTurn():
	._onNotMyTurn()
	print("your turn")

func _tryPlacePawns():
	var pos = Vector2(randi()%10,randi()%15)
	while not _can_place_pawn_on_tile(_board.getTile(pos)):
		pos = Vector2(randi()%10,randi()%15)
	var index = _get_lastUnplacedPawnIndex()
	get_parent().placePawnOnTile(index,pos)
