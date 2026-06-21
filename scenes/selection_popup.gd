extends Panel
class_name SelectionPopup

func _unhandled_input(event:InputEvent):
	if visible and event is InputEventMouseButton and event.pressed:
		var rect = get_global_rect()
		
		if not rect.has_point(event.position):
			hide()
