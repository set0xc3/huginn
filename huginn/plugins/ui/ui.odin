package ui

import "core:container/intrusive/list"
import "core:encoding/uuid"
import "core:fmt"

import m "huginn:core/math"
import "huginn:core/plugin"

vec2 :: distinct m.vec2
vec4 :: distinct m.vec4

Id :: distinct u32
Color :: distinct vec4

Rect :: struct {
	x, y, w, h: f32,
}

Command :: struct {
	variant: Command_Variant,
	size:    u32,
}

Command_Rect :: struct {
	using command: Command,
	rect:          Rect,
	color:         Color,
}

Command_Variant :: union {
	^Command_Rect,
}

Layout :: struct {}

Container :: struct {}

Style :: struct {}

Context :: struct {}

get_plugin :: proc() -> (plugin: ^plugin.Plugin) {
	return
}
