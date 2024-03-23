extends Node2D
@onready var DeathzoneRef = $Deathzone 
@onready var SpawnPoints = $SpawnPoints
@onready var MainSpawnPoint = $SpawnPoints/startPoint
@onready var trap = $Traps/enemy


func playerFallHandler(body):
	body.velocity = Vector2.ZERO;
	
	## Get the closest respawnPoint position and then set the body position there when "Body entered is triggered"
	var spawnPoints = SpawnPoints.get_children()
	var spawnPointsLocation = spawnPoints.map(func(position): return position.global_position.x )
	var closest = spawnPointsLocation.reduce(func(prev, curr):  return curr if abs(curr - body.global_position.x) < abs(prev - body.global_position.x) else prev)
	var closestLocation:Array = spawnPoints.filter(func(pos): return pos.global_position.x == closest)
	body.global_position= closestLocation[0].global_position
	

func triggerTrapHandler(body):
	if body is Player:
		body.staminaReset()
		body.global_position = MainSpawnPoint.global_position
	


func _ready():
	DeathzoneRef.connect("body_entered", playerFallHandler )
	trap.connect("triggerTrap",triggerTrapHandler)
	
func _process(_delta):
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene();
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	
		
	
		
