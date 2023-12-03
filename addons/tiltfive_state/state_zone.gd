class_name T5StateZone
extends T5ToolsScene


## Zone information
@export var zone_info : T5StateZoneInfo


## Save the zone state
func save_state() -> void:
	# Save state for all items in the zone
	propagate_notification(T5State.NOTIFICATION_STATE_SAVE)

	# Identify items in the zone
	var items_in_zone : Array[String] = []
	for item in T5StateItem.find_instances(self):
		items_in_zone.append(item.item_id)

	# Save the items in the zone
	T5StateData.active.set_value(zone_info.zone_id, items_in_zone)


# Override scene loading
func _on_scene_loaded(user_data : Variant) -> void:
	# Call the base
	super(user_data)

	# Find all T5StateItem instances designed into the zone
	var items_in_zone := {}
	for item in T5StateItem.find_instances(self):
		items_in_zone[item.item_id] = item

	# Find the zone items the StateData thinks should be in this zone
	var zone_items = T5StateData.active.get_value(zone_info.zone_id)

	# Free items designed into the zone but the StateData does not
	# think should exist.
	if zone_items is Array:
		for item_id : String in items_in_zone:
			if not zone_items.has(item_id):
				var item : T5StateItem = items_in_zone[item_id]
				item.get_parent().remove_child(item)
				item.queue_free()

	# Propagate state loading for all items in the zone
	propagate_notification(T5State.NOTIFICATION_STATE_LOAD)

	# Create items missing from the zone but StateData thinks should be present
	if zone_items is Array:
		for item_id : String in zone_items:
			if not items_in_zone.has(item_id):
				_create_item_instance(item_id)


# Override scene exiting
func _on_scene_exiting(user_data : Variant) -> void:
	# Call the base
	super(user_data)

	# Save zone state
	save_state()


# Create an item instance
func _create_item_instance(p_item_id : String) -> T5StateItem:
	# Get the item state dictionary
	var state = T5StateData.active.get_value(p_item_id)
	if not state is Dictionary:
		push_error("Zone item %s missing state information" % p_item_id)
		return null

	# Get the item type ID
	var item_type_id = state.get("type")
	if not item_type_id is String:
		push_error("Zone item %s missing type information" % p_item_id)
		return null

	# Get the item type
	var item_type := T5StateData.active.item_database.get_type(item_type_id)
	if not item_type:
		push_error("Zone item %s uses unknown type %s" % [p_item_id, item_type_id])
		return null

	# Construct the item
	var item := item_type.create(p_item_id)
	item.propagate_notification(T5State.NOTIFICATION_STATE_LOAD)
	if not item.get_parent():
		add_child(item)

	# Return the item
	return item
