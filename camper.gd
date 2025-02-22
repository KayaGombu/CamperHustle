extends CharacterBody2D

var camperCount = 0

var status = "Good"

func _ready() -> void:
	$AnimatedSprite2D.play()
	var timer = get_parent()
	timer.SC.connect(_get_sick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(status == "Good"):
		$AnimatedSprite2D.animation = "Down Walk"
	if(status == "Sick"):
		$AnimatedSprite2D.animation = "Sick - Down Walk"

func _on_cabin_body_entered(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount += 1 
		print("IN")

func _on_cabin_body_exited(body: Node2D) -> void:
	if body.has_method("camper"):
		camperCount -= 1
		print("OUT")

func _get_sick(name):
	if self.name == name:
		status = "Sick"

func camper():
	pass
