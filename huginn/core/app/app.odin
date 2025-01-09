package app

import "base:runtime"
import "core:container/intrusive/list"
import "core:container/queue"
import "core:fmt"
import "core:sync"
import "core:thread"

import m "huginn:core/math"
import sapp "huginn:vendor/sokol/app"
import sg "huginn:vendor/sokol/gfx"
import sglue "huginn:vendor/sokol/glue"
import slog "huginn:vendor/sokol/log"

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

App :: struct {
	is_quit: bool,
	plugins: list.List,
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

new :: proc() -> App {
	return {}
}

add_plugins :: proc(self: ^App, plugins: []^Plugin) {
	for plugin in plugins {
		list.push_back(&self.plugins, &plugin.node)
	}
}

@(private)
update :: proc(t: ^thread.Thread) {
	app_ctx := (cast(^App)t.data)

	{
		it := list.iterator_head(app_ctx.plugins, Plugin, "node")
		for plugin in list.iterate_next(&it) {
			plugin.build(plugin, app_ctx)
		}
	}
}

run :: proc(self: ^App) {
	t1 := thread.create(update)
	t1.init_context = context
	t1.user_index = 1
	t1.data = self
	thread.start(t1)

	run2()
}

@(private)
run2 :: proc() {
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
init :: proc "c" () {
	context = runtime.default_context()

	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})
}

@(private)
frame :: proc "c" () {
	context = runtime.default_context()
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
cleanup :: proc "c" () {
	context = runtime.default_context()
}
