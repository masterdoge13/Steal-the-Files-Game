extends CharacterBody2D
@export var SPEED = 50000
@export var GRAVITY = 6000
var vertical_speed = 50
var gravity_direction = Vector2(0,-1)
var can_jump = true
var falling = true
var player_state = "movable"
var detection_state = "unseen" 
#unseen for not detected but detectable
#hidden for not able to be detected
#detected for when guards are alerted
#close proximity for when guards are alerted at a very close proximity
var detected_count = 0
var close_proximity_count = 0

func _process(delta: float) -> void:
	if player_state == "movable":
		var direction = Input.get_vector("left", "right", "null", "null")
		velocity = direction*SPEED*delta
		move_and_slide()
		if falling:
			vertical_speed -= GRAVITY
		if can_jump:
			if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("jump alt"):
				vertical_speed = 100000
				can_jump = false
				falling = true
		if vertical_speed != 0:
			velocity = gravity_direction*vertical_speed*delta
		move_and_slide()
	print(detection_state)
	
func reset_jump():
	can_jump = true
	print("jump reset")

func stop_falling():
	falling = false
	print("falling stop")
	
func start_falling():
	falling = true
	print("falling start")

func partial_hide(hidden_pos: Vector2):
	position = hidden_pos
	player_state = "unmovable"
	if detection_state == "unseen":
		detection_state = "hidden"
	print(player_state)
	print(detection_state)
	
	
func full_hide(hidden_pos: Vector2):
	position = hidden_pos
	player_state = "unmovable"
	print(detection_state)
	if detection_state != "close proximity":
		print("not close")
		detection_state = "hidden"
	print(player_state)
	print(detection_state)
	set_collision_layer_value(2, false)
	set_collision_mask_value(2, false)
		
func detected():
	if detection_state != "hidden":
		detected_count += 1
		if (detected_count >= 1) and (close_proximity_count <= 0):
			detection_state = "detected"

		
func close_proximity():
	if detection_state != "hidden":
		close_proximity_count += 1
		if detected_count >= 1:
			detection_state = "close proximity"
		
func unseen():
	if detection_state == "hidden":
		detection_state = "unseen"
	print(player_state)
	print(detection_state)

func unseen_from_proximity():
	close_proximity_count -= 1
	if close_proximity_count <= 0:
		if (detected_count <= 0):
			detection_state = "unseen"
		else:
			detection_state = "detected"
	
func unseen_from_detected():
	detected_count -= 1
	if detected_count <= 0:
		if (close_proximity_count <= 0):
			detection_state = "unseen"
		else:
			detection_state = "close proximity"
		
		
	

func exit():
	player_state = "movable"
	print(player_state)
	print(detection_state)
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	
