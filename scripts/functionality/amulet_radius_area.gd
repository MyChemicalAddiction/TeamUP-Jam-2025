extends Area2D

@export var ATTRACTION_SPEED := 0.0

var outside := false ## True when the ghost is outside the radius.
var object: Node = null ## Will be set to ghost dynamically (less coupled this way).

func _on_body_entered(body: Node2D) -> void:
	if body is GhostCharacter:
		outside = false
		object = body

func _on_body_exited(body: Node2D) -> void:
	if body is GhostCharacter:
		object = body
		if body.visible:
			outside = true

func _physics_process(delta: float) -> void:
	if outside: ## Moves the ghost toward the center of the amulet if it's outside its radius.
		object.velocity = (global_position - object.global_position).normalized() * ATTRACTION_SPEED
		object.move_and_slide()
