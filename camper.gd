extends CharacterBody2D

var camperCount = 0

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
