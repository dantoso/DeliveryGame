extends Area2D
class_name InteractorArea

var interactables: Array[InteractableArea]

func _ready() -> void:
	area_entered.connect(
		func(interactable: InteractableArea):
			interactables.append(interactable)
	)
	area_exited.connect(
		func(interactable: InteractableArea):
			interactables.erase(interactable)
	)


func tryInteraction() -> void:
	if interactables.is_empty():
		return
	interactables.back().interact(self)
