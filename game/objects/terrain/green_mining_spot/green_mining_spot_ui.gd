extends InteractionUI


# Current action
var _action : String

# Current action price
var _price : int


func _ready():
	# Update the cash line
	%Cash.text = "₡%d" % GameState.cash

	# Update the turbine low information
	%BuyMine.disabled = GameState.cash < MiningRig.PRICE
	%MinePrice.text = "₡%d" % MiningRig.PRICE


func _on_buy_mine_pressed():
	# Save action and go to confirmation
	_action = "buy_mine"
	_price = MiningRig.PRICE
	%ConfirmMessage.text = "Confirm purchase\nof Mine"
	%TabContainer.current_tab = 1


func _on_close_pressed():
	# Hide the UI
	container.visible = false


func _on_yes_pressed():
	# Deliver the interaction and hide the UI
	GameState.cash -= _price
	interactable.interaction(_action)
	container.visible = false


func _on_no_pressed():
	# Go back to construct tab
	%TabContainer.current_tab = 0
