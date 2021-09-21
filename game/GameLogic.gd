extends Node

onready var parent = get_parent()

onready var hud = parent.get_node("HUD")

onready var end_anim = parent.get_node("CLayerEnd/GameOverAnim")

signal scored_goal

var points = ["indiferente", 0, 0]


func _ready() -> void:
	connect("scored_goal", self, "scored_goal")


func scored_goal(ball_node):
	if ball_node.position.x < 960:
		if points[2] + 1 < Global.points_to_win:
			hud.add_point(2)
			ball_node.position = ball_node.init_pos
		else:
			if end_anim.is_playing() == false:
				hud.add_point(2)
				end_anim.play("end")
	else:
		if points[1] + 1 < Global.points_to_win:
			hud.add_point(1)
			ball_node.position = ball_node.init_pos
		else:
			if end_anim.is_playing() == false:
				hud.add_point(1)
				end_anim.play("end")
	
	
