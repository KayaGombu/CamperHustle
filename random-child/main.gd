extends Node

@onready var spawn_area: Area2D = $SpawnArea
@onready var spawn_area_2: Area2D = $SpawnArea2
@onready var spawn_area_3: Area2D = $SpawnArea3



func _ready():
	if spawn_area == null:
		print("spawnArea node not found")
		return

	for _i in range(1):  #spawn number of babies
		spawn_area.spawn_baby()
		spawn_area_2.spawn_baby()
		spawn_area_3.spawn_baby()
