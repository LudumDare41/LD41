extends Spatial

var picked = false

puppet var puppet_picked = false

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	
	set_network_master(1)

func _process(delta):
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
