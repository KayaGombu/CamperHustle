extends Area2D

@export var child_scene: PackedScene 
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func get_random_position():
	var radius = collision_shape.shape.radius 
	var center = global_position

	while true:
		var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
		if random_offset.length() <= radius:
			return center + random_offset 

func spawn_child():
	if child_scene == null:
		print("child_scene is null")
		return

	var child = child_scene.instantiate() 
	child.position = get_random_position() 
	get_tree().current_scene.add_child(child)
	
