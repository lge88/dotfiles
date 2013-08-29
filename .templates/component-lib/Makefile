
SRC = $(wildcard lib/*.js)

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
	OPEN=gnome-open
endif
ifeq ($(UNAME), Darwin)
	OPEN=open
endif

build: components $(SRC) component.json
	@(node bin/build.js && touch components)

__pkgName__.js: components
	@component build --standalone __pkgName__ --name __pkgName__ --out .

components: component.json
	@(component install --dev && touch components)

clean:
	rm -fr build components template.js

component.json: $(SRC)
	@node bin/add-files.js

test: build
	$(OPEN) test/index.html

demo: build
	$(OPEN) examples/index.html

.PHONY: clean __pkgName__.js test
