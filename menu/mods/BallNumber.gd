extends CenterContainer

onready var regular_balls = $MiscOptions/RegularBalls/Number
onready var sticky_balls = $MiscOptions/StickyBalls/Number

#
#func regular_balls_changed(value) -> void:
#	if (Global.ball_quantity["regular"] + 1 + Global.ball_quantity["sticky"]) <= 10:
#		Global.ball_quantity["regular"] = value
#
#
#func sticky_balls_changed(value) -> void:
#	if (Global.ball_quantity["sticky"] + 1 + Global.ball_quantity["regular"]) <= 10:
#		Global.ball_quantity["sticky"] = value


func value_subtract(value, p, node):
	print("subtract")

	match (p.name):
		"RegularBalls":
			print("regular")
			Global.ball_quantity["regular"] = value
		"StickyBalls":
			print("sticky")
			Global.ball_quantity["sticky"] = value

func value_add(value, p, node):
	print("add")
	
	match (p.name):
		"RegularBalls":
			print("regular")
			if (Global.ball_quantity["regular"] + 1 + Global.ball_quantity["sticky"]) <= 10:
				Global.ball_quantity["regular"] = node.value
			else:
				Global.ball_quantity["regular"] = node.value
				sticky_balls.value -= 1
				sticky_balls.update()
		"StickyBalls":
			print("sticky")
			if (Global.ball_quantity["sticky"] + 1 + Global.ball_quantity["regular"]) <= 10:
				Global.ball_quantity["sticky"] = node.value
			else:
				Global.ball_quantity["sticky"] = node.value
				regular_balls.value -= 1
				regular_balls.update()
