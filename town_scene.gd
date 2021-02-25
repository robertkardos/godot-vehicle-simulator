extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_wheel_friction(friction):
	var root = get_node("/root")
	var car = root.find_node('car', true, false)
	var carbody = car.get_node("Body")
	var wheel1 = car.get_node("Body/Wheel1")
	var wheel2 = car.get_node("Body/Wheel2")
	var wheel3 = car.get_node("Body/Wheel3")
	var wheel4 = car.get_node("Body/Wheel4")
	wheel1.wheel_friction_slip = friction
	wheel2.wheel_friction_slip = friction
	wheel3.wheel_friction_slip = friction
	wheel4.wheel_friction_slip = friction
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $MuhRayCast.is_colliding():
		var collider = $MuhRayCast.get_collider()
		match collider.name:
#			"Landscape_ice":
#				set_wheel_friction(0.2)
			"Asphalt":
				set_wheel_friction(1)
			"Grass":
				set_wheel_friction(0.5)
		
#		var mat = colParent.get_surface_material(0)
#		var mat1 = colParent.get_surface_material(1)
#		if mat1:
#			print(mat1.resource_name)
#		else:
#			print(mat.resource_name)

#		print(physicsMatOverride.friction)
#		if $MuhRayCast.get_collider().get_node_or_null("MeshInstance"):
#			print($MuhRayCast.get_collider().get_node("MeshInstance").mesh.material)
#			var asd = 2
