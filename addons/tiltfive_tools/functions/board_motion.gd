extends Node


## Orientation of the controller
enum ControlOrientation {
	VERTICAL,		## Vertical - wand pointing forwards
	HORIZONTAL		## Horizontal - wand pointnig to the left
}

## Control reference frame
enum ControlReference {
	PLAYER,			## Control input relative to player
	WORLD			## Control input relative to world
}


## Board movement speed
@export var speed : float = 5.0

# Controls group
@export_group("Controls", "control_")

## Orientation of the controller
@export var control_orientation : ControlOrientation = ControlOrientation.VERTICAL

## Control reference frame
@export var control_reference : ControlReference = ControlReference.PLAYER


# Origin node
var _origin : T5Origin3D

# Camera node
var _camera : T5Camera3D

# Current motion region
var _region : T5ToolsMotionRegion

# Requested motion
var _control : Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the origin and camera
	var player := T5ToolsPlayer.find_instance(self)
	_origin = player.get_origin()
	_camera = player.get_camera()

	# Bind to scene loading
	T5ToolsStaging.instance.scene_loaded.connect(_on_scene_loaded)
	_on_scene_loaded(T5ToolsScene.get_current(), null)

	# Bind to the parent wand controller inputs
	var controller = get_parent() as T5Controller3D
	controller.input_vector2_changed.connect(_on_input_vector2_changed)


func _process(delta : float) -> void:
	# Skip if no motion region
	if not _region:
		return

	# Move the origin in the region
	var direction := _control_to_global(_control) * speed * delta
	_origin.global_position = _region.region_move(
		_origin.global_position,
		direction)


func _on_scene_loaded(scene : T5ToolsScene, user_data : Variant) -> void:
	# Ignore invalid scenes
	if not scene:
		return

	# Look for the motion region in the scene
	for child in scene.get_children():
		var region = child as T5ToolsMotionRegion
		if region:
			_region = region
			return

	# No motion region found
	_region = null


func _on_input_vector2_changed(p_name : String, p_value : Vector2) -> void:
	if p_name == "stick":
		_control = p_value


# Convert control input to global vector
func _control_to_global(control : Vector2) -> Vector3:
	# Get the oriented vector
	var vec : Vector3
	match control_orientation:
		ControlOrientation.VERTICAL:
			vec = Vector3(control.x, 0.0, -control.y)
		ControlOrientation.HORIZONTAL:
			vec = Vector3(-control.y, 0.0, -control.x)

	# Translate to reference frame
	if control_reference == ControlReference.PLAYER:
		# Get the frame Z vector (to-player, normalized)
		var frame_z := _camera.position.slide(Vector3.UP).normalized()
		var frame := Basis(
			Vector3.UP.cross(frame_z),
			Vector3.UP,
			frame_z)

		# Apply the reference frame
		vec = frame * vec

	# Return the vector
	return vec
