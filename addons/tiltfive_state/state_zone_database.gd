class_name T5StateZoneDatabase
extends Resource


## Array of supported zones
@export var zones : Array[T5StateZoneInfo] : set = _set_zones


# Items cache
var _cache := {}

# Items cache valid flag
var _cache_valid := false


## Gets a T5StateZoneInfo given its ID
func get_zone(p_zone_id : String) -> T5StateZoneInfo:
	# Populate the cache if necessary
	if not _cache_valid:
		_populate_cache()

	return _cache.get(p_zone_id)


# Handle setting the items
func _set_zones(p_zones : Array[T5StateZoneInfo]) -> void:
	# Save the new items
	zones = p_zones

	# Invalidate the cache
	_cache_valid = false


# Populate the type cache
func _populate_cache() -> void:
	# Populate the cache
	_cache = {}
	for zone in zones:
		_cache[zone.zone_id] = zone

	# Indicate the cache is valid
	_cache_valid = true
