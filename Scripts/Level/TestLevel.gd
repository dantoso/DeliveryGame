extends Node2D
class_name TestLevel

@export var speedCounter: Label
@onready var player: Player = $Player

func _process(delta: float) -> void:
	speedCounter.set_text("Speed: %f" % player.moveComponent.absVelocity)
