# UI Library Architecture Guidelines

> Note: the former standalone `Architecture` article has been consolidated into this guidelines page — this file is now the canonical architecture reference.

## Purpose

Define clear architectural rules for building a reusable, scalable, production‑grade UI Library that can be shared across multiple apps.

Goals:

* Strong separation of concerns
* Brand‑agnostic components
* High composability
* Atomic Design driven structure
* Style injection instead of hardcoded values
* Predictable folder organization
* AI and human contributor alignment

---

# Core Principles

## 1. UI Library Must Be Brand Agnostic

The UI Library:

* Does NOT contain brand colors
* Does NOT contain semantic palettes
* Does NOT contain app-specific business logic
* Does NOT depend on any App module

The UI Library exposes:

* Views
* Styles
* Configuration structs
* ViewModifiers
* Layout primitives

The App (or Design System module) provides:

* Semantic palette
* Typography system
* Spacing tokens
* Concrete Style factories

Dependency direction:

App → UILibrary

Never the opposite.

---

# Atomic Design Structure

Follow Atomic Design strictly.

## Atoms

Smallest UI units. No composition of complex business rules.

Examples:

* PrimaryText
* IconView
* DividerLine
* AvatarImage
* Spacing

Rules:

* Stateless
* Highly reusable
* Accept style/config objects

---

## Molecules

Composition of atoms.

Examples:

* LabeledIcon
* TextFieldWithTitle
* BadgeWithIcon

Rules:

* Still reusable across domains
* No feature logic
* No navigation

---

## Organisms

Complex UI sections.

Examples:

* OfflinePopup
* LoginForm
* ProductCard

Rules:

* Built using atoms + molecules
* Accept Style object
* No business logic

---

## Templates (Optional – usually App side)

Page layout structure without data.

---

## Pages (App only)

Concrete screen implementation with real data.

---

# Style Architecture

## Component Accepts Style Object

Never pass raw colors individually.

Correct:

Component(style: OfflinePopupStyle)

Wrong:

Component(textColor: Color?, backgroundColor: Color?, cornerRadius: CGFloat?)

---

## Style Responsibilities

A Style struct defines:

* Colors
* Typography
* Spacing
* Shape

It does NOT fetch palette.

It does NOT know about brand.

---

# Composability Rules

1. Prefer composition over inheritance
2. Avoid AnyView unless strictly necessary
3. Expose small focused Views
4. Use ViewModifier for cross‑cutting styling
5. Keep layout isolated from styling when possible

---

# Environment vs Initializer

Two valid approaches:

## 1. Explicit Style Injection (Default)

Pros:

* Clear dependency
* Easy testing
* Explicit

Use for most components.

## 2. Environment Injection (Advanced)

Useful when:

* You want automatic theme propagation
* You want global override capability
* You want subtree-based theme overrides

Use sparingly.

---

## Theme Switching With Explicit Style Injection

Using Explicit Style Injection does NOT prevent runtime theme switching.

Correct approach:

1. The App owns a Theme object (Observable or State driven).
2. The Theme builds concrete Style objects.
3. The App injects styles into components.
4. When Theme changes, styles are rebuilt and views refresh.

Example architecture:

AppTheme (light/dark/brandA/brandB)
↓
Style Factory
↓
Component(style: factory.offlinePopupStyle())

This keeps the UI Library pure while still enabling:

* Runtime theme switching
* White‑label support
* Per-feature theme customization

Environment injection is optional convenience, not a requirement for theming.

If you want subtree overrides (e.g., a specific section with different theme), Environment injection becomes useful. Otherwise explicit injection is fully sufficient and more predictable.

---

---

# Folder Structure

Recommended structure:

UILibrary/

```
UILibrary
│
├── Atoms
│   ├── Text
│   │   ├── PrimaryText.swift
│   │   ├── PrimaryTextStyle.swift
│   │   └── PrimaryTextModifier.swift
│   │
│   ├── Icon
│   │   ├── IconView.swift
│   │   └── IconStyle.swift
│   │
│   └── Spacing
│       └── Spacing.swift
│
├── Molecules
│   └── LabeledIcon
│       ├── LabeledIcon.swift
│       └── LabeledIconStyle.swift
│
├── Organisms
│   └── OfflinePopup
│       ├── OfflinePopup.swift
│       ├── OfflinePopupStyle.swift
│       ├── OfflinePopupConfiguration.swift
│       └── OfflinePopupModifier.swift
│
├── Modifiers
│   ├── ShadowModifier.swift
│   ├── RoundedSurfaceModifier.swift
│   └── LoadingModifier.swift
│
├── Extensions
│   ├── View+Extensions.swift
│   ├── Color+Extensions.swift
│   └── Font+Extensions.swift
│
├── Layout
│   ├── StackLayout.swift
│   └── GridLayout.swift
│
└── Utilities
    ├── Constants.swift
    └── Configuration.swift
```

