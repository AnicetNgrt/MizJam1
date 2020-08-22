extends Sprite

func _ready():
	$AnimationPlayer.play("wind")
	$AnimationPlayer.advance(randf())
