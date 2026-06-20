extends Node2D
class_name TowerManager

var all_towers: Array[Tower] = []

func _ready() -> void:
	Global.tower_selected.connect(_on_tower_selected)

func _on_tower_selected(new_tower:Tower):
	add_child(new_tower)
	register_tower(new_tower)

func _process(_delta: float) -> void:
	if Global.selected_tower != null:
		Global.selected_tower.global_position = get_global_mouse_position()

func register_tower(tower:Tower):
	if all_towers.find(tower) >= 0: return
	all_towers.append(tower)

func deregister_tower(tower:Tower):
	if all_towers.find(tower) >= 0:
		all_towers.erase(tower)
