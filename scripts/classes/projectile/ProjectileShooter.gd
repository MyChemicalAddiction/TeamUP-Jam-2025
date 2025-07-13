class_name ProjectileShooter
extends FunctionalComponent

"""
The ProjectileShooter component implements the FunctionalComponent interface
and shoots a desired projectile (as set in the projectile_scene var) toward
the way where it's facing in the 2d world (its rotation property).
"""

@export var projectile_scene: PackedScene

func _on_use():
	_fire_projectile()

func _fire_projectile():
	var instance = projectile_scene.instantiate()

	add_child.call_deferred(instance)
	instance.position = Vector2.ZERO

	var direction = Vector2.RIGHT.rotated(global_rotation)  ## Facing direction
	instance.shoot(direction)
