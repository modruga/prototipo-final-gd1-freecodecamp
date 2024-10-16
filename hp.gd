extends Label

func _ready():
	pass

func _process(delta):
	
	# o texto da label deve importar o valor de vida atual da entidade
	# Player, e para fazer isso é necessário importar o nodo (através do
	# método get_node) fazendo um cast para String com indentação
	text = "HP: " + str(get_node("../../Player/Player").health)
