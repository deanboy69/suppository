extends Area2D

signal died
onready var muzzle = get_node("muzzle")
onready var power_up = get_node("power_up")
onready var scalp = get_node("scalp_area")
onready var live = get_node("tex_sprite")
onready var dead = get_node("tex_dead_sprite")
onready var p_timer = get_node("p_timer")
onready var shot_timer = get_node("shot_timer")
onready var global_vars = get_node("/root/global_vars")
export var speed = 400
var can_move = false
var screensize
var muzzle_pos = Vector2()
var power_up_pos = Vector2()
var prev_shooting = false
#var extents?? oh i was trying to tie the screensize to the size of the device's screen ;)
var vel = Vector2()
var killed = false

func _ready():
	set_fixed_process(true)
	screensize = get_viewport_rect().size
	set_pos(screensize/2)

func _fixed_process(delta):
	var input = Vector2(0,0)
	input.y = Input.is_action_pressed("ui_down")- Input.is_action_pressed("ui_up")
	vel = input.normalized()  * speed #this ensures that movement vectors don't become longer in the diagonal direction... the dot product of going up and right at the same time would lead to a greater velocity. this prevents that.
	var pos = get_pos()+ vel * delta
	pos.x = clamp(pos.x, 0, 100 )
	pos.y = clamp(pos.y, 100, screensize.height-100)
	set_pos(pos)
	muzzle_pos = muzzle.get_pos() #not sure what this does? i wrote it though...
	power_up_pos = power_up.get_pos()
	if killed == false:
		var shooting = Input.is_action_pressed("ui_select")#was "shoot" but that wasn't working for some reason
		if (shooting and not prev_shooting):
		# Just pressed
#		        var g = gem.instance()
 #       gem_container.add_child(g)
  #      g.connect("gem_grabbed", self, "_on_gem_grabbed")
			var bullet = preload("res://nodes/bullet_area.tscn").instance()
		# Use the Position2D as reference
			bullet.set_pos(get_node("muzzle").get_global_pos())
		# Put it one parent above, so it is not moved by us
			get_node("..").add_child(bullet)
		# Play sound
			get_node("sfx").play("gunshot")
		prev_shooting = shooting
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://nodes/main_menu.tscn")
#	prev_shooting = shooting
	#time it out, so you can only have like 4 bullets on screen at once!!!!!!!!!!!!!!!!!!!!!!!!
func _on_tex_area_area_enter( area ):
	if area.get_groups().has("dead"):
		get_node("sfx").play("scalp")
		scalp.show()
		area.queue_free()
		p_timer.start()
	if area.get_groups().has("interact"):
		area.interacted()
	if area.get_groups().has("power_up"):
#		area.interacted()
#		area.queue_free()
		pass
	if area.get_groups().has("damage"):
		area.queue_free()
		tex_is_dead()
func tex_is_dead():
	if (killed):
		return
	killed = true
	live.hide()
	dead.show()
	emit_signal("died")
	self.speed = 0
	clear_shapes()
	global_vars.ya_died_fucko()
	for x in self.get_tree().get_nodes_in_group("missiles"):
		x.collide.queue_free()
	
func _on_p_timer_timeout():
	scalp.hide()
