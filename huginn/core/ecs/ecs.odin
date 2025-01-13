package ecs

Ecs :: struct {
	entities:   map[EntityId]Entity,
	components: map[Entity]map[string]Component,
	entity_idx: EntityId,
}

init :: proc() -> (ecs: ^Ecs) {
	ecs = new(Ecs)
	ecs.entities = make(map[EntityId]Entity)
	ecs.components = make(map[string]Component)
	return
}

deinit :: proc(ecs: ^Ecs) {
	delete(ecs.entities)
	delete(ecs.components)
	free(ecs)
}

registerComponent :: proc($T: typeid) {}

addComponent :: proc(id: EntityId, $T: typeid) {
}

getComponent :: proc(id: EntityId) {
}

deleteComponent :: proc(id: EntityId) {
}

hasComponent :: proc(id: EntityId, $T: typeid) -> bool {
	return false
}

createEntity :: proc(ecs: ^Ecs) -> EntityId {
	return 0
}

deleteEntity :: proc(id: EntityId) {}
