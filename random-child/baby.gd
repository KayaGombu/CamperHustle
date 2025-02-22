extends CharacterBody2D

@onready var player = $"../Player"
var player_entered = false

func _process(delta: float):
	position.x += 0.8

func _on_body_entered(body: Node2D):
	if player.name == body.name:
		player_entered = true
		print("Player entered")
		
	




func _on_body_exited(body: Node2D) -> void:
	if player.name == body.name:
		player_entered = false
		print("Player exited")
