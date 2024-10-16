extends Node2D

@onready var pause_menu = $PauseMenu
@export var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
	

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused


func _on_teleporting_area_body_entered(body):
	if body.name == "Player":
		
		await get_tree().create_timer(2.5,true,true,false).timeout
		get_tree().change_scene_to_file("res://credits.tscn")
