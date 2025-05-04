import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    coverage: {
      provider: "v8", // or 'istanbul'
      include: ["lib/**/*.ts"],
      reporter: ["text"],
    },
  },
});
