extends Node

onready var ball = get_parent().get_parent()

var current_player : Object
var collision_point

var player_distance_to_point
var wanted_y_position

var node2d

func stick():
	if ball.position.x < 960:
		ball.position.x = current_player.position.x + 37
	else:
		ball.position.x = current_player.position.x - 37
	
	node2d = Node2D.new()
	add_child(node2d)
	
	node2d.position = collision_point
	
	player_distance_to_point =  current_player.position.y - node2d.position.y
	
	$Duration.start()


func _physics_process(delta: float) -> void:
	if $Duration.is_stopped() == false:
		wanted_y_position = current_player.position.y - player_distance_to_point
		
		if ball.position.y != wanted_y_position:
			ball.position.y = wanted_y_position


func throw_ball() -> void:
	if ball.position.x < 960:
		ball.dir.x = 1
	else:
		ball.dir.x = -1
	
	if current_player.dir.y > 0:
		ball.dir.y = 1
	elif current_player.dir.y == 0:
		ball.dir.y = 0
	elif current_player.dir.y < 0:
		ball.dir.y = -1
	
	node2d.queue_free()
	current_player = null
	
	ball.position += ball.dir * 3
	
	ball.state_manager.change_state(ball.current_state, ball.States.THROWED)
