class_name Player
extends T5ToolsPlayer


@onready var _container : InspectionUIContainer = %InspectionUIContainer


func show_inspection_ui(
	target : Node3D,
	offset : Vector3,
	ui : PackedScene) -> void:

	_container.show_ui(target, offset, ui)
