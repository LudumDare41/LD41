extends Spatial

var picked = false

puppet var puppet_picked = false

func _ready():
	set_network_master(1)

func _process(delta):
	if is_network_master():
		rset("puppet_picked", picked)
	else:
		picked = puppet_picked
	
	if picked:
		visible = false
		$Area/CollisionShape.disabled = true


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		if body.health < 100:
			body.heal()
			picked = true
