extends Node2D

var spawnable = [["Campfire", Vector2(583, 323), 4]]
var fireNum = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../FireSpread".start(randi_range(20, 35))

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
	var posi = setPosition(random_index)
	obj.position = posi
	self.add_child(obj)
	obj.put_out.connect(_on_fire_put_out)
	spawnable.append(["Fire"+str(fireNum), posi, 4])
	fireNum += 1
	$"../ContinueSpread".start(randi_range(5, 10))

func setPosition(index):
	var neg = randi_range(-1, 1)
	while neg == 0:
		neg = randi_range(-1, 1)
	var x = neg * randi_range(40, 80)
	neg = randi_range(-1, 1)
	while neg == 0:
		neg = randi_range(-1, 1)
	var y = neg * randi_range(40, 80)
	var coords = spawnable[index][1] + Vector2(x, y)
	while true:
		if Vector2(613, 353) >= coords && coords >= Vector2(553, 293):
			x = neg * randi_range(40, 80)
			y = neg * randi_range(40, 80)
			coords = spawnable[index][1] + Vector2(x, y)
		elif Vector2(780, 115) <= coords && coords <= Vector2(334, 0):
			x = neg * randi_range(40, 80)
			y = neg * randi_range(40, 80)
			coords = spawnable[index][1] + Vector2(x, y)
		elif Vector2(1130, 610) <= coords && coords <= Vector2(20, 20):
			x = neg * randi_range(40, 80)
			y = neg * randi_range(40, 80)
			coords = spawnable[index][1] + Vector2(x, y)
		else:
			return coords

func _on_continue_spread_timeout() -> void:
	SpawnFire()

func _on_fire_put_out(name: Variant) -> void:
	for x in range(0, spawnable.size()):
		if spawnable[x][0] == name:
			spawnable.remove_at(x)
	if(spawnable.size() == 1):
		$"../ContinueSpread".stop()
		$"../FireSpread".start(randi_range(30, 45))
		spawnable = [["Campfire", Vector2(583, 323), 4]]
		fireNum = 1
