extends Control

onready var game_logic = get_parent().get_node("GameLogic")
onready var p1_points = $Center/HBox/PontosP1
onready var p2_points = $Center/HBox/PontosP2


func add_point(player_num : int):
	match player_num:
		1:
			game_logic.points[1] += 1
			p1_points.text = str(game_logic.points[1])
		2:
			game_logic.points[2] += 1
			p2_points.text = str(game_logic.points[2])
