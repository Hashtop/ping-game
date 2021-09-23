extends CenterContainer

onready var map_number = $MapNumber/Number


func map_value_changed(value) -> void:
	Global.current_map = value


func randomize_map() -> void:
	randomize()
	
	var selected_map = int(rand_range((map_number.min_value - 1) * 10, (map_number.max_value + 1) * 10))
	selected_map = round(selected_map / 10)
	selected_map = clamp(selected_map, map_number.min_value, map_number.max_value)
	
	Global.current_map = selected_map
	map_number.value = selected_map
	map_number.get_node("CenterContainer/HBoxContainer/Text").text = str(selected_map)
	
	print(Global.current_map)

