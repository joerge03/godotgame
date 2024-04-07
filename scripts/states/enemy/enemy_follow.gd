class_name EnemyFollow
extends State

@export var enemy: CharacterBody2D
@export var followRayCast: RayCast2D
@export var animationPlayer: AnimationPlayer

var player: Player

var enemyClass = EnemyClass.new()
 

func go_to_attack():
	print("test atatatatata")
	is_transition.emit(self,"EnemyAttack")

func _enter():
	player = get_tree().get_first_node_in_group("player")
	if animationPlayer && animationPlayer.get_animation("run"):
		animationPlayer.play("run")
	
	if enemy:
		enemy.open_shoot.connect(go_to_attack)
	
func _physics_update(delta):
	var direction = sign(player.global_position.x - enemy.global_position.x)
	if followRayCast && followRayCast.get_collider() is Player:
		enemy.velocity.x = direction * enemyClass.enemy_run_speed  
	else: 
		print("test")
		is_transition.emit(self, "EnemyIdle")
	
	
	
	
	
	


