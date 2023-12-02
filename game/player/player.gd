class_name Player
extends T5ToolsPlayer


@onready var _container : InteractionUIContainer = %InteractionUIContainer


func show_interaction_ui(
	target : InteractableObject,
	offset : Vector3,
	ui : PackedScene) -> void:

	_container.show_ui(target, offset, ui)
