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

var y_force
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
	DebugOverlay.draw.add_vector(self, "upwardForce", collPoint, 2, 4, Color(1,1,1, 0.5))

func _physics_process(delta):
	collPoint = get_collision_point()
	indicator.global_transform.origin = collPoint
	
	suspension(delta)

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

		upwardForce.y = global_transform.basis.xform(transform.basis.y * y_force).y
		springApplicationRatio = upwardForce.normalized().dot(global_transform.basis.y)
		upwardForce = upwardForce * springApplicationRatio
		parentBody.apply_impulse(parentBody.global_transform.basis.xform(parentBody.to_local(collPoint)), upwardForce)
		
#		var contact = get_collision_point() - parentBody.global_transform.origin
#		var normal = get_collision_normal()
#  # Check helps eliminate force spikes when tumbling
#		upwardForce = normal * y_force
#		parentBody.apply_impulse(contact, normal * y_force)
		
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
	
func getWheelName():
	return upwardForce




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugOverlay.wheelText[wheelName].set_text(wheelName + ": " + str(suspensionHeight))
#	pass
