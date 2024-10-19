extends Area2D

# feito às pressas, tudo que entrar no Area2D referente à quedas do mapa
# tem seu HP zerado, e no caso da entidade Player, essa condição de 
# derrota envia o jogador direto ao menu principal 
func _on_body_entered(body):
	
	# detecta o nome do corpo do jogador, altera seu valor booleano "alive"
	# para negativo, pausa a música de fundo e toca a música de morte
	if body.name == "Player":
		body.alive = false
		get_node("../BGM").stop()
		get_node("AudioStreamPlayer2D").play()
		
		# eu tenho CERTEZA que não devia ter feito isso aqui
		await get_tree().create_timer(2.0,true,true,false).timeout
	
		# essa informação se torna redundante a partir do momento que, apesar
		# do Player possuir um valor "morto" ou "não morto", existem
		# escrúpulos de um código feito em estado de mania onde verifica se
		# a vida está igual ou menor a zero
		body.health = 0;
		
