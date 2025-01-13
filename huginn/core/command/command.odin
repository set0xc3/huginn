package command

import "huginn:core/world"

Command :: struct {
	execute: proc(world: ^world.World),
	undo:    proc(world: ^world.World),
}
