extends Node
class_name MoveComponent

@onready var player: Player = get_parent()

@export var maxSpeed: = 50.0
@export var maxSteering: = 0.3 * PI
@export var steeringMod: = 2.0
@export var engineForce: = 25.0
@export var inertiaValue: = 12.5
@export var brakeForce: = 100.0

signal didTurn(new: Vector2)
signal didSteer(to: float)

var absVelocity: = 0.0
var steeringAngle: = 0.0
var accelPedal: = 0.0
var brakePedal: = 0.0

var targetNormal: = Vector2(0, 1):
	set(new):
		if new.length_squared() > 0:
			targetNormal = new
var orientation: = Vector2(0, 1):
	set(new):
		orientation = new.normalized()
		didTurn.emit(orientation)

# if turning too tight (target x orientaion dot product is too small)
# then calculate momentum, keep bike moving along orientation while losing speed
# while make it reaccelerate (from 0?) along target

# make it so the slower the bike, the easier to turn quickly
func updateMovement(delta: float) -> void:
	absVelocity = move_toward(absVelocity, 0, brake(delta) + inertia(delta))
	absVelocity = move_toward(absVelocity, maxSpeed, accelerate(delta))
	
	var targetAngle: = orientation.angle_to(targetNormal)
	steeringAngle = minf(absf(targetAngle), maxSteering) * signf(targetAngle)
	
	var frameSteering: = steeringAngle*delta*steeringMod*absVelocity*delta
	orientation = orientation.rotated(frameSteering)
	didSteer.emit(-frameSteering)
	
	player.velocity = absVelocity * Vector3(orientation.x, 0, orientation.y)


func accelerate(delta: float) -> float:
	return engineForce * delta * accelPedal


func brake(delta: float) -> float:
	return brakeForce * delta * brakePedal


func inertia(delta: float) -> float:
	return inertiaValue * delta * (1.0 - accelPedal)


#func getCentrifugal() -> Vector2:
