extends State
class_name PlayerIdleState

@export var player: Player
@export var moveComponent: MoveComponent

func enter(data: Variant) -> void:
	print("Idle")


func physicsUpdate(delta: float) -> void:
	moveComponent.fall(delta)
	if moveComponent.accelPedal > 0 && player.is_on_floor():
		stateMachine.transitionTo("MoveState")
