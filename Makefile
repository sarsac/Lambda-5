SOURCE_DIR := src
SOURCE := $(shell find $(SOURCE_DIR) -name "*.c")
HEADER := $(shell find $(SOURCE_DIR) -name "*.h")

FLAGS := -std=c18 -Wall -Werror -pedantic -fmax-errors=5

.PHONY: build
build: $(SOURCE) $(HEADER)
	@gcc $(FLAGS) $(SOURCE) -o .bin/main

.PHONY: release
release: $(SOURCE) $(HEADER)
	@gcc -O3 $(FLAGS) $(SOURCE) -o .bin/release


.PHONY: debug
debug: $(SOURCE) $(HEADER)
	@gcc -g $(FLAGS) $(SOURCE) -o .bin/debug

EMCC_EXPORT="_M_CompilerJS_init", "_M_CompilerJS_quit", "_M_CompilerJS_parse", "_M_CompilerJS_color_HTML", "_M_CompilerJS_get_errors", "_M_CompilerJS_print_tree"
EMCC_FLAGS=-s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall","cwrap"]' -s ALLOW_MEMORY_GROWTH=1

.PHONY: web
web: $(SOURCE) $(HEADER)
	@emcc $(SOURCE) -O3 -o docs/editor/bin/compiler.js -s EXPORTED_FUNCTIONS='[$(EMCC_EXPORT)]' $(EMCC_FLAGS)