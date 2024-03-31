class_name EnemyIdle
extends State

@export var enemy: CharacterBody2D
@export var speed: float = 50
@export var frontRayCast: RayCast2D
@export var backRayCast: RayCast2D
@export var timer: Timer

var directionX: int
var time: float
var wait: float  = 0


		#-1 for LEFT
		# 1 for RIGHT
		# 0 for STOP


func test():
	directionX = -1 if directionX > 0 else 1
	print("test")

func resetWait():
	wait = 0

func wander():
		print(timer.is_stopped(), "is timout stoped?")
		print(timer.time_left == 0, "is timer left 0? ", timer.time_left == 0 )
		print(!(frontRayCast.is_colliding() && backRayCast.is_colliding()), "is not about to fall?" )
		if !(frontRayCast.is_colliding() && backRayCast.is_colliding()) && timer.time_left == 0 && timer.is_stopped():
			test()
			timer.timeout.connect(resetWait)
			time = randf_range(1,2)
		else :
			directionX = randi_range(-1,1)
			print("time 0")
			time = randf_range(1,2)
			
			
		#print(timer.time_left, "time left")
			
		#else:
			#print("colliding")
			#directionX = randf_range(-1,1)
func _enter():
	timer.start(1)
	
func _update(delta):
		if time >0:
			time -= delta
		else: wander()
		
		if wait >0:
			wait -= delta
		
		if !(frontRayCast.is_colliding() && backRayCast.is_colliding()) && timer.time_left == 0 && wait == 0:
			wander()
			timer.start(1)
			print("run")
			wait = 0.5
		
		
	
	
func _physics_update(delta):
	if enemy:
		enemy.velocity.x = directionX * speed
		
			
			
	#print(time, "the time")
