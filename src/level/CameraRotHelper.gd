extends Spatial

func _ready():
	pass

func _process(delta):
	global_transform.origin = $"../BuildObject".global_transform.origin
	pass
