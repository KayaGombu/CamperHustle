extends Node2D
signal FS(name)
signal HS(name)

var campers = []
var alive = 7
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpawnCampers()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alive == 0:
		print("Game Over")

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
		obj.death.connect(_on_camper_death)
	$"../Child Event".start(randi_range(10, 20))

func _on_child_event_timeout() -> void:
	var event = randi_range(0, 1)
	if event == 0:
		sickness()
	elif event == 1:
		homesick()

func sickness():
	var a = campers.size()
	var random = randi_range(0, a-1)
	while (campers[random][2] == "Dead"):
		random = randi_range(0, a-1)
	campers[random][2] = "Sick"
	print(campers[random][0])
	FS.emit(campers[random][0])

func homesick():
	var a = campers.size()
	var random = randi_range(0, a-1)
	while (campers[random][2] == "Dead"):
		random = randi_range(0, a-1)
	campers[random][2] = "Sick"
	print(campers[random][0])
	HS.emit(campers[random][0])

func _on_camper_death(name):
	for i in campers.size():
		if campers[i][0] == name:
			campers[i][2] = "Dead"
			alive -= 1
	$"../Child Event".start(randi_range(10, 20))
