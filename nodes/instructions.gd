extends Node2D

var timeouts = null
var key_delay = 1
var can_proceed = false
onready var sfx = get_node("sfx")

func _ready():
	set_process(true)
	set_fixed_process(true)
	set_process_input(true)
	timeouts = Timer.new()
	timeouts.set_one_shot(true)
	timeouts.set_wait_time(key_delay)
	timeouts.connect("timeout", self, "on_timeout_complete")
	add_child(timeouts)
	timeouts.start()
	sfx.play("chapel_bell")

func on_timeout_complete():
	can_proceed = true

func _fixed_process(delta):
	if (Input.is_action_pressed("ui_select")&& can_proceed):
		get_tree().change_scene("res://nodes/Desert_Thirst_Main.tscn")