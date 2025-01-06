huginn:
- core
  - app
  - ecs
  - input
  - render
  - window
- sandbox
- vendor

```shell
odin run src/command/main.odin -file -out:build/huginn.bin -build-mode:exe -o:none -debug
odin run src/command/main.odin -file -out:build/huginn.bin -build-mode:exe -o:speed
```
