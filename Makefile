post-build:
	patchelf --remove-rpath $(BINARY)
	patchelf --set-interpreter /usr/lib64/ld-linux-x86-64.so.2 $(BINARY)

# build_release_sandbox:
# 	mkdir -p build/huginn/sandbox
# 	odin build huginn/sandbox -file -out:build/huginn/sandbox/release.bin -o:size -collection:huginn=huginn
# 	BINARY="build/huginn/sandbox/release.bin" $(MAKE) post-build

run_debug_sandbox-app:
	mkdir -p build/huginn/sandbox/app
	odin run huginn/sandbox/app -file -out:build/huginn/sandbox/app-debug.bin -o:none -debug -collection:huginn=huginn

run_debug_sandbox:
	mkdir -p build/huginn/sandbox
	tools/sokol-shdc -i huginn/sandbox/shader.glsl -o huginn/sandbox/shader.odin -l glsl430 -f sokol_odin
	odin run huginn/sandbox -file -out:build/huginn/sandbox/debug.bin -o:none -debug -collection:huginn=huginn

# run_release_sandbox:
# 	mkdir -p build/huginn/sandbox
# 	odin run huginn/sandbox -file -out:build/huginn/sandbox/release.bin -o:size -collection:huginn=huginn
