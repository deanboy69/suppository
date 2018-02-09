extends Area2D

const vel = -100

var hit = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(delta*vel, 0))
		
		# Instance a shot
#		var shot = preload("res://enemy_shot.tscn").instance()
#		# Set pos as "shoot_from" Position2D node
#		shot.set_pos(get_node("shoot_from").get_global_pos())
#		# Add it to parent, so it has world coordinates
#		get_parent().add_child(shot)


#func is_enemy():
#	return not destroyed


#func destroy():
#	if (destroyed):
#		return
#	destroyed = true
#	get_node("anim").play("explode")
#	set_fixed_process(false)
#	get_node("sfx").play("sound_explode")
	# Accumulate points
#	get_node("/root/game_state").points += 10


#func _on_visibility_enter_screen():
#	set_fixed_process(true)


#func _on_visibility_exit_screen():
#	queue_free()
