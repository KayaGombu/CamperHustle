extends Area2D

@export var bear_trap_scene: PackedScene 
@onready var collision_shape: CollisionShape2D = $CollisionShape2D 
var spawntraps = []

func get_random_position():
	var radius = collision_shape.shape.radius 
	var center = global_position

	while true:
		var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
		if random_offset.length() <= radius:
			return center + random_offset 

func spawn_bear_trap():
	if bear_trap_scene == null:
		print("bear_trap_scene is null")
		return

	var bear_trap = bear_trap_scene.instantiate()
	bear_trap.position = get_random_position() 
	get_tree().current_scene.add_child(bear_trap)
	
	spawntraps.append(bear_trap)

func removeAllBeartraps():
	for i in spawntraps:
		if is_instance_valid(i):
			i.queue_free()
	spawntraps.clear()
