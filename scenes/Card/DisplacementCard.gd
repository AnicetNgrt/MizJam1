extends Card

class_name DisplacementCard

export(PoolVector2Array) var pattern = []

var assignedPawnIndex = null
var assignedPawnSideNum = null
var assignedTilePos = null

func isInterestedByPawn(game, sender, pawnSideNum, pawnIndex):
	if not isPlayableFor(game, sender): return false
	if pawnSideNum != sender.get_index()+1: 
		#print("here")
		return false
	
	get_child(0).pawnIndex = pawnIndex
	for p in pattern:
		get_child(0).position = p
		if get_child(0).isValid(game, sender):
			return true
	
	return false

func assignPawn(sideNum, pawnIndex):
	if sideNum == assignedPawnSideNum and pawnIndex == assignedPawnIndex:
		assignedPawnIndex = null
		assignedPawnSideNum = null
	assignedPawnIndex = pawnIndex
	assignedPawnSideNum = sideNum

func isInterestedByTile(game, sender, pos):
	if not isPlayableFor(game, sender): return false
	if assignedPawnIndex == null: return false
	if assignedPawnSideNum == null: return false
	
	var pawns = sender.getPawns()
	var pawn = pawns[assignedPawnIndex]
	for p in pattern:
		var tileA = game._board.getIncidentTile(pawn.getPosition()+p, pawn.getPosition())
		var tileB = game._board.getIncidentTile(pos, pawn.getPosition())
		if tileA == tileB and tileA != null: return true
	return false

func assignTile(pos):
	if pos == assignedTilePos:
		assignedTilePos = null
	assignedTilePos = pos
