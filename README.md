# Typescript Library Cookiecutter

This repository is meant to serve as a template for creating a bare bones Typescript library.
It uses:

- TypeScript
- pnpm as the package manager
- Vite as the bundling tool
- Vitest for testing

Additionally, the library is compiled using ESNext, so consuming applications are responsible for
transpiling for older environments if needed.

## Usage

Cookiecutter is a python tool used to easily create new repositories from "cookiecutter" templates.
As such, the steps to use this particular template are as follows:

1. Install [Python 3](https://www.python.org/downloads/) if it isn't already installed.
1. Run `pip install pipx` to install `pipx`, which is recommended for running python tools.
1. `cd` into the directory where you want your new repository to be created.
1. Run `pipx run cookiecutter gh:24dlong/cookiecutter-typescript-library`
1. Follow the in-terminal prompts to provide the necessary inputs

## Contributing

1. Run `make setup-env` once before starting development.

## How this Template was Created

### Configuring pnpm

1. Run `pnpm init` to setup pnpm as the package manager.
1. Add the `node_modules` and `.pnpm` directories to the `.gitignore` file.
   x

### Setup Typescript

1. Run `pnpm add -D typescript` to install TypeScript as a dev dependency.
1. Run `pnpm tsc --init` to create a `tsconfig.json` file.
1. Make desired changes, most notably reviewing [Vite's recommendations](https://vite.dev/guide/features#typescript)

### Project Scaffolding

1. Create the `dist`, `lib`, and `test` directories.
1. Add `dist/` to .gitignore
1. Add some code to `/lib` and tests to `/tests`
1. Add a `/lib/index.ts` file to manage exports.
1. Add a `"version"` to `package.json`

### Setup Vite as the Build Tool

1. Run `pnpm add --D vite`.
1. Create a `vite.config.js` file in the root directory.
1. Add the `"build"` script to `package.json`
1. Add `"type": "module"` to `package.json` to address the [Vite CJS Deprecation](https://vite.dev/guide/troubleshooting.html#vite-cjs-node-api-deprecated) warning
1. Add the `"main"` and `"module"` attributes to `package.json` to specify the package entrypoints

### Setup Vitest as the Test Tool

1. Run `pnpm add -D vitest @vitest/coverage-v8`.
1. Update `vite.config.js` file, adding the `test` attribute
1. Add the `"test"` and `"coverage"` scripts to `package.json`

### Setup Linters

#### ESLint

1. Run `pnpm create @eslint/config` and answer prompts.
1. Add `{ignores: [...]}` object to `eslint.config.js`.

#### Prettier

1. Run `pnpm add -D --exact prettier eslint-config-prettier`.
1. Create a `.prettier.rc` and `.prettierignore` files.
1. Add `eslintConfigPrettier` to the `eslint.config.js` file.
1. Add the `"lint"` script to `package.json`

#### Husky & lint-staged

1. Run `pnpm add -D husky lint-staged`.
1. Run `npx husky init`
1. Add a `.lintstagedrc` configuration file.
1. Update `.husky/pre-commit` to run `lint-staged`

#### commitlint

1. Run `pnpm add -D @commitlint/{cli,config-conventional}`
1. Create a `commitlint.config.js` file
1. Add a `.husky/commit-msg` file to run `commitlint`

### Setup semantic-release

1. Run `pnpm add -D @semantic-release @semantic-release/changelog`
1. Create a `.releaserc` file

### Create Github Workflows

The vast majority of the code for these workflows is saved centrally in the
[github-actions-library](https://github.com/24dlong/github-actions-library).
However, some minor setup is still needed at the repository level.

#### Merge Workflow

1. Create a .nvmrc file
1. Set the paths option.
1. Set the permissions needed by the publish action.
1. Setup the necessary repository variables in GitHub.

### Configure Dependabot

This repository uses Dependabot to manage dependency updates. To enable Dependabot:

1. Create a `dependabot.yml` file in the `.github` directory
