extends Control
class_name TowerSelectionPopup

func _ready() -> void:
	Global.tower_selected.connect(_on_tower_selected)
	
func _on_tower_selected(tower:Tower) -> void:
	if tower.placed == false: return
	var target = tower.global_position
	var rect = get_viewport_rect()
	
