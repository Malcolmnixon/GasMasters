class_name PowerDraw
extends Node


## Amount of power used
@export var power_used : int


# Game zone
var _zone : GameZone


func _ready():
	# Subscribe to game zone events
	_zone = T5ToolsScene.get_current() as GameZone
	if _zone:
		_zone.power_draw += power_used


func _exit_tree():
	if _zone:
		_zone.power_draw -= power_used
