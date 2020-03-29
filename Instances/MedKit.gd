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
		if body.health < 100:
			body.heal()
			picked = true
			rset("puppet_picked", picked)

func _on_network_peer_connected(id):
	rset("puppet_picked", picked)
