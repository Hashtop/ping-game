extends Node

onready var player = get_parent().get_parent()

var enabled := false

var velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if enabled:
		move(delta)


func move(delta):
	velocity = player.speed * player.dir
	player.move_and_slide(velocity) * delta
