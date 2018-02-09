extends KinematicBody2D
onready var back = self

const scroll = -100

var hit = false

func _ready():
	add_to_group("stuff")
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(delta*scroll, 0))
	var pos = back.get_pos()
	if pos.x <= -128:
		move_to(Vector2(0,0))