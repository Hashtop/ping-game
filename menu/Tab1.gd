extends CenterContainer

onready var camera = get_parent().get_node("CameraPos")
onready var tween_cam = get_parent().get_node("CameraTween")

onready var b_play = $VBox/Options/Play/Panel/Button
onready var b_settings = $VBox/Options/Settings/Panel/Button
onready var b_exit = $VBox/Options/Exit/Panel/Button


func _ready() -> void:
	b_play.connect("pressed", self, "play")
	b_settings.connect("pressed", self, "settings")
	b_exit.connect("pressed", self, "exit")


func play():
	tween_cam.interpolate_property(camera, "position",
			Vector2(0, 0), Vector2(1920, 0), 2,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	tween_cam.start()


func settings():
	tween_cam.interpolate_property(camera, "position",
			Vector2(0, 0), Vector2(0, 1080), 2,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	tween_cam.start()


func exit():
	tween_cam.interpolate_property(camera, "position",
			Vector2(0, 0), Vector2(0, -2160), 4,
			Tween.TRANS_EXPO, Tween.EASE_IN)
	tween_cam.start()
	yield(tween_cam, "tween_completed")
	get_tree().quit()
