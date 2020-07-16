extends SpotLight

var value = 0.6

func _process(delta):
	randomize()
	var number = rand_range(0.2, 1)
	value = lerp(value, number, delta * 10)
	light_energy = value
	light_indirect_energy = value
