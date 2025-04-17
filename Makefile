.PHONY: setup-env install lint test build publish

setup-env:
	corepack enable

install:
	pnpm install
	pnpm setup:actionlint
	cd "{{cookiecutter.project_slug}}" && pnpm install
	cd "{{cookiecutter.project_slug}}" && pnpm setup:actionlint

lint:
	pnpm lint
	cd "{{cookiecutter.project_slug}}" && pnpm lint

test:
	cd "{{cookiecutter.project_slug}}" && pnpm coverage

build:
	cd "{{cookiecutter.project_slug}}" && pnpm build

publish:
	pnpm semantic-release
