extends Control

onready var game = get_parent().get_parent()

export var can_press := false

onready var blur_material = $Blur.material
onready var blur_anim = $BlurAnim

onready var back_button = $CanvasLayer/Options/VBox/Back/Button
onready var restart_button = $CanvasLayer/Options/VBox/Restart/Button
onready var menu_button = $CanvasLayer/Options/VBox/Menu/Button


func _ready() -> void:
	back_button.connect("pressed", self, "back_pressed")
	restart_button.connect("pressed", self, "restart_pressed")
	menu_button.connect("pressed", self, "menu_pressed")
	
	$CanvasLayer/Options.modulate = Color(0, 0, 0, 0)


func _process(delta: float) -> void:
	if game.can_pause:
		if Input.is_action_just_pressed("ui_cancel") and blur_anim.is_playing() == false:
			match get_tree().paused:
				false:
					get_tree().paused = true
					blur_anim.play("blur_in")
				true:
					blur_anim.play("blur_out")


func game_start():
	get_tree().paused = false


func back_pressed():
	if can_press:
		blur_anim.play("blur_out")


func restart_pressed():
	if can_press:
		$FadeAnim.play("fade_in")
		yield($FadeAnim, "animation_finished")
		blur_material.set_shader_param("blur_amount", 0)
		can_press = false
		get_tree().paused = false
		get_tree().reload_current_scene()


func menu_pressed():
	if can_press:
		$FadeAnim.play("fade_in")
		yield($FadeAnim, "animation_finished")
		get_tree().change_scene("res://menu/Menu.tscn")
		get_tree().paused = false
