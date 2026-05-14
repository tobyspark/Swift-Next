# Swift-Next Modernization Plan: Swift 5.7 → 6.3

This document enumerates the grammar, keyword, and lexical additions per Swift
release that `Swift.sublime-syntax` does not yet cover, with proposed scope
names that match existing conventions in the file (see `keyword.control.*`,
`keyword.declaration.*`, `storage.modifier.*`, `keyword.operator.*`,
`meta.annotation.*`, `support.function.annotation.*`, `constant.language.*`).

Scope verification sources:

- `Swift.sublime-syntax` (existing patterns are the canonical guide)
- `sublimehq/Packages` (e.g. Rust, JavaScript) for `meta.attribute`, regex
  delimiter handling, and `storage.modifier` placement
- `https://www.sublimetext.com/docs/scope_naming.html`

The "Currently covered?" answers are based on a full read of
`Swift.sublime-syntax` and confirmed by `grep` for each token; line numbers
quoted refer to the current file. Where this plan proposes adding a brand-new
scope leaf, it follows the longest sibling already present (e.g. existing
`storage.modifier.actor-isolation.nonisolated.swift` → new
`storage.modifier.actor-isolation.isolated.swift` already in the file at
`Swift.sublime-syntax:974`).

References for grammar evolution: TSPL `RevisionHistory.md` per release plus
the SE proposals at `https://github.com/swiftlang/swift-evolution/tree/main/proposals`.
SE numbers below are taken from the proposal index for the corresponding
release. They must be re-checked when each branch starts (a proposal can land
in a different release than originally targeted).

---

## Swift 5.7 — branch `swift-5.7`

TSPL summary: regular-expression literals, `if let shorthand`, `#unavailable`,
`Sendable` types, `@unchecked`. SE proposals primarily affecting the lexer /
parser surface that the syntax file must recognise:

- [ ] **Regex literals** `/.../` and extended `#/.../#`, including multi-line
      form (SE-0354 *Regex Literals*, SE-0355 *Regex Syntax*).
      Scope: `string.regexp.swift` with
      `punctuation.definition.string.begin.swift` /
      `…end.swift`; extended delimiters use
      `punctuation.definition.annotation.begin/end.swift` (mirrors
      `extended-string-literal` at `Swift.sublime-syntax:473`). See the Risk
      section below — this is the single hardest item.
- [ ] **`any P` existential explicit form** (SE-0335). The bareword `any` is
      already matched at `Swift.sublime-syntax:951` as
      `storage.modifier.existential.swift`. Verify it scopes correctly when
      `any` appears in parameter / return positions and inside generic
      argument lists; no new scope, but a test is required.
- [ ] **`some P` in parameter position** (SE-0341 *Opaque Parameter
      Declarations*). `some` is matched at `Swift.sublime-syntax:946`
      as `storage.modifier.opaque.swift`; same caveat as `any` — extend
      tests to parameter positions.
- [ ] **Primary associated types** `protocol P<T>` and `some P<Element ==
      Int>` (SE-0346). No new keyword, but the generic-argument parser
      around `protocol` declarations and conformance constraints needs a
      test. Scope reuses existing `meta.generic.swift` /
      `punctuation.definition.generic.begin/end.swift`.
- [ ] **`#unavailable(...)`** (SE-0290 expanded). Already partially handled
      at `Swift.sublime-syntax:1878` (`(\#)(available|unavailable)`) and a
      smoke test exists in `tests/syntax_test-grammar-test.swift`; add a
      dedicated assertion file.
- [ ] **`distributed actor` / `distributed func`** (SE-0336). `distributed`
      appears in the `reserved_word` regex
      (`Swift.sublime-syntax:74`) but is not given a `storage.modifier`
      scope. Proposed: `storage.modifier.distributed.swift`.
- [ ] **`buildPartialBlock(first:)` / `buildPartialBlock(accumulated:next:)`**
      (SE-0348). Library-only; no syntax change needed.
- [ ] **Implicitly-opened existentials** (SE-0352). No new tokens; verify
      tests for calls of generic functions on `any P` values.

## Swift 5.8 — branch `swift-5.8`

TSPL summary: `defer` outside error handling (no syntax change); minor
additions. SE proposals with surface impact:

- [ ] **`@backDeployed(before: ...)`** (SE-0376). Add to the
      `attribute-builtins` list at `Swift.sublime-syntax:1594`. Scope:
      `support.function.annotation.swift` (matches siblings such as
      `@available`).
- [ ] **Conditional attribute `#if hasAttribute(...)`** (SE-0367) /
      `hasFeature(...)` for `#if`. Add the predicates to
      `compiler-compilation-condition` at
      `Swift.sublime-syntax:1997`. Scope:
      `support.function.preprocessor.platform-condition.swift` (matches
      `canImport`, `os`, etc.).
