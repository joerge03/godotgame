class_name EnemyFollow
extends State

@export var enemy: Enemy
@export var followRayCast: RayCast2D
@export var animationPlayer: AnimationPlayer

var player: Player

var enemyClass = EnemyClass.new()
 

func go_to_attack():
	print("test atatatatata")
	is_transition.emit(self,"EnemyAttack")

func _enter():
	print("follow")
	player = get_tree().get_first_node_in_group("player")
	
	if !enemy.open_shoot.is_connected(go_to_attack):
		enemy.open_shoot.connect(go_to_attack)
		
	if animationPlayer && animationPlayer.get_animation("run"):
		animationPlayer.play("run")
	
func _physics_update(delta):
	## VARIABLES
	# To know which direction enemy should go when he see's the player
	var direction = sign(player.global_position.x - enemy.global_position.x)
	
	# Check if the enemy is in range, if it is then go follow If not then go back to idle
	if followRayCast && followRayCast.is_colliding() && followRayCast.get_collider() is Player:
		enemy.velocity.x = direction * enemyClass.enemy_run_speed  
	else:
		is_transition.emit(self, "EnemyIdle")
	
	
	
	
	
	


