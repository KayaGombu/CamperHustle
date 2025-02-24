extends CharacterBody2D
signal death(name)
signal survive(name)
signal in_cabin(name)
signal out_cabin(name)
signal picked_up
signal dropped

<<<<<<< HEAD

@export var speed = 200

@onready var player = $"../Player"
var inRange = false
var following = false
var camperCount = 0
	
func _ready() -> void:
	player.pick_up_child.connect(_on_player_pick_up_child)
	player.drop_child.connect(_on_player_drop_child)
	
func _physics_process(delta: float) -> void:
	if following:
		var direction = Input.get_vector("Left","Right","Up","Down")
		velocity = direction * speed
		move_and_slide()

func _on_player_pick_up_child():
	if inRange:
		print("pick up")
		following = true
func _on_player_drop_child():
	print("drop")
	following = false
	inRange = false
	
#Checks whether the player is in range
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print("in range")
		inRange = true
=======
@export var speed = 200
var camperCount = 0
@export var timeTilDeath = 10
var inRange = false
var following = false
var status = "Good"

func _ready() -> void:
	var player = get_node("/root/Main/Player")
	var heal = get_node("/root/Main/Infirmary")
	var playcate = get_node("/root/Main/Cabin")
	var parent = get_node("/root/Main/Campers")
	player.pick_up_child.connect(_on_player_pick_up_child)
	player.drop_child.connect(_on_player_drop_child)
	player.give_phone.connect(_give_camper_phone)
	heal.body_entered.connect(_on_camper_entered)
	playcate.body_entered.connect(_on_cabin_body_entered)
	playcate.body_exited.connect(_on_cabin_body_exited)
	parent.FS.connect(_get_sick)
	parent.HS.connect(_get_homesick)
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Timer.position = $TimerPlacement.position
	if following:
		var direction = Input.get_vector("Left","Right","Up","Down")
		velocity = direction * speed
		move_and_slide()
	if(status == "Good"):
		$Timer.visible = false
		$AnimatedSprite2D.animation = "Down Walk"
	elif(status == "Sick"):
		$AnimatedSprite2D.animation = "Sick - Down Walk"
		$Timer.text = str(round($TilDeath.time_left))
	elif(status == "Homesick"):
		$AnimatedSprite2D.animation = "Crying"
		$Timer.text = str(round($TilDeath.time_left))
	if $TilDeath.time_left == 0 && (status == "Sick" || status == "Homesick"):
		death.emit(self.name)
		queue_free()
>>>>>>> Lucas'-Branch

#Checks when the player leaves range
func _on_pick_up_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		print("leaving")
		inRange = false
func _on_cabin_body_entered(body: Node2D) -> void:
	if body.name == self.name:
		in_cabin.emit(self.name)

func _on_cabin_body_exited(body: Node2D) -> void:
	if body.name == self.name:
		out_cabin.emit(self.name)

func _get_sick(name):
	if self.name == name:
		status = "Sick"
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _get_homesick(name):
	if self.name == name:
		status = "Homesick"
		if following:
			following = false
			dropped.emit()
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _on_player_pick_up_child():
	if inRange && status != "Homesick":
		following = true
		picked_up.emit()

func _on_player_drop_child():
	following = false
	inRange = false
	dropped.emit()

#Checks whether the player is in range
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = true

#Checks when the player leaves range
func _on_pick_up_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = false

func _on_camper_entered(body: Node2D):
	if body.has_method("camper") && status == "Sick":
		following = false
		status = "Good"
		$TilDeath.stop()
		survive.emit(self.name)

func _give_camper_phone():
	if status == "Homesick" && inRange:
		status = "Good"
		$TilDeath.stop()
		survive.emit(self.name)

func camper():
	pass
