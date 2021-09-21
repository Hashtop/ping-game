# Vai conter toda a lógica pra quando a bola estiver se movimentando.
# Pode separar em outros mini-estados pra quando a bola tiver sido jogada.

extends Node

const THROW_SPEED = 1200

onready var ball = get_parent().get_parent()

onready var game_logic = ball.get_parent().get_node("GameLogic")

var enabled = false

var velocity = Vector2()
var collision

var current_player : Object

func _physics_process(delta: float) -> void:
	if enabled:
		move(delta)


func move(delta):
	if ball.current_state == ball.States.ACTIVE:
		velocity = ball.dir * ball.speed
	elif ball.current_state == ball.States.THROWED:
		velocity = ball.dir * THROW_SPEED
	
	collision = ball.move_and_collide(velocity * delta)
	if collision:
		var collider = collision.collider
		
		if collider.name.find("Wall") != -1:
			if ball.current_state == ball.States.THROWED:
				ball.state_manager.change_state(ball.current_state, ball.States.ACTIVE)
			
			ball.dir = ball.dir.bounce(collision.normal)
			
			current_player = null
		elif collider.name.find("Ball") != -1:
			ball.dir = ball.dir.bounce(collision.normal)
			
			ball.position += ball.dir * 3
			
			current_player = null
		elif collider.name.find("Player") != -1:
			if ball.ball_type == ball.Types.REGULAR:
				ball.dir = ball.dir.bounce(collision.normal)
				ball.position += ball.dir * 3
				
				if current_player != collider and ball.speed + 20 <= ball.MAX_SPEED:
					current_player = collider
					
					ball.speed += 20
			else:
				ball.state_manager.get_node("Sticked").current_player = collider
				ball.state_manager.get_node("Sticked").collision_point = collision.position
				ball.state_manager.change_state(ball.current_state, ball.States.STICKED)
		
		ball.get_node("SpeedDebug").text = str(ball.speed)

