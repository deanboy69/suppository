extends HBoxContainer

onready var fade_in = get_node("fade_in_logo")
onready var fade_out = get_node("fade_out_logo")
onready var fade_inst = get_node("fade_in_inst")
onready var title = get_node("center_container/title")
onready var instructions = get_node("center_container/instructions")
onready var timer = get_node("center_container/timer")
onready var esc = get_node("center_container/esc")
onready var fade_esc = get_node("fade_in_esc")
var timeouts = null
var quit_out = null
var key_delay = 3
var quit_delay = 1
var can_proceed = false
var can_quit = false

func _ready():
	set_process(true)
	set_fixed_process(true)
	set_process_input(true)
	fade_in.interpolate_property(title, 'visibility/opacity', 0, 1, 3, Tween.TRANS_SINE, Tween.EASE_IN)
	fade_in.start()
	fade_esc.interpolate_property(esc, 'visibility/opacity', 0, 1, 0.4, Tween.TRANS_SINE, Tween.EASE_IN)
	fade_esc.start()
	timer.start()
	timeouts = Timer.new()
	timeouts.set_one_shot(true)
	timeouts.set_wait_time(key_delay)
	timeouts.connect("timeout", self, "on_timeout_complete")
	add_child(timeouts)
	timeouts.start()
	
	quit_out = Timer.new()
	quit_out.set_one_shot(true)
	quit_out.set_wait_time(quit_delay)
	quit_out.connect("timeout", self, "on_quit_out_complete")
	add_child(quit_out)
	quit_out.start()
	
func on_timeout_complete():
	can_proceed = true
	
func on_quit_out_complete():
	can_quit = true
	
func _fixed_process(delta):
	if (Input.is_action_pressed("ui_select") && can_proceed):
		get_tree().change_scene("res://nodes/instructions.tscn")
	if (Input.is_action_pressed("ui_cancel") && can_quit):
		get_tree().quit()

func _on_fade_in_logo_tween_complete( object, key ):
	fade_out.interpolate_property(title, 'visibility/opacity', 1, 0, 2, Tween.TRANS_SINE, Tween.EASE_OUT)
	fade_out.start()

func _on_timer_timeout():
	fade_inst.interpolate_property(instructions, 'visibility/opacity', 0, 1, 1, Tween.TRANS_SINE, Tween.EASE_IN)
	fade_inst.start()