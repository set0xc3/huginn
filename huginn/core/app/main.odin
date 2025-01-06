package app

import il "core:container/intrusive/list"
import "core:container/queue"

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
	plugins: il.List,
	systems: il.List,
}

new :: proc() -> App {
	return {}
}

add_plugin :: proc() {}

add_system :: proc(schedule: Schedule_Type, system: proc()) {
}

update :: proc() {}

run :: proc(self: ^App) {
	for !self.is_quit {
		break
	}
}

cleanup :: proc() {}
