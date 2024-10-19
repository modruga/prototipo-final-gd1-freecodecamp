extends Node2D

# @onready var pause_menu = $PauseMenu
@export var paused = false

# resolvi não implementar o PauseMenu, pelo menos pra essa entrega,
# pois queria usufruir melhor das ferramentas de UI mas francamente
# não estou com paciência pra fazer isso agora
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://main.gd")
	

func _on_teleporting_area_body_entered(body):
	if body.name == "Player":
		
		await get_tree().create_timer(2.5,true,true,false).timeout
		get_tree().change_scene_to_file("res://credits.tscn")
