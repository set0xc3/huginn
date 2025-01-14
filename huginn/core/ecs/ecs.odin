package ecs

import "core:container/queue"
import sa "core:container/small_array"
import "core:fmt"

MAX_ENTITIES: int : 1024

Context :: struct {
	entities: sa.Small_Array(MAX_ENTITIES, Entity),
}

init :: proc() -> (self: ^Context) {
	self = new(Context)
	return
}

deinit :: proc(self: ^Context) {
	free(self)
}

push_entity :: proc(using self: ^Context) -> Entity_Hanlde {
	idx := sa.len(entities)
	entity := Entity {
		id       = auto_cast idx,
		is_valid = true,
	}

	err := sa.push(&entities, entity)
	assert(err != false)

	return auto_cast idx
}

remove_entity :: proc(using self: ^Context, id: Entity_Hanlde) {
	sa.set(&entities, auto_cast id, Entity{})
}

is_valid :: proc(using self: ^Context, id: Entity_Hanlde) -> bool {
	entity := sa.get_ptr(&entities, auto_cast id)
	return entity.id == id && entity.is_valid
}
