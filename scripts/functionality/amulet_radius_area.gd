extends Area2D

@export var MAX_ATTRACTION_SPEED := 1500.0 ## The max speed at which the ghost can be dragged toward the area.
@export var TIME_TO_SPEED := 0.5 ## The time in which the attraction speed goes from 0 to the set value.

var object: Node = null ## Will be set to ghost dynamically (less coupled this way).
var force_multiplier := 0.0 ## Scaled with the time the ghost is outside the area.

@onready var current_tween : Tween

func _ready():
	current_tween = self.create_tween()
	current_tween.kill()
	
	set_physics_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body is GhostCharacter:
		set_physics_process(false)
		object = body

func _on_body_exited(body: Node2D) -> void:
	if body is GhostCharacter:
		object = body
		if body.visible:
			current_tween.kill()
			current_tween = self.create_tween()
			
			force_multiplier = 0.0
			
			current_tween.tween_property(self, "force_multiplier", 1.0, TIME_TO_SPEED) ## Makes the ghost go quicker toward the area as more time passes with it outside it.
			set_physics_process(true)

func _physics_process(_delta: float) -> void:
	object.velocity = (global_position - object.global_position).normalized() * MAX_ATTRACTION_SPEED * force_multiplier
	object.move_and_slide()
	
