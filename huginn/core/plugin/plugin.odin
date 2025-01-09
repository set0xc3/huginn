package plugin

import "core:container/intrusive/list"
import "core:fmt"

State :: enum {
	// Plugins are being added.
	Adding,
	// All plugins already added are ready.
	Ready,
	// Finish has been executed for all plugins added.
	Finished,
	// Cleanup has been executed for all plugins added.
	Cleaned,
}

Interface :: struct {
	node:      list.Node,
	deps:      list.List,
	state:     State,
	build:     proc(self: ^Interface),
	ready:     proc() -> bool,
	finish:    proc(),
	cleanup:   proc(),
	is_unique: proc() -> bool,
}

test_plugin: Interface = {
	build = proc(self: ^Interface) {
	},
}
