package ecs

import "core:container/queue"

Entity_Id :: distinct u64

Entity :: struct {
	id:        Entity_Id,
	parent:    Entity_Id,
	name:      string,
	is_valid:  bool,
	is_hidden: bool,
	variant:   Component_Variant,
}
