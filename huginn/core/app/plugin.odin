package app

import "core:container/intrusive/list"
import "core:fmt"

Plugin :: struct {
	node:         list.Node,
	deps:         list.List,
	id:           string,

	//
	startup:      proc(),
	update:       proc(),
	fixed_update: proc(),
	build:        proc(self: ^Plugin, app_ctx: ^App),
	finish:       proc(),
	cleanup:      proc(),
}
