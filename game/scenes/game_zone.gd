class_name GameZone
extends T5StateZone


# Zone event signal
signal zone_event(event : String)


## Total power draw
@export var power_draw : int = 0

## Total power generation
@export var power_generation : int = 0

# Does the zone have power
@export var has_power : bool = true


# Power polling delay
var _power_poll : float = 2.0


func _process(delta : float) -> void:
	_power_poll -= delta
	if _power_poll <= 0.0:
		_power_poll = 2.0
		_update_power()


func _update_power() -> void:
	# Check for power change
	var new_has_power := power_generation >= power_draw
	if new_has_power == has_power:
		return

	has_power = new_has_power
	zone_event.emit("power_changed")

	if has_power:
		$PowerUp.play()
	else:
		$PowerDown.play()
