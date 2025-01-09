package main

import "huginn:core/app"
import "huginn:core/ui"

main :: proc() {
	app_ctx := app.new()
	app.add_plugins(&app_ctx, {&ui.plugin})
	app.run(&app_ctx)
}
