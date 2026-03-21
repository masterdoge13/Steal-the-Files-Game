extends Area2D

var interactable = false
var player

var ui = load("res://assets/userinterface/ShopUI.tscn")
var ui_instance

func _ready() -> void:
	ui_instance = get_tree().root.find_child("ShopUi", true, false)
	ui_instance.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("reset_jump"):
		interactable = true
		player = body
		print("shop entered")

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("reset_jump"):
		interactable = false
		ui_instance.visible = false
		print("shop exited")

func _input(event: InputEvent) -> void:
	if interactable and event.is_action_pressed("interact"):
		ui_instance.visible = !ui_instance.visible
		print("shop command sent: " + str(ui_instance.visible))
