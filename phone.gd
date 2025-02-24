extends Node2D
signal has_phone
signal dropped_phone

var inRange = false
var following = false
@onready var posi = get_node("/root/Main/Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	posi.pick_up_phone.connect(_on_player_pick_up_phone)
	get_node("/root/Main/Campers").useless.connect(_on_camper_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if following:
		self.position = posi.position - Vector2(-5, 5)

func _on_player_pick_up_phone():
	if inRange:
		following = true
		has_phone.emit()

#Checks whether the player is in range
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = true

#Checks when the player leaves range
func _on_pick_up_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = false

func _on_camper_death():
	following = false
	dropped_phone.emit()
