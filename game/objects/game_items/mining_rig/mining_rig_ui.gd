extends InspectionUI


var _update_delay : float = 1.0


func _ready() -> void:
	visibility_changed.connect(_update_gas_level)


func _process(delta : float) -> void:
	_update_delay -= delta
	if _update_delay < 0.0:
		_update_delay = 1.0
		_update_gas_level()


func _update_gas_level() -> void:
	if is_instance_valid(item):
		%GasLevel.value = item.gas_gathered


func _on_destroy_pressed():
	# Show the confirmation
	%TabContainer.current_tab = 1


func _on_yes_pressed():
	# Discard the mining rig
	item.interaction("destroy")

	# Hide the UI
	container.visible = false


func _on_no_pressed():
	# Just hide the UI
	container.visible = false


func _on_close_pressed():
	# Just hide the UI
	container.visible = false
