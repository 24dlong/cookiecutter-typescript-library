.PHONY: setup-env install lint test build publish

setup-env:
	corepack enable

install:
	yarn install
	yarn setup:actionlint
	cd "{{ cookiecutter.project_slug }}" && yarn install
	cd "{{ cookiecutter.project_slug }}" && yarn setup:actionlint

lint:
	yarn lint
	cd "{{ cookiecutter.project_slug }}" && yarn lint

test:
	cd "{{ cookiecutter.project_slug }}" && yarn coverage

build:
	cd "{{ cookiecutter.project_slug }}" && yarn build

publish:
	yarn semantic-release
