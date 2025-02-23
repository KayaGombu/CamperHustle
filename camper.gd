extends CharacterBody2D
signal death(name)

@export var speed = 200
var camperCount = 0
@export var timeTilDeath = 10
@onready var player = preload("../player.tscn").instantiate()
#@onready var parent = $"../Campers"
var inRange = false
var following = false
var status = "Good"

func _ready() -> void:
	player.pick_up_child.connect(_on_player_pick_up_child)
	player.drop_child.connect(_on_player_drop_child)
	$AnimatedSprite2D.play()
	var parent = get_parent()
	parent.FS.connect(_get_sick)
	parent.HS.connect(_get_homesick)
	print(get_signal_connection_list("pick_up_child"))

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

func _on_cabin_body_entered(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount += 1 
		print("IN")

func _on_cabin_body_exited(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount -= 1
		print("OUT")

func _get_sick(name):
	if self.name == name:
		status = "Sick"
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _get_homesick(name):
	if self.name == name:
		status = "Homesick"
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _on_player_pick_up_child():
	if inRange && status != "Homesick":
		following = true

func _on_player_drop_child():
	following = false
	inRange = false

#Checks whether the player is in range
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = true

#Checks when the player leaves range
func _on_pick_up_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = false

func camper():
	pass
