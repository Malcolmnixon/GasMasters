extends InspectionUI


## Turbine Low Price
const TURBINE_LOW_PRICE : int = 50

## Turbine High Price
const TURBINE_HIGH_PRICE : int = 200

## Research Station Price
const RESEARCH_STATION_PRICE : int = 400

# Current action
var _action : String

# Current action price
var _price : int


func _ready():
	# Update the cash line
	%Cash.text = "₡%d" % GameState.cash

	# Update the turbine low information
	%BuyTurbineLow.disabled = GameState.cash < TURBINE_LOW_PRICE
	%TurbineLowPrice.text = "₡%d" % TURBINE_LOW_PRICE

	# Update the turbine high information
	%BuyTurbineHigh.disabled = GameState.cash < TURBINE_HIGH_PRICE
	%TurbineHighPrice.text = "₡%d" % TURBINE_HIGH_PRICE

	# Update the turbine high information
	%BuyStation.disabled = GameState.cash < RESEARCH_STATION_PRICE
	%StationPrice.text = "₡%d" % RESEARCH_STATION_PRICE


func _on_buy_turbine_low_pressed():
	# Save action and go to confirmation
	_action = "buy_turbine_low"
	_price = TURBINE_LOW_PRICE
	%ConfirmMessage.text = "Confirm purchase\nof Turbine Low"
	%TabContainer.current_tab = 1


func _on_buy_turbine_high_pressed():
	# Save action and go to confirmation
	_action = "buy_turbine_high"
	_price = TURBINE_HIGH_PRICE
	%ConfirmMessage.text = "Confirm purchase\nof Turbine High"
	%TabContainer.current_tab = 1


func _on_buy_station_pressed():
	# Save action and go to confirmation
	_action = "buy_research_station"
	_price = RESEARCH_STATION_PRICE
	%ConfirmMessage.text = "Confirm purchase\nof Research Station"
	%TabContainer.current_tab = 1


func _on_close_pressed():
	# Hide the UI
	container.visible = false


func _on_yes_pressed():
	# Deliver the interaction and hide the UI
	GameState.cash -= _price
	item.interaction(_action)
	container.visible = false


func _on_no_pressed():
	# Go back to construct tab
	%TabContainer.current_tab = 0
