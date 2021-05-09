extends Spatial

onready var mesh:MeshInstance = $Anchor
onready var mat:SpatialMaterial = mesh.material_override.duplicate(true)
signal clicked(rot, pos, add)

func _ready():
	mat.albedo_color = Color(1,1,1)
	mesh.material_override = mat
	pass

func _on_Area_mouse_entered():
	mat.albedo_color = Color(0,0,0)
	mesh.material_override = mat
	pass

func _on_Area_mouse_exited():
	mat.albedo_color = Color(1,1,1)
	mesh.material_override = mat
	pass

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		var pos = $Anchor.transform.origin*2
		emit_signal("clicked", rotation, pos, true)
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		var pos = $Anchor.transform.origin*2
		emit_signal("clicked", rotation, pos, false)
		get_parent().get_parent().queue_free()
	pass
