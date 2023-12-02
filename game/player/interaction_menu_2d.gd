class_name BuildMenu2D
extends Control


## Signal invoked when the user selects the close button
signal close


# Target node
var _target : InteractableObject

# Menu title
var _title : String

# Menu items
var _items : Array[Dictionary]

# Selected item
var _selected : int


# Show the build menu
func show_menu(
	target : InteractableObject,
	title : String,
	items : Array) -> void:
	# Save the menu information
	_target = target
	_title = title
	_items = items

	# Free all menu items
	var children := %Menu.get_children()
	for child in children:
		child.queue_free()

	# Construct the buttons
	for index in _items.size():
		var item := _items[index]
		var button := Button.new()
		button.text = item["text"]
		button.pressed.connect(_on_item_pressed.bind(index))
		%Menu.add_child(button)

	# Show the menu tab
	%Title.text = _title
	%TabContainer.current_tab = 0


# Handle closed pressed
func _on_close_pressed() -> void:
	close.emit()


# Handle build/modify item pressed
func _on_item_pressed(index : int) -> void:
	# Save the selected index
	_selected = index

	# Show the confirmation tab
	%ConfirmMessage.text = _items[index].confirm
	%TabContainer.current_tab = 1


# Handle acceptance of confirmation
func _on_confirm_yes_pressed():
	_target.interaction(_items[_selected].id)
	close.emit()


# Handle refusal of confirmation
func _on_confirm_no_pressed():
	# Switch back to the menu tab
	%TabContainer.current_tab = 0
