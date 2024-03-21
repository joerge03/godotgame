extends Area2D



@onready var animated_sprite = $jumpPadTexture


#@onready 

func areaEnteredHandler(body):
	if body is Player:
		body.velocity.y = - 400
		animated_sprite.play("Jump")



func _ready():
	animated_sprite.play("Idle")
	connect("body_entered", areaEnteredHandler)
