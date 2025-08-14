extends Node
class_name State

@onready var stateMachine: StateMachine = get_parent()

func enter(data: Variant) -> void: return

func exit() -> void: return

func update(_delta: float) -> void: return

func physicsUpdate(_delta: float) -> void: return

func handleInput(_event: InputEvent) -> void: return
