extends Node2D
signal triggerTrap

@onready var trapColliderRef : Area2D = $Trap
@onready var animationPlayerRef: AnimationPlayer = $AnimationPlayer



func bodyEnteredHandler(body):
	if body is Player:
		triggerTrap.emit()
		
		

func _ready():
	trapColliderRef.body_entered.connect(bodyEnteredHandler)
	animationPlayerRef.play("spin")
