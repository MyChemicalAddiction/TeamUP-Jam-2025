shader_type canvas_item;

render_mode unshaded, blend_mix;

uniform float glow_strength : hint_range(0.0, 10.0) = 1;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = tex_color;

    // Boost brightness without changing hue
    COLOR.rgb += tex_color.rgb * glow_strength;
}