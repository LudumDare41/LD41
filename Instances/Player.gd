extends KinematicBody

var movement = Vector3()
var jump_force = 5
var speed = 10

puppet var puppet_transform = null
puppet var puppet_camera_rotation = null

func _ready():
	if is_network_master():
		$Camera.current = true
		$Camera/Angle.visible = false

func _physics_process(delta):
	if is_network_master():
		var direction_2D = Vector2()
		direction_2D.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		direction_2D.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		direction_2D = direction_2D.normalized()
		
		if Input.is_action_pressed("sprint"):
			speed = 15
		else:
			speed = 10
		
		movement.z = direction_2D.y * speed
		movement.x = direction_2D.x * speed
		movement.y -= 9.8 * delta
		
		movement = movement.rotated(Vector3.UP, rotation.y)
		
		if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				movement.y = jump_force
	
		movement = move_and_slide(movement, Vector3.UP)
		
		other_abilities()
		
		rset("puppet_transform", transform)
		rset("puppet_camera_rotation", $Camera.rotation)
	else:
		transform = puppet_transform
		$Camera.rotation = puppet_camera_rotation

func _input(event):
	if is_network_master():
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				rotation_degrees.y -= event.relative.x / 10
				$Camera.rotation_degrees.x -= event.relative.y / 10
				$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x, -90, 90)

func other_abilities():
	if Input.is_action_just_pressed("shoot"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
