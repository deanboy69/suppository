extends Area2D

var vel = -200
var pos = get_global_pos().x

var hit = false

func _ready():
	add_to_group("damage")
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(delta*vel, 0))
	pos = get_global_pos().x
	if pos <= 0:
		queue_free()
	
func _hit_something():
	if (hit):
		return
	hit = true
	queue_free()