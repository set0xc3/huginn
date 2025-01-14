package main

import "core:fmt"
import "huginn:core/ecs"

import "core:log"
import "core:mem"

main :: proc() {
	context.logger = log.create_console_logger()
	tracking_allocator: mem.Tracking_Allocator
	mem.tracking_allocator_init(&tracking_allocator, context.allocator)
	context.allocator = mem.tracking_allocator(&tracking_allocator)
	reset_tracking_allocator :: proc(a: ^mem.Tracking_Allocator) -> bool {
		err := false

		for _, value in a.allocation_map {
			fmt.printf("%v: Leaked %v bytes\n", value.location, value.size)
			err = true
		}

		mem.tracking_allocator_clear(a)
		return err
	}
	defer reset_tracking_allocator(&tracking_allocator)

	arena: mem.Arena
	arena_buffer: [1024]byte
	mem.arena_init(&arena, arena_buffer[:])
	app_arena := mem.arena_allocator(&arena)

	arena_temp := mem.begin_arena_temp_memory(&arena)
	mem.end_arena_temp_memory(arena_temp)

	// ecs_ctx := ecs.init()
	// defer ecs.deinit(ecs_ctx)

	// ent_a := ecs.push_entity(ecs_ctx)
	// if ecs.is_valid(ecs_ctx, ent_a) {
	// 	fmt.println("valided")
	// }

}
