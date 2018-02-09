extends Node
onready var stuff = get_tree().get_nodes_in_group("stuff")
onready var timer = get_node("timer")
#onready var move = get_node("move")
onready var sfx = get_node("sfx")
onready var tex = get_node("tex_area")
onready var background = get_node("background")
onready var teepee = get_node("teepee_area")
onready var hud = get_node("hud container").get_node("died")
onready var esc = get_node("hud container").get_node("esc_2")
var can_move = false
signal move
signal can_move

func _ready():
#	self.connect("move", self, "on_move")
	tex.connect("died", self, "on_die")
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)
	OS.set_window_title("DESERT THIRST")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	sfx.play("chapel_bell")
	
func process(delta):
	timer.start()
#	move.start()

func _on_timer_timeout():
	can_move = true && print ("true")
	emit("move")

func on_die():
	for x in self.get_tree().get_nodes_in_group("stuff"):
		x.set_fixed_process(false)
	for x in self.get_tree().get_nodes_in_group("enemy"):
		x.stop_play()
		hud.show()
		esc.show()
	
func stop():
	set_fixed_process(false)