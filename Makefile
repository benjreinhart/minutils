default: build

BIN = node_modules/.bin
SRCDIR = src
LIBDIR = lib

SRC = $(shell find "$(SRCDIR)" -name "*.coffee" -type f | sort)
LIB = $(SRC:$(SRCDIR)/%.coffee=$(LIBDIR)/%.js)

MOCHA = $(BIN)/mocha  --compilers coffee:coffee-script-redux/register -r coffee-script-redux/register
COFFEE = $(BIN)/coffee --js
CJSIFY = $(BIN)/cjsify

.PHONY: test

all: build cjsify cjsify-min test
build: $(LIB)

$(LIBDIR)/%.js: $(SRCDIR)/%.coffee
	@mkdir -p "$(@D)"
	$(COFFEE) <"$<" >"$@"

cjsify: build
	$(CJSIFY) lib/index.js --export mu --output ./minutils.js

cjsify-min: build
	$(CJSIFY) lib/index.js --export mu --minify --output ./minutils.min.js

test: build
	$(MOCHA) --reporter spec --recursive --colors
