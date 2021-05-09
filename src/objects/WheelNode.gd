extends VehicleWheel

signal add_block(pos)
signal block_removed()

onready var mesh:MeshInstance = $WheelNodeMesh
onready var mat:SpatialMaterial = mesh.material_override.duplicate(true)

func _ready():
	mat.albedo_color = Color(1,1,1)
	mesh.material_override = mat
	for i in range(4):
		add_anchor(Vector3(0, PI/2*i, 0))
	for i in range(2):
		add_anchor(Vector3(0, 0, PI/2 + PI*i))
	pass

func add_anchor(rotation:Vector3):
	var block = load("res://src/objects/AnchorNode.tscn").duplicate(true)
	var node:Spatial = block.instance() as Spatial
	$Anchors.add_child(node)
	node.rotation = rotation
	node.connect("clicked", self, "_on_Anchor_clicked")
	pass

func _process(delta):
	pass

func _on_Anchor_clicked(rot:Vector3, pos:Vector3, add:bool):
	pos = pos.rotated(Vector3(1,0,0), rot.x)
	pos = pos.rotated(Vector3(0,1,0), rot.y)
	pos = pos.rotated(Vector3(0,0,1), rot.z)
	print("pos: " + str(pos))
	pos += global_transform.origin
	if add:
		emit_signal("add_block", pos)
	else:
		emit_signal("block_removed")
	pass

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	
	pass

func _on_Area_mouse_entered():
	mat.albedo_color = Color(0,0,0)
	mesh.material_override = mat
	pass
