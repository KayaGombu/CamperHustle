extends CanvasLayer

@onready var colorRect = $"../ColorRect"
@onready var cabin: Area2D = $"../Cabin"


signal start_game
signal end_game
signal win_game
signal remove_beartraps

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ReturnButton.hide()
	$Message.text = "Press Start to Begin"
	$Message.show()
	$StartButton.show()
	$WinMessage.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_win_message(text):
	$WinMessage.text = text
	$WinMessage.show()
	
	
func show_game_over():
	$"../CanvasLayer/HealthBar".hide()
	$"./Message".hide()
	show_message("Game Over:(")
	await $MessageTimer.timeout
	
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func _on_start_button_pressed() -> void:
		$StartButton.hide()
		colorRect.hide()
		$Message.hide()
		$WinMessage.hide()
		
		start_game.emit()


func _on_end_game() -> void:
	show_game_over()
	$Score.hide()
	await get_tree().create_timer(2.0).timeout
	var tree = get_tree()
	if tree:
		tree.change_scene_to_file("res://main.tscn")


func _on_win_game() -> void:
	print("win game emitted")
	show_message_on_win()
	$StartButton.hide()
	colorRect.show()
	$Score.hide()
	$"../CampFire".hide()
	$"../Player".hide()
	$"../Music".stop()
	$"../Forest".stop()
	$"../Campers".queue_free()
	$"../ForestFire".queue_free()
	$"../CanvasLayer/HealthBar".hide()
	remove_beartraps.emit()
	$"../ContinueSpread".stop()
	$"../FireSpread".stop()
	$"../Child Event".stop()
	await get_tree().create_timer(5).timeout
	get_tree().reload_current_scene()
	
func show_message_on_win():
	show_message("You saved: " + str(cabin.camperCount) + " camper")
	
	
	#how many saved show message
	if cabin.camperCount == 7:
		show_win_message("Excelent job! All kids are safe.")
	elif cabin.camperCount == 1:
		show_win_message("You did everything you could :(")
	else:
		show_win_message("Nice Job!")	
