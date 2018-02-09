extends Sprite

const vel = -100

var hit = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(delta*vel, 0))