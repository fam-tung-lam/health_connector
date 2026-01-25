# health_connector_lint

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_lint">
    <img src="https://img.shields.io/pub/v/health_connector_lint.svg?style=popout" alt="Pub"/>
  </a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_lint/score">
    <img src="https://img.shields.io/pub/points/health_connector_lint?color=2E8B57&label=pub%20points" alt="Pub Points"/>
  </a>
</p>

Shared lint rules and analysis options for all `health_connector`
packages, enforcing consistent code quality across the monorepo.

---

## 📦 What's Included

- Strict Flutter lints
- Custom rules for health data handling
- Consistent formatting standards
- Comprehensive error analysis

---

## 🚀 Getting Started

Add to your `pubspec.yaml`:

```bash
flutter pub add --dev health_connector_lint
```

Or manually add to your `pubspec.yaml`:

```yaml
dependencies:
  health_connector_lint: [latest_version]
```

Include in your `analysis_options.yaml`:

```yaml
include: package:health_connector_lint/analysis_options.yaml
```

---

## ⚙️ Customization

You can override specific rules in your package's `analysis_options.yaml`:

```yaml
include: package:health_connector_lint/analysis_options.yaml

linter:
  rules:
    # Disable a rule from health_connector_lint
    public_member_api_docs: false
```

---

## 🤝 Contributing

To report issues or request features, please visit
our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
