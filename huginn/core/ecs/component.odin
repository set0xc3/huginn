package ecs

import m "huginn:core/math"

vec3 :: distinct m.vec3
quat :: distinct m.quat

Component :: struct {
	entity_id: Entity_Id,
	variant:   Component_Variant,
}

Component_Variant :: union {
	^Transform,
	^Sprite,
}

Transform :: struct {
	using _:  Component,
	position: vec3,
	rotation: quat,
	scale:    vec3,
}

Sprite :: struct {
	using _: Component,
}
