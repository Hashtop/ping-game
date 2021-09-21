extends Control

onready var restart_button = $Options/VBox/Restart/Button
onready var menu_button = $Options/VBox/Menu/Button

onready var transition = $Transition


func _ready() -> void:
	restart_button.connect("pressed", self, "restart_pressed")
	menu_button.connect("pressed", self, "menu_pressed")


func restart_pressed():
	transition.play("default")
	yield(transition, "animation_finished")
	get_tree().reload_current_scene()


func menu_pressed():
	transition.play("default")
	yield(transition, "animation_finished")
	get_tree().change_scene("res://menu/Menu.tscn")

