class_name EnemyIdle
extends State

@export var enemy: CharacterBody2D
@export var frontRayCast: RayCast2D
@export var backRayCast: RayCast2D
@export var lineOfSightCast: RayCast2D
@export var timer: Timer
@export var animationPlayer: AnimationPlayer

var directionX: int
var time: float
var player: Player
var enemyClass =  EnemyClass.new()


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
	timer.start(0.2)
	player = get_tree().get_first_node_in_group("player")
	print(animationPlayer.get_animation("idle"))
	if animationPlayer && animationPlayer.get_animation("idle"):
		print("idle")
		animationPlayer.play("idle")
	if enemy:
		enemy.open_shoot.connect(func(): 
			is_transition.emit(self, "EnemyAttack")
			print("emited")
			)
	
func _update(delta):
		var isOnEdge = !(frontRayCast.is_colliding() && backRayCast.is_colliding())
		if !(frontRayCast.is_colliding() && backRayCast.is_colliding()) && timer.time_left == 0:
			wander()
			timer.start(1)
		else:
			if time >0:
				time -= delta
			else: wander()
	
func _physics_update(delta):
	
	var direction = sign(player.global_position.x - enemy.global_position.x)
	if lineOfSightCast.get_collider() is Player:
		directionX = direction  
		is_transition.emit(self, "EnemyFollow")
		
	#CHECKS IF "PLAYER" is IN sight, if it's in sight enemy will follow
	if enemy:
		enemy.velocity.x =  directionX * enemyClass.enemy_walk_speed
		#Checks if the player is in range to shoot
		
		
		
		
			
