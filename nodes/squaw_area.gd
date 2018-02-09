extends Area2D

var vel = -50
onready var live = get_node("squaw_sprite")
onready var dead = get_node("squaw_dead_sprite")
onready var hits = get_node("squaw_shape")
onready var sprite = get_node("squaw_sprite")
var pos = get_global_pos().x
var killed = false

func _ready():
	add_to_group("stuff")
	add_to_group("enemy")
	set_fixed_process(true)

func _fixed_process(delta):
	pos = get_global_pos().x
	translate(Vector2(delta*vel, 0))
	sprite.play()
	if pos <= -100:
		queue_free()

func kill():
	if (killed):
		return
	killed = true
	live.hide()
	dead.show()
	vel = -100
	hits.rotate(PI/2)
	get_node("sfx").play("woman_died")
	remove_from_group("enemy")
	add_to_group("dead")
	
func stop_play():
	vel = 100
	set_fixed_process(true)
	