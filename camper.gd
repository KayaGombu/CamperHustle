extends CharacterBody2D


@export var speed = 180
var camperCount = 0
@onready var player = $"../Player"
var following = false
	
func _physics_process(delta: float) -> void:
	if following:
		var direction = Input.get_vector("Left","Right","Up","Down")
		velocity = direction * speed
		move_and_slide()
	
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.name == player.name:
		following = true
	
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
