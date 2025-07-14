class_name ProjectileShooter
extends FunctionalComponent

"""
The ProjectileShooter component implements the FunctionalComponent interface
and shoots a desired projectile (as set in the projectile_scene var) toward
the way where it's facing in the 2d world (its rotation property).

If assigned an "area", it shoots toward the direction it's facing whenever 
that area emits an area_entered signal IF the thing that entered it is a
Hurtbox area.
"""

@export var projectile_scene: PackedScene

func _on_use():
	_fire_projectile()

## Only shoots a projectile if the area that entered the scanning area is a hurtbox.
func _on_area_entered(obj):
	if obj is Hurtbox:
		use()

func _fire_projectile():
	var instance = projectile_scene.instantiate()

	add_child.call_deferred(instance)
	#instance.position = self.position

	var direction = Vector2.RIGHT.rotated(global_rotation)  ## Facing direction
	instance.shoot(direction)
