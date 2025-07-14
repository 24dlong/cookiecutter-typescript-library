import { expect, test } from "vitest";
import { multiply } from "../src/math/multiply";

test("multiply 1 and 2 should equal 2", () => {
  expect(multiply(1, 2)).toBe(2);
});
