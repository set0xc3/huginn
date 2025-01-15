package ecs

import "core:container/queue"
import "core:fmt"
import "core:mem"

DEFAULT_CAPACITY_ENTITIES: int : 1024

Context :: struct {
	entities: queue.Queue(Entity),
}

init :: proc(cap: int = DEFAULT_CAPACITY_ENTITIES) -> (self: ^Context) {
	self = new(Context)
	queue.init(&self.entities, cap)
	return
}

// TODO:
deinit :: proc(self: ^Context) {
}

// TODO:
register_component :: proc(using self: ^Context, $T: typeid) {

}

// TODO:
push_component :: proc(using self: ^Context, $T: typeid, entity_id: Entity_Id) -> T {
	return T{}
}

// TODO:
remove_component :: proc(using self: ^Context, component: $T) {
}

push_entity :: proc(using self: ^Context) -> Entity_Id {
	index := queue.len(entities)
	entity := Entity {
		id       = auto_cast index,
		is_valid = true,
	}
	queue.push(&entities, entity)
	return auto_cast index
}

remove_entity :: proc(using self: ^Context, id: Entity_Id) {
	queue.set(&entities, auto_cast id, Entity{})
}

is_valid :: proc(using self: ^Context, id: Entity_Id) -> bool {
	entity := queue.get_ptr(&entities, auto_cast id)
	return entity.id == id && entity.is_valid
}
