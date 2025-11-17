extends CharacterBody3D
class_name Player

enum ControlType {
	MOUSE,
	KEYS_ONLY
}

@export var camera: Camera3D
@export var controlType: ControlType = ControlType.MOUSE

@onready var moveComponent: MoveComponent = $MoveComponent
@onready var controller: PlayerController = $PlayerController
@onready var shape: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	moveComponent.didSteer.connect(turnSprite)


func _physics_process(delta: float) -> void:
	if controlType == ControlType.MOUSE:
		mouseRaycast()
	moveComponent.updateMovement(delta)
	move_and_slide()


func turnSprite(angle: float) -> void:
	shape.rotate_y(angle)


func mouseRaycast() -> void:
	var mousePos: = get_viewport().get_mouse_position()
	var space: = get_world_3d().direct_space_state
	var from: = camera.project_ray_origin(mousePos)
	var to: = from + camera.project_ray_normal(mousePos) * 100
	var query: = PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = 4
	var result: = space.intersect_ray(query)
	
	if result:
		print(result)
		var direction: Vector3 = (result.position - global_position).normalized()
		moveComponent.targetNormal = Vector2(direction.x, direction.z)
