extends SpotLight
#
#
#var default_light_energy = 0
#var flashlightStatus = true
#const MAX_BATTERY = 100
#var battery = MAX_BATTERY
#onready var batteryUI = get_node("../../../Control/FlashlightStatus/Flashlight")
#
#func _ready():
#	default_light_energy = light_energy
#
#func _process(delta):
#	if Input.is_action_just_pressed("Flashlight"):
#		flashlightStatus = !flashlightStatus
#	if flashlightStatus and battery > 1:
#		light_energy = default_light_energy
#		battery -= 5 * delta
#	else:
#		if battery < 100:
#			light_energy = 0
#			battery += 15 * delta
#
#	if battery < 2:
#		flashlightStatus = false
#	updateStatusUI(int(battery))
#
#func updateStatusUI(battery):
#	batteryUI.text = str(battery)
#
