class_name InteractionUIContainer
extends Node3D


## Pixel scale
@export var pixels_per_meter := 2000.0


# Viewport
@onready var _viewport : T5ToolsViewport2Din3D = $Viewport2Din3D


func show_ui(
	target : InteractableObject,
	offset : Vector3,
	ui : PackedScene) -> void:
	# Position the menu at the target
	global_position = target.global_position + offset

	# Switch scenes
	visible = false
	_viewport.scene = ui

	# Update the viewport
	var control := _viewport.get_scene_instance() as InteractionUI
	if not control:
		return

	# Configure the UI
	control.container = self
	control.interactable = target
	_viewport.viewport_size = control.size
	_viewport.screen_size = control.size / pixels_per_meter

	# Show the viewport
	visible = true
