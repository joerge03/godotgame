class_name EnemyAttack
extends State


@export var animation_player: AnimationPlayer
@export var enemy: CharacterBody2D
@export var line_of_sight: ShapeCast2D
@export var timer_def:= 1


var timer



func _enter():
	if animation_player && animation_player.get_animation("shoot"):
		animation_player.play("shoot")
		timer = timer_def
	pass
	
func _update(delta):
	pass

func _phsics_update(delta):
	if timer >0:
		timer -= delta
	elif enemy && line_of_sight && line_of_sight.get_collider(0) is Player: 
		animation_player.play("shoot")
	else: is_transition.emit(self, "EnemyIdle")



