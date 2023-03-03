extends CenterContainer

onready var camera = get_parent().get_node("CameraPos")
onready var tween_cam = get_parent().get_node("CameraTween")

func play_game() -> void:
	Global.played = true
	get_tree().change_scene("res://game/Game.tscn")


func back() -> void:
	tween_cam.interpolate_property(camera, "position",
			Vector2(1920, 0), Vector2(0, 0), 2,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	tween_cam.start()


