extends Spatial

var picked = false
var forward = true
puppet var puppet_picked = false

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	
	set_network_master(1)

func _process(delta):
	
	rotate_y(0.05)
#	if not $Tween.is_active():
#		if forward:
#			$Tween.interpolate_property(self, "translation:y", translation.y, 0.5, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
#			$Tween.start()
#			forward = false
#		else:
#			$Tween.interpolate_property(self, "translation:y", translation.y, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
#			$Tween.start()
#			forward = true
			
	if not is_network_master():
		picked = puppet_picked
	
	if picked:
		visible = false
		$Area/CollisionShape.disabled = true

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		body.pack += 1
		body.update_HUD()
		picked = true
		rset("puppet_picked", picked)
		rpc("sound")

remotesync func sound():
	$PickupSound.play()

func _on_network_peer_connected(id):
	rset("puppet_picked", picked)
