# Theming

## Overview

The UI Library does not own brand identity or visual tokens.

The application (or a dedicated Design System module) is responsible for:

- Semantic color tokens
- Typography system
- Spacing system
- Concrete Style factories

The UI Library only defines style contracts.

---

# Architectural Responsibility

UILibrary:

- Defines `Style` structs
- Defines UI structure
- Applies provided style
- Remains brand-agnostic

App / DesignSystem:

- Defines semantic tokens
- Maps tokens to concrete values
- Builds Style instances
- Controls runtime theme switching

---

# Explicit Style Injection (Recommended)

Primary strategy.

Flow:

Theme → Style Factory → Component(style:)

Conceptual example:

ActiveTheme ↓ OfflinePopupStyleFactory ↓ OfflinePopup(style: factory.error())

Advantages:

- Explicit dependency
- No hidden global state
- Easy testing
- Predictable rendering
- Clear ownership of styling

---

# Runtime Theme Switching

Theme switching is handled at App level.

Strategy:

1. Store active theme in state (Observable / State / Store).
2. Recreate Style factories when theme changes.
3. Inject updated styles into components.
4. SwiftUI re-renders automatically.

This supports:

- Light / Dark mode
- Multi-brand applications
- Feature-level overrides

Environment injection is NOT required for runtime theme switching.

---

# Environment Injection (Optional)

Use when:

- You want automatic subtree propagation
- You want global override capability
- You want section-scoped theming

If used, inject Style or Theme abstraction — never raw colors.

Avoid overusing Environment to prevent implicit dependencies.

---

# Semantic Tokens (App Side)

Recommended Design System structure:

```
DesignSystem
├── SemanticColors
├── Typography
├── Spacing
├── Elevation
└── StyleFactories
```

Example semantic categories:

- surfacePrimary
- surfaceCritical
- surfaceWarning
- textPrimary
- textOnSurface
- borderSubtle

Tokens describe intent, not visual value.

---

# White-Label Support

To support multiple brands:

- Each brand defines its own Theme
- Each Theme builds its own Style factories
- UILibrary remains unchanged

No brand token should ever appear inside UILibrary.

---

# Anti-Patterns

Do NOT:

- Hardcode colors in components
- Reference SemanticColors inside UILibrary
- Pass optional color parameters
- Use global singletons for theme
- Let components fetch theme themselves

---

# Summary

UILibrary = Structure + Style Contracts

DesignSystem / App = Theme + Semantic Tokens + Style Builders

Clear separation ensures:

- Maintainability
- Scalability
- Multi-app reuse
- Brand independence
- Testability

