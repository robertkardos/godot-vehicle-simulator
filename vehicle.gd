extends VehicleBody

const STEER_SPEED = 5
const STEER_LIMIT = 1

var steer_target = 0

export var engine_force_value = 240

func _physics_process(delta):
	var MuhRayCast = get_node("/root/TownScene/MuhRayCast")
	var cast_from_point = Vector3(global_transform.origin.x, global_transform.origin.y + 1, global_transform.origin.z)
	var cast_to_point = Vector3(0, -20, 0)
	MuhRayCast.transform.origin = cast_from_point
	MuhRayCast.set_cast_to(cast_to_point)
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	
	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	steer_target *= STEER_LIMIT
	
	if Input.is_action_pressed("accelerate"):
		engine_force = engine_force_value
	else:
		engine_force = 0
	
	if Input.is_action_pressed("reverse"):
		if (fwd_mps >= -1):
			engine_force = -engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0
	
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
