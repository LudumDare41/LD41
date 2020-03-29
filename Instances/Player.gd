extends KinematicBody

var movement = Vector3()
var jump_force = 5
var speed = 12

var health = 100
var ammo = 12
var pack = 2

var can_shoot = true

puppet var puppet_transform = null
puppet var puppet_camera_rotation = null

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	refresh_HUD()
	
	if is_network_master():
		$Camera.current = true
		$Camera/Angle.visible = false
		$HUD.visible = true
		$Camera/RayCast.enabled = true
	else:
		$HUD.visible = false

func _physics_process(delta):
	if is_network_master():
		var direction_2D = Vector2()
		direction_2D.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		direction_2D.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		direction_2D = direction_2D.normalized()
		
		if $Camera/Handgun/AnimationPlayer.current_animation != "fire" and $Camera/Handgun/AnimationPlayer.current_animation != "reload":
		
			if direction_2D != Vector2():
				$Camera/Handgun/AnimationPlayer.play("walk")
				rpc("animation", "walk")
			else:
				$Camera/Handgun/AnimationPlayer.play("idle")
				rpc("animation", "idle")
				
		
		if Input.is_action_pressed("sprint"):
			speed = 16
		else:
			speed = 12
		
		movement.z = direction_2D.y * speed
		movement.x = direction_2D.x * speed
		movement.y -= 9.8 * delta
		
		movement = movement.rotated(Vector3.UP, rotation.y)
		
		if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				movement.y = jump_force
	
		movement = move_and_slide(movement, Vector3.UP)
		
		other_abilities()
		
		rset("puppet_transform", transform)
		rset("puppet_camera_rotation", $Camera.rotation)
	else:
		transform = puppet_transform
		$Camera.rotation = puppet_camera_rotation

func _input(event):
	if is_network_master():
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				rotation_degrees.y -= event.relative.x / 7
				$Camera.rotation_degrees.x -= event.relative.y / 7
				$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x, -90, 90)

func other_abilities():
	if Input.is_action_just_pressed("shoot"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and can_shoot and ammo > 0 and $Camera/Handgun/AnimationPlayer.current_animation != "reload":
			ammo -= 1
			refresh_HUD()
			
			
			$Camera/ShootLight.visible = true
			rpc("shootlight", true)
			$ShootLightTimer.start()
			can_shoot = false
			$Timer.start()
			
			rpc("shoot_sound")
			rpc("animation", "fire")
			$Camera/Handgun/AnimationPlayer.play("fire")
			if $Camera/RayCast.is_colliding():
				if $Camera/RayCast.get_collider().is_in_group("Zombie"):
					$Camera/RayCast.get_collider().rpc("shot")
			
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("reload") and ammo != 12:
		if pack > 0:
			rpc("reload")
			ammo = 12
			pack -= 1
			refresh_HUD()
	
	
	if Input.is_action_just_pressed("flashlight"):
		$Camera/Flashlight.visible = !$Camera/Flashlight.visible
		rpc("toggle_light", $Camera/Flashlight.visible)

remotesync func reload():
	$Camera/Handgun/AnimationPlayer.play("reload")
	$ReloadSound.play()

func refresh_HUD():
	$HUD/Health.text = str (health)
	$HUD/Ammo.text = str( ammo ) + " / " + str(pack)

remote func shootlight(status):
	$Camera/ShootLight.visible = status

remote func animation(anim):
	$Camera/Handgun/AnimationPlayer.play(anim)

remotesync func toggle_light(status):
	$Camera/Flashlight.visible = status

remotesync func shoot_sound():
	$ShootSound.play()

func _on_network_peer_connected(id):
	rpc("toggle_light", $Camera/Flashlight.visible)


func _on_Timer_timeout():
	can_shoot = true


func _on_ShootLightTimer_timeout():
	$Camera/ShootLight.visible = false
	rpc("shootlight", false)
