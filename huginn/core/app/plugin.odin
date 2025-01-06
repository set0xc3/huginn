package app

import il "core:container/intrusive/list"

Plugin_State :: enum {
	// Plugins are being added.
	Adding,
	// All plugins already added are ready.
	Ready,
	// Finish has been executed for all plugins added.
	Finished,
	// Cleanup has been executed for all plugins added.
	Cleaned,
}

Plugin :: struct {
	self: il.Node,
}

@(private)
plugin_build :: proc(self: ^Plugin) {}

@(private)
plugin_ready :: proc(self: ^Plugin) -> bool {return true}

@(private)
plugin_finish :: proc(self: ^Plugin) {}

@(private)
plugin_cleanup :: proc(self: ^Plugin) {}

@(private)
plugin_is_unique :: proc(self: ^Plugin) {}
