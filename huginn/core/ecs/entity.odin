package ecs

import sa "core:container/small_array"

Entity_Id :: distinct u64

Entity :: struct {
	id:         Entity_Id,
	parent:     Entity_Id,
	name:       string,
	is_valid:   bool,
	is_hidden:  bool,
	components: sa.Small_Array(32, Component),
}
