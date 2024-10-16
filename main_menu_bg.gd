extends ParallaxBackground

var offset_x1 = 0.1
var offset_x2 = 0.5
var offset_x3 = 1

func _physics_process(delta):
	
	get_node("ParallaxLayer2").set_motion_offset(Vector2(offset_x1,0))
	get_node("ParallaxLayer").set_motion_offset(Vector2(offset_x2,0))
	get_node("ParallaxLayer3").set_motion_offset(Vector2(offset_x3,0))
	offset_x1 += 0.1
	offset_x2 += 0.3
	offset_x3 += 2