- [ ] **Concise magic file names** — no new tokens; covered by existing
      `#file` / `#fileID` / `#filePath` at `Swift.sublime-syntax:2080`.

## Swift 5.9 — branch `swift-5.9`

The largest single jump. TSPL highlights: `if`/`switch` expressions, macros,
parameter packs, ownership modifiers.

- [ ] **`if` and `switch` expressions** (SE-0380). No new keywords; the
      challenge is allowing `if` / `switch` to start a value expression after
      `=`, `return`, in tuple elements, etc. The current `keyword-control-flows`
      already matches these keywords; tests must confirm scoping inside
      `let x =` and `return` contexts.
- [ ] **Macros — declarations** (SE-0382, SE-0389):
  - `@freestanding(expression)` / `@freestanding(declaration)` /
    `@attached(...)` — add to `attribute-builtins`
    (`Swift.sublime-syntax:1594`). Inside the parens, the role keywords
    `expression`, `declaration`, `accessor`, `memberAttribute`, `member`,
    `peer`, `conformance`, `extension`, `preamble`, `body` should get
    `constant.language.attribute-option.swift` (matches the `inline(...)`
    pattern at `Swift.sublime-syntax:1651`).
  - `macro` declaration keyword. Proposed:
    `keyword.declaration.macro.swift` (sibling of
    `keyword.declaration.function.swift`).
- [ ] **Macro expansion expressions** `#foo(...)` and attached
      `@foo` (SE-0382). Add a `#identifier(` form to
      `compiler-literals` (`Swift.sublime-syntax:2074`) — but
      restricted to user identifiers, not the existing built-in `#file`
      list. Proposed: `meta.macro-expansion.swift` with
      `variable.function.macro.swift`; `@foo` falls through to existing
      `attribute-custom`.
- [ ] **Parameter packs / variadic generics** (SE-0393, SE-0398):
  - Contextual `each` — both as a generic parameter introducer
    (`<each T>`) and as a value-level expansion (`each pack`). Proposed:
    `keyword.operator.expansion.each.swift`.
  - Contextual `repeat` for pack expansion at expression / type
    position (distinct from the `repeat`-`while` loop already matched at
    `Swift.sublime-syntax:735`). Proposed:
    `keyword.operator.expansion.repeat.swift`.
- [ ] **Ownership modifiers as parameter modifiers** `borrowing` /
      `consuming` (SE-0377). Add to `modifier-for-parameter`
      (`Swift.sublime-syntax:962`). Proposed:
      `storage.modifier.ownership.borrowing.swift` and
      `…consuming.swift` (parallel to the existing
      `storage.modifier.mutation.mutating.swift` at
      `Swift.sublime-syntax:917`).
- [ ] **`consume x` expression** (SE-0366). Proposed:
      `keyword.operator.word.consume.swift` (sibling of
      `keyword.operator.word.type-casting.is.swift` at
      `Swift.sublime-syntax:714`).
- [ ] **`discard self` statement** (SE-0390). Proposed:
      `keyword.control.flow.discard.swift` (sibling of `defer` at
      `Swift.sublime-syntax:827`).
- [ ] **`~Copyable` suppressed conformance** (SE-0390). The leading `~`
      should be `keyword.operator.suppressed-conformance.swift`; `Copyable`
      itself is a `support.class.swift` (already covered by the prefixed
      type-name rule at `Swift.sublime-syntax:2158`). Most syntax engines
      will already paint this correctly; a test pin is enough.
- [ ] **Result builder transforms in attributes** (SE-0348 continuation).
      No new tokens.

## Swift 5.10 — branch `swift-5.10`

TSPL highlights: nested protocols, `UIApplicationMain` / `NSApplicationMain`
deprecation. No new keywords or punctuators.

- [ ] **`@UIApplicationMain` / `@NSApplicationMain`** marked deprecated — these
      are already in `attribute-builtins`
      (`Swift.sublime-syntax:1608`, `:1612`); no change.
- [ ] **Strict-concurrency-only changes** — no surface lexical impact, but
      add a test asserting `@MainActor`, `nonisolated`, `Sendable`
      continue to scope correctly inside nested protocol declarations.

## Swift 6.0 — branch `swift-6.0`

TSPL highlights: strict concurrency at language level, `package` access,
typed throws, macro-as-default-value.

- [ ] **`package` access level** (SE-0386). Extend
      `access_levels` variable at `Swift.sublime-syntax:94` to include
      `package`. Add a new capture in `modifier-access-level`
      (`Swift.sublime-syntax:900`). Proposed:
      `storage.modifier.access-level.package.swift`.
