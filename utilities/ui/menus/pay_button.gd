extends DefaultButton
class_name PayButton

signal paid
@export var price := 1000

func _can_pay() -> bool:
	var p = Global.game_scene_ref.purrency
	if p >= price: return true
	return false


func _process(_delta: float) -> void:
	if not self.visible: return
	self.modulate.a = 1. if _can_pay() else 0.5
func _on_pressed() -> void:
	super()
	if _can_pay(): 
		Global.game_scene_ref.pay(price)
		paid.emit()
