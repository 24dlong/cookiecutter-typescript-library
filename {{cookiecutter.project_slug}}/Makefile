SHELL := /bin/bash
.PHONY: setup-env registry-auth install lint test build pack-local publish

setup-env:
	corepack enable

registry-auth:
	. ./scripts/pnpm-auth.sh

install:
	make registry-auth
	pnpm install --frozen-lockfile
	pnpm setup:actionlint

lint:
	pnpm typecheck
	pnpm lint

test:
	pnpm coverage

build:
	pnpm build

# Build and pack a local tarball for testing in a consuming app. Each pack gets
# the next 0.0.0-local.N, because pnpm caches `file:` tarballs by name and version.
# `package.json` has no version (semantic-release sets it), so one is set for the
# pack only and always removed again.
#   make pack-local
#   make pack-local APP=../my-app
# With APP, the app's pnpm-workspace.yaml catalog entry (or package.json
# dependency) is pointed at the new tarball and `pnpm install` is run there.
LOCAL_TARBALL_DIR := $(CURDIR)/.cache/tarball

pack-local:
	@set -euo pipefail; \
	name=$$(node -p "require('./package.json').name"); \
	prefix=$$(echo "$$name" | sed 's/^@//; s|/|-|'); \
	mkdir -p "$(LOCAL_TARBALL_DIR)"; \
	last=$$(ls "$(LOCAL_TARBALL_DIR)" | sed -n 's/.*-0\.0\.0-local\.\([0-9]*\)\.tgz/\1/p' | sort -n | tail -1); \
	version="0.0.0-local.$$(( $${last:-0} + 1 ))"; \
	pnpm build; \
	trap 'pnpm --dir "$(CURDIR)" pkg delete version >/dev/null' EXIT; \
	pnpm pkg set version="$$version"; \
	pnpm pack --pack-destination "$(LOCAL_TARBALL_DIR)" >/dev/null; \
	tarball="$(LOCAL_TARBALL_DIR)/$$prefix-$$version.tgz"; \
	echo "Packed $$tarball"; \
	if [ -n "$(APP)" ]; then \
		( cd "$(APP)"; \
		file=$$(grep -l "$$name" pnpm-workspace.yaml package.json 2>/dev/null | head -1); \
		TARBALL="file:$$tarball" NAME="$$name" perl -pi -e 's|(\Q$$ENV{NAME}\E"?:\s*"?)(file:[^"\s]*\.tgz\|[0-9][^"\s]*)|$$1$$ENV{TARBALL}|' "$$file"; \
		echo "Updated $$file in $(APP)"; \
		pnpm install ); \
	fi

publish:
	. ./scripts/pnpm-auth.sh && pnpm semantic-release