- [ ] **Typed throws** `throws(SomeError)` (SE-0413). The bare `throws` is
      handled at `Swift.sublime-syntax:841`
      (`keyword.declaration.throws.swift`). Add a follow-on push for the
      `(Error)` clause: the parens become
      `punctuation.section.parens.begin/end.swift`, the inner type goes
      through the existing `types` include.
- [ ] **`@preconcurrency`** is already in `attribute-builtins` at
      `Swift.sublime-syntax:1633`; verify.
- [ ] **Strict concurrency: `nonisolated(unsafe)`** (SE-0412). Existing
      `modifier-actor-isolation` (`Swift.sublime-syntax:923`) only
      matches the bare `nonisolated`. Extend it to consume an optional
      `(unsafe)` argument; reuse `constant.language.attribute-option.swift`
      for the inner `unsafe` (matches the `unowned(safe)` pattern at
      `Swift.sublime-syntax:928`).
- [ ] **`count(where:)` etc.** — library-only; ignore.
- [ ] **`noasync` availability argument** (SE-0327 / SE-0431). Already
      present in `compiler-availability` at
      `Swift.sublime-syntax:1919`; verify.

## Swift 6.1 — branch `swift-6.1`

TSPL summary: `some` as lightweight generic syntax for parameters
(restated from 5.7), `noasync` argument to `@available` (above).

- [ ] **Opaque parameter types** — already covered by SE-0341 work in 5.7;
      add a dedicated assertion file that exercises `func f(_ x: some
      Equatable)` to lock the scope.
- [ ] **`@available(*, noasync)`** — covered, add test.

No new keywords or punctuators are introduced in 6.1.

## Swift 6.2 — branch `swift-6.2`

TSPL highlights: memory-safety chapter, `if case` pattern restatement, main
actor / isolation expansion, implicit protocol conformance and suppression.

- [ ] **`@concurrent`, `@isolated`, `@MainActor` propagation, `#isolation`**
      (SE-0420 / SE-0431). The macro-like literal `#isolation` should be
      added to `compiler-literals` (`Swift.sublime-syntax:2074`)
      with scope `keyword.other.preprocessor.swift` (matches `#file`).
- [ ] **`nonisolated(nonsending)`** parameter modifier (SE-0461). Extend
      the `nonisolated` push in `modifier-actor-isolation` (already
      proposed for 6.0) with another permitted option `nonsending`,
      scoped `constant.language.attribute-option.swift`.
- [ ] **`sending` parameter modifier** (SE-0430). Add to
      `modifier-for-parameter` (`Swift.sublime-syntax:962`). Proposed:
      `storage.modifier.sending.swift`.
- [ ] **Suppressed conformance `~Sendable`** (SE-0470). Same
      `keyword.operator.suppressed-conformance.swift` token introduced
      for `~Copyable` in 5.9; add a regression test.
- [ ] **`if case` pattern in guard / if** — already syntactically valid;
      add a test that locks `case` to
      `keyword.control.conditional.case.swift` here (current rule at
      `Swift.sublime-syntax:810` already covers it).

## Swift 6.3 — branch `swift-6.3`

TSPL summary: minor corrections; the meaningful surface change is
language-mode-gated.

- [ ] **`@export` declaration attribute** (SE-0XXX, tracked in the 2025-12
      TSPL update). Add to `attribute-builtins`
      (`Swift.sublime-syntax:1594`); scope
      `support.function.annotation.swift`. Confirm the proposal number
      against `swift-evolution` when the branch is opened — the TSPL
      entry references the attribute by name only.
- [ ] **Integer generic parameters** (`<let N: Int>`) (SE-0452). The `let`
      inside a generic parameter clause is currently consumed by
      `declaration-constant` at `Swift.sublime-syntax:1197`; verify it
      still scopes as `keyword.declaration.let.swift` inside
      `generic-parameter-clause-declaration`
      (`Swift.sublime-syntax:1784`). Add a test asserting both the
      `let` and the value-parameter name.
- [ ] **Any other 6.3 additions** — re-scan
      `swift-evolution/proposals/*.md` for `status: implemented (Swift 6.3)`
      when this branch starts; the list above is intentionally narrow
      because the TSPL entry for 6.3 is sparse.

---

## Cross-cutting work (do once, on the earliest branch that needs it)

These items are not version-specific but the first version that introduces a
related feature is the right place to land them.

- [ ] Add a test harness convention: every new `tests/syntax_test-*.swift`
      file begins with `// SYNTAX TEST "Swift.sublime-syntax"` and uses
      `^` assertions exactly like
      `tests/syntax_test-Literal String.swift` and
      `tests/syntax_test-grammar-test.swift`. Document the convention in
      `README.md` after the first version branch lands.
