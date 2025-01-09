package ui

import "core:container/intrusive/list"
import "core:encoding/uuid"
import "core:fmt"
import m "huginn:core/math"

import "huginn:/core/plugin"

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

init :: proc() {}

frame :: proc() {}

plugin_deps: []^plugin.Interface = {&plugin.test_plugin}
plugin: plugin.Interface = {
	build = proc(self: ^plugin.Interface) {
		for dep in plugin_deps {
			list.push_back(&self.deps, &dep.node)
			dep.build(dep)
		}

		init()
	},
	ready = proc() -> bool {
		return true
	},
}
