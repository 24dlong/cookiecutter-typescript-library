# {{ cookiecutter.project_name }}

### Installation

This library is published to a private AWS CodeArtifact repository. To install packages from the private registry you must authenticate with AWS CodeArtifact first.

Prerequisites

- AWS CLI installed and configured for the runner or local machine.

Required environment variables

- `AWS_CODE_ARTIFACT_DOMAIN` — CodeArtifact domain.
- `AWS_ACCOUNT_ID` — AWS account ID that owns the domain.
- `AWS_CODE_ARTIFACT_REPOSITORY` — CodeArtifact repository name.
- `AWS_CODE_ARTIFACT_NAMESPACE` — npm scope (e.g. `@24dlong`).
- `AWS_REGION` or `AWS_DEFAULT_REGION` — AWS region for the CodeArtifact domain.

Authenticate and install

1. Export the required variables (or set them in CI environment).

```bash
export AWS_CODE_ARTIFACT_DOMAIN=your-domain
export AWS_ACCOUNT_ID=123456789012
export AWS_CODE_ARTIFACT_REPOSITORY=shared-services
export AWS_CODE_ARTIFACT_NAMESPACE=@24dlong
```

2. Copy `scripts/pnpm-auth.sh` from this repository into your repository and run it
3. Add the package via `pnpm add @24dlong/auth`

## Usage

The library is compiled using TypeScript only and outputs ECMAScript modules (ESM). It is not bundled with tools like Vite or Rollup, so any further bundling or optimization is the responsibility of the consuming application.

## Contributing

This library uses:

- TypeScript
- pnpm as the package manager
- Vitest for testing
- Commits follow conventional commit format

### Test this library in a local app

Consume a packed tarball, not a bare `file:` link to the checkout. A tarball contains exactly what gets published (`dist` only), and pnpm copies it into the app's store.

pnpm caches a `file:` tarball by its file name and version. Packing again under the same version leaves the app on the stale copy, so **every pack needs a new local version**. `package.json` has no `version` (semantic-release sets it on publish), so a version is set for the pack only and removed afterwards. Tarballs go in `.cache/tarball`, which is git-ignored.

From this repository, run the make target. It builds, picks the next `0.0.0-local.N`, packs, and never leaves a version in `package.json`:

```bash
make pack-local
```

Pass `APP` to also point a consuming app at the new tarball and install it there. It updates the `{{ cookiecutter.scope + "/" if cookiecutter.scope }}{{ cookiecutter.project_slug }}` entry in the app's `pnpm-workspace.yaml` catalog (or its `package.json` dependency) and runs `pnpm install`:

```bash
make pack-local APP=../my-app
```

Then restart the app's dev server, and clear the bundler cache if it still shows the old code (for Expo: `expo start --clear`).

Without `APP`, set the dependency yourself:

```yaml
catalog:
  "{{ cookiecutter.scope + "/" if cookiecutter.scope }}{{ cookiecutter.project_slug }}": file:/path/to/{{ cookiecutter.project_slug }}/.cache/tarball/<tarball-name>-0.0.0-local.N.tgz
```

Before opening a PR in the app, switch the entry back to the published version. Do not commit the `file:` path.

Check what was packed with `tar -tzf .cache/tarball/<tarball-name>-0.0.0-local.N.tgz`.
