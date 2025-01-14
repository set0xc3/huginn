package main

import "core:fmt"
import "huginn:core/ecs"

import "core:log"
import "core:mem"
import virt "core:mem/virtual"

main :: proc() {
	arena: virt.Arena
	err := virt.arena_init_static(&arena)
	assert(err == .None)
	context.allocator = virt.arena_allocator(&arena)

	arena_temp := virt.arena_temp_begin(&arena)
	ecs_ctx := ecs.init()
	defer ecs.deinit(ecs_ctx)

	ent_a := ecs.push_entity(ecs_ctx)
	if ecs.is_valid(ecs_ctx, ent_a) {
		fmt.println("valided")
	}
	virt.arena_temp_end(arena_temp)
}
