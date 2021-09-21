extends KinematicBody2D

onready var state_manager = $StateManager

export var number : int
export var speed := 600

onready var init_pos = position

enum States {
	DISABLED,
	IDLE,
	MOVING,
	DASHING
}

var current_state = States.DISABLED

var dir = Vector2()


func _physics_process(delta: float) -> void:
	position.x = init_pos.x
	
	dir = Vector2.ZERO
	if Input.is_action_pressed("up" + str(number)):
		if current_state != States.MOVING and current_state != States.DASHING:
			state_manager.change_state(current_state, States.MOVING)
		
		dir.y -= 1
		dir = dir.normalized()
	if Input.is_action_pressed("down" + str(number)):
		if current_state != States.MOVING and current_state != States.DASHING:
			state_manager.change_state(current_state, States.MOVING)
		
		dir.y += 1
		dir = dir.normalized()
	
	if Input.is_action_just_pressed("dash" + str(number)):
		state_manager.change_state(current_state, States.DASHING)
	
	if dir == Vector2.ZERO:
		if current_state != States.IDLE:
			state_manager.change_state(current_state, States.IDLE)
	
