extends Label

# essa função envia à cena World o valor atual do combo 
# de "quicadas" da bola com jogador no ar, através de uma
# chamada ao nodo com casting String para endentação no texto 
# presente no label
func _process(delta):
	text = "COMBO: " + str(get_node("../../Player/Bola").combo)
