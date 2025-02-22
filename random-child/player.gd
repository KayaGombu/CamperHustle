extends CharacterBody2D

@export var speed = 500



@onready var player = $"."
var is_carrying = false
@onready var baby = $"../Baby"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	

	#pick up on input call F
	if Input.is_action_just_pressed("pick_up"):
		if not is_carrying:
			if baby.body_entered:
				pick_up_baby()
		else:
			drop_baby()
	

func _physics_process(delta):
	move_and_slide()
	
func pick_up_baby():
	baby.get_parent().remove_child(baby)
	add_child(baby)
	baby.position = Vector2(0, 32)
	baby.set_collision_layer(0)
	baby.set_collision_mask(0)
	is_carrying = true
	
func drop_baby():
	if baby:
		remove_child(baby)
		get_parent().add_child(baby)
		baby.position = Vector2(player.position)
		baby.set_collision_layer(1)
		baby.set_collision_mask(1)
		is_carrying = false
		
