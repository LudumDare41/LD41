extends SpotLight

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var default_light_energy = 0
var flashlightStatus = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	default_light_energy = light_energy
	pass

func _process(delta):
	if Input.is_action_just_pressed("Flashlight"):
		flashlightStatus = !flashlightStatus
	
	
	if flashlightStatus:
		light_energy = default_light_energy
	else:
		light_energy = 0
	
	pass
