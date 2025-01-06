post-build:
	patchelf --remove-rpath $(BINARY)
	patchelf --set-interpreter /usr/lib64/ld-linux-x86-64.so.2 $(BINARY)

pre-build:
	mkdir -p build/huginn/sandbox
	tools/sokol-shdc -i huginn/sandbox/ui/shader.glsl -o huginn/sandbox/ui/shader.odin -l glsl430 -f sokol_odin

build_release_sandbox-ui: pre-build
	odin build huginn/sandbox/ui -file -out:build/huginn/sandbox/ui-release.bin -o:size -collection:huginn=huginn
	BINARY="build/huginn/sandbox/ui-release.bin" $(MAKE) post-build

run_debug_sandbox-ui: pre-build
	odin run huginn/sandbox/ui -file -out:build/huginn/sandbox/ui-debug.bin -o:none -debug -collection:huginn=huginn

run_release_sandbox-ui: pre-build
	odin run huginn/sandbox/ui -file -out:build/huginn/sandbox/ui-release.bin -o:size -collection:huginn=huginn
