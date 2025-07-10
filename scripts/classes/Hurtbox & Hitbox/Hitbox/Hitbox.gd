extends Area2D
class_name Hitbox

"""
The Hitbox component defines behavior of hitboxes - areas which should cause
damage and/or knockback (and/or other stuff as defined by implementations
if ever such things get created) to Hurtbox components when their areas overlap.

The Hitbox itself doesn't hold hitbox-relevant state. It doesn't even hold 
hitbox-relevant behavior definitions. It instead delegates these things to
	HitboxRes
and
	HitboxHitBehavior
implementations (respectively).

This is done to employ the strategy pattern for having modular, easily 
extensible & modifiable reusable behavior definitions.

To add a hitbox to something:
	1) instance the Hitbox component as a child of that something;
	2) add a collision shape to the Hitbox;
	3) create a new HitboxRes & define its variables (or use an already created
	one);
	4) assign the new HitboxRes to the hitboxRes export var of the Hitbox;
	*5) if you want the Hitbox to be visible, add something like a Sprite child.
	**6) create a new HitboxHitBehavior (or use an already created one) as a
	child of the Hitbox and set the HitboxHitBehavior's hitBox export variable
	to reference the HitBox if you want extra behavior when the Hitbox hits 
	something.
"""

## Assign a [b]HitboxRes[/b] instance to this.
@export var hitboxRes: HitboxRes 

## Whether this Hitbox can do anything.
@export var enabled := true 

## The thing that "holds" the hitbox (set to the projectile if parented to one)
@export var holder: Node 

signal hit ## Emitted when the hitbox hits something

func _ready():
	area_entered.connect(_on_area_entered)
	_on_ready()

func _on_area_entered(area): ## Checks if a hurtbox has been hit.
	if area is Hurtbox:
		if enabled:
			hit.emit()

func _on_ready(): ## Overridden hook for desired extra behavior on ready.
	pass

func get_knockback(): ## Returns the knockback this Hurtbox should inflict.
	return hitboxRes.knockback

func get_damage(): ## Returns the damage this Hurtbox should deal.
	return hitboxRes.damage
