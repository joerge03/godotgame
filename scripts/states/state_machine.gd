class_name StateMachine
extends Node

@export var init_state: State

var current_state: State

var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State :
			states[child.name.to_lower()] = child
			child.is_transition.connect(on_transition)
	if init_state:
		init_state._enter()
		current_state = init_state
			
func on_transition(state: State, new_state_name: String):
	var latest_state: State = states.get(new_state_name.to_lower())
	if state == current_state && current_state && state && latest_state:
		current_state._exit()
		latest_state._enter()
		current_state = latest_state

func _process(delta):
	if current_state:
		current_state._update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state._physics_update(delta)
			 
		
