//from "Share a Shader" forum thread

extern number shift = 0;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
  {
  vec2 tc = texture_coords;
  vec2 scale = vec2(1.0/800.0, 1.0/600.0);
  vec4 r = Texel(texture, vec2(tc.x + shift * scale.x, tc.y - shift * scale.y));
  vec4 g = Texel(texture, vec2(tc.x, tc.y + shift*scale.y));
  vec4 b = Texel(texture, vec2(tc.x - shift*scale.x, tc.y - shift*scale.y));
  number a = r.a+g.a+b.a / 3.0;

  return vec4(r.r, g.g, b.b, a);
}