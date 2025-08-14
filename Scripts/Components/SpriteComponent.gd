extends AnimatedSprite2D
class_name SpriteComponent

var locked: = false
var direction: = Vector2(1, 0):
	set(new):
		direction = new
		updateAnimationFace(new)


func _ready() -> void:
	animation_changed.connect(
		func():
			for connection in animation_looped.get_connections():
				animation_looped.disconnect(connection.callable)
	)


func updateAnimationFace(normal: Vector2) -> void:
	if !locked && normal.x != 0:
		flip_h = normal.x < 0


func onLoop(call: Callable) -> void:
	animation_looped.connect(call, CONNECT_PERSIST)


func onEnd(call: Callable) -> void:
	animation_finished.connect(call, CONNECT_ONE_SHOT)
