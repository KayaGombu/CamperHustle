extends Node

var spawnable = [["Campfire", Vector2(583, 323), 4]]
var fireNum = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FireSpread.start(randi_range(2, 3))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fire_spread_timeout() -> void:
	SpawnFire()
	

func SpawnFire():
	var x = spawnable.size()
	var random = randi_range(0, x-1)
	while (spawnable[random][2] == 0):
		random = randi_range(0, x-1)
	spawnable[random][2] -= 1
	var pre = preload("res://fire.tscn")
	var obj = pre.instantiate()
	var posi = spawnable[random][1] + Vector2(randi_range(-80, 80), randi_range(-80, 80))
	obj.position = posi
	get_tree().current_scene.add_child(obj)
	spawnable.append(["Fire"+str(fireNum), posi, 4])
	fireNum += 1
	$FireSpread.start(randi_range(10, 20))


func _on_fire_put_out(sender) -> void:
	print("Sender = "+ sender)
