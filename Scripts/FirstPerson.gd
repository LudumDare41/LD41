extends KinematicBody
#
#var mouse_sensitivity = 5
#var speed = 10
#var gravity = 9.8
#
#var movement = Vector3()
#
#func _ready():
#	Game.player = self
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#
#func _process(delta):
#
#	if Input.is_action_just_pressed("ui_cancel"):
#		get_tree().change_scene("res://MainMenu.tscn")
#
#
#	var input_axis = Vector2()
#	input_axis.y = -Input.get_action_strength("ui_up") +  Input.get_action_strength("ui_down")
#	input_axis.x = -Input.get_action_strength("ui_left") + Input.get_action_strength("ui_right")
#
#	input_axis = input_axis.normalized()
#
#	movement.z = input_axis.y * speed
#	movement.x = input_axis.x * speed
#	movement.y -= gravity * delta
#
#	movement = movement.rotated(global_transform.basis.y, $Head.rotation.y)
#
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		movement.y = 5
#
#	movement = move_and_slide(movement, Vector3.UP)
#
#
#func _input(event):
#	if event is InputEventMouseMotion:
#		$Head.rotation_degrees.y -= event.relative.x
#		$Head/Camera.rotation_degrees.x -= event.relative.y * mouse_sensitivity / 2.9
#		$Head/Camera.rotation_degrees.x = clamp($Head/Camera.rotation_degrees.x, -90, 90)
