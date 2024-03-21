extends Area2D



func playerHit(body):
	if body as Player:
		body.queue_free()
	

func _ready():
	connect("body_entered", playerHit )
