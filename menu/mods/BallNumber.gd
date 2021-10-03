extends CenterContainer

onready var regular_balls = $MiscOptions/RegularBalls/Number
onready var sticky_balls = $MiscOptions/StickyBalls/Number


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
				sticky_balls.subtract_value()
				sticky_balls.update()
		"StickyBalls":
			print("sticky")
			if (Global.ball_quantity["sticky"] + 1 + Global.ball_quantity["regular"]) <= 10:
				Global.ball_quantity["sticky"] = node.value
			else:
				Global.ball_quantity["sticky"] = node.value
				regular_balls.subtract_value()
				regular_balls.update()


func randomize_value():
	var max_regular = int(rand_range(0, 10))
	
	while (Global.ball_quantity["regular"] != max_regular):
		Global.ball_quantity["regular"] = max_regular
		regular_balls.value = max_regular
		
	Global.ball_quantity["sticky"] = 10 - max_regular
	sticky_balls.value = 10 - max_regular
	
	regular_balls.update()
	sticky_balls.update()
