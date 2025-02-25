extends Node

@onready var bear_trap_spawn: Area2D = $BearTrapSpawn
@onready var bear_trap_spawn_2: Area2D = $BearTrapSpawn2
@onready var bear_trap_spawn_3: Area2D = $BearTrapSpawn3
@onready var bear_trap_spawn_4: Area2D = $BearTrapSpawn4



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bear_trap_spawn == null:
		print("spawnArea node not found")
		
	for _i in range(2):
		bear_trap_spawn.spawn_bear_trap()
		bear_trap_spawn_2.spawn_bear_trap()
		bear_trap_spawn_3.spawn_bear_trap()
		bear_trap_spawn_4.spawn_bear_trap()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
