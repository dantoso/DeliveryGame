extends Node
class_name MoveComponent

@onready var character: CharacterBody2D = get_parent()

@export var maxSpeed: = 400.0
@export var acceleration: = 300.0
@export var deceleration: = 50.0
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

# if turning too tight (target x orientaion dot product is too small)
# then calculate momentum, keep bike moving along orientation while losing speed
# while make it reaccelerate (from 0?) along target
func updateMovement(delta: float) -> void:
	absVelocity = move_toward(absVelocity, 0, brake(delta) + inertia(delta))
	absVelocity = move_toward(absVelocity, maxSpeed, accelerate(delta))
	var dot: = targetNormal.dot(orientation)
	orientation = orientation.move_toward(targetNormal, delta * steerMultiplier)
	
	character.velocity = absVelocity * orientation


func accelerate(delta: float) -> float:
	return acceleration * delta * accelPedal


func brake(delta: float) -> float:
	return brakeForce * delta * brakePedal


func inertia(delta: float) -> float:
	return deceleration * delta * (1.0 - accelPedal)


#func getCentrifugal() -> Vector2:
