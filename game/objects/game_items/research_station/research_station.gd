extends GameItem


const SHIFT_DURATION : float = 60.0

@export var shift_progress : float = 0.0


func _process(delta : float) -> void:
	# Skip if no power
	if not _zone.has_power:
		return

	# Spawn cargo when full
	shift_progress += delta
	if shift_progress > SHIFT_DURATION:
		shift_progress = 0.0
		GameState.cash += 20
