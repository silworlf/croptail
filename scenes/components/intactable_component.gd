class_name InteractableComponent

extends Area2D

signal interactivable_activated
signal interactivable_deactivated


func _on_body_entered(body: Node2D) -> void:
	interactivable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	interactivable_deactivated.emit()
