extends Area2D
class_name InteractableArea

signal interaction(with: InteractorArea)

func interact(interactor: InteractorArea) -> void:
	interaction.emit(interactor)
