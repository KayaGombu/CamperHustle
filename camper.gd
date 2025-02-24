extends Node2D
signal FS(name)
signal HS(name)
signal useless
signal give_player_phone

var campers = []
var alive = 7
var playcated = 0
@onready var phone = preload("res://phone.tscn").instantiate()
var playerHolding = false
signal holding
signal empty
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phone.name = "Phone"
	phone.position = Vector2(-100, -100)
	self.add_child(phone)
	get_child(0).has_phone.connect(_player_has_phone)
	SpawnCampers()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playcated == alive:
		print("Player saved " + str(playcated) + " campers")
		$"../FireSpread".stop()
		$"../Child Event".stop()
	elif alive == 0:
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
		obj.survive.connect(_on_camper_survival)
		obj.in_cabin.connect(_enter_cabin)
		obj.out_cabin.connect(_exit_cabin)
		obj.picked_up.connect(_on_picked_up)
		obj.dropped.connect(_on_dropped)
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
	FS.emit(campers[random][0])

func homesick():
	var a = campers.size()
	var random = randi_range(0, a-1)
	while (campers[random][2] == "Dead"):
		random = randi_range(0, a-1)
	var x
	var y
	if !campers[random][3]:
		x = randi_range(1070, 1120)
		y = randi_range(170, 430)
	else:
		x = randi_range(27, 491)
		y = randi_range(236, 630)
	get_child(0).position = Vector2(x, y)
	HS.emit(campers[random][0])

func _on_camper_death(name):
	for i in campers.size():
		if campers[i][0] == name:
			campers[i][2] = "Dead"
			alive -= 1
	useless.emit()
	get_child(0).position = Vector2(-100, -100)
	$"../Child Event".start(randi_range(10, 20))

func _on_camper_survival(name):
	useless.emit()
	get_child(0).position = Vector2(-100, -100)
	$"../Child Event".start(randi_range(10, 20))

func _enter_cabin(name):
	playcated += 1
	for i in campers.size():
		if campers[i][0] == name:
			campers[i][3] = true

func _exit_cabin(name):
	playcated -= 1
	for i in campers.size():
		if campers[i][0] == name:
			campers[i][3] = false

func _on_picked_up():
	if !playerHolding:
		playerHolding = true
		holding.emit()

func _on_dropped():
	playerHolding = false
	empty.emit()

func _player_has_phone():
	give_player_phone.emit()