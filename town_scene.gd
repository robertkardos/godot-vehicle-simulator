extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	var root = get_node("/root")
	var car = root.find_node('car', true, false)
	var carbody = car.get_node("Body")
	var wheel1 = car.get_node("Body/Wheel1")
	var wheel2 = car.get_node("Body/Wheel2")
	var wheel3 = car.get_node("Body/Wheel3")
	var wheel4 = car.get_node("Body/Wheel4")
	
#	print(carbody.get_engine_force())
	if $MuhRayCast.is_colliding():
		var wat = $MuhRayCast.get_collider().get_physics_material_override()
		
		wheel1.wheel_friction_slip = wat.friction
		wheel2.wheel_friction_slip = wat.friction
		wheel3.wheel_friction_slip = wat.friction
		wheel4.wheel_friction_slip = wat.friction
		print(wat.friction)
		if $MuhRayCast.get_collider().get_node_or_null("MeshInstance"):
			print($MuhRayCast.get_collider().get_node("MeshInstance").mesh.material)
			var asd = 2
