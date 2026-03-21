extends CharacterBody2D
@export var SPEED = 5000
@export var GRAVITY = 6000
var vertical_speed = 50
var gravity_direction = Vector2(0,-1)
var falling = true
var state = "patrolling"
var target = null
#patrolling for moving from one point to another
#pursuit for pursuing player
#waiting when waiting
var facing = 1

func stop_falling():
	falling = false
	vertical_speed = 0
	
func start_falling():
	falling = true
	
func _process(delta: float) -> void:
	if falling:
		vertical_speed -= GRAVITY
	if vertical_speed != 0:
		velocity = gravity_direction*vertical_speed*delta
	move_and_slide()
	if (state == "pursuit") and (target != null):
		var direction = Vector2((-global_position.x + target.global_position.x), 0)
		if ((-global_position.x + target.global_position.x)*facing) < 0:
			scale.x = -1
			facing = -facing
		else:
			scale.x = 1
		direction = direction.normalized()
		velocity = direction*SPEED*delta
		move_and_slide()

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("close_proximity"):
		body.close_proximity()
		target = body
		if (body.detection_state == "close proximity") or (body.detection_state == "detected"):
			state = "pursuit"
			print("attack")
			


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("unseen_from_proximity"):
		body.unseen_from_proximity()

func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("detected"):
		body.detected()
		target = body
		if (body.detection_state == "close proximity") or (body.detection_state == "detected"):
			state = "pursuit"
			print("target found")
			


func _on_detection_body_exited(body: Node2D) -> void:
	if body.has_method("unseen_from_detected"):
		body.unseen_from_detected()
		
		if body.detection_state != "close proximity":
			print("stop pursuit")
			target = null
			state = "waiting"
			$Interest.start(5)


func _on_interest_timeout() -> void:
	state = "patrolling"
