package main

import "core:fmt"
import "huginn:core/ecs"

main :: proc() {
	ecs_ctx := ecs.init()
	defer ecs.deinit(ecs_ctx)
}
