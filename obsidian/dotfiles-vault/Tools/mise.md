# mise — Polyglot Version Manager

> One tool to manage all runtime versions. Replaces nvm, sdkman, pyenv, rbenv, etc.

## Why mise (over nvm/sdkman)

| | mise | nvm / sdkman |
|---|------|--------------|
| Languages | Node, Python, Ruby, Go, Java, Rust, + 200 more | One language each |
| Config | `.mise.toml` or `.tool-versions` per project | Language-specific files |
| Speed | Rust binary, instant activation | Shell function, slow |
| Shims | Yes (+ direct PATH injection) | Yes |
| Global defaults | Yes | Yes |

`.zshrc` loads both nvm and mise — migrate projects gradually by adding a `.mise.toml`.

## Usage

```bash
mise use node@lts          # set node version for this project (creates .mise.toml)
mise use python@3.12       # set python for this project
mise use --global node@lts # set global default
mise install               # install all versions in .mise.toml
mise ls                    # list installed versions
mise current               # show active versions in current dir
```

## Per-project config (`.mise.toml`)

```toml
[tools]
node = "lts"
python = "3.12"
go = "1.22"
```

Check this file into git — team members get the same versions automatically.

## Migration from nvm

```bash
# After adding mise use node@lts:
# Comment out or remove nvm section from .zshrc once all projects use .mise.toml
```
