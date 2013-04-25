
refresh: reconfigure debug

debug: all configure-development
	@NODE_PATH=lib node --debug index.js

debug-brk: all configure-development
	@NODE_PATH=lib node --debug-brk index.js

run: all configure-production pre-build
	@NODE_PATH=lib NODE_ENV=production node index.js

pre-build:
	@scripts/{{pkgName}}-build -a

all: node_modules components public

test:
	@scripts/{{pkgName}}-test

node_modules:
	@npm install

public:
	@mkdir -p public

components:
	@component install

clean: clean-components clean-public clean-configures

clean-configures:
	@rm -fr configure*

clean-components:
	@rm -fr components

clean-public:
	@rm -fr public

clean-npms:
	@rm -fr node_modules

wipe: clean-npms clean

configure: configure-dev.js configure-prod.js

reconfigure: clean-configures
	@echo "Reconfigure..."
	@scripts/{{pkgName}}-config -d
	@scripts/{{pkgName}}-config -p

configure-dev.js: 
	@scripts/{{pkgName}}-config -d

configure-prod.js:
	@scripts/{{pkgName}}-config -p

configure-development: configure-dev.js
	@echo "Using development configure..."
	@ln -fs configure-dev.js configure.js

configure-production: configure.prod.js
	@echo "Using production configure..."
	@ln -fs configure-dev.js configure.js

.PHONY: debug debug-brk test clean components configure-development configure-production all configure pre-build
