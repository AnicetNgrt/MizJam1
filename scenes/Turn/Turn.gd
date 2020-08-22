extends Node

class_name Turn

const Rules = preload("res://resources/Rules.gd")

var num:int
export var sideA:int = 0
export var sideB:int = 0

signal modifierAdded(modifiern,num,part)

func setup(num:int, rules:Rules):
	self.num = num
	sideA = rules.firstSideToPlay
	if sideA == 1: sideB = 2
	else: sideB = 1
	
	addModifier(ModifierSetPlayingSide.new(sideA),1)
	addModifier(ModifierGiveActionPoints.new(sideA,rules.actionPoints),1)
	addModifier(ModifierSetPlayingSide.new(sideB),2)
	addModifier(ModifierGiveActionPoints.new(sideB,rules.actionPoints),2)

func addModifier(modifier:Modifier, part:int):
	if part == 1:
		$PartA.add_child(modifier)
		emit_signal("modifierAdded",modifier,num,1)
	elif part == 2:
		$PartB.add_child(modifier)
		emit_signal("modifierAdded",modifier,num,2)
