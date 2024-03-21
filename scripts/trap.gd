extends Node2D
signal triggerTrap

@onready var trapColliderRef = $Trap
@onready var trapAttackScene = preload("res://scenes/trap_attack.tscn")



func bodyEnteredHandler(body):
	if body is Player:
		emit_signal("triggerTrap", body)
		
func attack():
	var trapAttackInstance = trapAttackScene.instantiate()
	trapAttackInstance.global_position = global_position
	trapAttackInstance.global_position.y = global_position.y -20
	add_child(trapAttackInstance)
	

func _ready():
	trapColliderRef.connect("body_entered", bodyEnteredHandler)
