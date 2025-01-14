package ecs

Entity_Hanlde :: distinct uint

Entity :: struct {
	id:       Entity_Hanlde,
	is_valid: bool,
	variant:  Component_Variant,
}
