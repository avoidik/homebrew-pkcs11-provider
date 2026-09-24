# homebrew-pkcs11-provider

Homebrew formulae to install [latchset/pkcs11-provider](https://github.com/latchset/pkcs11-provider)

## How to install

```bash
brew tap avoidik/pkcs11-provider
brew install pkcs11-provider
```

## How to remove

```bash
brew untap avoidik/pkcs11-provider
```

## Releases

The `Release` workflow builds and tests the formula on macOS for every pull request and push to `main`.
On `main`, once the tests pass, it creates tag `v<version>` and a GitHub release from the formula's `version` if they do not exist yet.
To publish a new version, update `version` and `sha256` in `Formula/pkcs11-provider.rb` and merge to `main`.
