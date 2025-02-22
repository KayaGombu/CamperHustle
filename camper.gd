extends CharacterBody2D


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
		following = true
func _on_player_drop_child():
	following = false
	inRange = false
	
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.name == player.name:
		inRange = true
func _on_cabin_body_entered(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount += 1 
		print("IN")

func _on_cabin_body_exited(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount -= 1
		print("OUT")
	
