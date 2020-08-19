extends Node

class_name Turn

const Rules = preload("res://resources/Rules.gd")

var _num

func _init(num:int, rules:Rules):
	_num = num
	var playingNum = _num%2 + 1
	var idleNum = (_num + 1)%2 + 1
	add_child(ModifierSetPlayingSide.new(playingNum))
	add_child(ModifierGiveActionPoints.new(playingNum,rules.actionPoints))
