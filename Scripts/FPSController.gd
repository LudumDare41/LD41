extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector3()
export var speed = 30
export var gravity = 3
var dir = Vector3(0,0,0)
export var jump = 10
export var mouse_sensitivity = 0.3
var camera_angle = 0

func _ready():
	set_process_input(true)
	pass

func _physics_process(delta):
	
	direction = Vector3(0,0,0)
	var aim = $Head/Camera.get_global_transform().basis
	if Input.is_action_pressed("ui_up"):
		direction -= aim.z
	if Input.is_action_pressed("ui_down"):
		direction += aim.z
	if Input.is_action_pressed("ui_right"):
		direction += aim.x
	if Input.is_action_pressed("ui_left"):
		direction -= aim.x
	
	direction = direction.normalized()
	direction *= speed
	dir = direction.linear_interpolate(direction, speed * delta)
	
	dir.y += -9.8 * delta * gravity
	dir.x = direction.x
	dir.z = direction.z
	
	dir = move_and_slide(dir, Vector3(0,1,0))

	if Input.is_action_pressed("ui_select") && is_on_floor():
		dir.y = jump
	pass

func _input(event):
	if event is InputEventMouseMotion:
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var change = -event.relative.y * mouse_sensitivity
		
		if (change + camera_angle) < 90 and (change + camera_angle) > -90:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change






		