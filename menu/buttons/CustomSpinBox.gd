extends Control

signal value_subtract(value, pname, node)
signal value_add(value, pname, node)

export var value := 0
export var min_value := 0
export var max_value := 0

onready var a1_button = $CenterContainer/HBoxContainer/Arrow1/Arrow/Button
onready var a2_button = $CenterContainer/HBoxContainer/Arrow2/Arrow/Button

onready var text = $CenterContainer/HBoxContainer/Text

onready var parent = get_parent()

func _ready():
	if value < min_value:
		value = min_value
	
	a1_button.connect("pressed", self, "subtract_value")
	a2_button.connect("pressed", self, "add_value")
	
	update()

func subtract_value():
	if value - 1 >= min_value:
		value -= 1
		
		emit_signal("value_subtract", value, parent, self)
		
		update()


func add_value():
	if value + 1 <= max_value:
		value += 1
		
		emit_signal("value_add", value, parent, self)
		
		update()

func update():
	text.text = str(value)
