class_name T5StateItemType
extends Resource


## Type ID for this item type
@export var type_id : String

## Scene file for instancing T5StateItem instances
@export_file('*.tscn') var instance_scene : String


## Create an item instance with a specific item ID
func create(p_item_id : String) -> T5StateItem:
	# Create the item
	var item := _create()
	if not item:
		return null

	# Set the item information and return the item
	item.item_id = p_item_id
	return item


## Create a dynamic instance
func create_dynamic() -> T5StateItem:
	# Create the item
	var item := _create()
	if not item:
		return null

	# Set the item information and return the item
	var uid := ResourceUID.create_id()
	item.item_id = "%s_%x" % [type_id, uid]
	item.dynamic = true
	return item


# Create an instance of the item
func _create() -> T5StateItem:
	# Load the scene
	var scene : PackedScene = load(instance_scene)
	if not scene:
		push_error("Item Type %s missing scene" % type_id)
		return null

	# Create the item
	var item : T5StateItem = scene.instantiate()
	if not item:
		push_error("Item Type %s creation error" % type_id)
		return null

	# Return the item
	return item
