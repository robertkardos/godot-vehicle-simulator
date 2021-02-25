extends RigidBody

var keys = {
	"space": false,
	"w": false,
	"a": false,
	"s": false,
	"d": false
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var FrontL
var FrontR
var RearL
var RearR

var turnDegree = 0

var FrontL_forward = Vector3(1, 2, 3)

# Called when the node enters the scene tree for the first time.
func _ready():
#	self.vel = Vector3(2, 3, 7)
	self.getWheels()

func _physics_process(delta):
	FrontL_forward = FrontL.transform.basis.z
	
#	FrontL.rotate_y(0.001)

	if Input.is_key_pressed(KEY_SPACE):
		self.handbrake()
	if Input.is_key_pressed(KEY_T):
		self.addGas()
	if Input.is_key_pressed(KEY_F):
		turn(0.1)
	if Input.is_key_pressed(KEY_H):
		turn(-0.1)



func getWheels():
	FrontL = self.get_parent().get_node("Wheel_Front_L")
	FrontR = self.get_parent().get_node("Wheel_Front_R")
	RearL = self.get_parent().get_node("Wheel_Rear_L")
	RearR = self.get_parent().get_node("Wheel_Rear_R")

func addGas():
	FrontL.gas()
	FrontR.gas()
	RearL.gas()
	RearR.gas()
	
func handbrake():
	FrontL.handbrake()
	FrontR.handbrake()
	RearL.handbrake()
	RearR.handbrake()
	
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
