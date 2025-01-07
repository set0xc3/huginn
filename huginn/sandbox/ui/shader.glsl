@header package main
@header import sg "huginn:vendor/sokol/gfx"
@header import m "huginn:core/math"
@ctype mat4 m.mat4

@vs vs
layout(binding=0) uniform vs_params {
  mat4 projection;
};

in vec4 position0;
in vec4 color0;

out vec4 color;
out vec2 frag_coord;

void main() {
  gl_Position = projection * position0;
  color = color0;

  frag_coord = position0.xy;
}
@end

@fs fs
in vec4 color;
out vec4 frag_color;

in vec2 frag_coord;

// https://iquilezles.org/articles/distfunctions2d/

float sdf_circle(vec2 p, float r) {
  return length(p) - r;
}

float sdf_rect(vec2 p, vec2 b) {
  vec2 d = abs(p) - b;
  return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float sdf_rect_rounded(vec2 p, vec2 b, vec4 r) {
  r.xy = (p.x > 0.0) ? r.xy : r.zw;
  r.x = (p.y > 0.0) ? r.x : r.y;
  vec2 q = abs(p) - b + r.x;
  return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r.x;
}

void main() {
  // Центрируем координаты в диапазоне [-0.5, 0.5]
  vec2 position = frag_coord - 0.5;

  // Вычисляем расстояние до границы круга
  float dist = sdf_rect_rounded(position, vec2(0.5, 0.5), vec4(0.1, 0.1, 0.1, 0.1));
  float edge_width = fwidth(dist) * 0.5;
  // Вычисляем альфа-канал для плавного перехода
  float alpha = color.a - smoothstep(-edge_width, edge_width, dist);
  vec4 color = vec4(color.rgb, alpha);

  // --- Blending Layers ---
  vec4 result = color;
  // result = mix(result, circle_color, circle_alpha);
  result = mix(result, color, alpha);
  // result = mix(result, borderColor, borderAlpha);

  frag_color = result;
}
@end

@program quad vs fs
