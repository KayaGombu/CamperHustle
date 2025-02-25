extends Node2D

func _ready() -> void:
	pass

func _on_area_2d_close() -> void:
	$AnimatedSprite2D.animation = "closed"
	$Activate.play()


func _on_area_2d_delete() -> void:
	self.queue_free()
