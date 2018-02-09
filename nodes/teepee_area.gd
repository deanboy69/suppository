extends Area2D

onready var burn = get_node("teepee_burn_sprite")
onready var norm = get_node("teepee_sprite")
var pos = get_global_pos().x
var interacted = false

const vel = -100

var hit = false

func _ready():
	add_to_group("stuff")
	add_to_group("interact")
	set_fixed_process(true)

func _fixed_process(delta):
	pos = get_global_pos().x
	translate(Vector2(delta*vel, 0))
	if pos <= -300:
		queue_free()
	
func interacted():
	if (interacted):
		return
	interacted = true
	get_node("sfx").play("burn")
	norm.hide()
	burn.show()