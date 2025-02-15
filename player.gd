extends CharacterBody2D

@export var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x = 1
		velocity.y = 0
	if Input.is_action_pressed("left"):
		velocity.x = -1
		velocity.y = 0
	if Input.is_action_pressed("down"):
		velocity.y = 1
		velocity.x = 0
	if Input.is_action_pressed("up"):
		velocity.y = -1
		velocity.x = 0

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, get_viewport_rect().size)


func _physics_process(delta):
	move_and_slide()
