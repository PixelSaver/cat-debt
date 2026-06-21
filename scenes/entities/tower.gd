extends RigidBody2D
class_name Tower
const BULLET = preload("res://scenes/entities/bullet.tscn")
@onready var range_area: Area2D = $RangeArea

var placeable := false
var placed := false
@onready var sprite: Sprite2D = $Sprite2D
var enemies_in_range: Array[Enemy] = []
var INFO = TowerInfo.stats
var type : TowerInfo.TowerType = TowerInfo.TowerType.LOW
var cumulative_timer := 0.0

func _ready() -> void:
	self.lock_rotation = true
	range_area.body_entered.connect(_on_range_entered)
	range_area.body_exited.connect(_on_range_exited)
func _get_stats() -> Dictionary:
	return INFO.get(type)

func _process(delta: float) -> void:
	if not placed:
		if self.placeable: sprite.modulate.a = 1.0
		else: sprite.modulate.a = 0.7
	else:
		var stats = _get_stats()
		var cooldown = stats["attack_cooldown"]
		if not cooldown: push_error("Attack cooldown doesn't exist in tower type")
		if enemies_in_range.size() > 0 and enemies_in_range[0]:
			cumulative_timer += delta
			while cumulative_timer > cooldown:
				cumulative_timer -= cooldown
				var inst = BULLET.instantiate() as Bullet
				add_child(inst)
				await get_tree().process_frame
				inst.bullet_init(
					enemies_in_range[0], 
					stats["bullet_speed"], 
					stats["damage"]
				)
		else:
			#cumulative_timer = 0.0
			pass

func _on_range_entered(body:Node2D):
	var enemy = body as Enemy
	if not enemy: return
	enemies_in_range.append(enemy)
	enemy.tree_exited.connect(func():
		enemies_in_range.erase(enemy)
	)
func _on_range_exited(body:Node2D):
	var enemy = body as Enemy
	if not enemy: return
	enemies_in_range.erase(enemy)

func register_areas(arr:Array[Area2D]):
	for area in arr:
		area.body_entered.connect(func(body:Node2D):
			if body == self:
				print("not Placeable")
				placeable = false
		)
		area.body_exited.connect(func(body:Node2D):
			if body == self:
				print("placeable")
				placeable = true
		)
