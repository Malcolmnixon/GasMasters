extends InspectionUI


var _update_delay : float = 1.0


func _ready() -> void:
	visibility_changed.connect(_update_status)
	_update_status()


func _process(delta : float) -> void:
	_update_delay -= delta
	if _update_delay < 0.0:
		_update_delay = 1.0
		_update_status()


func _update_status() -> void:
	var zone := T5ToolsScene.get_current() as GameZone

	%Cash.text = "₡%d" % GameState.cash
	%PowerGeneration.text = "%d kWh" % zone.power_generation
	%PowerUsage.text = "%d kWh" % zone.power_draw


func _on_status_button_pressed():
	# Switch to the Status Tab
	%TabContainer.current_tab = 0


func _on_help_button_pressed():
	# Switch to the Help Tab
	%TabContainer.current_tab = 1


func _on_close_button_pressed():
	# Hide the container
	container.visible = false
