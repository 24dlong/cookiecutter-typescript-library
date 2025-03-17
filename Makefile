.PHONY: setup-env install lint test build publish

setup-env:
	corepack enable
	yarn setup:actionlint

install:
	yarn install

lint:
	yarn lint

test:
	yarn coverage

build:
	yarn build

publish:
	yarn semantic-release
