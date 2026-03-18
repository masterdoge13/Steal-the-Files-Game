extends Area2D

var player_in_range = false
var player_inside = false
var player
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("partial_hide"):
		player_in_range = true
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("partial_hide"):
		player_in_range = false

func _input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		if player_inside:
			player_inside = false
			player.unseen()
			player.exit()
			print("exit command sent")
		else:
			player.partial_hide(global_position)
			player_inside = true
			print("hide command sent")
			
