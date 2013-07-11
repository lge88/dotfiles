node:
	NODE_PATH=.. mocha entry.js

browser: build
	open browser/index.html

build: install
	component build -d

install:
	component install -d

update:
	node .update.js

.PHONY: build install update
