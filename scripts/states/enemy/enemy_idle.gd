class_name EnemyIdle
extends State

@export var enemy: Enemy
@export var frontRayCast: RayCast2D
@export var backRayCast: RayCast2D
@export var followRaycast: RayCast2D
@export var lineOfSight: ShapeCast2D
@export var timer: Timer
@export var animationPlayer: AnimationPlayer

var directionX: int
var time: float
var player: Player
var enemyClass =  EnemyClass.new()


		#-1 for LEFT
		# 1 for RIGHT
		# 0 for STOP

func transitionToAttack():
	is_transition.emit(self, "EnemyAttack")

func wander():
		if !(frontRayCast.is_colliding() && backRayCast.is_colliding()) && timer.time_left == 0 && timer.is_stopped():
			directionX = -1 if directionX > 0 else 1
			time = randf_range(0.5,1 )
		else:
			directionX = randi_range(-1,1)
			time = randf_range(1,2)
			
func _enter():
	print("idle")
	player = get_tree().get_first_node_in_group("player")
	if !enemy.open_shoot.is_connected(transitionToAttack):
		enemy.open_shoot.connect(transitionToAttack)
	if animationPlayer && animationPlayer.get_animation("idle"):
		print("idle")
		animationPlayer.play("idle")
	
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
	
	## VARIABLES	
	# direction to move "where" the enemy is
	var direction =  sign(player.global_position.x - enemy.global_position.x)
		
	if enemy:
		enemy.velocity.x =  directionX * enemyClass.enemy_walk_speed
	
	if followRaycast.is_colliding() && followRaycast.get_collider() is Player:
		directionX = direction
		is_transition.emit(self, "EnemyFollow")
	#CHECKS IF "PLAYER" is IN sight, if it's in sight enemy will follow

		
		
		
		
			
