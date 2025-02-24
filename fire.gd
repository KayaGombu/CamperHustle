extends Node2D
signal putOut(name)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Fire.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "Fire"


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		putOut.emit(self.name)
		queue_free()
