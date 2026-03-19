extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("reset_jump"):
		body.reset_jump()
		body.stop_falling()


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("start_falling"):
		body.start_falling()
