package ecs

EntityId :: distinct u64

Entity :: struct {
	id:   EntityId,
	mask: ComponentMask,
}
