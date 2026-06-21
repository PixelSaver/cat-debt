extends PixelMenu
class_name Game

func get_towers_to_place() -> Array[TowerInfo.TowerType]:
	return [TowerInfo.TowerType.LOW, TowerInfo.TowerType.LOW]

func _ready() -> void:
	Global.game_scene_ref = self

func start_anim(): 
	Global.state = Global.States.GAME

func end_anim(): self.hide()
