extends Node

class_name Turn

const Rules = preload("res://resources/Rules.gd")

var num:int
export var sideA:int = 0
export var sideB:int = 0

signal modifierAdded(modifier,num,part)
signal modifierRemoved(modifier,num,part)

func addModifier(modifier:Modifier, part:int):
	if part == 1:
		$PartA.add_child(modifier)
		emit_signal("modifierAdded",modifier,num,1)
	elif part == 2:
		$PartB.add_child(modifier)
		emit_signal("modifierAdded",modifier,num,2)

func removeModifier(modifier:Modifier, part:int):
	if part == 1:
		$PartA.remove_child(modifier)
		emit_signal("modifierRemoved",modifier,num,1)
	elif part == 2:
		$PartB.remove_child(modifier)
		emit_signal("modifierRemoved",modifier,num,2)
