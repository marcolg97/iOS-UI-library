# Component Implementation Checklist

This document outlines all the steps and verifications required when adding a new UI component to the UILibrary. Follow this checklist for every new Atom, Molecule, or Organism to ensure consistency, quality, and maintainability.

## 1. Architecture & Folder Structure

1. Create the component in the correct folder under `Sources/UILibrary/Components/`:
   - `Atoms/`, `Molecules/`, or `Organisms/` depending on complexity
   - Each component in its own directory with a descriptive name

## 2. Code & APIs

1. Implement the SwiftUI view (e.g. `MyComponent.swift`).
2. Create a corresponding `Style` struct (e.g. `MyComponentStyle.swift`) that is immutable and brand-agnostic.
3. Add presets or extensions to the style as needed (e.g. `MyComponentStyle+Preset.swift`).
4. Ensure no business logic is present; components must be purely presentational.
5. Use composition over inheritance and avoid `AnyView` unless absolutely required.
6. If a modifier is appropriate, place it under `Modifiers/`.

## 3. Documentation

1. Document all public APIs using SwiftDoc comments in-source (responsibility, layer, usage context).
2. If a component requires additional conceptual explanation, add a file under `Sources/UILibrary/Documentation.docc/`.
3. Keep documentation concise and brand-agnostic.

## 4. Previews & Style Injection

1. Add SwiftUI previews for the component in its implementation file or a separate `*+Preview.swift` file.
2. Cover all relevant variants and style presets.
3. Example:
   ```swift
   MyComponent(style: .init(...))
       .previewLayout(.sizeThatFits)
   ```

## 5. README & CHANGELOG

1. Add the component to the component list in `README.md` with a short description.
2. Update `CHANGELOG.md` under the appropriate release (new feature or breaking change).
3. For breaking changes, bump the MAJOR version and document migration notes in the changelog.

## 6. Tests

1. Add unit tests if the component has any non-trivial behavior (e.g. style computations).
2. Tests live in `Tests/UILibraryTests/`.
3. Run the test suite to ensure all tests pass:
   ```bash
   swift test --build-system swiftbuild
   ```

## 7. Localization & Resources

1. If the component displays text, add keys to `Sources/UILibrary/Resources/Localizable.xcstrings`.
2. Use `UILibrary`’s localization helpers if available.

## 8. Clean & Validate

1. Build the library to verify there are no compile errors:
   ```bash
   swift build --build-system swiftbuild
   ```
2. Confirm previews compile and display correctly in Xcode.
3. Ensure there are no brand tokens or business logic.
4. Verify style struct is immutable:
   - Use `let` for all properties
   - No `internal` mutable state

## 9. Commit & Branch Workflow

1. Create a feature branch (e.g. `feat/atoms/my-component`) before working.
2. Commit changes frequently and push to remote.
3. Open a pull request against `main` with a descriptive title and summary.

## 10. Final Checklist Before PR

- [x] Code in correct folder
- [x] SwiftDoc comments added
- [x] Component list updated in `README.md`
- [x] `CHANGELOG.md` entry created
- [x] Previews compile with variants
- [ ] Tests added/passed
- [x] No brand tokens or business logic
- [x] Style struct immutable
- [x] JOURNAL.md entry describing change and rationale

> **Note:** This checklist should be followed for every component, even when making incremental updates or refactors. It helps maintain the library’s quality and ensures all contributors share a common framework for work.