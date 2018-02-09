extends Area2D

var vel = -100
onready var live = get_node("archer_sprite")
onready var dead = get_node("archer_dead_sprite")
onready var hits = get_node("archer_shape")
onready var sprite = get_node("archer_sprite")
var pos = get_global_pos().x
var killed = false

func _ready():
	add_to_group("stuff")
	add_to_group("enemy")
	set_fixed_process(true)

func _fixed_process(delta):
	pos = get_global_pos().x
	translate(Vector2(delta*vel, 0))
	if pos <= -100:
		queue_free()
	var arrow = preload("res://nodes/arrow_area.tscn").instance()
	_on_archer_sprite_frame_changed()
	
#func is_enemy():# not sure what either of these lines do and they don't seem to fuck up code if removed...?
#	return not killed#

func kill():
	if (killed):
		return
	killed = true
	live.hide()
	live.stop()
	dead.show()
	hits.rotate(PI/2)
	get_node("sfx").play("man_died")
	remove_from_group("enemy")
	add_to_group("dead")

func stop_play():
	sprite.stop()

func _on_archer_sprite_frame_changed():
	print("benis")