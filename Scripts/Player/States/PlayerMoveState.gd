extends State
class_name PlayerMoveState

@export var player: Player
@export var moveComponent: MoveComponent

func enter(data: Variant) -> void:
	print("Move")


func physicsUpdate(delta: float) -> void:
	moveComponent.fall(delta)
	moveComponent.updateMovement(delta)
	if moveComponent.absVelocity == 0 && player.is_on_floor():
		stateMachine.transitionTo("IdleState")
