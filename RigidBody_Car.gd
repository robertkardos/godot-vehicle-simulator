extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var wheels

var spring_length = 1
var compress = 0
var prev_compress = 0

var turnDegree = 0

var upwardForce = Vector3(0, 20, 0)
var upwardForcePos = Vector3(1.25, 0, 2.5)

var FrontL_forward = Vector3(1, 2, 3)

var rayCast
var indicator

# Called when the node enters the scene tree for the first time.
func _ready():
	rayCast = get_node("RayCast")
	indicator = get_node("Indicator")
	
#	self.vel = Vector3(2, 3, 7)
	DebugOverlay.draw.add_vector(self, "upwardForce", upwardForcePos, 2, 4, Color(1,1,1, 0.5))
	self.getWheels()

func _physics_process(delta):
#	FrontL_forward = FrontL.transform.basis.z
	add_force(upwardForce, upwardForcePos)
	prev_compress = compress
#	FrontL.rotate_y(0.001)

	if rayCast.is_colliding():
		var collPoint = rayCast.get_collision_point()
		indicator.global_transform.origin = collPoint
		var suspentionHeight = rayCast.global_transform.origin.distance_to(collPoint)
		compress = 1 - (suspentionHeight / spring_length)
		var y_force = 170 * compress * spring_length
		upwardForce.y = y_force
	else:
		upwardForce.y = 0
	
	if (compress - prev_compress) >= 0:
		upwardForce.y += 11 * (compress - prev_compress) / delta
	else:
		upwardForce.y += 11 * (compress - prev_compress) / delta
	
		
		
	if Input.is_key_pressed(KEY_SPACE):
		self.handbrake()
	if Input.is_key_pressed(KEY_T):
		self.addGas()
	if Input.is_key_pressed(KEY_F):
		turn(0.1)
	if Input.is_key_pressed(KEY_H):
		turn(-0.1)


func getWheels():
	wheels = {
		"fl" : self.get_node("WheelCast_FL")
	}
	
	rayCast = wheels["fl"]
#	FrontL = self.get_parent().get_node("Wheel_Front_L")
#	FrontR = self.get_parent().get_node("Wheel_Front_R")
#	RearL = self.get_parent().get_node("Wheel_Rear_L")
#	RearR = self.get_parent().get_node("Wheel_Rear_R")

func addGas():
	pass
	
func handbrake():
	pass
	
func turn(deg):
	pass



#func _input(ev):
#	if ev is InputEventKey and ev.scancode == KEY_F:
#		turn(0.1)
#	if ev is InputEventKey and ev.scancode == KEY_H:
#		turn(-0.1)
#
#	if ev is InputEventKey and ev.scancode == KEY_T:
#		self.addGas()
##		var forward = Vector3(0, 0, 1111) #example: direction in -z
##		var global_direction = global_transform.basis.xform(forward)
##		apply_impulse(Vector3(0, 0, 0), global_direction)
#
#	if ev is InputEventKey and ev.scancode == KEY_G:
#		print("G")
##		var forward = Vector3(0, 0, -1111) #example: direction in -z
##		var global_direction = global_transform.basis.xform(forward)
##		apply_impulse(Vector3(0, 0, 0), global_direction)
#
##		apply_impulse(Vector3(0, 0, 0), Vector3(11, 0, 0))
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass




#frontL.set("motor/target_velocity", 100)
#RearL.set("motor/target_velocity", 100)
#frontR = self.get_node("RigidBody_Wheel_Front_R/HingeJoint")
#RearR = self.get_node("RigidBody_Wheel_Rear_R/HingeJoint")
