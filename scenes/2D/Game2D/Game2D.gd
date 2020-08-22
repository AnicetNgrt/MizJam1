extends Game

class_name Game2D

func configureSides(names:PoolStringArray):
	.configureSides(names)
	_timeline.side1Name = names[0]
	_timeline.side2Name = names[1]
