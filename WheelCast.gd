extends RayCast

var wheelName = "" setget setWheelName, getWheelName

var BUMP = 0.7 # default: 0.95, seems to be stiff and non-bouncy
var REBOUND = 0.065 # default: 0.065
var SPRING = 3
var SPRING_LENGTH = 1

var suspensionVec = Vector3(0, 0, 0)
var collPoint = Vector3(0, 0, 0)

var parentBody: RigidBody

var springApplicationRatio

var prev_pos
var z_vel

export(float, 0, 2, 0.05) var peak = 1
export(float, 1, 2.5, 0.05) var x_shape = 1.35
export(float, 1, 2.5, 0.05) var z_shape = 1.65
export(float, 0, 20, 0.1) var stiff = 10
export(float, -10, 0, 0.05) var curve = 0


var wheelForce1 = Vector3(0, 0, 0)
var wheelForce2 = Vector3(0, 0, 0)
var wheelForce3 = Vector3(0, 0, 0)



var testVec = Vector3(0, 0, 0)

var y_force = 0


var compress = 0
var prev_compress = 0
var suspensionHeight
var normal = Vector3(0, 0, 0)

var wheelPosition setget setWheelPosition, getWheelPosition
var upwardForce : Vector3 = Vector3(0, 0, 0) setget setUpwardForce, getUpwardForce

var indicator
# Called when the node enters the scene tree for the first time.
func _ready():
	parentBody = get_parent()
	indicator = get_node("Indicator")
	prev_pos = global_transform.origin


var local_vel
var x_slip
var z_slip

func calculate(delta):
	collPoint = get_collision_point()
	indicator.global_transform.origin = collPoint
	
	suspension(delta)
	
#	
#	(global_transform.origin - prev_pos) / delta = movement in global coordinates
#	global_transform xform_inv transforms from global to local
	local_vel = global_transform.basis.xform_inv((global_transform.origin - prev_pos) / delta)
#	local_vel = transform.basis.xform(local_vel)
	z_vel = -local_vel.z
	var planar_vect = Vector2(local_vel.x, local_vel.z).normalized()
	prev_pos = global_transform.origin

	x_slip = asin(clamp(-planar_vect.x, -1, 1))

	var spin = 2
	var radius = 1

	z_slip = 0
	if z_vel != 0:
		z_slip = (spin * radius - z_vel) / abs(z_vel)


	var x_force = pacejka(x_slip, x_shape)
	var z_force = pacejka(z_slip, z_shape)

	if is_colliding():
		var contact = get_collision_point() - parentBody.global_transform.origin
		
		wheelForce1 = global_transform.basis.x * x_force
		wheelForce2 = normal * y_force
		wheelForce3 = global_transform.basis.z * z_force
		
#		if wheelName == "fl":
#			testVec.x = 1
#			parentBody.add_force(testVec, contact)
		parentBody.add_force(wheelForce1 * 80, contact)
		
##		parentBody.add_force(wheelForce2, contact)
#		parentBody.add_force(-wheelForce3, contact)


func pacejka(slip, t_shape):
	
#	var v1 = atan(stiff * slip)
#	var v2 = (stiff * slip - v1)
#	var v3 = stiff * slip - curve * v2
#	var v4 = t_shape * atan(v3)
#	return y_force * peak * sin(v4)
	return y_force * peak * sin(t_shape * atan(stiff * slip - curve * (stiff * slip - atan(stiff * slip))))

func suspension(delta : float) -> void:
	prev_compress = compress
	if is_colliding():
		suspensionVec = global_transform.origin - collPoint
		
		suspensionHeight = global_transform.origin.distance_to(collPoint)
		compress = 1 - (suspensionHeight / SPRING_LENGTH) # 1 = fully compressed
		y_force = SPRING * compress * SPRING_LENGTH
		
		if compress >= prev_compress: # compressing
			var v = BUMP * (compress - prev_compress) / delta
			y_force += v
		else: # decompressing
			var v = REBOUND * (compress - prev_compress) / delta
			y_force += v
		
		
#		upwardForce.y = y_force
#		upwardForce = transform.basis.y * y_force

#		upwardForce.y = global_transform.basis.xform(transform.basis.y * y_force).y
#		springApplicationRatio = upwardForce.normalized().dot(global_transform.basis.y)
#		upwardForce = upwardForce * springApplicationRatio
#		parentBody.apply_impulse(parentBody.global_transform.basis.xform(parentBody.to_local(collPoint)), upwardForce)
#		parentBody.add_force(upwardForce, parentBody.global_transform.basis.xform(parentBody.to_local(collPoint)))
		
		var contact = get_collision_point() - parentBody.global_transform.origin
		var normal = get_collision_normal()
		# Check helps eliminate force spikes when tumbling
		upwardForce = normal * y_force
		parentBody.apply_impulse(contact, normal * y_force)
		
	else:
		springApplicationRatio = 0
		upwardForce = Vector3(0, 0, 0)



func setWheelPosition(pos: Vector3):
	print("Set wheel position")
	
func getWheelPosition():
	print("Get wheel position")

func setUpwardForce(vec: Vector3):
	upwardForce = vec
	
func getUpwardForce():
	return upwardForce
	
func setWheelName(text: String):
	wheelName = text
	
#	if wheelName == "fl":
	DebugOverlay.draw.add_vector(self, "wheelForce1", collPoint, false, 2, 4, Color(1,1,1, 0.5))
	DebugOverlay.draw.add_vector(self, "wheelForce3", collPoint, false, 2, 4, Color(1,0,0, 0.5))
	
func getWheelName():
	return upwardForce




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var varToWrite = z_slip
	DebugOverlay.wheelText[wheelName].set_text(wheelName + ": " + (" " if varToWrite >=0 else "") + str(stepify(varToWrite, 0.001)))
#	pass
