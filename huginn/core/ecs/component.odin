package ecs

import m "huginn:core/math"

vec3 :: distinct m.vec3
quat :: distinct m.quat

Component_Variant :: union {
	Transform,
}

Transform :: struct {
	position: vec3,
	rotation: quat,
	scale:    vec3,
}
