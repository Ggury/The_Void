shader_type canvas_item;

uniform vec4 color = vec4(0,0,0,0);
uniform float multiplier = 0.2;
uniform float softness = 3.0;

void fragment()
{
	float value = distance(UV,vec2(0.5));
	COLOR = vec4(color.rgb, smoothstep(multiplier, softness,value));
}

