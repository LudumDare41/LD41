extends MeshInstance

func _ready():
	$ImpactSound.play()
	$Timer.start()

func _on_Timer_timeout():
	$ImpactLight.visible = false
