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

Use a `file:` dependency from the consuming app. This keeps the setup simple and points the app at this local checkout.

First, build this library:

```bash
cd /Users/dlong/Documents/Coding/{{cookiecutter.project_slug}}
pnpm install
pnpm build
```

Then, in the consuming app's `package.json`, set the dependency to this local path:

```json
{
  "dependencies": {
    "@24dlong/{{cookiecutter.project_slug}}": "file:/Users/dlong/Documents/Coding/{{cookiecutter.project_slug}}"
  }
}
```

Install dependencies from the consuming app:

```bash
pnpm install
```

When you change this library, run `pnpm build` here again. If the consuming app does not pick up the change, run `pnpm install` in the consuming app again and restart its dev server.
