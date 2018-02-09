extends Node

onready var effect = get_node("fade_to_black")
onready var deanboy = get_node("deanboy")
onready var logo = get_node("logo")
onready var timer = get_node("timer")
onready var timer_2 = get_node("timer_2")

func _ready():
	set_process(true)
	get_node("sfx").play("ooo")
func _set_process(delta):
	timer.start()

func _on_timer_timeout():
	effect.interpolate_property(deanboy, 'visibility/opacity', 1, 0, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	effect.interpolate_property(logo, 'visibility/opacity', 1, 0, 2, Tween.TRANS_SINE, Tween.EASE_OUT)
	effect.start()

func _on_fade_to_black_tween_complete( object, key ):
	timer_2.start()

func _on_timer_2_timeout():
	get_tree().change_scene("res://nodes/main_menu.tscn")