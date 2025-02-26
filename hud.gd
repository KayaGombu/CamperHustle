extends CanvasLayer

signal start_game
@onready var colorRect = $"../ColorRect"

signal end_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Message.text = "Press Start to Begin"
	$Message.show()
	$StartButton.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over:(")
	await $MessageTimer.timeout
	
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func _on_start_button_pressed() -> void:
		$StartButton.hide()
		colorRect.hide()
		$Message.hide()
		start_game.emit()


func _on_end_game() -> void:
	show_game_over()
	
	await get_tree().create_timer(2.0).timeout
	var tree = get_tree()
	if tree:
		tree.change_scene_to_file("res://main.tscn") 
	
	
