extends CharacterBody2D
class_name Player

@onready var moveComponent: MoveComponent = $MoveComponent
@onready var controller: PlayerController = $PlayerController

func _physics_process(delta: float) -> void:
	moveComponent.updateMovement(delta)
	move_and_slide()
