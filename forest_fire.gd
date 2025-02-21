extends Node2D

var spawnable = [["Campfire", Vector2(583, 323), 4]]
var fireNum = 1

func _ready() -> void:
	$"../FireSpread".start(randi_range(2, 3))

func _process(delta: float) -> void:
	#if !$"../FireSpread".time_left == 0:
		#if $"../ForestFire".get_child_count() == 0:
			#$"../ContinueSpread".stop()
			#$"../FireSpread".start(randi_range(2, 3))
			#spawnable = [["Campfire", Vector2(583, 323), 4]]
			#fireNum = 1
	pass

func _on_fire_spread_timeout() -> void:
	print("Timer")
	SpawnFire()

func SpawnFire():
	var x = spawnable.size()
	var random = randi_range(0, x-1)
	while (spawnable[random][2] == 0):
		random = randi_range(0, x-1)
	spawnable[random][2] -= 1
	var pre = preload("res://fire.tscn")
	var obj = pre.instantiate()
	obj.name = "Fire"+str(fireNum)
	var posi = spawnable[random][1] + Vector2(randi_range(-80, 80), randi_range(-80, 80))
	obj.position = posi
	get_tree().current_scene.add_child(obj)
	spawnable.append(["Fire"+str(fireNum), posi, 4])
	fireNum += 1
	$"../ContinueSpread".start(randi_range(10, 20))

func _on_continue_spread_timeout() -> void:
	SpawnFire()
