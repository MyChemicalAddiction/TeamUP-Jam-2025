extends Area2D
class_name Hurtbox

"""
The Hurtbox component defines behavior of hurtboxes - areas which should take
damage and/or knockback (and/or other stuff as defined by implementations
if ever such things get created) from Hurtbox components when their areas 
overlap.

The Hurtbox itself doesn't hold hurtbox-relevant state. It doesn't even hold 
hurtbox-relevant behavior definitions. It instead delegates these things to
	HurtboxRes
and
	HurtboxHitBehavior
implementations (respectively).

This is done to employ the strategy pattern for having modular, easily 
extensible & modifiable reusable behavior definitions.

To add a hurtbox to something:
	1) instance the Hurtbox component as a child of that something;
	2) add a collision shape to the Hurtbox;
	3) create a new HurtboxRes & define its variables (or use an already created
	one);
	4) assign the new HurtboxRes to the hurtboxRes export var of the Hurtbox;
	5) create a new HurtboxHitBehavior (or use an already created one) as a
	child of the Hurtbox and set the HurtboxHitBehavior's hurtBox export variable
	to reference the HurtBox for defining behavior upon being hit.
	6) create a new HurtboxDestroyedBehavior (or use an already created one) as
	a child of the Hurtbox and set the HurtboxDestroyedBehavior's hurtBox variable
	to reference the Hurtbox for defining behavior upon the destruction of the
	Hurtbox.
	7) Assign the Holder of the Hurtbox.
"""

## Assign a [b]HurtboxRes[/b] instance to this.
@export var hurtboxRes: HurtboxRes 

## Whether this Hurtbox can do anything.
@export var enabled := true 

## The "thing" that has this hurtbox. This reference is used inside destroy() to free it.
@export var holder: Node 

signal hit(damage, knockback) ## Emitted when the hurtbox is hit.
signal destroyed ## Emitted when the hurtbox is destroyed.

func _ready():
	area_entered.connect(_on_area_entered)
	_on_ready()

func _on_area_entered(area): ## Checks if a hurtbox has been hit.
	if area is Hitbox:
		if enabled:
			hit.emit(area.get_damage(), area.get_knockback())

func _on_ready(): ## Overridden hook for desired extra behavior on ready.
	pass

func get_HP(): ## Returns the HP.
	return hurtboxRes.HP

func damage(received_damage): ## Deals damage to the hurtbox & emits the destroyed signal if the HP goes below 0. This does not get called by default by the hurtbox! Instead, it is called externally by a HurtboxDamageHitBehavior implementation if it deems it fit.
	hurtboxRes.HP -= received_damage
	if hurtboxRes.HP <= 0:
		destroyed.emit()

func destroy():
	holder.queue_free()
