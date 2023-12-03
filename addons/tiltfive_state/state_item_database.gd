class_name T5StateItemDatabase
extends Resource


## Array of supported item types
@export var items : Array[T5StateItemType] : set = _set_items


# Items cache - type_id:String -> T5StateItemType
var _cache := {}

# Cache valid flag
var _cache_valid := false


# Gets a T5StateItemType given its id
func get_type(p_type_id : String) -> T5StateItemType:
	# Populate the cache if necessary
	if not _cache_valid:
		_populate_cache()

	return _cache.get(p_type_id)


# Handle setting the items
func _set_items(p_items : Array[T5StateItemType]) -> void:
	# Save the new items
	items = p_items

	# Invalidate the cache
	_cache_valid = false


# Populate the type cache
func _populate_cache() -> void:
	# Populate the cache
	_cache = {}
	for item in items:
		_cache[item.type_id] = item

	# Indicate the cache is valid
	_cache_valid = true
