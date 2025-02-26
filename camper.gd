extends CharacterBody2D
signal death(name)
signal survive(name)
signal in_cabin(name)
signal out_cabin(name)
signal picked_up
signal dropped

@export var camperSpeed: float = 30
@export var change_interval: float = 4 
@export var change_strength: float = 0.1
@export var speed = 200
var direction: Vector2 = Vector2.ZERO
var camperCount = 0
@export var timeTilDeath = 10
var inRange = false
var following = false
var status = "Good"
var playcated = false



func _ready() -> void:
	print("Hello")
	var player = get_node("/root/Main/Player")
	var heal = get_node("/root/Main/Infirmary")
	var playcate = get_node("/root/Main/Cabin")
	var parent = get_node("/root/Main/Campers")
	player.pick_up_child.connect(_on_player_pick_up_child)
	player.drop_child.connect(_on_player_drop_child)
	player.give_phone.connect(_give_camper_phone)
	heal.body_entered.connect(_on_camper_entered)
	playcate.body_entered.connect(_on_cabin_body_entered)
	playcate.body_exited.connect(_on_cabin_body_exited)
	parent.FS.connect(_get_sick)
	parent.HS.connect(_get_homesick)
	set_random_direction()
	
	
	#handle camper entering traps
	add_to_group("Camper")
	var change_timer = Timer.new()
	change_timer.wait_time = change_interval 
	change_timer.one_shot = false
	change_timer.timeout.connect(set_random_direction)
	add_child(change_timer)
	change_timer.start()

func set_random_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	

func movement(movement):
	if movement.x < 0:
		$AnimatedSprite2D.flip_h = true
		sideAnimation()
	elif movement.x > 0:
		$AnimatedSprite2D.flip_h = false
		sideAnimation()
	if movement.y < 0:
		upAnimation()
	elif movement.y > 0:
		downAnimation()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Timer.position = $TimerPlacement.position
	if following:
		var facing = Input.get_vector("Left","Right","Up","Down")
		velocity = facing * speed
		move_and_slide()
		movement(velocity.normalized())
	elif !playcated && status != "Homesick":
		velocity = direction * camperSpeed
		move_and_slide()
		movement(direction)
	else:
		$AnimatedSprite2D.animation = "Idle Down"
		if status == "Sick":
			$AnimatedSprite2D.animation = "Sick - Down Idle"
	if($AnimatedSprite2D.animation_finished):
			$AnimatedSprite2D.play()
	if(status == "Good"):
		$Timer.visible = false
	elif(status == "Sick"):
		$Timer.text = str(round($TilDeath.time_left))
	elif(status == "Homesick"):
		movement(Vector2.ZERO)
		$AnimatedSprite2D.animation = "Crying"
		$Timer.text = str(round($TilDeath.time_left))
	if $TilDeath.time_left == 0 && (status == "Sick" || status == "Homesick"):
		death.emit(self.name)
		queue_free()

func _on_cabin_body_entered(body: Node2D) -> void:
	if body.name == self.name:
		playcated = true
		in_cabin.emit(self.name)

func _on_cabin_body_exited(body: Node2D) -> void:
	if body.name == self.name:
		playcated = false
		out_cabin.emit(self.name)

func _get_sick(name):
	if self.name == name:
		status = "Sick"
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _get_homesick(name):
	if self.name == name:
		status = "Homesick"
		if following:
			following = false
			dropped.emit()
		$Timer.visible = true
		$TilDeath.start(timeTilDeath)

func _on_player_pick_up_child():
	if inRange && status != "Homesick":
		following = true
		picked_up.emit()

func _on_player_drop_child():
	following = false
	inRange = false
	dropped.emit()

#Checks whether the player is in range
func _on_pick_up_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = true

#Checks when the player leaves range
func _on_pick_up_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		inRange = false

func _on_camper_entered(body: Node2D):
	if body.name == self.name && status == "Sick":
		status = "Good"
		$TilDeath.stop()
		survive.emit(self.name)

func _give_camper_phone():
	if status == "Homesick" && inRange:
		status = "Good"
		$TilDeath.stop()
		survive.emit(self.name)

func downAnimation():
	if status == "Sick":
		$AnimatedSprite2D.animation = "Sick - Down Walk"
	else:
		$AnimatedSprite2D.animation = "Down Walk"

func upAnimation():
	if status == "Sick":
		$AnimatedSprite2D.animation = "Sick - Up Walk"
	else:
		$AnimatedSprite2D.animation = "Up Walk"

func sideAnimation():
	if status == "Sick":
		$AnimatedSprite2D.animation = "Sick - Side Walk"
	else:
		$AnimatedSprite2D.animation = "Side Walk"

func beartrapKill():
	death.emit(self.name, "beartrap")
	queue_free()

func camper():
	pass
