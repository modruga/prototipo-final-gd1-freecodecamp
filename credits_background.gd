extends ParallaxBackground

# variável global scrollingSpeed, que é responsável por
# agir como multiplicador ao atribuirmos valor ao método
# scroll_offset.x, que determina o movimento horizontal
# relativo do parallax usado na criação das camadas
# do background
var scrollingSpeed = 5

func _process(delta):
	
	# multiplicação do valor do offset ditada pelo delta
	scroll_offset.x -= scrollingSpeed * delta
	
	# (não entendi direito a parte de inverter/mirror do bg)
