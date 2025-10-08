extends Node
class_name PlayerController

@export var moveComponent: MoveComponent

@onready var player: Player = get_parent()

var steerFunc: Callable

func _ready():
	if player.controlType == player.ControlType.MOUSE:
		steerFunc = Callable(self, "mouseSteer")
	if player.controlType == player.ControlType.KEYS_ONLY:
		steerFunc = Callable(self, "keySteer")

func _physics_process(delta: float) -> void:
	steerFunc.call()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if player.controlType == Player.ControlType.MOUSE:
			var normal: = getMouseVector()
			moveComponent.targetNormal = normal
	if event.is_action_pressed("Accelerate"):
		moveComponent.accelPedal = 1
	elif event.is_action_released("Accelerate"):
		moveComponent.accelPedal = 0
	elif event.is_action_pressed("Brake"):
		moveComponent.brakePedal = 1
	elif event.is_action_released("Brake"):
		moveComponent.brakePedal = 0


func getMouseVector() -> Vector2:
	var globalPos: = player.global_position
	var mousePos: = player.get_global_mouse_position()
	
	return (mousePos - globalPos).normalized()


func mouseSteer() -> void:
	var steering: = Input.get_vector("SteerLeft", "SteerRight", "SteerUp", "SteerDown")
	moveComponent.targetNormal = steering


func keySteer() -> void:
	var steering: = Input.get_axis("SteerLeft", "SteerRight")
	moveComponent.targetNormal = moveComponent.orientation.rotated(steering * moveComponent.maxSteering)
