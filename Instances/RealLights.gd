extends OmniLight

var activated = true

func _process(delta):
	randomize()
	if activated:
		if $TurnedOn.is_stopped():
			var number = rand_range(0.5, 3)
			$TurnedOn.wait_time = number
			$TurnedOn.start()
	else:
		if $TurnedOff.is_stopped():
			var number = rand_range(0.01, 0.5)
			$TurnedOff.wait_time = number
			$TurnedOff.start()

func _on_TurnedOn_timeout():
	activated = false
	hide()


func _on_TurnedOff_timeout():
	activated = true
	show()
