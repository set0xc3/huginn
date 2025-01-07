package main

import "base:runtime"
import "core:fmt"

import m "huginn:core/math"
import sapp "huginn:vendor/sokol/app"
import sg "huginn:vendor/sokol/gfx"
import sglue "huginn:vendor/sokol/glue"
import slog "huginn:vendor/sokol/log"

state: struct {
	default: struct {
		pass_action: sg.Pass_Action,
		pip:         sg.Pipeline,
		bind:        sg.Bindings,
	},
	rx, ry:  f32,
}

Vertex :: struct {
	x, y, r, g, b, a: f32,
}

init :: proc "c" () {
	context = runtime.default_context()

	sg.setup({environment = sglue.environment(), logger = {func = slog.func}})

	// a vertex buffer
	vertices := [?]Vertex {
		{-1.0, 1.0, 240.0 / 255, 241.0 / 255, 242.0 / 255, 1.0},
		{1.0, 1.0, 240.0 / 255, 241.0 / 255, 242.0 / 255, 1.0},
		{1.0, -1.0, 240.0 / 255, 241.0 / 255, 242.0 / 255, 1.0},
		{-1.0, -1.0, 240.0 / 255, 241.0 / 255, 242.0 / 255, 1.0},
	}
	state.default.bind.vertex_buffers[0] = sg.make_buffer(
		{data = {ptr = &vertices, size = size_of(vertices)}},
	)

	// an index buffer
	indices := [?]u16{0, 1, 2, 0, 2, 3}
	state.default.bind.index_buffer = sg.make_buffer(
		{type = .INDEXBUFFER, data = {ptr = &indices, size = size_of(indices)}},
	)

	// a shader and pipeline object
	state.default.pip = sg.make_pipeline(
		{
			shader = sg.make_shader(quad_shader_desc(sg.query_backend())),
			index_type = .UINT16,
			layout = {
				attrs = {
					ATTR_quad_position0 = {format = .FLOAT2},
					ATTR_quad_color0 = {format = .FLOAT4},
				},
			},
		},
	)

	// default pass action
	state.default.pass_action = {
		colors = {0 = {load_action = .CLEAR, clear_value = {1, 0, 1, 1}}},
	}
}

frame :: proc "c" () {
	context = runtime.default_context()

	t := f32(sapp.frame_duration() * 60.0)
	state.rx += 1.0 * t

	// projection_matrix := m.ortho_mat4(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0)
	vs_params := Vs_Params {
		position = {100.0, 100.0},
		size     = {100.0, 100.0},
		// projection = projection_matrix,
	}

	sg.begin_pass({action = state.default.pass_action, swapchain = sglue.swapchain()})
	sg.apply_pipeline(state.default.pip)
	sg.apply_bindings(state.default.bind)
	sg.apply_uniforms(UB_vs_params, {ptr = &vs_params, size = size_of(vs_params)})
	sg.draw(0, 6, 1)
	sg.end_pass()
	sg.commit()
}

compute_mvp :: proc(rx, ry, aspect, eye_dist: f32) -> m.mat4 {
	proj := m.persp(fov = 45.0, aspect = aspect, near = 0.01, far = 10.0)
	view := m.lookat(eye = {0.0, 0.0, eye_dist}, center = {}, up = m.up())
	view_proj := m.mul(proj, view)
	rxm := m.rotate(rx, {1.0, 0.0, 0.0})
	rym := m.rotate(ry, {0.0, 1.0, 0.0})
	model := m.mul(rym, rxm)
	mvp := m.mul(view_proj, model)
	return mvp
}

cleanup :: proc "c" () {
	context = runtime.default_context()
	sg.shutdown()
}

main :: proc() {
	sapp.run(
		{
			init_cb = init,
			frame_cb = frame,
			cleanup_cb = cleanup,
			width = 1920,
			height = 1080,
			window_title = "quad",
			icon = {sokol_default = false},
			logger = {func = slog.func},
		},
	)
}
