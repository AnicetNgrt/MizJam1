extends Node

class_name Side

export(int,0,999) var actionPoints: int

func getPawnCount() -> int:
	var count = 0
	for c in get_children():
		if c is Pawn:
			count += 1
	return count

func addPawn(pawn:Pawn):
	add_child(pawn)

func removePawn(pawn:Pawn):
	remove_child(pawn)
