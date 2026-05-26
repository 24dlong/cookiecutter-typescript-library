SHELL := /bin/bash
.PHONY: setup-env registry-auth install lint test build publish

setup-env:
	corepack enable

registry-auth:
	. ./scripts/pnpm-auth.sh

install:
	pnpm install --frozen-lockfile
	pnpm setup:actionlint

lint:
	pnpm lint

test:
	pnpm coverage

build:
	pnpm build

publish:
	. ./scripts/pnpm-auth.sh && pnpm semantic-release
