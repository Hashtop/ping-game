extends KinematicBody2D


onready var state_manager = $StateManager
onready var state_active = $StateManager/Active

onready var game_logic = get_parent().get_node("GameLogic")

export var speed := 600

const MAX_SPEED = 1000

onready var init_pos = position

enum States {
	IDLE,
	ACTIVE,
	STICKED,
	THROWED,
	EXPLODING
}

var current_state = States.IDLE

enum Types {
	REGULAR,
	STICKY
}

export (Types) var ball_type

var dir := Vector2()

func _ready() -> void:
	if ball_type == Types.REGULAR:
		$Sprite1.visible = true
	else:
		$Sprite2.visible = true
	
	dir = randomize_dir()
	
	add_to_group("balls")


static func randomize_dir() -> Vector2:
	var rand_dir = Vector2()
	
	randomize()
	
	rand_dir.x = clamp(int(rand_range(-10, 10)), -1, 1)
	while rand_dir.x == 0:
		rand_dir.x = clamp(int(rand_range(-10, 10)), -1, 1)

	randomize()
	
	rand_dir.y = clamp(int(rand_range(-10, 10)), -1, 1)
	
	return rand_dir


func ball_exited() -> void:
	game_logic.emit_signal("scored_goal", self)
	
