extends CharacterBody2D
@export var SPEED = 50000
@export var GRAVITY = 6000
var vertical_speed =50
var gravity_direction = Vector2(0,-1)
var can_jump = true
var player_state = "movable"
var detection_state = "detectable"

func _process(delta: float) -> void:
	if player_state == "movable":
		var direction = Input.get_vector("left", "right", "null", "null")
		velocity = direction*SPEED*delta
		move_and_slide()
		vertical_speed -= GRAVITY
		if can_jump:
			if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jump alt"):
				vertical_speed = 100000
				can_jump = false
		if vertical_speed != 0:
			velocity = gravity_direction*vertical_speed*delta
		move_and_slide()
	
func reset_jump():
	can_jump = true
	print("jump reset")
