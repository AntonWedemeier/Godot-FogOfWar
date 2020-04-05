extends Node

# warning-ignore:unused_argument
func _process(delta):
	if get_tree().paused == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().paused = false
