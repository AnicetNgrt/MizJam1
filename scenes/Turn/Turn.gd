extends Node

class_name Turn

const Rules = preload("res://resources/Rules.gd")

var num:int
export var sideA:int = 0
export var sideB:int = 0

func setup(num:int, rules:Rules):
	self.num = num
	sideA = rules.firstSideToPlay
	if sideA == 1: sideB = 2
	else: sideB = 1
	
	$PartA.add_child(ModifierSetPlayingSide.new(sideA))
	$PartA.add_child(ModifierGiveActionPoints.new(sideA,rules.actionPoints))
	$PartB.add_child(ModifierSetPlayingSide.new(sideB))
	$PartB.add_child(ModifierGiveActionPoints.new(sideB,rules.actionPoints))
