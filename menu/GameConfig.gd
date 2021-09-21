extends CenterContainer

onready var camera = get_parent().get_node("CameraPos")


func play_game() -> void:
	Global.played = true
	get_tree().change_scene("res://game/Game.tscn")


func back() -> void:
	$Anim.interpolate_property(camera, "position",
			Vector2(1920, 0), Vector2(0, 0), 2,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Anim.start()
