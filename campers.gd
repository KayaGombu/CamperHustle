extends Node2D
signal SC(name)

var campers = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpawnCampers()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SpawnCampers():
	for i in 7:
		var pre = preload("res://camper.tscn")
		var obj = pre.instantiate()
		obj.name = "Camper"+str(i+1)
		var x = randi_range(0, 530)
		var y = randi_range(0, 648)
		while Vector2(530, 115) >= Vector2(x, y) && Vector2(x, y) >= Vector2(333, 0):
			x = randi_range(0, 530)
			y = randi_range(0, 648)
		obj.position = Vector2(x, y)
		self.add_child(obj)
		campers.append([obj.name, obj.position, "Alive", false])
		#Name, Position, Status, Playcated
	$"../Child Event".start(randi_range(1, 2))

func _on_child_event_timeout() -> void:
	sickness()

func sickness():
	var a = campers.size()
	var random = randi_range(0, a-1)
	while (campers[random][2] == "Dead"):
		random = randi_range(0, a-1)
	campers[random][2] = "Sick"
	SC.emit(campers[random][0])
