extends VBoxContainer

onready var ball_number = $BallNumber
onready var map_select = $VSplitContainer/MapSelect

func randomize_pressed():
	ball_number.randomize_value()
	map_select.randomize_map()
