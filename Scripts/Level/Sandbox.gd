extends Node3D
class_name Sandbox

@export var speedCounter: Label
@export var rotationLabel: Label
@onready var player: Player = $Player

func _process(delta: float) -> void:
	speedCounter.set_text("Speed: %f" % player.moveComponent.absVelocity)
	rotationLabel.set_text("Steering: %f PI" % (player.moveComponent.steeringAngle/PI))
