extends Button
class_name SectionButton

## Emitted when button is released
signal section_switch(new_section)

## The section this button should transfer to
@export var section: Control

## The top menu control node (to which it connects the section_switch signal)
@export var menu: Control

func _ready():
	button_up.connect(switch_section)
	section_switch.connect(menu.switch_section)

## Emits the section_switch signal, caught by the top menu node
func switch_section():
	section_switch.emit(section)
