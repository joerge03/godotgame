class_name EnemyFollow
extends State

@export var enemy: CharacterBody2D
@export var speed: float

var player: Player
var radius
 

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	
	
	
func _update(delta):
	radius = player.global_position.x - enemy.global_position.x
	
	
	
	
	
	


