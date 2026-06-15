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
	cd "{{cookiecutter.project_slug}}" && pnpm lint

test:
	cd "{{cookiecutter.project_slug}}" && pnpm coverage

build:
	cd "{{cookiecutter.project_slug}}" && pnpm build

publish:
	. ./scripts/pnpm-auth.sh && pnpm semantic-release
