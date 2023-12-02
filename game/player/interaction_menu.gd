class_name InteractionMenu
extends Node3D


var _interaction_menu_2d : BuildMenu2D


func _ready() -> void:
	# Get the viewport
	var viewport : T5ToolsViewport2Din3D = $Viewport2Din3D
	_interaction_menu_2d = viewport.get_scene_instance()
	_interaction_menu_2d.close.connect(_on_close)


func show_menu(
	target : InteractableObject,
	offset : Vector3,
	title : String,
	items : Array[Dictionary]) -> void:
	# Position the menu at the target
	global_position = target.global_position + offset

	# Show the menu
	visible = false
	_interaction_menu_2d.show_menu(target, title, items)
	visible = true


func _on_close() -> void:
	visible = false
