class_name EnemyIdle
extends State

@export var enemy: CharacterBody2D
@export var speed: float = 50
@export var frontRayCast: RayCast2D
@export var backRayCast: RayCast2D
@export var timer: Timer

var directionX: int
var time: float
var player: Player


		#-1 for LEFT
		# 1 for RIGHT
		# 0 for STOP

func wander():
		if !(frontRayCast.is_colliding() && backRayCast.is_colliding()) && timer.time_left == 0 && timer.is_stopped():
			directionX = -1 if directionX > 0 else 1
			time = randf_range(0.5,1 )
		else: 
			directionX = randi_range(-1,1)
			time = randf_range(1,2)
func _enter():
	timer.start(1)
	player = get_tree().get_first_node_in_group("player")
	
func _update(delta):
		
		#print(time)
		
		if !(frontRayCast.is_colliding() && backRayCast.is_colliding()) && timer.time_left == 0:
			wander()
			timer.start(1)
		else:
			if time >0:
				time -= delta
			else: wander()
	
func _physics_update(delta):
	
	
	
	var direction = sign(player.global_position.x - enemy.global_position.x)
	
	#print(player.global_position)
	if enemy:
		enemy.velocity.x = directionX * speed
		
			
			
	#print(time, "the time")
