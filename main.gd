extends Node

@onready var bear_trap_spawn: Area2D = $BearTrapSpawn
@onready var bear_trap_spawn_2: Area2D = $BearTrapSpawn2
@onready var bear_trap_spawn_3: Area2D = $BearTrapSpawn3
@onready var bear_trap_spawn_4: Area2D = $BearTrapSpawn4




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Main/Player").hide()
	$CampFire.hide()
	$ColorRect.show()
	$HUD.show()
	if bear_trap_spawn == null:
		print("spawnArea node not found")
	$ColorRect.show()
	$HUD.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func game_over():
	pass

func new_game():
	print("new game called")
	$Player.position = $StartPosition.position
	$StartTimer.start()
	$HUD.show_message("Save the campers!")
	
	
	for _i in range(2):
		bear_trap_spawn.spawn_bear_trap()
		bear_trap_spawn_2.spawn_bear_trap()
		bear_trap_spawn_3.spawn_bear_trap()
		bear_trap_spawn_4.spawn_bear_trap()
	get_node("/root/Main/Player").show()
	$CampFire.show()
	$Forest.play()
	$Music.play()
	get_tree().call_group("campers", "queue_free")
	
	await get_tree().create_timer(2.0).timeout
	$HUD/Message.hide()
