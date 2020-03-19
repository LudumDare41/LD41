extends KinematicBody
##
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
