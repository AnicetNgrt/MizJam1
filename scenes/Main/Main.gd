extends Node

func _ready():
	$"2D/Background/AnimationPlayer".play("scroll")

func _on_ButtonTutorial_pressed():
	get_tree().change_scene("res://scenes/Game/TutorialGame.tscn")
