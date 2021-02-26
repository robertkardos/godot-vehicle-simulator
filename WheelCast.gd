extends RayCast

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spring_length = 1
var compress = 0
var prev_compress = 0

var wheelPosition setget setWheelPosition, getWheelPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
#func physicsCalc:
#	add_force(upwardForce, upwardForcePos)
#	prev_compress = compress
##	FrontL.rotate_y(0.001)
#
#	if rayCast.is_colliding():
#		var collPoint = rayCast.get_collision_point()
#		indicator.global_transform.origin = collPoint
#		var suspentionHeight = rayCast.global_transform.origin.distance_to(collPoint)
#		compress = 1 - (suspentionHeight / spring_length)
#		var y_force = 170 * compress * spring_length
#		upwardForce.y = y_force
#	else:
#		upwardForce.y = 0
#
#	if (compress - prev_compress) >= 0:
#		upwardForce.y += 11 * (compress - prev_compress) / delta
#	else:
#		upwardForce.y += 11 * (compress - prev_compress) / delta

func setWheelPosition(pos: Vector3):
	print("Set wheel position")
	
func getWheelPosition():
	print("Get wheel position")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
