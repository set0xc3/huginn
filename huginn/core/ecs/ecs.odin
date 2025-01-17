package ecs

import "core:container/queue"
import sa "core:container/small_array"
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
push_component :: proc(using self: ^Context, $T: typeid, entity_id: Entity_Id) -> ^T {
	entity := queue.get_ptr(&entities, entity_id)

	sa.push(&entity.components, T{})
	component := cast(^T)sa.get_ptr(&entity.components, sa.len(entity.components) - 1)
	component.variant = component

	#partial switch c in component.variant {
	case ^Transform:
		fmt.println(typeid_of(T))
		c.scale = {1.0, 1.0, 1.0}
	}

	component.entity_id = entity_id

	return cast(^T)component
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
