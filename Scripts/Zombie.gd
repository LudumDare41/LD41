extends KinematicBody

var health = 100

var dead = false
var speed = 0.5

var death_animation = false

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
	if is_network_master():
		
		if not dead:
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
			if dead == false:
				rpc("dead")
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
	health -= 40
	if health > 0:
		$Mouth/Hit.play()














##export var speed = 2.5
##var dir = Vector3()
##var vel = Vector3()
##const GRAVITY = -9.8
##
##var life = 80
##var dead = false
##
##var canGrowl = false
##
##var seePlayer = false
##
##func _ready():
##	$GrowlTimer.wait_time = rand_range(2.0, 5.0)
##
##func _physics_process(delta):
##
##
##	if dead:
##		return
##
##	$ZombieModel/AnimationPlayer.queue("WalkAction")
##
##	dir = Game.player.translation - self.translation
##
##
##
##	dir = dir.normalized()
##
##	vel.y += GRAVITY * delta
##
##	var tmp_vel = vel
##	tmp_vel.y = 0
##
##	# where would the zombie go at max speed
##	var target = dir * speed
##
##	# calculate a portion of the distance to go
##	tmp_vel = tmp_vel.linear_interpolate(target, 12 * delta)
##
##	vel.x = tmp_vel.x
##	vel.z = tmp_vel.z
##
##	$RayCast.look_at(Game.player.translation, Vector3.UP)
##	if $RayCast.get_collider() == Game.player:
##		seePlayer = true
##		vel = move_and_slide(vel, Vector3(0, 1, 0))
##		look_at(Game.player.translation, Vector3(0,1,0))
##	else:
##		seePlayer = false
##
##	rotation.x = 0
##	if $RayCast != null:
##		$RayCast.rotation.x = 0
##
##func hit(damage, headshot):
##	if not dead:
##		if headshot:
##			damage = damage*3
##
##		life -= damage
##
##		hit_particle()
##		if life <= 0:
##			die()
##			return
##		$Hit.play()
##
##func die():
##	dead = true
##	$CollisionShape.disabled = true
##	$ZombieModel/AnimationPlayer.stop()
##	$ZombieModel/AnimationPlayer.play("DieAction")
##	$RayCast.queue_free()
##	$CollisionShape.queue_free()
##	$Die.play()
##	$DeadTimer.start()
##
##func hit_particle():
##	$HitParticle.emitting = true
##	$HitParticle.restart()
##
##func _on_DeadTimer_timeout():
##	self.queue_free()
##
##
##func _on_GrowlTimer_timeout():
##	if not dead:
##		if canGrowl:
##			if seePlayer == false:
##				$Growl.play()
##				$GrowlTimer.wait_time = rand_range(2.0, 5.0)
##			else:
##				$GrowlAttack.play()
##				$GrowlTimer.wait_time = rand_range(0.5, 1.3)
##
##		$GrowlTimer.start()
##		canGrowl = true
