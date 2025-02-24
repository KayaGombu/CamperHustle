extends Node

<<<<<<< Updated upstream
=======
@onready var child_spawn_area: Area2D = $ChildSpawnArea
@onready var child_spawn_area_2: Area2D = $ChildSpawnArea2
@onready var child_spawn_area_3: Area2D = $ChildSpawnArea3
@onready var child_spawn_area_4: Area2D = $ChildSpawnArea4

@onready var bear_trap_spawner: Area2D = $BearTrapSpawner
@onready var bear_trap_spawner_2: Area2D = $BearTrapSpawner2
@onready var bear_trap_spawner_3: Area2D = $BearTrapSpawner3
@onready var bear_trap_spawner_4: Area2D = $BearTrapSpawner4




>>>>>>> Stashed changes
var spawnable = [["Campfire", Vector2(583, 323), 4]]
var fireNum = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FireSpread.start(randi_range(240, 360))
<<<<<<< Updated upstream
=======
	
	#show hud
	$ColorRect.show()
	$HUD.show()
	
	#for child spawn
	if child_spawn_area == null:
		print("SpawnArea node not found")
		return
		
	for _i in range(1):
		child_spawn_area.spawn_child()
		child_spawn_area_2.spawn_child()
		child_spawn_area_3.spawn_child()
		child_spawn_area_4.spawn_child()
	
	for _i in range(2):
		bear_trap_spawner.spawn_trap()
		bear_trap_spawner_2.spawn_trap()
		bear_trap_spawner_3.spawn_trap()
		bear_trap_spawner_4.spawn_trap()
	
>>>>>>> Stashed changes


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_fire_spread_timeout() -> void:
	SpawnFire()

func SpawnFire():
	var a = spawnable.size()
	var random = randi_range(0, a-1)
	while (spawnable[random][2] == 0):
		random = randi_range(0, a-1)
	spawnable[random][2] -= 1
	var pre = preload("res://fire.tscn")
	var obj = pre.instantiate()
	obj.name = "Fire"+str(fireNum)
	var m = randi_range(-1, 1)
	while m == 0:
		m = randi_range(-1, 1)
	var x = m * randi_range(40, 80)
	var n = randi_range(-1, 1)
	while n == 0:
		n = randi_range(-1, 1)
	var y = n * randi_range(40, 80)
	var posi = spawnable[random][1] + Vector2(x, y)
	print(posi)
	while Vector2(613, 353) >= posi && posi >= Vector2(553, 293):
		x = m * randi_range(40, 80)
		y = n * randi_range(40, 80)
		posi = spawnable[random][1] + Vector2(x, y)
	obj.position = posi
	$ForestFire.add_child(obj)
	obj.put_out.connect(_on_fire_put_out)
	spawnable.append(["Fire"+str(fireNum), posi, 4])
	fireNum += 1
	$ContinueSpread.start(randi_range(10, 20))
	
func _on_continue_spread_timeout() -> void:
	SpawnFire()
	

func _on_fire_put_out(name: Variant) -> void:
	for x in spawnable.size()-1:
		if spawnable[x][0] == name:
			spawnable.remove_at(x)
	if(spawnable.size() == 1):
		$ContinueSpread.stop()
		$FireSpread.start(randi_range(5, 10))
		spawnable = [["Campfire", Vector2(583, 323), 4]]
		fireNum = 1


func game_over():
	pass

func new_game():
	
	$Player.position = $StartPosition.position
	$StartTimer.start()
	$HUD.show_message("Save the campers!")
	$HUD.hide()
	get_tree().call_group("campers", "queue_free")
