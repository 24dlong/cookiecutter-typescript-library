import { expect, test } from "vitest";
import { add } from "../lib/math/add";

test("add 1 and 2 should equal 3", () => {
  expect(add(1, 2)).toBe(3);
});
