extends Node2D
signal triggerTrap

@export var speed: float

@onready var trapColliderRef : Area2D = $Trap
@onready var animationPlayerRef: AnimationPlayer = $AnimationPlayer




func bodyEnteredHandler(body):
	if body is Player:
		triggerTrap.emit(body)
		
		

func _ready():
	trapColliderRef.body_entered.connect(bodyEnteredHandler)
