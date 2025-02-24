extends CharacterBody2D


#@export var speed = 200

@onready var player = $"../Player"
var inRange = false
var following = false
var camperCount = 0


#camper movement
@export var camperSpeed: float = 30
@export var change_interval: float = 4 
@export var change_strength: float = 0.1

var direction: Vector2 = Vector2.ZERO


	
func _ready() -> void:
	player.pick_up_child.connect(_on_player_pick_up_child)
	player.drop_child.connect(_on_player_drop_child)
	
	
	#camper movement
	set_random_direction()
	
	var change_timer = Timer.new()
	change_timer.wait_time = change_interval 
	change_timer.one_shot = false
	change_timer.timeout.connect(set_random_direction)
	add_child(change_timer)
	change_timer.start()
	
func set_random_direction():

	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	
func _physics_process(delta: float) -> void:
	#if following:
		#var direction = Input.get_vector("Left","Right","Up","Down")
		velocity = direction * camperSpeed
		move_and_slide()

func _on_player_pick_up_child():
	if inRange:
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
func _on_cabin_body_entered(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount += 1 
		print("IN")

func _on_cabin_body_exited(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount -= 1
		print("OUT")

func camper():
	pass
