package main

import "core:fmt"
import "huginn:core/app"

sandbox_startup :: proc() {
	fmt.println("[sandbox] Startup")
}

sandbox_update :: proc() {
	fmt.println("[sandbox] Update")
}

main :: proc() {
	a := app.new()

	app.add_system(.Startup, sandbox_startup)
	app.add_system(.Update, sandbox_update)
	app.run(&a)

	defer app.cleanup()
}
