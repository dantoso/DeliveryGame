extends Node
class_name StateMachine

var states: Dictionary[String, State]
var currentState: State
@export var defaultState: State

func start() -> void:
	var children: = get_children()
	for child in children:
		if child is State:
			if !defaultState:
				defaultState = child
			states[child.name] = child
	currentState = defaultState
	currentState.enter(null)


func _process(delta: float) -> void:
	if currentState:
		currentState.update(delta)


func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physicsUpdate(delta)


func _unhandled_input(event: InputEvent) -> void:
	if currentState:
		currentState.handleInput(event)


func transitionTo(key: String, data: Variant = null) -> void:
	var newState: State = states[key]
	
	if currentState == newState:
		return
	
	if !currentState || !newState:
		return
	
	currentState.exit()
	
	newState.enter(data)
	currentState = newState