---

# Component Folder Convention

Each component must live inside its own folder.

Example:

Organisms/OfflinePopup/

Contains only:

* OfflinePopup.swift
* OfflinePopupStyle.swift
* OfflinePopupConfiguration.swift
* OfflinePopup+Preview.swift (optional)

Never mix unrelated components in same folder.

---

# ViewModifiers Guidelines

Use ViewModifier when:

* Styling is reusable
* Behavior is reusable
* Multiple components need it

Do NOT put ViewModifiers inside component file unless private.

Public reusable modifiers belong in:

Modifiers/

---

# Extensions Guidelines

Only create extensions for:

* View helpers
* Safe Color helpers
* Reusable computed properties

Never put business logic in extensions.

---

# Naming Conventions

* Use semantic names
* Avoid “Custom”, “My”, “Base”
* Avoid UI references to brand

Correct:

PrimaryButton
SurfaceContainer
ErrorBadge

Wrong:

RedButton
AppPrimaryBlueButton

---

# AI Contribution Rules

When AI generates components:

* Must follow Atomic Design layer
* Must generate Style struct
* Must avoid hardcoded colors
* Must avoid business logic
* Must not introduce dependencies to App module
* Must keep initializer minimal
* Must avoid optional styling parameters

---

# Human Contribution Rules

When developers add components:

* Respect folder structure
* Extract style
* Keep views small
* Compose instead of nesting deeply
* Do not add semantic palette here
* Add preview for validation

---

# What Never Goes Into UI Library

* Networking
* Feature logic
* ViewModels tied to feature
* Analytics
* Navigation logic
* Brand palette
* App theme

---

# Final Architecture Summary

UI Library = Structural UI + Style Contracts

Design System (App side) = Semantic Tokens + Palette + Concrete Style Builders

App = Business Logic + Screens + Feature Composition

---

# Documentation Guidelines

## Code Documentation Rules

All public APIs must include structured documentation comments.

Each public type must document:

* Responsibility
* Usage context
* Layer (Atom, Molecule, Organism)

Each public function must document:

* Purpose
* Parameters
* Return value
* Failure conditions (if any)

Example:

/// Displays a transient offline notification banner.
/// - Parameters:
///   - icon: System image name.
///   - message: Message displayed to the user.
///   - style: Visual style configuration.
/// - Note: Organism component. No business logic allowed.

Avoid:

* Redundant comments
* Obvious descriptions
* Implementation details in public docs

---

## Library Documentation Structure (GitHub Ready)

The repository should contain:

```
UILibrary
│
├── Sources/
├── Tests/
├── README.md
├── CHANGELOG.md
├── LICENSE
└── Docs/
    ├── LibraryGuidelines.md (Architecture content consolidated)
    ├── Contributing.md
    ├── Theming.md
    └── Components/
        ├── OfflinePopup.md
        └── PrimaryButton.md
```

---

## README.md Must Contain

1. Purpose of the library
2. Architectural principles
3. Atomic Design explanation
4. Installation instructions (SPM)
5. Basic usage example
6. Theming strategy explanation
7. Folder structure overview
8. Contribution rules

---

## Per Component Documentation

Each component should have:

* Description
* Layer classification
* Style explanation
* Usage example
* Preview image (optional)

Example structure inside Docs/Components:

OfflinePopup.md

Contents:

* Overview
* Public API
* Style Contract
* Usage
* Do / Don’t

---

## Buildable Documentation (DocC)

Use DocC for official documentation generation.

Steps:

1. Add a Documentation Catalog (.docc).
2. Write DocC articles for Architecture and Theming.
3. Mark public APIs with documentation comments.
4. Build documentation archive.
5. Publish as static site (GitHub Pages).

This provides:

* Searchable API docs
* Symbol graphs
* Tutorials
* Visual hierarchy

---

## Versioning and Stability

Follow Semantic Versioning:

* MAJOR: Breaking API change
* MINOR: New backward-compatible feature
* PATCH: Bug fixes

Never introduce breaking changes silently.

Document all changes in CHANGELOG.md.

---

# Long Term Scalability Strategy

* Keep atoms extremely stable
* Evolve molecules carefully
* Allow organisms to be replaced
* Keep Style structs backward compatible
* Avoid breaking public APIs

---

This structure ensures:

* Multi‑brand support
* White label readiness
* Testability
* Maintainability
* Predictable scaling across apps

