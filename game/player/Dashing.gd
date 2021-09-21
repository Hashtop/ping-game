extends Node

var dash_speed := 1400
var dash_dir = Vector2()

onready var state_manager = get_parent()
onready var player = get_parent().get_parent()

var velocity


func _physics_process(delta: float) -> void:
	if $DashDuration.is_stopped() == false:
		if $MovementLockDuration.is_stopped():
			velocity = dash_speed * player.dir
		else:
			velocity = dash_speed * dash_dir
		
		player.move_and_slide(velocity) * delta
		
		player.position.x = player.init_pos.x


func start_dash():
	dash_dir = player.dir
	$DashDuration.start()
	$MovementLockDuration.start()


func dash_ended() -> void:
	$DashDuration.stop()
	$MovementLockDuration.stop()
	$DashCooldown.start()
	$CooldownAnim.stop()
	$CooldownAnim.play("charging")
	state_manager.change_state(state_manager.p_states.DASHING, state_manager.p_states.IDLE)
