
node: update
	NODE_PATH=.. mocha entry.js

browser: build
	if [[ `uname` == Darwin ]]; then open build/mocha.html;else gnome-open build/mocha.html;fi

build: components update
	component build -d

components:
	component install -d

update:
	node bin/update.js

create:
	@echo "create test file: $(test)"
	cp bin/template.js $(test)

.PHONY: build create update
