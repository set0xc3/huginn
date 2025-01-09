package main

import "core:fmt"
import "huginn:core/app"
import "huginn:core/ui"

main :: proc() {
	app_ctx := app.new()
	app.add_plugins(&app_ctx, {ui.get_plugin()})
	app.run(&app_ctx)
}
