tool # needed so it runs in the editor
extends EditorScenePostImport

func post_import(scene: Object):
#	var Asphalt = scene.find_node('Asphalt')
#	var AsphaltColl: StaticBody = Asphalt.find_node('Asphalt')
	# do your stuff here
	
		# child
	for grandchild in scene.get_children():
#		for grandchild in child.get_children():
		print(grandchild.get_class())
		if grandchild.get_class() == "StaticBody":
			print(grandchild.name)
			grandchild.add_to_group("terrainColliderGroup")
			grandchild.set_collision_mask(3)
			grandchild.set_collision_layer_bit(1, true)

	print('custom IMPORTER ran')
#	var desired_children = scene.get_tree().get_nodes_in_group("terrainColliderGroup")
#	print(desired_children)
	
	return scene # remember to return the imported scene
