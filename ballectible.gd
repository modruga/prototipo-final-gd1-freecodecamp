extends Node2D

var collectible = true

func _ready():
	$AnimatedSprite2D.play("idle")

func _on_area_2d_body_entered(body):
	
	if collectible:
		if body.name == "Bola":
			body.bolaCoins += 1
			collectible = false
			queue_free()
