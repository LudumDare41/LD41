extends Spatial

var picked = false

puppet var puppet_picked = false

func _ready():
	set_network_master(1)

func _process(delta):
	if is_network_master():
		rset_unreliable("puppet_picked", picked)
	else:
		picked = puppet_picked
	
	if picked:
		visible = false
		$Area/CollisionShape.disabled = true


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		body.pack += 1
		body.refresh_HUD()
		picked = true
