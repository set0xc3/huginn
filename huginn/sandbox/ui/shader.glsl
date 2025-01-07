@header package main
@header import sg "huginn:vendor/sokol/gfx"
// @header import m "huginn:core/math"
// @ctype mat4 m.mat4

@vs vs
layout(binding=0) uniform vs_params {
  vec2 position;
  vec2 size;
};

in vec4 position0;
in vec4 color0; out vec4 color;

out vec2 u_position;
out vec2 u_size;

void main() {
  gl_Position = position0;
  color = color0;

  u_position = position;
  u_size = size;
}
@end

@fs fs
in vec4 color;
out vec4 frag_color;

in vec2 u_position;
in vec2 u_size;

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

vec2 u_rectSize = u_size;
vec4 u_cornerRadii = vec4(10.0, 10.0, 10.0, 10.0);
float u_borderThickness = 1.0;
float u_borderSoftness = 0.5;
float u_edgeSoftness = 0.5;

vec4 u_colorBg = vec4(240.0 / 255.0, 241.0 / 255.0, 242.0 / 255.0, 1.0);
vec4 u_colorRect = vec4(1.0, 1.0, 1.0, 1.0);
vec4 u_colorBorder = vec4(205.0 / 255, 210.0 / 255, 214.0 / 255, 1.0);

void main() {
  vec2 p = gl_FragCoord.xy - u_rectSize;

  p -= u_position;

  // --- Rectangle ---
  float dist = sdf_rect_rounded(p, u_rectSize, u_cornerRadii);
  float edgeWidth = fwidth(dist) * u_edgeSoftness;
  float rectAlpha = 1.0 - smoothstep(-edgeWidth, edgeWidth, dist);
  vec4 rectColor = vec4(u_colorRect.rgb, rectAlpha);

  // --- Border ---
  float borderDist = abs(dist) - u_borderThickness;
  float baseBorderEdgeWidth = fwidth(borderDist);
  float borderEdgeWidth = baseBorderEdgeWidth * u_borderSoftness;
  float borderAlpha = 1.0 - smoothstep(-borderEdgeWidth, borderEdgeWidth, borderDist);
  vec4 borderColor = vec4(u_colorBorder.rgb, borderAlpha * rectAlpha);

  float dist_circle = sdf_circle(p, 150.0);
  float circle_edge_width = fwidth(dist_circle) * 0.5;
  float circle_alpha = 1.0 - smoothstep(-circle_edge_width, circle_edge_width, dist_circle);
  vec4 circle_color = vec4(vec3(1.0, 0.0, 1.0), circle_alpha);

  // --- Blending Layers ---
  vec4 result = u_colorBg;
  // result = mix(result, circle_color, circle_alpha);
  result = mix(result, rectColor, rectAlpha);
  result = mix(result, borderColor, borderAlpha);

  frag_color = result;
}
@end

@program quad vs fs
