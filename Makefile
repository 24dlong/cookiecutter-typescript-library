SHELL := /bin/bash
.PHONY: setup-env registry-auth install lint test build publish

setup-env:
	corepack enable

registry-auth:
	. ./scripts/pnpm-auth.sh

install:
	make registry-auth
	pnpm install --frozen-lockfile
	pnpm setup:actionlint
	cd "{{cookiecutter.project_slug}}" && make install

lint:
	pnpm lint
	cd "{{cookiecutter.project_slug}}" && make lint

test:
	cd "{{cookiecutter.project_slug}}" && make test

build:
	cd "{{cookiecutter.project_slug}}" && make build

publish:
	. ./scripts/pnpm-auth.sh && pnpm semantic-release
