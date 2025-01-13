package ecs

MAX_COMPONENTS: uint : 128

ComponentMask :: bit_set[0 ..< MAX_COMPONENTS]

Component :: struct {}

Transform :: struct {}

Sprite :: struct {}

Physics :: struct {}
