extends VBoxContainer


func _on_MusicSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)


func _on_SoundSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)

