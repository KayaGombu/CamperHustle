extends Node2D

var spawnable = [["Campfire", Vector2(583, 323), 4]]
var fireNum = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../FireSpread".start(randi_range(240, 360))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_fire_spread_timeout() -> void:
	SpawnFire()

func SpawnFire():
	var index = spawnable.size()
	var random_index = randi_range(0, index-1)
	while (spawnable[random_index][2] == 0):
		random_index = randi_range(0, index-1)
	spawnable[random_index][2] -= 1
	var pre = preload("res://fire.tscn")
	var obj = pre.instantiate()
	obj.name = "Fire"+str(fireNum)
	var neg = randi_range(-1, 1)
	while neg == 0:
		neg = randi_range(-1, 1)
	var x = neg * randi_range(40, 80)
	neg = randi_range(-1, 1)
	while neg == 0:
		neg = randi_range(-1, 1)
	var y = neg * randi_range(40, 80)
	var posi = spawnable[random_index][1] + Vector2(x, y)
	while Vector2(613, 353) >= posi && posi >= Vector2(553, 293):
		x = neg * randi_range(40, 80)
		y = neg * randi_range(40, 80)
		posi = spawnable[random_index][1] + Vector2(x, y)
	obj.position = posi
	self.add_child(obj)
	obj.putOut.connect(_on_fire_put_out)
	spawnable.append(["Fire"+str(fireNum), posi, 4])
	fireNum += 1
	$"../ContinueSpread".start(randi_range(10, 20))
	
func _on_continue_spread_timeout() -> void:
	SpawnFire()
	

func _on_fire_put_out(name: Variant) -> void:
	for x in spawnable.size():
		if spawnable[x][0] == name:
			spawnable.remove_at(x)
	if(spawnable.size() == 1):
		$"../ContinueSpread".stop
		$"../FireSpread".start(randi_range(240, 360))
		spawnable = [["Campfire", Vector2(583, 323), 4]]
		fireNum = 1
