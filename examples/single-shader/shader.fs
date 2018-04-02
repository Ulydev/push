//from "Share a Shader" forum thread

extern float strength = 2.0f;

vec4 effect(vec4 color, Image tex, vec2 tC, vec2 pC){
	vec2 dir = .5 - tC;
	float dist = sqrt(dir.x * dir.x + dir.y * dir.y);
	
	vec4 c = Texel(tex, tC);
	
	float t = dist * strength;
	t = clamp(t, 0, 1);
	
	return mix(c, vec4(0), t);
}