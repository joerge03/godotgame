class_name EnemyIdle
extends State

@export var enemy: CharacterBody2D
@export var speed: float = 100

var directionX: float
var time: float


func wander():
	directionX = randf_range(-1,1)
	time = randf_range(1,5)
	


func _enter():
	wander()
	
func _update(delta):
	#print(time)
	if time >= 0:
		time -= delta
	else:
		wander()
		
func _physics_update(delta):
	if enemy:
		enemy.velocity.x = directionX * speed
