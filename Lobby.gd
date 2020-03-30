extends Control

func _on_HostButton_pressed():
	Network.create_server()

func _on_JoinButton_pressed():
	Network.join_server( $Menu/IP.text )

func _on_IP_text_entered(new_text):
	_on_JoinButton_pressed()
