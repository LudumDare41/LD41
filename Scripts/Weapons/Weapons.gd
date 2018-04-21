extends Spatial

#Shooting params
var shoot_range = 1000
var screen_width_center = 0
var screen_height_center = 0
var shoot_origin = Vector3()
var shoot_direction = Vector3()
var shooting = false
var impactForce = 20
var weaponID = 0

func _ready():
	
	screen_width_center = OS.get_window_size().x/2
	screen_height_center = OS.get_window_size().y/2
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var camera = get_node("../")
		shoot_origin = camera.project_ray_origin(Vector2(screen_width_center, screen_height_center))
		shoot_direction = camera.project_ray_normal(Vector2(screen_width_center, screen_height_center)) * shoot_range
		
		if event.button_index == 1:
			shooting = true
		
func _physics_process(delta):
	if shooting:
		pistol()
	shooting = false
	pass

func pistol():
	print("test")
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(shoot_origin, shoot_direction, [self], 1)
	var impulse
	var impact_position
	if result:
		impulse = (result.position - global_transform.origin).normalized()
		var position = result.position - result.collider.global_transform.origin
		if shooting and result.collider is RigidBody:
			result.collider.apply_impulse(position, impulse*impactForce)
	
