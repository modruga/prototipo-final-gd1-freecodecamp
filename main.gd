extends Node2D

# obviamente essa implementação de menu foi completamente improvisada,
# tendo em mente que das funcionalidades de interface de usuário eu
# acabei usando somente um CanvasItem.

# inicia a música do menu principal à primeira disposição
func _ready():
	
	# pré-instrui o início da música do menu (importada em loop)
	$MainMenuBGM.play()

# se apertar esc no menu, fecha o jogo
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().quit()

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
	
	# aprontando besteira pra se fazer de bonito na apresentação;
	# eu vi um tutorial interessante sobre signals e implementação
	# de fade entre cenas, mas não aprontei o jogo em cima de uma
	# scene manager e não quero dor de cabeça a essa altura do
	# campeonato
	await get_tree().create_timer(2.5,true,true,false).timeout
	get_tree().change_scene_to_file("res://world.tscn")

# botão de créditos
func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
