extends CharacterBody2D

@export var speed = 200
var screen_size
var direction
var holding = false
var sprintCount = 20
signal pick_up_child
signal drop_child
signal step

func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	var collision = move_and_collide(velocity * delta)
	if !collision:
		if Input.is_action_pressed("Right"):
			velocity.x += 1
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
		if Input.is_action_pressed("Down"):
			velocity.y += 1
		if Input.is_action_pressed("Up"):
			velocity.y -= 1

	if velocity.length() != 0:
		if !$Footsteps.playing:
			$Footsteps.play()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Side Walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		if velocity.x < 0:
			direction = "Left"
		else:
			direction = "Right"
	elif velocity.y != 0:
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "Up Walk"
			direction = "Up"
		else:
			$AnimatedSprite2D.animation = "Down Walk"
			direction = "Down"
	if velocity.x == 0 && velocity.y == 0:
		idle()
		
	if Input.is_action_just_pressed("pick_up"):
		if not holding:
			holding = true
			pick_up_child.emit()
		else:
			holding = false
			drop_child.emit()
func idle():
	$Footsteps.stop()
	if direction == "Up":
		$AnimatedSprite2D.animation = "Up Idle"
	elif direction == "Down":
		$AnimatedSprite2D.animation = "Down Idle"
	elif direction == "Left":
		$AnimatedSprite2D.animation = "Side Idle"
		$AnimatedSprite2D.flip_h = true
	elif direction == "Right":
		$AnimatedSprite2D.animation = "Side Idle"			

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("fire"):
		print("Fire")
		step.emit()
func player():
	pass
