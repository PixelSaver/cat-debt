extends PixelMenu
class_name BeginningCutscene

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var debt_text: RichTextLabel = $DebtText
const GAME = preload("res://scenes/game.tscn")
var ts : Array[Tweenable]
var t : Tween

## Call when the cutscene is finished and go to the game
func end_cutscene() -> void:
	print("To game")
	Global.menu_manager.transition_to_scene(GAME)

func start_anim():
	Global.state = Global.States.BEGINNING_CUTSCENE
	debt_text.modulate.a = 0.0
	anim.scale = Vector2.ZERO
	await get_tree().create_timer(1.0).timeout
	t = default_tween().set_ease(Tween.EASE_IN)
	t.tween_property(anim, "scale", Vector2.ONE * 0.4, 1.0)
	await t.finished
	await get_tree().create_timer(0.5).timeout
	await _anim_slots()

func _anim_slots():
	anim.play("cut_scene")
	await anim.animation_finished
	if t and t.is_running(): t.kill()
	t = default_tween()
	debt_text.offset_transform_position.y = 0.0
	debt_text.modulate.a = 1.0
	t.tween_property(debt_text, "offset_transform_position:y", -50., 0.7)
	t.tween_property(debt_text, "modulate:a", 0.0, 0.3).set_delay(0.4)
	await get_tree().create_timer(1.5).timeout
	anim.play("cut_scene")
	await anim.animation_finished
	if t and t.is_running(): t.kill()
	t = default_tween()
	debt_text.offset_transform_position.y = 0.0
	debt_text.modulate.a = 1.0
	t.tween_property(debt_text, "offset_transform_position:y", -50., 0.7)
	t.tween_property(debt_text, "modulate:a", 0.0, 0.3).set_delay(0.4)
	
	
	
func end_anim():
	pass
	
