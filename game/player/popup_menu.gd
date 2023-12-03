extends Node3D


func _ready() -> void:
	$Viewport2Din3D.connect_scene_signal("close", _on_close)


func _on_close() -> void:
	visible = false
