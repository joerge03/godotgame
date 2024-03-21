extends Area2D
class_name TrapAttack


signal enemyHitPlayer

@onready var animation = $AnimatedSprite2D



func playerHit(body):
	if body as Player:
		emit_signal("enemyHitPlayer", body)
		queue_free()
	elif body:
		queue_free()
	
	

func _ready():
	connect("body_entered", playerHit )
	animation.play("attack")
	
	
func _process(delta):
	if animation.frame == 7:
		queue_free()
		
func flipSprite(isTrue: bool  = animation.flip_h):
	animation.flip_h = isTrue
	return animation.flip_h
		
func _physics_process(delta):
	if animation.flip_h == true:
		#print_debug("flipped")
		global_position.x = global_position.x - (100 * delta)
	else :
		#print_debug("not_flipped")
		global_position.x = global_position.x + (100 * delta)
		
	
	
	
	
