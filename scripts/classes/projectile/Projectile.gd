extends RigidBody2D
class_name Projectile

"""
The Projectile class holds behavior & state for in-game projectiles. 
To use it:
	1) instance it
	2) assign it a sprite2d or some sort of visual texture
	3) assign it a Hitbox component & set that up
	4) assign the Projectile a ProjectileRes & set that up
"""

@export var projectileRes: ProjectileRes ## The Resource of the projectile holds info about its speed, etc.

func _ready():
	## Set the projectile to be able to collide with walls and such.
	set_collision_mask_value(1, true)
	
	## Make the projectile be able to send signals when it collides
	contact_monitor = true
	max_contacts_reported = 1
	
	## Disables gravity if this is a "straight projectile" (so it doesn't arch)
	if projectileRes is StraightProjectileRes: gravity_scale = 0  # Disable gravityp
	
	body_entered.connect(_on_body_entered) ## What happens when the Projectile hits something like a wall
	
func _on_body_entered(_body): ## TODO: later, this can be modified to add special effects when a projectile hits a wall or other phyisical object.
	queue_free()
	
func shoot(direction: Vector2):
	if projectileRes == null:
		push_error("ProjectileRes is not assigned.")
		return
		
	if direction == Vector2.ZERO:
		push_error("Invalid direction passed to shoot().")
		return

	direction = direction.normalized()
	global_rotation = direction.angle()
	linear_velocity = direction * projectileRes.SPEED
