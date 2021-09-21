extends Node2D

onready var balls_to_spawn = Global.ball_quantity
onready var number_of_balls = balls_to_spawn["regular"] + balls_to_spawn["sticky"]

export var can_pause := false

onready var intro = $CLayerIntro/IntroAnim

var map_node : Object

var ball_resource = preload("res://game/ball/Ball.tscn")
var player_resource = preload("res://game/player/Player.tscn")


func _ready() -> void:
	if number_of_balls > 10:
		number_of_balls = 10
	
	if Global.current_map != 0 and Global.current_map < Global.map_list.size():
		var map = load(Global.map_list[Global.current_map]).instance()
		
		add_child(map)
		
		map_node = map
	
	intro.play("countdown")


func spawn_balls():
	randomize()
	
	var spawners = get_tree().get_nodes_in_group("spawners")
	spawners.shuffle()
	
	for i in spawners:
		if number_of_balls > spawners.find(i, 0):
			var current_spawn = i
			
			var ball = ball_resource.instance()
			
			ball.position = current_spawn.position
			
			if balls_to_spawn["regular"] != 0:
				ball.ball_type = ball.Types.REGULAR
				balls_to_spawn["regular"] -= 1
			else:
				ball.ball_type = ball.Types.STICKY
				balls_to_spawn["sticky"] -= 1
			
			add_child(ball)


func spawn_players():
	var index := 1
	var p_spawners = get_tree().get_nodes_in_group("pspawn")
	
	for i in p_spawners:
		var p_spawn = i
		
		var player = player_resource.instance()
		
		player.position = i.position
		player.number = index
		
		add_child(player)
		
		player.add_to_group("players")
		
		index += 1


func enable_balls():
	var all_balls = get_tree().get_nodes_in_group("balls")
	
	for i in all_balls:
		var ball = i
		
		ball.state_manager.change_state(ball.current_state, ball.States.ACTIVE)


func stop_game():
	$CLayerIntro.queue_free()
	$CLayerPause.queue_free()
	
	can_pause = false
	
	var all_balls = get_tree().get_nodes_in_group("balls")
	
	for i in all_balls:
		var ball = i
		
		ball.state_manager.change_state(ball.current_state, ball.States.IDLE)
