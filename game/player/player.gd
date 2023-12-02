class_name Player
extends T5ToolsPlayer


@onready var _interaction_menu : InteractionMenu = %InteractionMenu


func show_interaction_menu(
	target : InteractableObject,
	offset : Vector3,
	title : String,
	items : Array[Dictionary]) -> void:

	_interaction_menu.show_menu(target, offset, title, items)
