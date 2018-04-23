extends KinematicBody

# Helpers
var direction = Vector3()
var velocity = Vector3(0,0,0)

#walk variables
const MAX_SPEED = 10
const MAX_RUNNING_SPEED = 20
const ACCEL = 2
const DEACCEL = 8
export var gravity = -9.8 * 3

#Mouse controller variables
export var mouse_sensitivity = 0.3
var camera_angle = 0

#jump
export var jump = 10

#Player
const MAX_HEALTH = 100
const MAX_STAMINA = 100
var health = MAX_HEALTH
var stamina = MAX_STAMINA
var isRunning = false
var inDemageArea = false

#Audio
onready var FootstepsAudio = get_node("Footsteps")
var footstepSounIsPlaying = false
var timer = 0.5

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#register the player to the global class
	Game.player = self

func _physics_process(delta):
	timer -= delta
	if health < 1:
		get_tree().change_scene("res://Levels/GameOver.tscn")
	if inDemageArea and health > 0.5:
		health -= 10 * delta
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	direction = Vector3(0,0,0)
	var aim = $Head/Camera.get_global_transform().basis
	if Input.is_action_pressed("ui_up"):
		direction -= aim.z
		footstep()
	if Input.is_action_pressed("ui_down"):
		direction += aim.z
		footstep()
	if Input.is_action_pressed("ui_right"):
		direction += aim.x
		footstep()
	if Input.is_action_pressed("ui_left"):
		direction -= aim.x
		footstep()
		
	direction.y = 0
	direction = direction.normalized()
	velocity.y += gravity * delta
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("shift") and stamina > 0.1:
		stamina -= 15 * delta
		speed = MAX_RUNNING_SPEED
	else:
		if stamina < 100:
			stamina += 2 * delta
		speed = MAX_SPEED
	# where would the player go at max speed
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	
	# calculate a portion of the distance to go
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	

	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if Input.is_action_pressed("ui_select") && is_on_floor():
		velocity.y = jump
		timer = 0.8
	
	updateStatusUI(int(health),int(stamina))

func _input(event):
	if event is InputEventMouseMotion:
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var change = -event.relative.y * mouse_sensitivity
		
		if (change + camera_angle) < 90 and (change + camera_angle) > -90:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change
			
func updateStatusUI(health, stamina):
	var staminaLabel = get_node("Control/StatusUI/Stamina")
	staminaLabel.text = str(stamina)
	var healthLabel = get_node("Control/StatusUI/Health")
	healthLabel.text = str(health)

func _on_Area_body_entered(body):
	if body.is_in_group("DemageArea"):
		inDemageArea = true
	pass # replace with function body


func _on_Area_body_exited(body):
	if body.is_in_group("DemageArea"):
		inDemageArea = false
	pass # replace with function body

func footstep():
	if !FootstepsAudio.is_playing() and timer < 0.01:
		FootstepsAudio.play()
		timer = 0.5