class_name EnemyAttack
extends State


@export var animation_player: AnimationPlayer
@export var enemy: CharacterBody2D
@export var line_of_sight: ShapeCast2D
@export var timer_def:= 0.2



var timer



func _enter():
	animation_player.play("shoot")
	timer = timer_def
	
	print("attack")
func _physics_update(delta):
	enemy.velocity.x = 0
	if timer >0:
		timer -= delta
		print(timer)
	elif enemy && line_of_sight && line_of_sight.is_colliding() && line_of_sight.get_collider(0) is Player:
		animation_player.play("shoot")
		print("shoot")
	else:
		print("transition to enemy idle")
		is_transition.emit(self, "EnemyIdle")



