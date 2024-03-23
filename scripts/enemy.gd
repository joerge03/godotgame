extends CharacterBody2D
signal triggerTrap

@onready var enemyBodyRef= $enemyBody
@onready var trapAttackScene = preload("res://scenes/trap_attack.tscn")
@onready var attackPointRef = $attackPoint
@onready var animationPlayer = $AnimationPlayer
@onready var lineOfSightRef = $lineOfSight
@onready var sprite2d = $Sprite2D
@onready var attackCooldown = $attackCooldown8
#@onready var trapAttackInstance = $trap_attack

func bodyEnteredHandler(body):
	if body is Player:
		print("sdfasdfasdf")
		emit_signal("triggerTrap", body)
		
func idle():
	animationPlayer.play("idle")

func attack():
	var lineOfSiteValue: Player
	var isPlayerLeft 
	var trapAttackInstance: TrapAttack = trapAttackScene.instantiate()
	if lineOfSightRef.is_colliding() && lineOfSightRef.get_collider(0) is Player:
		lineOfSiteValue = lineOfSightRef.get_collider(0)
		isPlayerLeft =  global_position.x > lineOfSiteValue.global_position.x
		
		trapAttackInstance.enemyHitPlayer.connect(bodyEnteredHandler)
		attackPointRef.add_child(trapAttackInstance)
	else:
		attackCooldown.stop() 
		return
		
		
	trapAttackInstance.global_position.y = global_position.y + 10
	if isPlayerLeft:
		trapAttackInstance.flipSprite(true)
		trapAttackInstance.global_position.x = global_position.x - 20
	else:
		trapAttackInstance.global_position.x = global_position.x + 30
		trapAttackInstance.flipSprite( false)


		
func _process(_delta): 
	#TO FOLLOW THE ENEMY RAYCAST
	lineOfSightRef.scale.y =  -lineOfSightRef.scale.y if sprite2d.flip_h else abs(lineOfSightRef.scale.y)  
		
	

func _physics_process(_delta):
	# VARIABLES
	var line_of_sight_scale_y = lineOfSightRef.scale.y
	
	# CHECK IF IS COLLIDING WITH PLAYER
	var isCollidingWithPlayer = lineOfSightRef.is_colliding() && lineOfSightRef.get_collider(0) is Player
	
	
	
	if  isCollidingWithPlayer && attackCooldown.is_stopped() && attackCooldown.time_left == 0:
		
		# SET IF THE ENEMY IS LOOKING LEFT OR RIGHT
		var player:Player = lineOfSightRef.get_collider(0)
		sprite2d.flip_h = global_position.x > player.global_position.x
		
		# START THE SHOOT ANIMATION
		animationPlayer.play("shoot")
		attackCooldown.start()
	elif !isCollidingWithPlayer:
		attackCooldown.stop()
	
func _ready():  
	enemyBodyRef.connect("body_entered", bodyEnteredHandler)
	get_tree().get_nodes_in_group("enemy")
	
	#attackCooldown.connect("timeout", attack)
	
	#pass
