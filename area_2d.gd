extends Area2D

@onready var camper_scene = preload("res://camper.tscn")

#beartrap's implementation

func _ready() -> void:
	body_entered.connect(_on_area_2d_body_entered)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Camper"):
		body.emit_signal("camper_destroyed")
		body.queue_free()
		$"../..".queue_free()
		
