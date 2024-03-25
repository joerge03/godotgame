class_name LifeComponent
extends Area2D

@export var health := 10

var default_health: float



func _ready():
	default_health = health


func damage(attack: Attack):
	health -= attack.attack_damage
	if default_health <= 0:
		get_parent().queue_free()


