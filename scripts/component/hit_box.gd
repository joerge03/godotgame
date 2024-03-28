class_name HitBox
extends Area2D

@export var life_component: LifeComponent


func damage(attack: Attack):
	if life_component:
		print("damage at atataat")
		life_component.damage(attack)
	
	
