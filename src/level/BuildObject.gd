extends VehicleBody

var blocks = [
	"res://src/objects/BlockNode.tscn",
	"res://src/objects/WheelNode.tscn"
]

var block_index = 0;
var block_mass = 70

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_home"):
		apply_torque_impulse(Vector3(mass, 0, 0))
	if Input.is_action_pressed("ui_accel"):
		print(engine_force)
		engine_force += 100
		if engine_force > 13000:
			engine_force = 13000;
	if Input.is_action_pressed("ui_brake"):
		print(engine_force)
		engine_force -= 100
		if engine_force <= -5000:
			engine_force = -5000;
	
	engine_force = lerp(engine_force, 0.0, 0.01)
	for child in get_children():
		if child is VehicleWheel:
			child.engine_force = engine_force
	
	if Input.is_action_pressed("ui_steer_left"):
		steering = .4
		for child in get_children():
			if child is VehicleWheel and child.use_as_steering:
				child.steering = steering
	elif Input.is_action_pressed("ui_steer_right"):
		steering = -.4
		for child in get_children():
			if child is VehicleWheel and child.use_as_steering:
				child.steering = steering
	else:
		steering = 0
		for child in get_children():
			if child is VehicleWheel:
				child.steering = steering
				
	if Input.is_action_just_pressed("ui_next"):
		print("next")
		block_index += 1
		print(block_index)
	if Input.is_action_just_pressed("ui_prev"):
		print("prev")
		block_index -= 1
		print(block_index)
		
	if block_index < 0:
		block_index = blocks.size() - 1
	elif block_index > blocks.size() - 1:
		block_index = 0
	pass

func _on_BlockNode_add_block(pos):
	print("Adding at " + str(pos))
	var block = load(blocks[block_index]).duplicate(true)
	var node:Spatial = block.instance() as Spatial
	node.transform.origin = pos
	add_child(node)
	node.connect("add_block", self, "_on_BlockNode_add_block")
	mass += block_mass
	apply_central_impulse(Vector3(0, mass, 0))
	update_gizmo()
	pass

func _on_BlockNode_block_removed():
	print("Removing")
	mass -= block_mass
	apply_central_impulse(Vector3(0, mass, 0))
	pass
