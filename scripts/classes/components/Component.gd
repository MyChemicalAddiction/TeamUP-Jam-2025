extends Node2D
class_name Component

"""
The Component superclass provides a common interface for enabling/disabling
behavior of a component.
"""

@export var enabled = true

signal on_enabled
signal on_disabled

## A node that, when used, enables this one. This is typically assigned an InteractionArea node but can also be assigned another Functional Component, too, since they also emit this signal (polymorphism W).
@export var enabler: Node 

## Keeps track of if any areas are currently inside the area of the "Tracking Area" assigned to this component
@export var area_tracker_component: AreaEnteredTrackerComponent

## Whether this component is able to be enabled/disabled
var actable := true

## A node that can send a disable/enable signal which disables/enables this component.
@export var enable_manager: Node 

## The component which this component acts as an enable_manager for.
var enablee: Node

## Whether this node should take priority as another's enablee.
@export var is_enablee := false

## Emitted when an enablee is detected.
signal enablee_set(en: Node)

## An area that, when entered [b]by another area[/b], enables this component, and when exited, disables it.
@export var enabling_area: Area2D

func _ready():
	if enabler and enabler != self:
		enabler.used.connect(enable)
	if enable_manager:
		if is_enablee:
			if enable_manager.has_method("set_enablee"):
				enable_manager.call_deferred("set_enablee", self)
		enable_manager.on_disabled.connect(disable)
		enable_manager.on_enabled.connect(enable)
	if enabling_area:
		enabling_area.area_entered.connect(_on_enabling_area_entered)
		enabling_area.area_exited.connect(_on_enabling_area_exited)
	if enabled:
		enable()
	else:
		disable()
	if area_tracker_component:
		area_tracker_component.area_empty.connect(disable)
		area_tracker_component.area_present.connect(enable)

func set_enablee(new_enablee: Node):
	enablee = new_enablee
	enablee_set.emit(enablee)

func enable(): ## Sets enabled variable to true & triggers any extra relevant implementation-defined behavior.
	if actable:
		enabled = true
		on_enabled.emit()
		_on_enable()

func disable(): ## Sets enabled variable to false & triggers any extra relevant implementation-defined behavior.
	if actable:
		enabled = false
		on_disabled.emit()
		_on_disable()

func _on_enabling_area_entered(_area):
	enable()
	
func _on_enabling_area_exited(_area):
	disable()

func _on_disable(): ## Hook for extra behavior on disabling.
	pass
	
func _on_enable(): ## Hook for extra behavior on enabling.
	pass
