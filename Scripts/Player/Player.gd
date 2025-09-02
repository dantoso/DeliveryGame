extends CharacterBody2D
class_name Player

enum ControlType {
	MOUSE,
	KEYS_ONLY
}

@export var controlType: ControlType = ControlType.MOUSE

@onready var moveComponent: MoveComponent = $MoveComponent
@onready var controller: PlayerController = $PlayerController
@onready var sprite: SpriteComponent = $SpriteComponent

func _ready():
	moveComponent.didTurn.connect(
		func(new: Vector2):
			sprite.direction = new
	)

func _physics_process(delta: float) -> void:
	moveComponent.updateMovement(delta)
	move_and_slide()
