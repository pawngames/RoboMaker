extends Spatial

onready var wheel_parent:VehicleWheel = get_parent()
onready var mesh:MeshInstance = $Anchor
onready var mat:SpatialMaterial = mesh.material_override.duplicate(true)
signal clicked(rot, pos, add)

func _ready():
	mat.albedo_color = Color(1,1,1)
	mesh.material_override = mat
	pass

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		if event.button_index == BUTTON_RIGHT:
			print("enable")
			wheel_parent.use_as_steering = true
			wheel_parent.use_as_traction = true
			mat.albedo_color = Color(0,0,0)
			mesh.material_override = mat
		if event.button_index == BUTTON_LEFT:
			print("disable")
			wheel_parent.use_as_steering = false
			wheel_parent.use_as_traction = false
			mat.albedo_color = Color(1,1,1)
			mesh.material_override = mat
	pass
