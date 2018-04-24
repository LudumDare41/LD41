extends SpotLight

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var default_light_energy = 0
var flashlightStatus = true
const MAX_BATTERY = 100
var battery = MAX_BATTERY
onready var batteryUI = get_node("../../../Control/FlashlightStatus/Flashlight")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	default_light_energy = light_energy
	pass

func _process(delta):
	if Input.is_action_just_pressed("Flashlight"):
		flashlightStatus = !flashlightStatus
	if flashlightStatus and battery > 1:
		light_energy = default_light_energy
		battery -= 1.5 * delta
	else:
		light_energy = 0
		battery += 3 * delta
		
	if battery < 2:
		flashlightStatus = false
	updateStatusUI(int(battery))
	pass
	
func updateStatusUI(battery):
	batteryUI.text = str(battery)

