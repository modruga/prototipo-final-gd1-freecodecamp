extends Node2D

# pré-instrui o interpretador a iniciar a música dos créditos
func _onready():
	$CreditsBGM.play()
	
func _physics_process(delta):
	
	# caso seja pressionado ESC em qualquer modelo de teclado, independente
	# do input map, volta ao menu, pulando os créditos
	if Input.is_physical_key_pressed(4194305): # esc
			get_tree().change_scene_to_file("res://main.tscn")
	
	# pra evitar que apareça na cena indo pra direita caindo em diagonal
	if get_node("Player").is_on_floor():
		
		# recebe uma Key (que possui um valor constante) e verifica diretamente
		# se a tecla específica (independente de input map) está sendo pressionada
		# (nesse caso, no escopo de _physics_process, verifica a cada delta)
		if Input.is_physical_key_pressed(69): # nicE
			get_node("Player").SPEED = 300
			Input.action_press("move_right")
		else:
			get_node("Player").SPEED = 150.0
			# gambiarra que não devia ser feita desse jeito porém isso faz com que
			# o input nomeado "move_right" (em project settings > input map) seja
			# articialmente pressionado todo delta
			Input.action_press("move_right")
		

# Area2D que faz teleporte pra outras cenas
func _on_teleport_area_body_entered(body):
	
	if body.name == "Player":
		
		# cada vez que eu uso essa função eu sinto vontade de bater a cabeça na
		# parede
		await get_tree().create_timer(1.5,true,true,false).timeout
		get_tree().change_scene_to_file("res://main.tscn")
