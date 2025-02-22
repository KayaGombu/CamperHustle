extends CharacterBody2D
signal death(name)

var camperCount = 0
@export var timeTilDeath = 10

var status = "Good"

func _ready() -> void:
	$AnimatedSprite2D.play()
	var parent = get_parent()
	parent.FS.connect(_get_sick)
	parent.HS.connect(_get_homesick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Timer.position = $TimerPlacement.position
	if(status == "Good"):
		$Timer.visible = false
		$AnimatedSprite2D.animation = "Down Walk"
	elif(status == "Sick"):
		$AnimatedSprite2D.animation = "Sick - Down Walk"
		$Timer.text = str(round($TilDeath.time_left))
	elif(status == "Homesick"):
		$AnimatedSprite2D.animation = "Crying"
		$Timer.text = str(round($TilDeath.time_left))
	if $TilDeath.time_left == 0 && (status == "Sick" || status == "Homesick"):
		death.emit(self.name)
		queue_free()

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
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _get_homesick(name):
	if self.name == name:
		status = "Homesick"
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func camper():
	pass
