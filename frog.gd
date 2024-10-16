extends CharacterBody2D

# esse script é responsável pelo comportamento do inimigo Frog,
# lidando com tarefas cruciais como determinação de seu módulo e direção
# de velocidade, comportamento em relação ao jogador, área de detecção, etc.

# o método get_setting do objeto de acesso global ProjectSettings é
# capaz de importar valores determinados em escopo de projeto, que é
# o caso do valor de gravidade, presente no endereço enviado como
# parâmetro em formato String, atribuído à variável global gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# variável que servirá como âncora para receber o endereço do nodo Player
# para acessar os métodos relacionados ao corpo do jogador
var player

var jumpSPEED = 100

@onready var collision_shape_2d = $CollisionShape2D
@onready var PlayerDetection = $FrogHit/CollisionShape2D
@onready var FrogHit = $FrogCollision/CollisionShape2D
@onready var FrogCollision = $FrogCollision/CollisionShape2D

# variável global booleana que agirá em conjunto com as conexões de nodo
# "_on_area_2d_body_entered" e "_on_area_2d_body_exited" com a área
# determinada pelo collisionShape presente em PlayerDetection 
var chase = false

# variável SPEED que serve como multiplicador para o módulo de velocidade
# do Frog, agindo em conjunto com a variável interna "direction", que determina
# sua direção de movimento
var SPEED = 50

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	
	# variável gravity usando o valor da configuração global do projeto
	# como multiplicador (em conjunto à delta) para agir sob a
	# velocidade no eixo y do Frog
	velocity.y += gravity * delta
	
	# atribuição de valor interna da função à variável Player que
	# usa como referência o endereço do nodo Player que está presente
	# em World, no endereço (em formato String) encontrado em sua
	# instância Local da cena World.
	player = get_node("../../Player/Player")
	
	# variável direction determina a direção que Frog estará olhando
	# e consequentemente se movendo baseado na diferença entre sua posição
	# e a do jogador
	var direction = (player.position - self.position).normalized()
	
	# caso o jogador esteja no alcance do CollisionShape2D da Area2D
	# "PlayerDetection", em suas respectivas funções "_on_body_entered" e
	# "_on_body_exited", a flag booleana "chase" alterará seu valor entre
	# verdadeiro e falso
	if chase == true:
		if direction.x > 0:
			
			# tá sentindo esse cheirinho? a origem desse odor fétido vem
			# do fato que estamos prestes a adentrar 4 CAMADAS DE CÓDIGO
			# ENCAPSULADO. se eu mostrasse isso pra qualquer desenvolvedor
			# de qualquer área onde legibilidade de programas extensos é
			# crucial, seria executado em praça pública.
			if chase == true:
				
				# verifica se a animação em andamento não é a de morte
				# caso não haja essa verificação, o trigger para liberação
				# de memória ao acertar o inimigo não aciona
				if get_node("AnimatedSprite2D").animation != "death":
					print("chasing right")
					get_node("AnimatedSprite2D").flip_h = true
					get_node("AnimatedSprite2D").play("jump")
					velocity.x = direction.x * SPEED
		
		else:
			if chase == true:
				
				# a mesma verificação de animação de morte está presente aqui,
				# com certeza tem uma forma menos burra de fazer isso
				if get_node("AnimatedSprite2D").animation != "death":
					print("chasing left")
					get_node("AnimatedSprite2D").flip_h = false
					get_node("AnimatedSprite2D").play("jump")
					velocity.x = direction.x * SPEED
	
	
	# caso o corpo tenha saído do alcance do PlayerDetection, a função
	# "_on_body_exited" atribuirá o valor false à flag "chase", e a
	# execução sairá das condições de perseguição acima, resultando na
	# necessidade de zerar a velocidade do Frog
	else:
		
		# a lógica do programa-exemplo do freeCodeCamp não devia
		# ter esse tipo de comprometimento, mas funciona, e é o que
		# importa, eu acho
		if get_node("AnimatedSprite2D").animation != "death":
			velocity.x = 0
			get_node("AnimatedSprite2D").play("idle")
	
	# ainda não entendi o que isso faz mas aparentemente nada relacionado ao
	# movimento do corpo funciona se não incluir essa bodega
	move_and_slide()

# ligação com o nodo-filho de Frog, vinda de "PlayerDetection", que é
# um Area2D vinculado a um CollisionShape2D circular que envolve
# uma área considerável em volta do Frog, e a mesma detecta o contato com
# outros corpos 2D. essa ligação é criada na aba "Node" na mesma área
# do inspetor.
func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
		
		# imprime o retorno do método global_position da instância Player
		# presente na cena World.
		chase = true

# também ligado nodo-filho PlayerDetection, essa função realiza a
# tarefa oposta da função anterior, notificando o sistema de que o
# corpo do jogador deixou a área de detecção de Frog
func _on_player_detection_body_exited(body):
	
	if body.name == "Player":
		chase = false

# essa ligação vem do nodo area2D vinculado à CollisionShape2D localizada
# em cima do Frog, e o código queue_free() é basicamente uma liberação
# de alocação de memória que determina o fim da vida útil da entidade
# Frog. descanse em paz guerreiro
func _on_frog_hit_body_entered(body):
	if body.name == "Player":
		
		$DeathSound.play()
		$AnimatedSprite2D.play("death")
		
		#---------------------------------------------------#
		
		# tentativa falha de tentar se livrar do Area2D e suas respectivas
		# hitboxes mas percebi que eu não posso fazer isso dentro de uma
		# conexão de Node2D afinal isso destruiria a própria conexão então
		# no fim só acabei me sentindo burro mesmo
		
		# var collision_shape_2d = $CollisionShape2D
		# var PlayerDetection = $FrogHit/CollisionShape2D
		# var FrogHit = $FrogCollision/CollisionShape2D
		# var FrogCollision = $FrogCollision/CollisionShape2D
		# var areaFrogHit = $FrogHit
		
		# collision_shape_2d.disabled = true
		# FrogHit.disabled = true
		# FrogCollision.disabled = true
		# PlayerDetection.disabled = true
		
		# como CARALHOS eu me livro desse hit duplo? é uma questão
		# da própria estrutura? eu devia ter implementado essa forma
		# de matar a entidade de um jeito diferente? SOCORRO
		
		#---------------------------------------------------#
		
		# ao acertar o hurtbox do Frog, a entidade Player recebe um valor
		# de velocidade instantânea y = -200 para dar um efeito de
		# "quicada"
		body.velocity.y = -250
		
		# no mundo da programação amadora, nos primeiros semestres da
		# computação, somos ensinados a nunca, jamais, dependermos de
		# qualquer sistema de "espera" hard-codado num programa. mas
		# quebrar esse ensinamento foi MUITO satisfatório.
		# o método "animation_finished" envia um sinal que indica que
		# a animação terminou, e dessa forma podemos esperar a explosão
		# acabar antes da entidade ser jogada ao shadow realm.
		await $AnimatedSprite2D.animation_finished
		
		queue_free()
		# não adianta mais querer voltar atrás. o sapo morreu. e a culpa
		# é toda sua.
		

# caso o jogador entre na área determinada pelo nodo FrogCollision, 
# seu atributo "health" é subtraído em 3
func _on_frog_collision_body_entered(body):
	if body.name == "Player":
		body.health = 0
