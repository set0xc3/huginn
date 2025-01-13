package plugin

import "core:container/intrusive/list"
import "core:fmt"

import "huginn:core/command"
import "huginn:core/world"

CommandSender :: struct {
	send_command: proc(command: command.Command),
}

Plugin :: struct {
	on_init:            proc(world: ^world.World),
	on_update:          proc(world: ^world.World),
	on_fixed_update:    proc(world: ^world.World),
	on_cleanup:         proc(world: ^world.World),
	set_command_sender: proc(sender: CommandSender),
}
