extends Node

@export var baby_scene: PackedScene = preload("res://baby.tscn")  # Load baby scene
@onready var spawn_area: Node2D = $"../spawn_area"
