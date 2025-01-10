import { defineConfig } from 'vitest/config';

const libraryName = "library";

export default defineConfig({
    build: {
        lib: {
            entry: "lib/main.ts", // Your library's entry point
            name: libraryName, // Global variable name for UMD builds
            fileName: (format) => `${libraryName}.${format}.js`,
        },
        outDir: 'dist',    
    },
    cacheDir: '.vite',
    test: {
        coverage: {
            provider: "v8", // or 'istanbul'
            include: ["lib/**/*.ts"],
            reporter: ['text'],
        }
    },
});
