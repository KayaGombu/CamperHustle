extends Node2D
signal put_out(name)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Fire.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "Fire"


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		put_out.emit(self.name)
		queue_free()
	elif body.has_method("camper"):
		body.death.emit(body.name)
		body.queue_free()
