# Typescript Library Cookiecutter

This repository is meant to serve as a template for creating a bare bones
library for use in Typescript applications. It uses:

- TypeScript
- Yarn Berry as the package manager
- Vite as the bundling tool
- Vitest for testing

Additionally, the library is compiled using ESNext, so consuming applications are responsible for transpiling
for older environments if needed.

## Contributing
1. In order for your IDE to play nicely with Yarn Berry & TypeScript, you'll likely need to do some additional setup. See [Yarn's documentation](https://yarnpkg.com/getting-started/editor-sdks) and find the section that pertains to your IDE.

## Steps to Recreate this Template

### Configuring Yarn
1. Run `yarn init -2` to install Yarn.
1. Open `.gitignore`and follow instructions to setup yarn zero-installs and swap comments on the suggested lines.

### Setup Typescript
1. Run `yarn add --dev typescript` to install TypeScript as a dev dependency.
1. Run `yarn add --dev @yarnpkg/sdks` to ensure TypeScript compability with Yarn Berry.
1. Follow the instructions in [Yarn's documentation](https://yarnpkg.com/getting-started/editor-sdks) for your IDE of choice.
1. Run `yarn tsc --init` to create a `tsconfig.json` file.
1. Make desired changes, most notably reviewing [Vite's recommendations](https://vite.dev/guide/features#typescript)


### Project Scaffolding
1. Create the `dist`, `lib`, and `test` directories.
1. Add `dist/` to .gitignore
1. Add some code to `/lib` and tests to `/tests`
1. Add a `/lib/index.ts` file to manage exports.
1. Add a `"version"` to `package.json`

### Setup Vite as the Build Tool
1. Run `yarn add --dev vite` to add `vite` as a dev dependency.
1. Create a `vite.config.js` file in the root directory.
1. Add the `"build"` script to `package.json`
1. Add `"type": "module"` to `package.json` to address the [Vite CJS Deprecation](https://vite.dev/guide/troubleshooting.html#vite-cjs-node-api-deprecated) warning
1. Add the `"main"` and `"module"` attributes to `package.json` to specify the package entrypoints

### Setup Vitest as the Test Tool
1. Run `yarn add --dev vitest @vitest/coverage-v8` to install `vitest` dev dependencies.
1. Update `vite.config.js` file, adding the `test` attribute
1. Add the `"test"` and `"coverage"` scripts to `package.json`