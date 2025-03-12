.PHONY: setup-env install lint test build release

setup-env:
	corepack enable

install:
	yarn install

lint:
	yarn lint

test:
	yarn coverage

build:
	yarn build

release:
	yarn semantic-release