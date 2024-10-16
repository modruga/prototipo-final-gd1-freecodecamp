extends Area2D

# feito às pressas, tudo que entrar no Area2D referente à quedas do mapa
# tem seu HP zerado, e no caso da entidade Player, essa condição de 
# derrota envia o jogador direto ao menu principal 
func _on_body_entered(body):
	
	if body.name == "Player":
		get_node("../BGM").stop()
		get_node("AudioStreamPlayer2D").play()
		
		# eu tenho CERTEZA que não devia ter feito isso aqui
		await get_tree().create_timer(2.0,true,true,false).timeout
	
		body.health = 0;
		
