extends CharacterBody2D

# variável incremental de combo que altera a velocidade e altura de
# pulo do Player
var combo = 0

func _ready():
	
	# é realizada a sincronização da posição horizontal do Player e
	# da bola a partir do primeiro frame
	var PlayerXPos = get_node("../../Player/Player").position.x
	
	# aqui se atribui o valor da posição X do Player com a Bola
	position.x = PlayerXPos
	
	# para evitar problemas de movimentação, deve-se trabalhar em cima
	# da posição x atual e nunca zerar o valor horizontal ao atualizar
	# ou definir uma força constante sob o eixo x
	velocity = Vector2(position.x,0)

func _physics_process(delta):
	
	if get_node("../..").paused:
		velocity += Vector2(0,0)
	else:
	# aqui, dentro de _physics_process, é atualizado a cada frame a
	# posição da bola em relação à posição horizontal do Player
		var PlayerXPos = get_node("../../Player/Player").position.x
		velocity -= Vector2(velocity.x,-4.5)
	
	
	
	
	# move_and_collide, nesse contexto, em conjunto à velocity e valor
	# delta, habilita a bola a ter propriedades físicas contínuas
		var collision = move_and_collide(velocity * delta)
	
		if get_node("../../Player/Player").isDying == true:
				pass
		else:
	
		# o retorno da normal da trajetória resulta num efeito de "quicada"
		# menos artificial
			if collision:
				velocity = Vector2.UP * 200
	
		position.x = PlayerXPos
	

func _on_area_2d_body_entered(body):
	
	var comboColor = Color()
	
	# por enquanto, a condição de incremento do combo é resumido em
	# estar no ar quando a bola quicar na cabeça do Player. isso
	# se dá pelo fato de que infelizmente existe um prazo de entrega
	if body.name == "Player":
		
		if get_node("../../Player/Player").isDying == true:
				pass
		else:
			print("quicou")
			$Quicada.play()
			
			# como condição temporária de acréscimo de combo, é checado
			# ao entrar em contato com a bola se o jogador está no chão
			# ou não
			if !get_node("../../Player/Player").is_on_floor():
				print("combo")
				combo+=1
				
				
				
				# perceba que a notação usada se aproveita de um método
				# vinculado ao objeto Vector2 associado diretamente ao
				# eixo vertical apontado para cima. fiz dessa forma pra
				# preservar a simplicidade do projeto
				velocity = Vector2.UP * 200
				
				
			
			# em teoria seria só botar um else em vez da condição específica
			# de que o jogador está no chão, mas ter feito isso resolveu um
			# problema que realmente não identifiquei do que se tratava	
			if get_node("../../Player/Player").is_on_floor():
				print("errou")
				velocity = Vector2.UP * 125
				combo=0
				
			# lembra quando mencionei a quantia exorbitante de camadas
			# de estruturas condicionais que apontei como um pecado no arquivo
			# ________? aqui resolvi tomar vergonha na cara e implementar o
			# que seria considerado em gdscript a estrutura "switch-case", que
			# foi perfeita pra esse contexto
			match combo:
				
				0:
					comboColor = Color(255,255,255,1) # branco
					get_node("../../UI/Combo").set("theme_override_colors/font_color", comboColor) # branco
					get_node("../Player").SPEED = 100
					get_node("../Player").JUMP_VELOCITY = -300
				
				1:
					get_node("../Player").SPEED = 100
					get_node("../Player").JUMP_VELOCITY = -300
					
					# altera a cor da fonte através de um comando set no atributo
					# font_color, presente no sistema de themes onde está contido
					# a fonte, cor da fonte, etc, na Label; esse comando
					# busca, dentro de world, através do diretório local,
					# o Label de combo. isso deu mais trabalho pra entender
					# que eu imaginava e o resultado é bem medíocre, mas
					# quanto mais indicação visual que represente a
					# velocidade do Player, melhor
					comboColor = Color(255,255,255,1) # branco
					get_node("../../UI/Combo").set("theme_override_colors/font_color", comboColor) # branco 
					
				2:
					get_node("../Player").SPEED = 150
					get_node("../Player").JUMP_VELOCITY = -325
					
					comboColor = Color(0, 255, 0, 1) # verde
					get_node("../../UI/Combo").set("theme_override_colors/font_color", comboColor) # verde
					
				3:
					get_node("../Player").SPEED = 200
					get_node("../Player").JUMP_VELOCITY = -350
					
					comboColor = Color(255.0, 255.0, 0.0 ,1.0)
					get_node("../../UI/Combo").set("theme_override_colors/font_color", comboColor) # amarelo
					
				4:
					get_node("../Player").SPEED = 250
					get_node("../Player").JUMP_VELOCITY = -375
					
					comboColor = Color(255.0, 150.0, 0.0, 1.0) # laranja
					get_node("../../UI/Combo").set("theme_override_colors/font_color", comboColor) # laranja
					
				5:
					get_node("../Player").SPEED = 300
					get_node("../Player").JUMP_VELOCITY = -400
					
					comboColor = Color(255, 0, 0, 1) # vermelho
					get_node("../../UI/Combo").set("theme_override_colors/font_color",comboColor)
					
