extends VBoxContainer


func _on_ShakeNumber_value_changed(value) -> void:
	Global.shake_intensity = value
	print(Global.shake_intensity)
