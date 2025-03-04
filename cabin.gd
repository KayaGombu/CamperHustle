extends Area2D

var camperCount = 0
@onready var campers: Node2D = $"../Campers"
@onready var hud: CanvasLayer = $"../HUD"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(campers):
		if camperCount == campers.alive:
			print("finished game")
			$"../HUD".win_game.emit()
			camperCount = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Camper"):
		camperCount += 1
		print("Camper entered. Total: ", camperCount)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Camper"):
		camperCount -= 1
		
		print("Camper exited: ", camperCount)
