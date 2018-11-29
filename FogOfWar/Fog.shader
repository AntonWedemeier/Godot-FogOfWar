shader_type canvas_item;

uniform sampler2D last_texture;
uniform sampler2D clear_texture;
uniform vec2 clear_position;
uniform vec2 clear_size;

void fragment() {
	vec4 clr = texture(last_texture, UV);
	clr.rgb /= clr.a;
	if ((UV.x >= clear_position.x) && 
	    (UV.x <  clear_position.x + clear_size.x) && 
	    (UV.y >= clear_position.y) && 
	    (UV.y <  clear_position.y + clear_size.y)) 
	{
		float x1 = (UV.x - clear_position.x) / clear_size.x;
		float y1 = (UV.y - clear_position.y) / clear_size.y;
		vec4 clr_clear = texture(clear_texture, vec2(x1, y1));
		if (clr_clear.a >= 0.99) clr.a = min(clr_clear.r, clr.a);
	}
	COLOR = clr;
}