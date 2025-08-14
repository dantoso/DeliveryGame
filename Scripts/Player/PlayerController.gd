extends Node
class_name PlayerController

@export var moveComponent: MoveComponent

func _physics_process(delta: float) -> void:
	var steering: = Input.get_vector("SteerLeft", "SteerRight", "SteerUp", "SteerDown")
	moveComponent.targetNormal = steering


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Accelerate"):
		moveComponent.accelPedal = 1
	elif event.is_action_released("Accelerate"):
		moveComponent.accelPedal = 0
	elif event.is_action_pressed("Brake"):
		moveComponent.brakePedal = 1
	elif event.is_action_released("Brake"):
		moveComponent.brakePedal = 0
