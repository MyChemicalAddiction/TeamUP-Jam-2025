extends Component
class_name LightComponent 

"""
Encapsulates functionality for modifying a Sprite's Material's Shader's 
glow strength.
"""

@export var sprite: Node2D
@export var on_enable_glow_strength := 1.0
@export var on_disable_glow_strength := 0.0

## If true, will create a duplicate of the sprite's material so as not to modify other sprites who share it as well
@export var make_sprite_material_unique := true

@onready var sprite_material: ShaderMaterial

func _ready():
	super()
	if make_sprite_material_unique:
		sprite.material = sprite.material.duplicate()
	sprite_material = sprite.material as ShaderMaterial

func _on_enable():
	call_deferred("_light")
	
func _on_disable():
	call_deferred('_dim')

func _light():
	sprite_material.set_shader_parameter("glow_strength", on_enable_glow_strength)

func _dim():
	sprite_material.set_shader_parameter("glow_strength", on_disable_glow_strength)
