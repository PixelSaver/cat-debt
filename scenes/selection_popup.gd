class_name SelectionPopup
extends Panel

@export var but: DefaultButton

func _ready() -> void:
	but.pressed.connect(_on_upgrade_pressed)

func _unhandled_input(event: InputEvent):
	if visible and event is InputEventMouseButton and event.pressed:
		var rect = get_global_rect()
		
		if not rect.has_point(event.position):
			hide()

func _on_upgrade_pressed() -> void:
	pass

func _update_ui() -> void:
	pass
	# update level, price, and the availability of the button
