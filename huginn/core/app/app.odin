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

App :: struct {
	is_quit: bool,
	plugins: list.List,
}

init :: proc() -> (app: ^App) {
	app = new(App)
	return
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
}