- [ ] Move `package` into the `reserved_word` variable
      (`Swift.sublime-syntax:69`) the same time it's added to
      `access_levels` (5.7+ contextual, 6.0+ required).
- [ ] Audit the `reserved_word` list: `borrowing`, `consuming`,
      `package`, `each`, `repeat` (already there), `consume`,
      `discard`, `sending` — these are contextual keywords; check
      whether including them in `reserved_word` causes false
      "invalid.illegal.unexpected-word.swift" matches inside parameter
      lists, since `reserved-word-pop` is included in
      `parameter-list-body` at `Swift.sublime-syntax:1048`.

---

## Risk / hard cases

1. **Regex literals (SE-0354 / SE-0355)** — by far the highest-risk item.
   The bare `/.../` form collides with division, line comments (`//`),
   block comments (`/*`), and operator characters defined in the
   `operator_head` variable at `Swift.sublime-syntax:49` which already
   contains `/`. Strategy:
   - Treat `#/.../#` as a separate, easy case modelled on
     `extended-string-literal` (`Swift.sublime-syntax:473`) — the
     `#` anchors disambiguate, so do this first.
   - For bare `/.../`, copy the disambiguation approach used by
     `sublimehq/Packages/JavaScript/JavaScript.sublime-syntax` (regex
     allowed after `=`, `(`, `,`, `return`, `:`, `?`, `[`, infix
     operators; division otherwise) and
     `sublimehq/Packages/Ruby/Ruby.sublime-syntax` (`expect_re` context
     toggled by surrounding tokens). Implementing this requires a new
     `expect-regex` / `expect-operand` context distinction throughout
     `statements-scope-any` — touching this is invasive.
   - Skip the bare form initially if it can't be done cleanly; ship
     `#/.../#` only on the 5.7 branch and re-attempt the bare form on
     a follow-up branch. Document this clearly in the 5.7 PR.

2. **`if` / `switch` as expressions (SE-0380)** — the current
   `keyword-control-flows` context assumes statement position; it
   pushes a body context for `switch`. Using `switch` after `=` puts it
   inside `statements-scope-any`, which already includes
   `keyword-control-flows`, so it may just work — but verify the
   `meta_scope: meta.block.swift meta.switch.swift` push set at
   `Swift.sublime-syntax:771` doesn't interfere with the surrounding
   expression. Write the test first to discover the failure mode.

3. **Parameter packs `each` / `repeat`** — `repeat` already means the
   `repeat`-`while` loop at `Swift.sublime-syntax:735`. Differentiating
   pack-expansion `repeat` from the loop requires lookahead: pack
   `repeat` is followed by `(`, an identifier-position token, or
   `each`; loop `repeat` is followed by `{` (and then `while`). Adding
   a second `repeat` rule before the existing one with a tight
   lookahead is the simplest path. Pin the discrimination with tests
   on both forms.

4. **Contextual keyword collisions** — `borrowing`, `consuming`,
   `sending`, `consume`, `discard`, `each`, `package` are all
   contextual. Adding them to `reserved_word` is destructive (the
   `reserved-word-pop` contexts treat them as invalid), so prefer
   adding them as positional matches in
   `modifier-for-parameter` / `modifier-types` / etc., and leave
   `reserved_word` alone. Each new contextual keyword needs at least
   one positive test (used correctly) and one negative test (used as
   an identifier in a parameter name or function name).

5. **Typed throws `throws(E)`** — the existing
   `keyword-declarations` match for `throws` at
   `Swift.sublime-syntax:841` is a plain word match. The follow-on
   `(E)` clause must be pushed only when the next non-space character
   is `(`. Using a small push context (similar to the
   `modifier-reference-counting` `unowned(...)` pattern at
   `Swift.sublime-syntax:928`) keeps the change local and reversible.

6. **`~Copyable` / `~Escapable` / `~Sendable`** — `~` is already in
   `operator_head`, so a custom-operator match may swallow it before
   the suppressed-conformance rule fires. Sequence the new rule
   before `operator-custom` in `statements-scope-any`, gated on a
   following identifier with capitalised first letter.

7. **Macros `#foo(...)`** — must not break the existing
   `compiler-literals` rules that match a hard-coded list of `#`
   identifiers (`#file`, `#selector`, …). Add the user-macro rule
   *after* the built-ins so the builtin list still wins.

8. **`Swift - Standard Library.sublime-syntax` include** — at
   `Swift.sublime-syntax:2153`, a sibling syntax is included that is
   not present in this repository. New types added by stdlib in 5.7+
   (`Regex`, `Duration`, `Clock`, …) will not be highlighted as
   stdlib symbols until that file is updated. Out of scope for this
   plan, but worth flagging on each branch's PR description.
