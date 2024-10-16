extends Node2D

# inicia a música do menu principal à primeira disposição
func _ready():
	
	$MainMenuBGM.play()

# o conjunto de métodos em get_tree() tratam de funções onde
# seu escopo ronda em torno da árvore de conteúdos que pode
# ser analisada no menu de cena, na aba "Local".
func _on_quit_button_pressed():
	
	$MainMenuBGM.stop()
	$QuitSound.play()
	
	await get_tree().create_timer(2.5,true,true,false).timeout
	get_tree().quit()
	

# o método "change_scene_to_file" de get_tree()
# recebe como parâmetro uma String
# com o caminho até a cena desejada
func _on_play_button_pressed():
	
	$MainMenuBGM.stop()
	$SelectSound.play()
	
	# novamente aprontando besteira pra se fazer de bonito n apresentação;
	# eu vi um tutorial interessante sobre signals e implementação
	# de fade entre cenas, mas não aprontei o jogo em cima de uma
	# scene manager e não quero dor de cabeça a essa altura do
	# campeonato
	await get_tree().create_timer(2.5,true,true,false).timeout
	get_tree().change_scene_to_file("res://world.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
