extends Node2D

@export var life_component: LifeComponent


func damage(attack: Attack):
	if life_component:
		life_component.attack(attack.attack_damage)
	
	
