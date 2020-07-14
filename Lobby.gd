extends Control

func _ready():
	get_tree().set_network_peer(null)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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
