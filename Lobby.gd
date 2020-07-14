extends Control

func _ready():
	get_tree().set_network_peer(null)

func _on_HostButton_pressed():
	Network.create_server()

func _on_JoinButton_pressed():
	Network.join_server( $Menu/IP.text )

func _on_IP_text_entered(new_text):
	_on_JoinButton_pressed()

func _on_Quit_pressed():
	get_tree().quit()
