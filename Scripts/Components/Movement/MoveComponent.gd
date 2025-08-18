extends Node
class_name MoveComponent

@onready var character: CharacterBody2D = get_parent()

@export var maxSpeed: = 300.0
@export var acceleration: = 350.0
@export var deceleration: = 100.0
@export var brakeForce: = 1000.0
@export var steerMultiplier: = 3.0

signal didTurn(new: Vector2)

var absVelocity: = 0.0
var accelPedal: = 0.0
var brakePedal: = 0.0

var targetNormal: = Vector2(0, -1):
	set(new):
		if new.length_squared() > 0:
			targetNormal = new
var orientation: = Vector2(0, -1):
	set(new):
		orientation = new.normalized()
var moveNormal: = Vector2.ZERO:
	set(new):
		moveNormal = new
		if orientation.dot(new) < 0:
			absVelocity = 0
			didTurn.emit(new)
		if new.length_squared() > 0:
			orientation = new.normalized()


func updateMovement(delta: float) -> void:
	absVelocity = move_toward(absVelocity, 0, brake(delta) + inertia(delta))
	absVelocity = move_toward(absVelocity, maxSpeed, accelerate(delta))
	orientation = orientation.move_toward(targetNormal, delta * steerMultiplier)
	
	character.velocity = absVelocity * orientation


func accelerate(delta: float) -> float:
	return acceleration * delta * accelPedal


func brake(delta: float) -> float:
	return brakeForce * delta * brakePedal


func inertia(delta: float) -> float:
	return deceleration * delta
