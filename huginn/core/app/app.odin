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
}

init :: proc() -> (app: ^App) {
	app = new(App)
	return
}

@(private)
update :: proc() {
}

run :: proc(self: ^App) {
}
