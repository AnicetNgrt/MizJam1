extends Node

class_name Turn

const Rules = preload("res://resources/Rules.gd")

var num

func setup(num:int, rules:Rules):
	self.num = num
	var playingNum = num%2 + 1
	var idleNum = (num + 1)%2 + 1
	add_child(ModifierSetPlayingSide.new(playingNum))
	add_child(ModifierGiveActionPoints.new(playingNum,rules.actionPoints))
