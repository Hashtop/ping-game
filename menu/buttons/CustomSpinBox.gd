extends Control

signal value_subtract(value, pname, node)
signal value_add(value, pname, node)

signal value_changed(new_value)

export var value := 0
export var min_value := 0
export var max_value := 0

export var cooldown_time := 0.8

onready var a1_button = $CenterContainer/HBoxContainer/Arrow1/Arrow/Button
onready var a2_button = $CenterContainer/HBoxContainer/Arrow2/Arrow/Button
onready var lefta_spr = $CenterContainer/HBoxContainer/Arrow1/Arrow/Sprite
onready var righta_spr = $CenterContainer/HBoxContainer/Arrow2/Arrow/Sprite

onready var text = $CenterContainer/HBoxContainer/Text
onready var tween = $Tween

onready var parent = get_parent()

var still_pressed = false
var grace_period = 1

func _ready():
	if value < min_value:
		value = min_value
	
	a1_button.connect("pressed", self, "subtract_value")
	a2_button.connect("pressed", self, "add_value")
	
	a1_button.connect("button_up", self, "stop_pressing")
	a2_button.connect("button_up", self, "stop_pressing")
	
	update()

func _process(delta):
	if (still_pressed == true):
		if (a1_button.pressed == true):
			subtract_value()
		elif (a2_button.pressed == true):
			add_value()
	
	
	if (tween.is_active() == false):
		lefta_spr.position = Vector2(0, 0)
		righta_spr.position = Vector2(0, 0)


func subtract_value():
	if value - 1 >= min_value:
		value -= 1
		
		emit_signal("value_subtract", value, parent, self)
		
		update()
		
		tween.interpolate_property(lefta_spr, "position", 
				Vector2(0, 0), Vector2(-10, 0), 0.1,Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()
		
		if (still_pressed == true):
			var timer = create_timer(cooldown_time)
			
			yield(timer, "timeout")
			timer.remove_from_group("active_timers")
			timer.queue_free()
		else:
			var timer = create_timer(grace_period)
			
			yield(timer, "timeout")
			timer.remove_from_group("active_timers")
			timer.queue_free()
			
			still_pressed = true


func add_value():
	if value + 1 <= max_value:
		value += 1
		
		emit_signal("value_add", value, parent, self)
		
		update()
		
		tween.interpolate_property(righta_spr, "position", 
				Vector2(0, 0), Vector2(10, 0), 0.1, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()
		
		if (still_pressed == true):
			var timer = create_timer(cooldown_time)
			
			yield(timer, "timeout")
			timer.remove_from_group("active_timers")
			timer.queue_free()
		else:
			var timer = create_timer(grace_period)
			
			yield(timer, "timeout")
			timer.remove_from_group("active_timers")
			timer.queue_free()
			
			still_pressed = true


func stop_pressing():
	var active_timers = get_tree().get_nodes_in_group("active_timers")
	
	if (active_timers.size() != 0):
		for current_timer in active_timers:
			current_timer.queue_free()
	
	still_pressed = false
	


func update():
	text.text = str(value)
	
	emit_signal("value_changed", value)


func create_timer(wait_time) -> Node:
	var cooldown = Timer.new()
	add_child(cooldown)
	
	cooldown.wait_time = wait_time
	cooldown.start()
	
	cooldown.add_to_group("active_timers")
	
	return cooldown
