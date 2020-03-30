extends KinematicBody

var health = 100

var dead = false
var speed = 0.5

var death_animation = false
var walk_animation = false

var pitch_level = 1

var vector = Vector3()

puppet var puppet_dead = false
puppet var puppet_transform = transform

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	
	set_network_master(1)
	if is_network_master():
		randomize()
		pitch_level = rand_range(0.88, 1.12)
		rpc("sound_setup")

func _process(delta):
	
	if not $ZombieModel/AnimationPlayer.is_playing() and not walk_animation:
		$ZombieModel/AnimationPlayer.play("WalkAction 2")
		walk_animation = true
	
	if is_network_master():
		
		if not dead and walk_animation:
			if get_tree().get_nodes_in_group("Player"):
				var player = get_tree().get_nodes_in_group("Player")[0]
				if player:
					$LineOfSight.look_at(player.global_transform.origin, Vector3.UP)
					
					if $LineOfSight.is_colliding():
						if $LineOfSight.get_collider().is_in_group("Player"):
				
							look_at(player.global_transform.origin, Vector3.UP)
			
							rotation.x = 0
							vector.x = player.global_transform.origin.x - global_transform.origin.x
							vector.z = player.global_transform.origin.z - global_transform.origin.z
						else:
							vector.x = 0
							vector.z = 0
				
				
				vector.y -= 9.8 * delta
				move_and_slide(vector * speed)
			
				if $AttackRange.is_colliding():
					if $AttackRange.get_collider().is_in_group("Player"):
						$AttackRange.get_collider().attacked(delta)
			
			
				rset_unreliable("puppet_transform", transform)
		if health <= 0:
			print($DeadTimer.time_left)
			if dead == false:
				rpc("dead")
				$DeadTimer.start()
			dead = true

	else:
		transform = puppet_transform

func _on_network_peer_connected(id):
	if is_network_master() and health <= 0:
		rpc("dead")
		rset("puppet_transform", transform)
		rpc("sound_setup")
		
		
remotesync func dead():
	if death_animation == false:
		$ZombieModel/AnimationPlayer.play("DieAction")
		$Mouth/Dead.play()
		death_animation = true
	$CollisionShape.disabled = true
	$LineOfSight.enabled = false
	$AttackRange.enabled = false

remotesync func sound_setup():
	$Mouth/Hit.pitch_scale = pitch_level
	$Mouth/Dead.pitch_scale = pitch_level

remotesync func shot():
	health -= 50
	if health > 0:
		$Mouth/Hit.play()

remotesync func wakeup():
	$ZombieModel/AnimationPlayer.play_backwards("DieAction")

	death_animation = false
	health = 100
	dead = false
	$CollisionShape.disabled = false
	walk_animation = false
	$LineOfSight.enabled = true
	$AttackRange.enabled = true


func _on_DeadTimer_timeout():
	rpc("wakeup")
