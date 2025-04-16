.PHONY: setup-env install lint test build publish

setup-env:
	corepack enable

install:
	pnpm install
	pnpm setup:actionlint

lint:
	pnpm lint

test:
	pnpm coverage

build:
	pnpm build

publish:
	pnpm semantic-release
