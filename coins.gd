extends Label

func _process(delta):
	
	# o texto da label deve importar o valor de moedas da entidade
	# Player, e para fazer isso é necessário importar o nodo (através do
	# método get_node) fazendo um cast para String com indentação
	text = "COINS: " + str(get_node("../../Player/Player").coins)
