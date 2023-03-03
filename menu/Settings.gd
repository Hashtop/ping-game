extends CenterContainer

var save_path = "user://settings.json"

onready var camera = get_parent().get_node("CameraPos")
onready var tween_cam = get_parent().get_node("CameraTween")

onready var music_slider = $VBox/Options/Center/SoundOptions/VolMusic/VolumeSlider
onready var sound_slider = $VBox/Options/Center/SoundOptions/VolAudio/VolumeSlider

onready var shake_slider = $VBox/Options/Center2/MiscOptions/ShakeAmount/ShakeNumber

func _ready() -> void:
	load_settings()
	
	music_slider.value = AudioServer.get_bus_volume_db(1)
	sound_slider.value = AudioServer.get_bus_volume_db(2)
	
	shake_slider.value = Global.shake_intensity
	shake_slider.get_node("CenterContainer/HBoxContainer/Text").text = str(shake_slider.value)


func exit_settings() -> void:
	save_settings()
	
	tween_cam.interpolate_property(camera, "position",
			Vector2(0, 1080), Vector2(0, 0), 2, 
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	tween_cam.start()


func save_settings():
	var settings = {
		"music_volume": AudioServer.get_bus_volume_db(1),
		"audio_volume": AudioServer.get_bus_volume_db(2),
		
		"shake_intensity": Global.shake_intensity
	}
	
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_line(to_json(settings))
	file.close()


func load_settings():
	var file = File.new()
	if file.file_exists(save_path):
		file.open(save_path, File.READ)
		
		var json = parse_json(file.get_line())
		
		AudioServer.set_bus_volume_db(1, json["music_volume"])
		AudioServer.set_bus_volume_db(2, json["audio_volume"])
		
		Global.shake_intensity = json["shake_intensity"]
