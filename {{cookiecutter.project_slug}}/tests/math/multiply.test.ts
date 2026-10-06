import { expect, test } from "vitest";
import { multiply } from "../../src/main.js";

test("multiply 1 and 2 should equal 2", () => {
  expect(multiply(1, 2)).toBe(2);
});
