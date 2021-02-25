extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dirIndicator
var pointOfForceApply = Vector3(0, 0, 0.1)

var engineForce = 11
var breakingForce = 11
var isBreaking = false

var forcesOnWheel = Vector3(0, 0, 0)

var engineForceVec = Vector3(0, 0, 0)
var breakingForceVec = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	dirIndicator = self.transform.basis.z
	
	DebugOverlay.draw.add_vector(self, "dirIndicator", 1, 4, Color(0,1,1, 0.5))
	DebugOverlay.draw.add_vector(self, "forcesOnWheel", 1, 4, Color(1,1,1, 0.5))
	DebugOverlay.draw.add_vector(self, "engineForceVec", 1, 4, Color(0,1,0, 0.5))
	DebugOverlay.draw.add_vector(self, "breakingForceVec", 1, 4, Color(1,0,0, 0.5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dirIndicator = self.transform.basis.z
	engineForceVec = dirIndicator * engineForce
	breakingForceVec = dirIndicator * - breakingForce
	forcesOnWheel = engineForceVec + breakingForceVec
#	add_force(dirIndicator * 111, Vector3(0, 0, 0))
	engineForce = 0
	breakingForce = 0
	add_force(forcesOnWheel, pointOfForceApply)

func gas():
	engineForce = 11

func handbrake():
	breakingForce = 11
