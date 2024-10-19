extends Node2D

# bit que serve como flag para que a mesma moeda instanciada não
# possa ser coletada mais de uma vez
var collectable = true

# pré-instrui a engine a iniciar a animação idle da moeda
# esse spritesheet não possui animação de coleta, porém, acho
# que é o que vai acabar indo pro projeto final
func _ready():
	$AnimatedSprite2D.play("idle")
	pass

func _on_area_2d_body_entered(body):
	
	# caso seja a primeira vez que a moeda detecte o corpo
	# do jogador, entra na condicional o valor booleano positivo
	if collectable:
		
		if body.name == "Player":
			
			# torna o valor booleano negativo, para que não entre
			# mais nesse escopo após a primeira detecção do corpo
			collectable=false
			
			# atributo de moedas localizada na cena Player recebe
			# +1
			body.coins += 1
			$AnimatedSprite2D.visible = false
			$AudioStreamPlayer2D.play()
			
			# aguarda o fim do som de coleta
			await $AudioStreamPlayer2D.finished
			
			# adeus moedinha
			queue_free()
		
	
