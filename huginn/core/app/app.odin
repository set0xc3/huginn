package app

import "core:container/intrusive/list"
import "core:container/queue"

import m "huginn:core/math"
import sapp "huginn:vendor/sokol/app"
import sg "huginn:vendor/sokol/gfx"
import sglue "huginn:vendor/sokol/glue"
import slog "huginn:vendor/sokol/log"

import "base:runtime"
import "core:fmt"

import "huginn:core/app"
import "huginn:core/plugin"
import "huginn:core/ui"

Schedule_Type :: enum {
	//
	PreStartup,
	Startup,
	PostStartup,
	//
	PreUpdate,
	Update,
	PostUpdate,
	//
	FixedPreUpdate,
	FixedUpdate,
	FixedPostUpdate,
}

Context :: struct {
	is_quit: bool,
	plugins: list.List,
	systems: list.List,
}

@(private)
state: struct {
	default: struct {
		pass_action: sg.Pass_Action,
		pip:         sg.Pipeline,
		bind:        sg.Bindings,
	},
	rx, ry:  f32,
}

new :: proc() -> Context {
	return {}
}

add_plugins :: proc(self: ^Context, plugins: []^plugin.Interface) {
	for p in plugins {
		list.push_back(&self.plugins, &p.node)

		p.state = .Adding
		p.build(p)
	}
}

add_system :: proc(schedule: Schedule_Type, system: proc()) {
}

run :: proc(self: ^Context) {
	sapp.run(
		{
			init_cb = init,
			frame_cb = frame,
			cleanup_cb = cleanup,
			event_cb = event,
			width = 1280,
			height = 720,
			window_title = "huginn",
			icon = {sokol_default = false},
			logger = {func = slog.func},
		},
	)
}

@(private)
event :: proc "c" (event: ^sapp.Event) {
	#partial switch event.type {
	case .KEY_UP:
		if event.key_code == .ESCAPE {
			sapp.quit()
		}
	}
}

@(private)
init :: proc "c" () {
	context = runtime.default_context()

	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})
}

@(private)
frame :: proc "c" () {
	context = runtime.default_context()
}

@(private)
cleanup :: proc "c" () {
	context = runtime.default_context()
}
