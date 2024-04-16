class_name Enemy
extends CharacterBody2D
signal triggerTrap
signal open_shoot

@onready var enemyBodyRef= $HitBox
@onready var trapAttackScene = preload("res://scenes/trap_attack.tscn")
@onready var attackPointRef = $attackPoint
#@onready var animationPlayer = $AnimationPlayer
@onready var lineOfSightRef = $lineOfSight
@onready var sprite2d = $Sprite2D
@onready var attackCooldown = $attackCooldown
@onready var frontRayCast = $frontFloorCast
@onready var backRayCast = $backFloorCast
@onready var followRayCast = $followRayCast

func bodyEnteredHandler(body):
	if body is Player:
		emit_signal("triggerTrap", body)
var lineOfSiteValue: Player
var isPlayerLeft: bool
		
func idle():
	#animationPlayer.play("idle")
	pass
	

func attack():
	var trapAttackInstance: TrapAttack = trapAttackScene.instantiate()
	
	trapAttackInstance.enemyHitPlayer.connect(bodyEnteredHandler)
	attackPointRef.add_child(trapAttackInstance)
	#else:
		#attackCooldown.stop()
		#return
		
		
	trapAttackInstance.global_position.y = global_position.y + 8
	if isPlayerLeft:
		trapAttackInstance.flipSprite(true)
		trapAttackInstance.global_position.x = global_position.x - 10
	else:
		trapAttackInstance.global_position.x = global_position.x + 15
		trapAttackInstance.flipSprite(false)


		
func _process(_delta):
	#TO FLIP THE LINEOFSIGHT raycast with sprite2d
	if sprite2d.flip_h:
		lineOfSightRef.scale.y = -lineOfSightRef.scale.y 
		lineOfSightRef.position.x = -abs(lineOfSightRef.position.x) 
	else:
		lineOfSightRef.position.x = abs(lineOfSightRef.position.x) 
		lineOfSightRef.scale.y = abs(lineOfSightRef.scale.y)  
		
	

func _physics_process(_delta):
	move_and_slide()
	# VARIABLES
	var line_of_sight_scale_y = lineOfSightRef.target_position.x
	var follow_ray_cast_scale_y = followRayCast.target_position.x
	
	  
	
	if !is_on_floor():
		velocity.y += 100 * _delta
		if velocity.y >= 600:
			velocity.y = 600
	if velocity.x != 0:
		sprite2d.flip_h = velocity.x < 0
		 
		lineOfSightRef.target_position.x = -abs(line_of_sight_scale_y) if sprite2d.flip_h else abs(line_of_sight_scale_y) 
		followRayCast.target_position.x = -abs(follow_ray_cast_scale_y) if sprite2d.flip_h else abs(follow_ray_cast_scale_y)
		
		
		
	
	# CHECK IF IS COLLIDING WITH PLAYER
	if lineOfSightRef.is_colliding() && lineOfSightRef.get_collider(0) is Player:
		var player: Player = lineOfSightRef.get_collider(0)
		open_shoot.emit()
		lineOfSiteValue = lineOfSightRef.get_collider(0)
		isPlayerLeft =  global_position.x > lineOfSiteValue.global_position.x
	#CHECK IF ENEMY IS FALLING
	if !frontRayCast.is_colliding() || !backRayCast.is_colliding():
		velocity.x = abs(velocity.x) if velocity.x < 0 else -abs(velocity.x) 
	
		
		
	
func _ready():  
	enemyBodyRef.connect("body_entered", bodyEnteredHandler)
