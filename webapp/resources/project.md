# Project & community

Health Connector SDK is an open-source Flutter SDK under the MIT License, developed as a Melos-managed monorepo.

## Report a bug or request a feature

Open an issue on [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).

Health bugs are frequently device-specific, so a reproducible report needs more than a stack trace. Please include:

- **Device and OS version** — Health Connect capability varies by Mainline module level, and some iOS types have version floors
- **Flutter and Dart versions**
- **Health Connector SDK version**
- **Steps to reproduce**, and logs from a [`PrintLogProcessor`](/guide/tasks/logging)
- **Expected versus actual behavior**

Before filing, check whether the behavior is a documented platform difference — [Platform differences](/guide/concepts/platform-differences) and the [error code reference](/reference/error-codes) cover the most common surprises. Reproducing the flow in the [Toolbox demo app](/resources/toolbox) is the quickest way to tell an SDK bug from a configuration issue.

## Contribute

1. Fork the repository
2. Create a feature branch — `git checkout -b feature/amazing-feature`
3. Commit your changes
4. Push the branch
5. Open a pull request

Before submitting:

- Follow the lint rules in [`health_connector_lint`](https://github.com/fam-tung-lam/health_connector/tree/main/packages/health_connector_lint)
- Add tests for new functionality
- Update documentation as needed

For anything substantial, open an issue first to discuss the approach.

Full details are in [CONTRIBUTING.md](https://github.com/fam-tung-lam/health_connector/blob/main/CONTRIBUTING.md).

## Improve these docs

Every page has a **Suggest an edit to this page** link at the bottom that opens the source file on GitHub. Documentation fixes are welcome as pull requests, same as code.

## Repository

| Resource | Link |
|---|---|
| Source | [github.com/fam-tung-lam/health_connector](https://github.com/fam-tung-lam/health_connector) |
| Package | [pub.dev/packages/health_connector](https://pub.dev/packages/health_connector) |
| SDK reference | [Health Connector reference](/reference/) |
| Changelog | [pub.dev changelog](https://pub.dev/packages/health_connector/changelog) |
| Issues | [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues) |

## License

MIT. See [LICENSE](https://github.com/fam-tung-lam/health_connector/blob/main/LICENSE).

<NextSteps
  :links="[
    { text: 'Packages', link: '/reference/packages', description: 'The monorepo layout and what each package does.' },
    { text: 'Toolbox demo app', link: '/resources/toolbox', description: 'Reproduce a problem before reporting it.' },
    { text: 'Migration guides', link: '/resources/migration', description: 'Upgrading across major versions.' },
  ]"
/>
