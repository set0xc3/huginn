package main

import "core:fmt"
import "huginn:core/ecs"

main :: proc() {
	ecs_ctx := ecs.init()
	defer ecs.deinit(ecs_ctx)

	ent_a := ecs.push_entity(ecs_ctx)
	if ecs.is_valid(ecs_ctx, ent_a) {
		fmt.println("valided")
	}
}
