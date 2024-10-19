extends CharacterBody2D

# variável que armazena o valor de vida do Player
@export var health = 1
@export var coins = 0
@export var isDying = false

var songPlayed=false

# constante global usada para definir a velocidade de movimento
# do personagem ao usar inputs de movimento
@export var SPEED = 100.0

var alive = true

# constante global usada para definir velocidade instantânea do
# pulo do personagem
var JUMP_VELOCITY = -300.0

# usando a anotação onready, é buscado no momento de iniciar o jogo
# o nodo AnimationPlayer, que é responsável por administrar
# as animações contextualmente
@onready var anim = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D



# ready é executado somente 1 vez ao iniciar o jogo
func _ready():
	print("iniciando...")
	collision_shape_2d.disabled = false

# a função _physics_process administra as forças que afetam
# as entidades com propriedades físicas, recebendo como parâmetro
# o valor flutuante delta, que nesse módulo em si é constante, ao 
# contrário de _process(), que não é constante
func _physics_process(delta):	
	
	# isso aqui ficou uma bosta
	if !alive:
		velocity.x = 0
		$CollisionShape2D.set_deferred("disabled", true)
		$".".set_deferred("disabled", true)
	
	# eu ia fazer a implementação de um menu usando os nodos de UI incluídos
	# na Godot, mas a essa altura com tudo que tá acontecendo ao meu redor é
	# mais fácil eu engatinhar no rodapé e comer reboco da parede
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://main.tscn")
		
	# isso aqui tá horrível!!! socorro
	if health <= 0:
		
		# fun fact: esqueci dessa booleana ao implementar as chamadas
		# com a variável "alive". ela basicamente indica a mesma coisa,
		# porém gastando o dobro de memória :)
		isDying = true
		velocity = Vector2(0,0)
		
		# função que faz com que todas as colisões do CollisionShape2D
		# sejam desativadas
		# collision_shape_2d.disabled = true
		
		anim.play("death")
		
		await get_tree().create_timer(1,true,true,false).timeout
		get_tree().change_scene_to_file("res://main.tscn")
	
	# se não estiver no chão, adiciona força de gravidade
	# diretamente no player
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# se pressionar o botão de pulo, substitui o valor atual
	# da velocidade vertical para o impulso atribuído pela
	# constante "JUMP_VELOCITY"
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		get_node("AudioStreamPlayer2D").play()
	
	if alive:
		# o valor de direção alterna entre os valores "-1, 0 e 1",
		# sendo -1 esquerda e 1 direita, e usa os inputs "move_left" e
		# "move_right" em seus parâmetros para futuramente definir a
		# direção de movimento do personagem. isso foi definido em
		# project > project settings > input
		var direction := Input.get_axis("move_left", "move_right")
		
		# caso a direção seja -1, inverte o sentido da animação
		# em andamento no nodo "AnimatedSprite2D".
		# por padrão, o valor atribuído é 1, pois os sprites
		# desenhados olhando para a direita.
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false
		
		# usando o valor retornado pelo método get_axis(String[]),
		# é aplicada a direção de velocidade do personagem, usando o
		# valor de direção (-1, 0 ou 1) para multiplicar pela velocidade
		# atual do personagem
		if(direction):
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("run")
		
		# caso não haja inputs, o jogador torna a desacelerar até
		# alcançar o valor 0, e passa então a executar a animação
		# idle
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				anim.play("idle")
	else:
		velocity.x = 0
	
	# caso o personagem esteja em queda (aumento do valor y),
	# independente se tiver sido originado da ação pulo ou não,
	# inicia a animação de queda
	if velocity.y > 0:
		anim.play("fall")
	
	move_and_slide()

# essa verificação zera manualmente a velocidade vertical do Player,
# pois sua colisão está em layer diferente da bola por motivos de
# física (caso os dois estejam colidindo, a força da bola em
# move_and_collide é aplicada para baixo, como reação do contato com
# o jogador
func _on_ball_collision_area_body_entered(body):
	if body.name == "bola":
		velocity = Vector2.DOWN * 0
