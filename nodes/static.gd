extends Sprite

const vel = -100

var hit = false
var pos = get_global_pos().x

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	translate(Vector2(delta*vel, 0))
	pos = get_global_pos().x
	if pos <= -50:
		queue_free()
