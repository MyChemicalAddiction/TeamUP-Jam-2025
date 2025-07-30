extends Area2D

@export var MAX_ATTRACTION_SPEED := 1500.0 ## The max speed at which the ghost can be dragged toward the area.
@export var TIME_TO_SPEED := 0.5 ## The time in which the attraction speed goes from 0 to the set value.

@onready var object: Character = get_tree().get_first_node_in_group("Ghost") ## The Ghost player
var force_multiplier := 0.0 ## Scaled with the time the ghost is outside the area.

var default_ghost_collision_mask: int = -1 ## Stores the default mask of the Ghost

@onready var current_tween : Tween

## Emitted when it starts pulling the ghost
signal on_enabled

## Emitted when it stops pulling the ghost
signal on_disabled

func _ready():
	default_ghost_collision_mask = object.collision_mask
	
	current_tween = self.create_tween()
	current_tween.kill()
	
	set_physics_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body is GhostCharacter:
		object.in_amulet_radius = true
		set_physics_process(false)
		
		object.collision_mask = default_ghost_collision_mask
		
		on_disabled.emit()

func _on_body_exited(body: Node2D) -> void:
	if body is GhostCharacter:
		object.in_amulet_radius = false
		
		current_tween.kill()
		current_tween = self.create_tween()
		
		force_multiplier = 0.0
		
		current_tween.tween_property(self, "force_multiplier", 1.0, TIME_TO_SPEED) ## Makes the ghost go quicker toward the area as more time passes with it outside it.
		set_physics_process(true)
		object.collision_mask = 0
		
		on_enabled.emit()

func _physics_process(_delta: float) -> void:
	object.velocity = (global_position - object.global_position).normalized() * MAX_ATTRACTION_SPEED * force_multiplier
	object.move_and_slide()
	
