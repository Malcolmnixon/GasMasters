class_name T5ToolsVisiblePause
extends Node


## Target node (null for parent)
@export var target : Node3D


## Target Node3D
var _target : Node3D


func _ready() -> void:
	# Get the target node
	_target = target if target else get_parent()
	if not _target:
		push_warning("VisiblePause %s could not get target" % self)
		return

	# Connect to visibility changed signals
	_target.visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
	get_tree().paused = _target.is_visible_in_tree()
