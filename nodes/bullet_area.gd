extends Area2D

onready var collide = get_node("bullet_shape")
var vel = 200 
var pos = get_global_pos().x

func _ready():
	add_to_group("missiles")
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(delta*vel, 0))
	pos = get_global_pos().x
	if pos >= get_viewport_rect().size.width + 20:
		self.queue_free()
		
func _on_bullet_area_area_enter( area ):
	if pos >= 40 && area.get_groups().has("enemy"):
		area.kill()
		queue_free()
