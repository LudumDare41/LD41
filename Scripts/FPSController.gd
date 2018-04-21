extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector3()
export var speed = 15
export var gravity = 3
var dir = Vector3(0,0,0)
export var jump = 10

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	
	direction = Vector3(0,0,0)
	if Input.is_action_pressed("up"):
		direction.z = -1
	if Input.is_action_pressed("down"):
		direction.z = 1
	if Input.is_action_pressed("rigth"):
		direction.x = 1
	if Input.is_action_pressed("left"):
		direction.x = -1
	
	direction = direction * speed
	
	dir.y += -9.8 * delta * gravity
	dir.x = direction.x
	dir.z = direction.z
	
	dir = move_and_slide(dir, Vector3(0,1,0))
	
	if Input.is_action_pressed("space") && is_on_floor():
		## Isso aqui faz ele pular
		dir.y = jump
	pass