class_name PowerGenerator
extends Node


## Amount of power generated
@export var power_generation : int


# Game zone
var _zone : GameZone


func _ready():
	# Subscribe to game zone events
	_zone = T5ToolsScene.get_current() as GameZone
	if _zone:
		_zone.power_generation += power_generation


func _exit_tree():
	if _zone:
		_zone.power_generation -= power_generation
