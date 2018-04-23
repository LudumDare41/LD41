extends Spatial

func _ready():
	$Control/TextureRect.texture = Game.deathScreenShot

func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().change_scene("res://MainMenu.tscn")
