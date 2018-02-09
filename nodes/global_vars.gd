extends Node

var is_player_dead = false

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	pass

func ya_died_fucko():
	is_player_dead == true
	print ("ya died")