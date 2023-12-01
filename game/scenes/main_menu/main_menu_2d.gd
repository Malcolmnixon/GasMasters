extends Control


## Start scene
@export_file('*.tscn') var start_scene : String


func _on_new_pressed():
	T5ToolsStaging.load_scene(start_scene)


func _on_quit_pressed():
	get_tree().quit()
