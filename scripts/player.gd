extends CharacterBody2D
class_name Player


@onready var jump_timer = $Jump_timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var animationPlayer = $AnimationPlayer
@onready var attack_collision: Area2D = $attack
@onready var attackSprite:= $attackSprite


var states: Dictionary = {}



@export var gravity := 400

@export var speed := 200

@export var run := speed+ 100

@export var jumpForce := -200

@export var defaultStamina := 700

var stamina = defaultStamina

var timer: float = 4


func staminaReset():
	stamina = defaultStamina
	jump_timer.stop()

func _ready():
	attack_collision.position = Vector2(30, -25)
	
	
func _process(delta):
	
	#STAMINA RESETER WHEN GET ENOUGH REST (YOU SHOULD TOO!)
	
	if timer > 0:
		print(timer)
		timer -= delta
	elif stamina != defaultStamina :
		print("test")
		staminaReset()


func _physics_process(delta):
	var direction = Input.get_axis("left","right")

	var isMovement = direction== -1 || direction == 1
	
	#print(stamina, "stamina")
	#print(timer, "timer")


	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y >= 600:
			velocity.y = 600
	## Gravity
	velocity.x = direction * speed

	if Input.is_action_pressed("run") && isMovement:
		velocity.x = direction * run


	if Input.is_action_pressed("up") && is_on_floor():
		# Check if there is stamina to jump
		timer = 4
		if stamina <= 0 && jump_timer.time_left == 0:
			if !jump_timer.timeout.is_connected(staminaReset):
				jump_timer.connect("timeout", staminaReset)
			jump_timer.start()
		elif stamina >=100:
			stamina -= 100
			velocity.y = jumpForce



	updateAnimation(direction, isMovement)




	#Animation for run
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("attack"):
		animationPlayer.play("attack")


func updateAnimation(direction, isMovement):
	if direction != 0:
		animated_sprite.flip_h = direction == -1
		
		attackSprite.flip_h = animated_sprite.flip_h 
		attack_collision.position.x = -abs(attack_collision.position.x) if animated_sprite.flip_h else abs(attack_collision.position.x)
		#if animated_sprite.flip_h:
			#attack_collision.position.x = -abs(attack_collision.position.x)
			#attackSprite.flip_h = true
		#else:
			#attack_collision.position.x = abs(attack_collision.position.x)

	if !is_on_floor():
		animated_sprite.play("Jump")
		return
	if Input.is_action_pressed("run") && isMovement:
		animated_sprite.play("Run")
	elif isMovement && is_on_floor():
		animated_sprite.play("Walk")
	if !direction && is_on_floor():
		animated_sprite.play("Idle")


