extends Node

var freeze_timer


func freeze_frame():
	freeze_timer = Timer.new()
	freeze_timer.wait_time = 0.05
	freeze_timer.connect("timeout", self, "freeze_ended")
	add_child(freeze_timer)
	freeze_timer.start()
	get_tree().paused = true


func freeze_ended():
	freeze_timer.queue_free()
	get_tree().paused = false
	

