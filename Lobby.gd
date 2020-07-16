extends Control

func _ready():
	get_tree().set_network_peer(null)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$Tween.interpolate_property($Logo1, "position:y", $Logo1.position.y, 850, 2, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.interpolate_property($Logo2, "position:y", $Logo2.position.y, 850, 2, Tween.TRANS_BOUNCE, Tween.EASE_OUT, 0.5)
	$Tween.interpolate_property($Logo3, "position:y", $Logo3.position.y, 850, 2, Tween.TRANS_BOUNCE, Tween.EASE_OUT, 1)
	$Tween.start()
	

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_HostButton_pressed():
	Network.create_server()

func _on_JoinButton_pressed():
	Network.join_server( $Menu/IP.text )

func _on_IP_text_entered(new_text):
	_on_JoinButton_pressed()

func _on_Quit_pressed():
	get_tree().quit()


func _on_Timer_timeout():
	$Menu.show()
	$Back.show()
