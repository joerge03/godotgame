extends Area2D


@export var attack_damage: float = 1
var attackDamage = Attack.new()
	

func attack(body):
	if body is HitBox:
		
		body.damage(attackDamage)

func _ready():
	attackDamage.attack_damage = attack_damage
	
	area_entered.connect(attack)
