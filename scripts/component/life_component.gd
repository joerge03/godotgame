class_name LifeComponent
extends Node2D

@export var health := 10

var default_health: float



func _ready():
	default_health = health


func damage(attack: Attack):
	print(default_health, "hadsgasd")
	default_health -= attack.attack_damage
	if default_health <= 0:
		get_parent().queue_free()


