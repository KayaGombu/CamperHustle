extends Node2D
signal putOut
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Fire.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "Fire"


func _on_player_step() -> void:
	print("Step")
	putOut.emit()

func fire():
	pass
